# Marker convention & workflow — MATH201 Pluto notebooks

Notebook: `E:\Dropbox\KFUPMWork\Teaching\OldSemesters\Sem261\MATH201\notes\src\MATH_201_CH10.jl`
This file: `…\MATH201\notes\notes\NOTEBOOK_MARKERS.md`
Served by Pluto at `http://localhost:1201/edit?id=…` (the `id` is assigned fresh each time
Pluto restarts — it is not stable, so never rely on it).

---

# Part 1 — The convention

A marker is a single comment line, alone in an otherwise-empty cell, placed at the
exact spot where the generated output should appear.

```julia
#@ VERB target -- free-text notes
```

* `#@` = pending, waiting for Claude.
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

## Examples

```julia
#@ SOL 10.3 ex2
#@ ANIM 10.4 ex4 -- sweep θ from 0 to 2π, trace the rose r = 2cos3θ
#@ PARAM 10.4 limacon -- a=0:0.5:5(1), b=0:0.5:5(2)
#@ FIX 10.5 ex3 -- the shaded region looks wrong near the pole
#@ TABLE 10.4 ex4 -- θ and r at multiples of π/6
```

---

# Part 2 — Workflow for Claude

## Scanning

Read markers from the **live page** (the DOM), not from Pluto's `/notebookfile`
endpoint. That endpoint serves the last *saved* state and can lag behind cells the
user has just edited — a scan against it will wrongly report "nothing pending".

Note that a **folded** cell does not expose its code in `innerText`; query the
CodeMirror content (`.cm-content`) instead when checking folded cells.

When several markers are pending: report the list — section, verb, target — and
wait for the user to choose, rather than doing them all unprompted.

## Editing cells

Do **not** type code into a cell. CodeMirror's auto-indent and bracket-closing
corrupt whitespace inside `cm"""…"""` strings, where leading spaces change the
Markdown. Instead put the exact text on the clipboard and paste it:

1. Click into the cell's code area (verify the caret is in the editor).
2. `Ctrl+A`, `Ctrl+V`.
3. `Shift+Enter` runs in place; `Ctrl+Enter` runs **and creates a new cell below**,
   which is how to insert the second cell of a pair.
4. Fold the code with the cell's eye button ("Show/hide code").

**Never press `Ctrl+A` unless the caret is inside an editor.** Outside one, Pluto
selects every cell in the notebook.

If a click lands unreliably, locate the cell by a distinctive code string and click
the element directly rather than guessing coordinates.

## Cell pairs

A Pluto cell cannot read a variable it binds, so a toggle is always **two** cells:

```julia
#✓ SOL 10.3 ex2
begin
    s10_3_ex2_sol_box = @bind s10_3_ex2_show_sol CheckBox(default=false)
    cm"""
$(s10_3_ex2_sol_box) **Show Solution**
"""
end
```

```julia
if s10_3_ex2_show_sol
    cm"""
$(bbl("Solution",""))
… solution text …
$(ebl())
"""
else
    md""
end
```

`ANIM` is likewise two cells: one binding `Clock` + `Slider`, one drawing the plot
from a frame index such as `n = mod(clock + scrub, N+1)`.

## House style

* `cm"""…"""` is a **macro string**: no escape processing, so `\frac`, `\left`,
  `\theta` are safe unescaped. `$(…)` interpolation still works.
* Inline math is double backticks; display math is a ```` ```math ```` fence.
* Box helpers defined in the notebook: `ex(n, title)`, `bbl(title, sub)` … `ebl()`,
  `bth(title)` … `eth()`, `define`, `remark`, `remarks`, plus `warning_box` /
  tip-box HTML helpers.
* Keep generated content inside these helpers so it matches the rest of the notes.

## Leave alone

Two cells are intentionally left unfolded and should not be "tidied":
the `sin(π/3), sqrt(3)/2` scratch cell, and the
`md"## Points of Intersection of Polar Graphs"` cell.

## Kick-off phrase for a fresh session

> This is my MATH201 Pluto notebook, open in the browser tab.
> Read `MATH201\notes\notes\NOTEBOOK_MARKERS.md`, then scan the live page for `#@`
> markers and
> report what's pending.
