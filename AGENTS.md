# Repository Guidelines

## Project Structure & Module Organization
- `src/`: Pluto notebooks and helpers (e.g., `MATH201_NOTES.jl`, `Section11_6.jl`, small Python helpers).
- `docs/`: Static export. `index.html` is generated; do not edit manually.
- `imgs/`: Figures referenced by notebooks.
- Root: `Project.toml`, `src/export.jl`, `Dockerfile`, `docker-compose.yaml`, `postcreate.jl`.

## Build, Test, and Development Commands
- Install deps: `julia --project=. -e "using Pkg; Pkg.instantiate()"`
- Run Pluto locally: `julia --project=. -e "using Pluto; Pluto.run()"`
- Export site (generates `docs/index.html`): `julia --project=. src/export.jl`
- Preview export: open `docs/index.html` or `python -m http.server -d docs 8000`
- Optional container: `docker compose up --build` (bind-mounts repo; Julia preinstalled).

## Coding Style & Naming Conventions
- Language: Julia (primary) with occasional small Python utilities.
- Indentation: 4 spaces; keep lines focused; avoid trailing whitespace.
- Names: functions/variables `lowercase_with_underscores`; modules/types `CamelCase`.
- Notebooks: main `MATH201_NOTES.jl`; new sections like `SectionNN_M.jl` (e.g., `Section11_6.jl`).
- Images: place in `imgs/` and reference via relative paths.

## Testing Guidelines
- No formal test suite. Validate by:
  - Running the notebook in Pluto without cell errors.
  - Running `src/export.jl` and confirming `docs/index.html` updates.
  - Spot-checking key figures/links render correctly.

## Commit & Pull Request Guidelines
- Commits: short, present-tense summaries with scope (e.g., `update 13.3`, `finish chapter 13`, `add remark on lines`).
- PRs: describe changes, reference affected sections, include screenshots or a note confirming `docs/index.html` renders, and link related issues if any.

## Security & Configuration Tips
- Do not edit `docs/index.html` directly—regenerate via `src/export.jl`.
- Avoid committing large media (videos); prefer external links or compress.
- Keep dependencies minimal; update `Project.toml` intentionally; do not commit secrets.

## Agent-Specific Instructions
- Prefer changes in `src/` and `imgs/`; regenerate exports after edits.
- Do not restructure directories or modify Docker setup unless required by the task.
