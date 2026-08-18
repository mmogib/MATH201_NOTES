const ROOT = normpath(joinpath(@__DIR__, ".."))
const CELL_ORDER_START = "# ╔═╡ Cell order:"
const UUID_PATTERN = "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
const CELL_RE = Regex("^# ([^A-Za-z0-9_]+) (" * UUID_PATTERN * ")\\s*\$", "m")
const CELL_ORDER_RE = Regex("^# ([^A-Za-z0-9_]+)(" * UUID_PATTERN * ")\\s*\$", "m")
const PACKAGE_IDS = [
    "00000000-0000-0000-0000-000000000001",
    "00000000-0000-0000-0000-000000000002",
]

struct Cell
    id::String
    marker_prefix::String
    text::String
end

struct SplitOptions
    source::String
    output_dir::String
    output_prefix::String
    chapters::Union{Nothing, Vector{String}}
end

function split_cells(body::AbstractString)
    matches = collect(eachmatch(CELL_RE, body))
    isempty(matches) && error("No Pluto cells found in notebook body.")

    cells = Cell[]
    for (index, regex_match) in pairs(matches)
        start_index = regex_match.offset
        end_index = index < length(matches) ? prevind(body, matches[index + 1].offset) : lastindex(body)
        push!(cells, Cell(regex_match.captures[2], regex_match.captures[1], rstrip(body[start_index:end_index]) * "\n"))
    end
    return cells
end

function read_notebook(source::String)
    text = read(source, String)
    parts = split(text, CELL_ORDER_START; limit=2)
    length(parts) == 2 || error("Missing Pluto Cell order section in $source.")

    body, order_text = parts
    matches = collect(eachmatch(CELL_RE, body))
    isempty(matches) && error("No Pluto cells found in $source")

    prefix = body[1:prevind(body, matches[1].offset)]
    cells = split_cells(body)
    order_ids = [m.captures[2] for m in eachmatch(CELL_ORDER_RE, order_text)]
    isempty(order_ids) && error("No cell IDs found in Pluto Cell order section.")
    return prefix, cells, order_ids
end

function parse_chapter_headings(text::String)
    matches = collect(eachmatch(r"(?m)#\s*([0-9]+)\.", text))
    return [m.captures[1] for m in matches]
end

function parse_chapter_heading(text::String)
    headings = parse_chapter_headings(text)
    return isempty(headings) ? nothing : last(headings)
end

is_pluto_package_cell(cell::Cell) = cell.id in PACKAGE_IDS

function normalize_generated_cell(text::String)
    return replace(replace(rstrip(text), "\t" => "    "), r"[ ]+(?=\r?\n)" => "")
end

function order_line(cell::Cell)
    return "# $(cell.marker_prefix) $(cell.id)"
end

function cell_order(cells)
    return join(vcat([CELL_ORDER_START], order_line.(cells)), "\n") * "\n"
end

function default_output_prefix(source::String)
    stem = splitext(basename(source))[1]
    return endswith(stem, "_NOTES") ? stem[1:end-6] : stem
end

function parse_chapter_list(raw::AbstractString)
    parts = [strip(part) for part in split(raw, ',')]
    filter(!isempty, parts)
end

function parse_args(args::Vector{String})
    source = nothing
    output_dir = nothing
    output_prefix = nothing
    chapters = nothing

    i = 1
    while i <= length(args)
        arg = args[i]
        if arg == "--source"
            i += 1
            i > length(args) && error("--source requires a path.")
            source = args[i]
        elseif arg == "--output-dir"
            i += 1
            i > length(args) && error("--output-dir requires a path.")
            output_dir = args[i]
        elseif arg == "--output-prefix"
            i += 1
            i > length(args) && error("--output-prefix requires a value.")
            output_prefix = args[i]
        elseif arg == "--chapters"
            i += 1
            i > length(args) && error("--chapters requires a comma-separated list.")
            chapters = parse_chapter_list(args[i])
        else
            error("Unknown argument: $arg")
        end
        i += 1
    end

    source === nothing && (println("Enter the Pluto source notebook path:"); source = strip(readline()))
    isempty(source) && error("No source notebook provided.")
    output_dir === nothing && (output_dir = dirname(source))
    output_prefix === nothing && (output_prefix = default_output_prefix(source))
    return SplitOptions(source, output_dir, output_prefix, chapters)
end

function infer_chapters(cells_by_id, order_ids)
    chapters = String[]
    seen = Set{String}()
    for id in order_ids
        cell = get(cells_by_id, id, nothing)
        cell === nothing && continue
        is_pluto_package_cell(cell) && continue
        for chapter in parse_chapter_headings(cell.text)
            if !(chapter in seen)
                push!(chapters, chapter)
                push!(seen, chapter)
            end
        end
    end
    return chapters
end

function is_common_tail_cell(cell::Cell)
    text = cell.text
    return occursin("using CommonMark", text) ||
           occursin("initialize_eqref(", text) ||
           occursin("@htl(\"\"\"", text) ||
           occursin("function add_space(", text) ||
           occursin("function post_img(", text) ||
           occursin("function poolcode(", text) ||
           occursin("function define(", text) ||
           occursin("function remark(", text) ||
           occursin("function remarks(", text) ||
           occursin("function bbl(", text) ||
           occursin("function theorem(", text) ||
           occursin("function bth(", text) ||
           occursin("function beginBlock(", text) ||
           occursin("function beginTheorem(", text) ||
           occursin("function endBlock(", text) ||
           occursin("function endTheorem(", text) ||
           occursin("function example(", text) ||
           occursin("function rect(", text) ||
           occursin("function reimannSum(", text)
end

function prompt_for_chapters()
    println("Could not infer chapter headings from the notebook.")
    println("Enter chapter numbers or labels, comma-separated:")
    raw = strip(readline())
    isempty(raw) && error("No chapter list provided.")
    return parse_chapter_list(raw)
end

function push_unique_cell!(cells::Vector{Cell}, cell::Cell)
    if isempty(cells) || last(cells).id != cell.id
        push!(cells, cell)
    end
    return cells
end

function split_cells_by_region(cells_by_id, order_ids, chapter_labels)
    wanted = Set(chapter_labels)
    chapter_cells = Dict(chapter => Cell[] for chapter in chapter_labels)
    common_start = Cell[]
    common_end = Cell[]
    package_cells = Cell[]
    active_chapters = Set{String}()
    tail_started = false
    seen_requested = Set{String}()

    for id in order_ids
        cell = get(cells_by_id, id, nothing)
        cell === nothing && continue

        if is_pluto_package_cell(cell)
            push!(package_cells, cell)
            continue
        end

        if tail_started
            push!(common_end, cell)
            continue
        end

        headings = parse_chapter_headings(cell.text)
        matching_headings = [chapter for chapter in headings if chapter in wanted]

        if !isempty(matching_headings)
            empty!(active_chapters)
            union!(active_chapters, matching_headings)
            union!(seen_requested, matching_headings)
        elseif !isempty(headings)
            empty!(active_chapters)
        end

        if !isempty(active_chapters)
            if length(seen_requested) == length(chapter_labels) && isempty(headings) && is_common_tail_cell(cell)
                tail_started = true
                empty!(active_chapters)
                push!(common_end, cell)
            else
                for chapter in active_chapters
                    push_unique_cell!(chapter_cells[chapter], cell)
                end
            end
        elseif isempty(seen_requested)
            push!(common_start, cell)
        end
    end

    any(v -> !isempty(v), values(chapter_cells)) || error("No chapter content was found.")
    isempty(common_end) && error("No common tail cells were found.")

    return common_start, chapter_cells, common_end, package_cells
end

function split_common_start(common_start::Vector{Cell})
    toc_cells = Cell[]
    intro_cells = Cell[]
    for cell in common_start
        occursin("TableOfContents(", cell.text) ? push!(toc_cells, cell) : push!(intro_cells, cell)
    end
    return toc_cells, intro_cells
end

function write_notebook(output::String, prefix::AbstractString; physical_cells, execution_cells)
    body = join((normalize_generated_cell(cell.text) for cell in physical_cells), "\n\n") * "\n\n"
    write(output, String(prefix) * body * cell_order(execution_cells))
    println("Wrote ", relpath(output, ROOT))
end

function split_pluto_chapters(; source::String, output_dir::String=dirname(source), output_prefix::String=default_output_prefix(source), chapters::Union{Nothing, Vector{String}}=nothing)
    prefix, cells, order_ids = read_notebook(source)
    cells_by_id = Dict(cell.id => cell for cell in cells)

    inferred = isnothing(chapters) ? infer_chapters(cells_by_id, order_ids) : chapters
    isempty(inferred) && (inferred = prompt_for_chapters())

    common_start, chapter_cells, common_end, package_cells = split_cells_by_region(cells_by_id, order_ids, inferred)
    toc_cells, intro_cells = split_common_start(common_start)

    mkpath(output_dir)
    for chapter in inferred
        chapter_block = chapter_cells[chapter]
        isempty(chapter_block) && error("No cells assigned to chapter $chapter.")
        physical_cells = vcat(common_start, chapter_block, common_end, package_cells)
        execution_cells = vcat(package_cells, toc_cells, common_end, intro_cells, chapter_block)
        output = joinpath(output_dir, "$(output_prefix)_CH$(chapter).jl")
        write_notebook(output, prefix; physical_cells=physical_cells, execution_cells=execution_cells)
    end
end

function main(args::Vector{String}=ARGS)
    opts = parse_args(args)
    split_pluto_chapters(source=opts.source, output_dir=opts.output_dir, output_prefix=opts.output_prefix, chapters=opts.chapters)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
