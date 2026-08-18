# AGENTS.md

## Project

This repository contains MATH201 Calculus III course notes authored as Pluto notebooks and exported as a static site.

## Workflow

- Edit notebooks in Pluto.
- Maintain `docs/index.html` directly as a static landing page.
- Export and publish through `export_push.sh` or `export_push.bat` with a commit message.
- Use `src/export.jl` as the build and export entry point.
- `src/export.jl` exports chapter notebooks only; it must not regenerate `docs/index.html`.
- Use `julia --project=. src/export.jl --ch=...` for selective chapter exports when needed.
- Treat `docs/` as the published static-site tree.
- Keep landing-page-only published assets under `docs/assets/`.
- Publish wrappers should run from the repository root and stage only `docs/` unless explicitly redesigned.
- Prefer Julia for repository automation scripts. Do not add Python or a Python environment unless there is a clear technical reason.

## Notebook Split Conventions

- Chapter notebooks should be standalone Pluto notebooks.
- Do not introduce a shared `common.jl` dependency for chapter notebooks.
- Duplicate required imports, helper functions, and setup cells into each standalone chapter notebook.
- Split by Pluto cell boundaries, not by raw line ranges inside a cell.
- Preserve valid Pluto headers and `Cell order` sections.
- The source of truth is the standalone chapter notebooks under `src/`.
- `refs/MATH201_NOTES_legacy.jl` is an archived pre-split source retained only for historical reference or re-running the splitter.
- After validation, archive the legacy notebook under `refs/`.

## Repository Folders

- `src/`: Pluto notebooks and export scripts.
- `docs/`: published static-site output, including the hand-maintained landing page.
- `docs/assets/`: published assets used by the static landing page.
- `imgs/`: course image assets.
- `refs/`: syllabus/reference files and archived legacy sources.
- `notes/`: project plans, specs, and discussion notes.

## Agent Notes

- Save project specs and planning notes under `notes/`, not `docs/superpowers/...`.
- Review `.gitignore` before staging broad generated changes.
- Do not delete or reorganize assets unless explicitly requested.
- Avoid reverting user cleanup or generated changes unless explicitly approved.
