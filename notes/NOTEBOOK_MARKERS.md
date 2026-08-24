# Marker convention — MATH201 Pluto notebooks

A marker is a single comment line, alone in an otherwise-empty cell, placed at the
exact spot where the generated output should appear.

```julia
#@ VERB target -- free-text notes
```

* `#@` = pending, waiting for me.
* `#✓` = done. The line stays as the first line of the generated cell, as a record
  of what that cell is and where it came from.

Scanning for `#@` gives the pending list; scanning for `#✓` gives the history.

## Verbs

| Verb | What gets built |
|---|---|
| `SOL` | Toggable solution — `CheckBox`, hidden by default, content in `bbl("Solution","")` … `ebl()` |
| `ANIM` | PlutoUI `Clock` + scrub `Slider` driving a plot; always visible |
| `PARAM` | Hard-coded constants → labelled sliders; the plot cell is rewired to read them |
| `PLOT` | A static illustrative figure |
| `TABLE` | A table of values in the notebook's style |
| `TIP` / `WARN` | One of the coloured hint / pitfall boxes |
| `FIX` | Something here is wrong — diagnose and repair |

## Target

Enough to locate the work: `10.2 ex4b`, `10.4 ex5`, `10.2 hypocycloid`.
Surrounding cells supply the rest of the context.

## Defaults (so they never need restating)

* Solutions are **hidden** by default; animations are **always visible**.
* Every generated code cell is **folded**.
* Bound variables are namespaced `s10_2_<id>_<what>` — no collisions across the notebook.
* Where a curve has a natural period or domain, it is **computed**, not hard-coded
  (e.g. a hypocycloid closes at `2πB/gcd(A,B)`, never a fudged `20π`).
* Solution prose is **student-facing**, in Larson's voice — projectable in class.

Override any default after the `--`:

```julia
#@ SOL 10.3 ex2 -- show by default
```

## Options

`PARAM` accepts explicit ranges as `range(default)`:

```julia
#@ PARAM 10.2 hypocycloid -- A=2:40(32), B=1:40(14)
```

Omit them and sensible bounds are inferred from the current hard-coded values.

## Working style

When several markers are pending I report the list — section, verb, target — and
wait for you to say which to run, rather than doing them all unprompted.

## Examples

```julia
#@ SOL 10.3 ex2
#@ ANIM 10.4 ex4 -- sweep θ from 0 to 2π, trace the rose r = 2cos3θ
#@ PARAM 10.4 limacon -- a=0:0.5:5(1), b=0:0.5:5(2)
#@ FIX 10.5 ex3 -- the shaded region looks wrong near the pole
#@ TABLE 10.4 ex4 -- θ and r at multiples of π/6
```
