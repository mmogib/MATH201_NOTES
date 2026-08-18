# MATH201 Notes Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert the MATH201 notes repo from a single-notebook export model into a multi-chapter notebook workflow with a static branded landing page, chapter-only exporter, and updated project guidance.

**Architecture:** Port the proven MATH102 pattern into the MATH201 repository: add the generic Pluto chapter splitter and a MATH201 wrapper, generate standalone chapter notebooks for chapters `10`, `11`, `13`, and `14`, replace the old single-notebook exporter with a chapter-only exporter supporting `--ch`, and maintain `docs/index.html` as a static branded page with published assets inside `docs/assets/`.

**Tech Stack:** Julia (`PlutoSliderServer`), static HTML/CSS, existing Pluto notebooks, repository-local assets, and syllabus content from `refs/math201-252.pdf`

---

## File Map

- Create: `..\..\MATH201\notes\scripts\split_pluto_chapters.jl`
  - Generic splitter ported from MATH102 and adapted only as needed.
- Create: `..\..\MATH201\notes\scripts\split_math201_notebook.jl`
  - MATH201 wrapper script with source defaults and published chapter selection.
- Modify: `..\..\MATH201\notes\src\export.jl`
  - Replace the single-notebook `mv(..., docs/index.html)` model with chapter-only export and `--ch` support.
- Modify: `..\..\MATH201\notes\export_push.sh`
  - Pass exporter args through after the commit message.
- Modify: `..\..\MATH201\notes\export_push.bat`
  - Pass exporter args through after the commit message.
- Modify: `..\..\MATH201\notes\docs\index.html`
  - Replace the generated single-page output with a static branded landing page.
- Create: `..\..\MATH201\notes\docs\assets\...`
  - Published landing-page assets such as logo and textbook image if needed.
- Modify: `..\..\MATH201\notes\AGENTS.md`
  - Update workflow and static-landing-page ownership.
- Modify: `..\..\MATH201\notes\Readme.md`
  - Update split/export/publish documentation.
- Verify only: `..\..\MATH201\notes\refs\MATH201_NOTES_legacy.jl`
  - Source notebook for chapter inference and split validation.
- Verify only: `..\..\MATH201\notes\refs\math201-252.pdf`
  - Course metadata, learning outcomes, grading policy, and chapter coverage.

### Task 1: Add The Generic Splitter And MATH201 Wrapper

**Files:**
- Create: `..\..\MATH201\notes\scripts\split_pluto_chapters.jl`
- Create: `..\..\MATH201\notes\scripts\split_math201_notebook.jl`
- Verify: `..\..\MATH201\notes\refs\MATH201_NOTES_legacy.jl`

- [ ] **Step 1: Inspect MATH201 notebook structure before copying logic**

Run:

```powershell
Get-Content ..\..\MATH201\notes\refs\MATH201_NOTES_legacy.jl -TotalCount 200
```

Expected:

- Pluto notebook header present
- enough evidence of heading cells and shared setup cells to justify using the MATH102 splitter architecture

- [ ] **Step 2: Copy the generic splitter from MATH102 into the MATH201 repo**

Create:

- `..\..\MATH201\notes\scripts\split_pluto_chapters.jl`

using the proven MATH102 splitter as the starting point.

Preserve core behavior:

- read Pluto notebook cells and cell order
- infer chapter headings
- preserve common start/common end
- write valid standalone Pluto notebooks
- support `--source`, `--output-dir`, `--output-prefix`, and `--chapters`

- [ ] **Step 3: Create the MATH201 wrapper**

Create:

- `..\..\MATH201\notes\scripts\split_math201_notebook.jl`

The wrapper should call the generic splitter with:

- source notebook: `refs/MATH201_NOTES_legacy.jl`
- output dir: `src`
- output prefix: `MATH_201`
- chapter list limited to `10`, `11`, `13`, `14`

Equivalent target shape:

```julia
include(joinpath(@__DIR__, "split_pluto_chapters.jl"))

const ROOT = normpath(joinpath(@__DIR__, ".."))

function main()
    split_pluto_chapters(
        source = joinpath(ROOT, "refs", "MATH201_NOTES_legacy.jl"),
        output_dir = joinpath(ROOT, "src"),
        output_prefix = "MATH_201",
        chapters = ["10", "11", "13", "14"],
    )
end

main()
```

- [ ] **Step 4: Run the wrapper and generate the chapter notebooks**

Run:

```powershell
julia --project=. ..\..\MATH201\notes\scripts\split_math201_notebook.jl
```

Expected:

- chapter notebooks are written under `..\..\MATH201\notes\src\`
- target files include:
  - `MATH_201_CH10.jl`
  - `MATH_201_CH11.jl`
  - `MATH_201_CH13.jl`
  - `MATH_201_CH14.jl`

- [ ] **Step 5: Sanity-check the generated outputs**

Run:

```powershell
Get-ChildItem ..\..\MATH201\notes\src\MATH_201_CH*.jl
```

Expected: all four target chapter notebooks exist.

- [ ] **Step 6: Commit the splitter port**

Run:

```powershell
git -C ..\..\MATH201\notes add scripts\split_pluto_chapters.jl scripts\split_math201_notebook.jl src\MATH_201_CH10.jl src\MATH_201_CH11.jl src\MATH_201_CH13.jl src\MATH_201_CH14.jl
git -C ..\..\MATH201\notes commit -m "Add MATH201 chapter split workflow"
```

Expected: one focused commit for the splitter and generated chapter notebooks.

### Task 2: Replace The Exporter And Publish Wrappers

**Files:**
- Modify: `..\..\MATH201\notes\src\export.jl`
- Modify: `..\..\MATH201\notes\export_push.sh`
- Modify: `..\..\MATH201\notes\export_push.bat`

- [ ] **Step 1: Replace the old single-notebook exporter**

Read the current exporter:

```powershell
Get-Content ..\..\MATH201\notes\src\export.jl
```

Expected: single notebook export plus `mv(source, dest, force = true)`.

Then replace it with the MATH102-style chapter exporter adapted for MATH201 notebooks:

- note list for chapters `10`, `11`, `13`, `14`
- `--ch=10` and `--ch=10,11`
- unknown chapter validation
- no `docs/index.html` generation or renaming

- [ ] **Step 2: Verify exporter help**

Run:

```powershell
julia --project=. ..\..\MATH201\notes\src\export.jl --help
```

Expected: usage text mentioning `--ch=10,11`.

- [ ] **Step 3: Verify selective export**

Run:

```powershell
julia --project=. ..\..\MATH201\notes\src\export.jl --ch=10
```

Expected:

- export succeeds
- chapter 10 HTML is regenerated
- `docs/index.html` is not rewritten

- [ ] **Step 4: Verify invalid chapter rejection**

Run:

```powershell
julia --project=. ..\..\MATH201\notes\src\export.jl --ch=10,99
```

Expected: exit failure with a clear unknown-chapter error.

- [ ] **Step 5: Update shell publish wrapper**

Modify `..\..\MATH201\notes\export_push.sh` so:

- `$1` is the commit message
- remaining arguments pass through to `src/export.jl`

Target usage:

```bash
./export_push.sh "Update selected chapters" --ch=10,11
```

- [ ] **Step 6: Update batch publish wrapper**

Modify `..\..\MATH201\notes\export_push.bat` so:

- `%~1` is the commit message
- remaining arguments pass through to `src\export.jl`

- [ ] **Step 7: Commit exporter and wrapper changes**

Run:

```powershell
git -C ..\..\MATH201\notes add src\export.jl export_push.sh export_push.bat
git -C ..\..\MATH201\notes commit -m "Update MATH201 export and publish workflow"
```

Expected: one focused commit for exporter and wrappers.

### Task 3: Build The Static Branded Landing Page

**Files:**
- Modify: `..\..\MATH201\notes\docs\index.html`
- Create: `..\..\MATH201\notes\docs\assets\...`
- Verify: `..\..\MATH201\notes\refs\math201-252.pdf`
- Inspect: `..\..\MATH201\notes\imgs\`

- [ ] **Step 1: Identify landing-page assets**

Run:

```powershell
Get-ChildItem ..\..\MATH201\notes\imgs
```

Expected: determine whether a suitable textbook image already exists. If not, plan to copy one into `docs/assets/`.

- [ ] **Step 2: Replace docs/index.html with a static page**

Rewrite `..\..\MATH201\notes\docs\index.html` as a static branded landing page with:

1. KFUPM-branded header
2. course title `MATH201: Calculus III`
3. course metadata with `3-0-3`
4. chapter cards for `10`, `11`, `13`, `14`
5. textbook block
6. learning outcomes
7. grading policy
8. course description
9. quiet footer links

Avoid:

- generated-export language
- term-specific hero wording
- dependence on image paths outside `docs/`

- [ ] **Step 3: Add published assets inside docs/assets**

Create `..\..\MATH201\notes\docs\assets\` and place any landing-page-only assets there, such as:

- KFUPM logo image
- textbook cover if used

Then update `docs/index.html` to reference only paths inside `docs/`, for example:

```html
<img src="assets/kfupm_logo_secondary_07.png" alt="KFUPM logo">
```

- [ ] **Step 4: Add the MATH201 grading formula and example**

The landing page must include:

```text
Exam I: 75/300 (25%)
Exam II: 75/300 (25%)
Final Exam: 105/300 (35%)
Class Work: 45/300 (15%)
```

and:

```text
y = 9 * (median Ex1% + median Ex2%) / 40
```

plus:

```text
[y - 1.5, y + 1.5]
```

and one plain-language worked example.

- [ ] **Step 5: Verify the static page content**

Run:

```powershell
Get-Content ..\..\MATH201\notes\docs\index.html
```

Expected:

- all required sections present
- all chapter links present
- no `../imgs/...` references
- all landing-page assets referenced from `docs/assets/`

- [ ] **Step 6: Commit the landing page**

Run:

```powershell
git -C ..\..\MATH201\notes add docs\index.html docs\assets
git -C ..\..\MATH201\notes commit -m "Add static branded MATH201 landing page"
```

Expected: one focused commit for the landing page and published assets.

### Task 4: Update AGENTS.md And Readme.md

**Files:**
- Modify: `..\..\MATH201\notes\AGENTS.md`
- Modify: `..\..\MATH201\notes\Readme.md`

- [ ] **Step 1: Update AGENTS.md workflow guidance**

Revise `..\..\MATH201\notes\AGENTS.md` so it matches the MATH102-style architecture:

- `docs/index.html` is static and maintained directly
- `src/export.jl` exports chapter notebooks only
- `docs/assets/` contains landing-page assets
- `notes/` and `refs/` should be used as intended

Remove or replace any guidance saying `docs/index.html` is generated and should never be edited manually.

- [ ] **Step 2: Update Readme.md**

Revise `..\..\MATH201\notes\Readme.md` to document:

- standalone chapter notebooks
- splitter usage
- chapter-only export
- `--ch=...` support
- wrapper pass-through usage
- static landing page ownership
- published assets under `docs/assets/`

- [ ] **Step 3: Commit documentation updates**

Run:

```powershell
git -C ..\..\MATH201\notes add AGENTS.md Readme.md
git -C ..\..\MATH201\notes commit -m "Update MATH201 project guidance"
```

Expected: one focused commit for repo guidance.

### Task 5: End-To-End Verification

**Files:**
- Verify: `..\..\MATH201\notes\src\export.jl`
- Verify: `..\..\MATH201\notes\docs\index.html`
- Verify: `..\..\MATH201\notes\docs\MATH_201_CH10.html`
- Verify: `..\..\MATH201\notes\docs\MATH_201_CH11.html`
- Verify: `..\..\MATH201\notes\docs\MATH_201_CH13.html`
- Verify: `..\..\MATH201\notes\docs\MATH_201_CH14.html`

- [ ] **Step 1: Run full export**

Run:

```powershell
julia --project=. ..\..\MATH201\notes\src\export.jl
```

Expected:

- all four chapter HTML files export successfully
- `docs/index.html` remains unchanged

- [ ] **Step 2: Confirm landing page stability**

Run:

```powershell
git -C ..\..\MATH201\notes diff -- docs/index.html
```

Expected: no new exporter-induced diff in `docs/index.html`.

- [ ] **Step 3: Run whitespace and patch checks**

Run:

```powershell
git -C ..\..\MATH201\notes diff --check
```

Expected: no whitespace errors in the intended changed files.

- [ ] **Step 4: Inspect final summary**

Run:

```powershell
git -C ..\..\MATH201\notes status --short
git -C ..\..\MATH201\notes diff --stat
```

Expected:

- intended files are changed
- unrelated pre-existing dirty files remain clearly distinguishable

- [ ] **Step 5: Commit refreshed chapter exports if intended**

If the refreshed chapter HTML exports should be included, commit them deliberately:

```powershell
git -C ..\..\MATH201\notes add docs\MATH_201_CH10.html docs\MATH_201_CH11.html docs\MATH_201_CH13.html docs\MATH_201_CH14.html
git -C ..\..\MATH201\notes commit -m "Refresh exported MATH201 chapters"
```

## Self-Review

### Spec coverage

Covered requirements:

- chapters `10`, `11`, `13`, `14`
- generic splitter plus MATH201 wrapper
- static branded landing page
- chapter-only exporter
- `--ch` support with validation
- wrapper-script passthrough
- updated `AGENTS.md` and `Readme.md`
- `docs/assets/` ownership
- legacy notebook retained during validation

No major spec gaps found.

### Placeholder scan

Checked for `TBD`, `TODO`, and vague implementation language. The plan gives concrete files, commands, and expected outcomes throughout.

### Type consistency

The plan consistently assumes:

- chapter notebook names use the `MATH_201_CHNN` pattern
- `docs/index.html` is static
- `src/export.jl` is chapter-only
- published landing-page assets live inside `docs/assets/`
