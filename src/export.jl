using PlutoSliderServer

const DOCS_DIR = "docs"

const NOTEBOOKS = [
    ("10", "MATH_201_CH10", "Chapter 10"),
    ("11", "MATH_201_CH11", "Chapter 11"),
    ("13", "MATH_201_CH13", "Chapter 13"),
    ("14", "MATH_201_CH14", "Chapter 14"),
]

function parse_chapter_list(raw::AbstractString)
    chapters = [strip(chapter) for chapter in split(raw, ",")]
    filter!(!isempty, chapters)
    isempty(chapters) && error("No chapter numbers were provided.")
    return unique(chapters)
end

function parse_args(args::Vector{String})
    chapters = nothing
    i = 1
    while i <= length(args)
        arg = args[i]
        if startswith(arg, "--ch=")
            chapters = parse_chapter_list(arg[6:end])
        elseif arg == "--ch"
            i += 1
            i > length(args) && error("--ch requires a comma-separated list, e.g. --ch=10,11.")
            chapters = parse_chapter_list(args[i])
        elseif arg in ("-h", "--help")
            println("Usage: julia --project=. src/export.jl [--ch=10,11]")
            println("If --ch is omitted, all chapter notebooks are exported.")
            exit(0)
        else
            error("Unknown argument: $arg")
        end
        i += 1
    end
    return chapters
end

function selected_notebooks(selected_chapters)
    if isnothing(selected_chapters)
        return NOTEBOOKS
    end

    known_chapters = Set(entry[1] for entry in NOTEBOOKS)
    unknown_chapters = [chapter for chapter in selected_chapters if !(chapter in known_chapters)]
    isempty(unknown_chapters) || error("Unknown chapter ID(s): " * join(unknown_chapters, ", "))

    selected = [entry for entry in NOTEBOOKS if entry[1] in selected_chapters]
    isempty(selected) && error("No notebooks matched the requested chapter filter.")
    return selected
end

function export_chapter_notebooks(notebooks)
    mkpath(DOCS_DIR)
    for (_, notebook_name, _) in notebooks
        notebook_path = joinpath("src", notebook_name * ".jl")
        PlutoSliderServer.export_notebook(notebook_path; Export_output_dir = DOCS_DIR)
    end
end

function main(args=ARGS)
    selected_chapters = parse_args(args)
    notebooks = selected_notebooks(selected_chapters)
    export_chapter_notebooks(notebooks)
end

main()
