# MATH201 Notes Cleanup Plan

The repository was initialized from `mmogib/MATH201_NOTES` and updated with the Sem252 migration state. This plan separates safe cleanup from files that should remain until their workflow is confirmed.

## Completed cleanup

- `MATH201_TA_Instructions.txt`
- `MATH201_TA_Instructions_with_Starters.txt`
  - TA-only materials; not referenced by the notes, site, or build workflow.
- `test_export_push.sh`
  - Ad hoc shell-wrapper test; not part of the documented course-notes workflow.
- `Readme.md_old`
  - Superseded documentation copy.
- `.zshrc`
  - Personal shell configuration; only needed by the Dockerfile, so remove it together with the container setup if that setup is retired.
- `src/MATH201_NOTES_242.jl` was moved to `refs/MATH201_NOTES_242.jl`.
  - It remains available for historical comparison without competing with the active chapter sources.

## Completed conditional cleanup

- `Dockerfile`, `docker-compose.yaml`, `postcreate.jl`, and `.zshrc` were removed as one retired container workflow.
- `src/Section11_6.jl`, `src/sec11_5.py`, `src/section_11_5.py`, `hyperboloid_growth.mp4`, and `hyperboloid_sections.mp4` were removed together as retired animation helpers and outputs.

## Keep

- `refs/MATH201_NOTES_legacy.jl` as the archived pre-split source.
- `src/MATH_201_CH10.jl`, `src/MATH_201_CH11.jl`, `src/MATH_201_CH13.jl`, and `src/MATH_201_CH14.jl`.
- `docs/`, `imgs/`, `refs/`, `notes/`, `scripts/`, and the export/publish scripts.

## Recommended order

1. Confirm that TA materials, the old README, and the export-wrapper test are no longer needed.
2. Archive or remove the Term 242 notebook.
3. Run the chapter splitter and exporter, inspect the static landing page, then commit cleanup in one focused change.

The legacy combined notebook has been moved to `refs/MATH201_NOTES_legacy.jl`, and all cleanup items in this plan have now been completed.
