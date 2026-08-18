# MATH201: Calculus III (Term 261)

This repository contains Pluto.jl notes, exercises, and static course materials for MATH201 Calculus III (Term 261) at King Fahd University of Petroleum & Minerals (KFUPM).

## Course Material

Open the published course site:

- [Course landing page](./docs/index.html)
- [Chapter 10 notes](./docs/MATH_201_CH10.html)
- [Chapter 11 notes](./docs/MATH_201_CH11.html)
- [Chapter 13 notes](./docs/MATH_201_CH13.html)
- [Chapter 14 notes](./docs/MATH_201_CH14.html)

## Source Notebooks

The chapter notes are standalone Pluto notebooks:

- `src/MATH_201_CH10.jl`
- `src/MATH_201_CH11.jl`
- `src/MATH_201_CH13.jl`
- `src/MATH_201_CH14.jl`

Each notebook includes its own imports and helper definitions so it can be opened and exported independently.

The legacy combined source notebook is archived for reference:

- `refs/MATH201_NOTES_legacy.jl`

Use the MATH201 wrapper to regenerate the published chapter notebooks:

```bash
julia --project=. scripts/split_math201_notebook.jl
```

Use the generic splitter directly when you need to override the defaults:

```bash
julia --project=. scripts/split_pluto_chapters.jl --source refs/MATH201_NOTES_legacy.jl --output-prefix MATH_201
```

You can also limit the split to selected chapters:

```bash
julia --project=. scripts/split_pluto_chapters.jl --source refs/MATH201_NOTES_legacy.jl --output-prefix MATH_201 --chapters 10,11
```

## Build And Export

Install Julia dependencies:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

Export the chapter notebooks:

```bash
julia --project=. src/export.jl
```

The exporter updates only the chapter HTML files in `docs/`. It does not regenerate `docs/index.html`.

Export only selected chapters:

```bash
julia --project=. src/export.jl --ch=10
julia --project=. src/export.jl --ch=10,11
```

Publish with a commit message:

```bash
./export_push.sh "Update MATH201 notes"
```

On Windows:

```bat
export_push.bat "Update MATH201 notes"
```

Pass export arguments through the publish scripts after the commit message:

```bash
./export_push.sh "Update selected chapters" --ch=10,11
```

```bat
export_push.bat "Update selected chapters" --ch=10,11
```

## Landing Page

The landing page is maintained directly at `docs/index.html`.

- It is a static branded page, not a generated Julia template.
- Published landing-page assets live under `docs/assets/`.
- Repo-level source assets can remain under `imgs/`, but `docs/index.html` should reference only published paths inside `docs/`.

## Repository Layout

- `src/`: Pluto notebooks and export scripts.
- `docs/`: published static-site output, including the static landing page.
- `docs/assets/`: published assets used by the landing page.
- `imgs/`: course image assets.
- `refs/`: syllabus/reference material and archived legacy sources.
- `notes/`: project plans, specs, and discussion notes.
- `AGENTS.md`: repository-specific guidance for future agent sessions.

## Course Description

This course provides a comprehensive introduction to multivariable calculus, covering parametric and polar curves, vectors, lines, planes, and surfaces in space, cylindrical and spherical coordinates, functions of several variables, partial and directional derivatives, gradients, tangent planes, extrema with and without constraints, and double and triple integrals in various coordinate systems.

## Textbook

Calculus: Early Transcendental Functions, 7th Edition (Metric Version), by Ron Larson and Bruce Edwards.
