include(joinpath(@__DIR__, "split_pluto_chapters.jl"))

const ROOT = normpath(joinpath(@__DIR__, ".."))

function main()
    split_pluto_chapters(
        source=joinpath(ROOT, "refs", "MATH201_NOTES_legacy.jl"),
        output_dir=joinpath(ROOT, "src"),
        output_prefix="MATH_201",
        chapters=["10", "11", "13", "14"],
    )
end

main()
