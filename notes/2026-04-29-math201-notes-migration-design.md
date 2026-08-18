# MATH201 Notes Migration Design

## Goal

Migrate the MATH201 notes repository from a single-notebook export model to the same multi-chapter, static-landing-page model used in MATH102.

The target state is:

- standalone chapter Pluto notebooks for selected published chapters
- a static branded `docs/index.html`
- a chapter-only export workflow
- updated repository guidance and publish scripts

## Scope

This migration covers:

- notebook splitting
- exporter redesign
- publish wrapper updates
- landing page redesign
- repository documentation and agent guidance updates

This migration does not include:

- deleting the legacy combined source notebook during the first pass
- unrelated cleanup of current dirty worktree items
- restructuring Docker or container setup

## Target Chapters

The published standalone chapter notebooks should be:

- Chapter `10`
- Chapter `11`
- Chapter `13`
- Chapter `14`

These chapters should be inferred and extracted from the Pluto notebook, but the intended published set is explicitly fixed to the four chapter numbers above.

## Split Model

MATH201 should use the same notebook structure as MATH102.

Each chapter notebook should be:

- standalone
- valid as an independent Pluto notebook
- exportable on its own
- free of shared runtime dependencies on a `common.jl` file

The split structure should be:

- `common start`
- chapter-specific content
- `common end`
- Pluto metadata and package cells as needed

The splitter should preserve:

- valid Pluto headers
- correct `Cell order`
- shared imports, helper functions, CSS/setup cells, and other global shared notebook cells required by each standalone notebook

The legacy notebook should remain in place during migration and validation.

## Splitter Approach

Use the same generic splitter model already proven in MATH102.

Expected behavior:

- infer candidate chapter headings automatically from the notebook
- limit generated output to chapters `10`, `11`, `13`, and `14`
- preserve shared notebook cells across all generated chapter notebooks
- support command-line chapter filtering for selective regeneration

The MATH201 repo should receive:

- a generic splitter script
- a course-specific wrapper for MATH201 source defaults

## Landing Page Model

`docs/index.html` should become a static hand-maintained page.

It should no longer be generated from `src/export.jl`.

The page should follow the same overall branded pattern as MATH102:

- course-first layout
- KFUPM branding
- chapter cards as the main action
- academic support sections below the hero

## Branding Direction

The page should use the same institutional design language adopted for MATH102:

- KFUPM logo in the header
- restrained academic tone
- light background
- chapter cards with clear navigational emphasis
- static published assets inside `docs/assets/`

The visual system should remain:

- minimal
- official
- readable
- consistent across course sites

## Landing Page Content

The landing page should include:

### Header

- course title: `MATH201: Calculus III`
- department context
- college context
- prerequisite if included in the source material or existing course guidance
- credit hours: `3-0-3`

The hero must avoid term-specific wording so the page remains reusable.

### Chapter Navigation

The main actions are four chapter cards linking to:

- `MATH_201_CH10.html`
- `MATH_201_CH11.html`
- `MATH_201_CH13.html`
- `MATH_201_CH14.html`

The chapter cards should be the most visually prominent interactive elements on the page.

### Textbook

Use the MATH201 textbook information from the syllabus.

If a suitable textbook image exists locally or can be copied from shared assets appropriately, include it in the textbook block.

### Learning Outcomes

Use the syllabus learning outcomes for MATH201.

### Grading Policy

The page should include:

- Exam I: `75/300 (25%)`
- Exam II: `75/300 (25%)`
- Final Exam: `105/300 (35%)`
- Class Work: `45/300 (15%)`

The classwork formula should be shown explicitly:

```text
y = 9 * (median Ex1% + median Ex2%) / 40
```

The interval should also be shown:

```text
[y - 1.5, y + 1.5]
```

The page should also include a short worked example in plain language.

### Course Description

The page should summarize MATH201 topics such as:

- parametric and polar curves
- vectors, lines, planes, and surfaces
- multivariable functions
- partial and directional derivatives
- extrema
- double and triple integrals

### Footer

The footer should remain quiet and include the same institutional/instructor link pattern used for MATH102, adapted as needed for MATH201.

## Export Model

The current MATH201 exporter still follows the old single-notebook model:

- export `MATH201_NOTES.jl`
- move the exported HTML into `docs/index.html`

This must be replaced.

The new exporter should:

- export chapter notebooks only
- not write or rewrite `docs/index.html`
- support `--ch=10` and `--ch=10,11` style filtering
- validate chapter IDs and error on unknown requested chapters

## Publish Wrapper Model

`export_push.sh` and `export_push.bat` should be updated to match the newer workflow:

- first argument is the commit message
- remaining arguments are passed through to `src/export.jl`

This enables:

- full export publish
- selected chapter publish

without changing the basic user workflow.

## Documentation And Guidance

The following files should be updated to match the new architecture:

- `AGENTS.md`
- `Readme.md`

They should describe:

- static landing page ownership
- chapter-only export behavior
- `docs/assets/` as published landing-page assets
- chapter split conventions
- current workflow expectations

## Success Criteria

The migration is successful if:

- MATH201 has standalone published chapter notebooks for `10`, `11`, `13`, and `14`
- the landing page is static and branded
- `src/export.jl` exports chapters only
- `docs/index.html` survives exports unchanged
- wrapper scripts support export argument passthrough
- repo guidance reflects the new architecture
- the legacy combined notebook remains available during validation

