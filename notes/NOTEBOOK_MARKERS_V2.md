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

Override any default after the separator — **either `--` or `:`**, whichever is
more natural to type. Everything after the first `--` or `:` is free text and is
read as the override:

```julia
#@ SOL 10.3 ex2 -- show by default
#@ SOL 10.5 ex1: Default show solution is true
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

Two different jobs, two different sources.

**Pending markers — read the live page (the DOM).** Pluto's `/notebookfile`
endpoint serves the last *saved* state and can lag behind cells the user has just
edited, so a `#@` scan against it will wrongly report "nothing pending":

```js
[...document.querySelectorAll('pluto-cell')]
  .map(c => c.querySelector('.cm-content'))
  .filter(m => m && /#@/.test(m.innerText))
```

Note that a **folded** cell does not expose its code in `innerText` — query the
CodeMirror content (`.cm-content`) as above rather than reading the cell.

**Reference material — read `/notebookfile?id=…`.** For anything that is *not*
being edited — an existing `#✓` pair to copy house style from, an example's
statement text, which box helpers exist — the endpoint is far cheaper than walking
the DOM, and staleness is irrelevant because those cells aren't in play:

```js
const id = new URLSearchParams(location.search).get('id')
const src = await fetch(`/notebookfile?id=${id}`).then(r => r.text())
const cells = src.split(/\n# ╔═╡ /).slice(1)   // first line of each = its UUID
```

Beware: file order is **not** display order. Pluto keeps the display order in a
list at the bottom of the file, so the `if …_show_sol` half of a pair often sits
far from its checkbox cell.

When several markers are pending: report the list — section, verb, target — and
wait for the user to choose, rather than doing them all unprompted.

## Editing cells

Do **not** type code into a cell. CodeMirror's auto-indent and bracket-closing
corrupt whitespace inside `cm"""…"""` strings, where leading spaces change the
Markdown. Put the exact text on the clipboard and paste it.

Two things that look like shortcuts and are not:

* A synthetic `paste` `ClipboardEvent` dispatched from JS is **silently ignored**
  by CodeMirror. It returns without error and changes nothing. Dead end.
* `navigator.clipboard.writeText` throws `NotAllowedError: Document is not
  focused` until something has really clicked the page.

So the working procedure is:

1. **One real click** into any cell's code area, to give the document focus.
   After that, `cell.querySelector('.cm-content').focus()` from JS is enough for
   every subsequent cell, and clipboard writes keep working.
2. `await navigator.clipboard.writeText(text)`.
3. **Assert** `document.activeElement` is a `.cm-content` inside the *intended*
   cell before touching the keyboard. Never press `Ctrl+A` on an unverified
   caret — outside an editor, Pluto selects every cell in the notebook.
4. `Ctrl+A`, `Ctrl+V`.
5. `Shift+Enter` runs in place; `Ctrl+Enter` runs **and creates a new cell below**,
   which is how to insert the second cell of a pair. The new cell is focused, so
   step 2 can be repeated straight away for its contents.
6. Fold the code with the cell's eye button ("Show/hide code"):
   `cell.querySelector('button.foldcode').click()`.

Folding notes: a folded cell has **no `.cm-content` in the DOM at all**, so unfold
it before pasting into it and refold afterwards. `classList.contains('code_folded')`
only reflects a fold a tick later — don't read it back in the same statement.

If a click lands unreliably, locate the cell by a distinctive code string and click
the element directly rather than guessing coordinates.

## Verifying the result

Screenshots are unreliable here: whenever the browser tab is backgrounded the
capture comes back blank white, with no error. Don't trust an empty screenshot as
evidence of an empty plot.

The dependable check is to measure the rendered image directly. Pull the output
`<img>` data URI into a canvas and count pixels:

```js
const src = [...cell.querySelectorAll('img')].map(i => i.src)
              .find(s => s.startsWith('data:image'))
const img = new Image(); img.src = src; await img.decode()
// draw to a canvas on white, then getImageData and classify by colour
```

Useful measurements:

* **Colour histogram** (top colours by count) — tells you which layers actually
  rendered. A fill at `fillalpha = α` over white lands at `α·c + (1-α)·255`.
* **Angle histogram about the pole** — bin shaded pixels by `atan2` around the
  plot centre. This is what proves a polar wedge spans the angles it should.
  Locate the centre from a known ray (e.g. a dotted `θ = π/2` line: its `x` is the
  centre `x`, its lower end the centre `y`). Do **not** derive it from the bounding
  box of black pixels — the axis tick labels are black too.
* **Area ratios between two frames** — compare against the analytic integrals.
  Expect a few percent low on small regions; anti-aliased edge pixels fall outside
  a tight colour tolerance.

Also worth knowing: a `Slider(0:105)` reports `max = 106` on its HTML input, since
the input is a 1-based index into the range, not the value.

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
* `\begin{aligned}` works, including `&&` for a right-hand annotation column —
  used for the red `\color{red}{\text{…}}` step labels.
* Box helpers defined in the notebook: `ex(n, title)`, `bbl(title, sub)` … `ebl()`,
  `bth(title)` … `eth()`, `define`, `remark`, `remarks`, plus `warning_box` /
  tip-box HTML helpers.
* Keep generated content inside these helpers so it matches the rest of the notes.

## Plotting pitfalls

* **`fill = true` under `proj = :polar` fills to the *Cartesian* baseline `y = 0`,**
  i.e. the 0°–180° line — not to the pole. A partial sweep therefore leaks all the
  way round to `θ = π`. Close the wedge at the pole explicitly instead:

  ```julia
  θpath = vcat(θ0, ts, θn)
  rpath = vcat(0.0, r.(ts), 0.0)
  plot(θpath, rpath; proj = :polar, fill = true, …)
  ```

  With the path starting and ending at the pole the baseline closure is degenerate,
  and the filled polygon is the true sector. (A full sweep hides this bug, because
  its last point is already at the pole — always check a mid-sweep frame.)
* **Pin `ylims` in any animated plot** (`ylims = (0, 6)`), or the axis rescales
  frame to frame and the curves appear to breathe.
* **Give a sweep a hold at the end of its cycle**, or the completed state flashes
  past for one tick and the animation reads as though it never finishes:

  ```julia
  N, H = 80, 25                                   # sweep frames, held frames
  n = min(mod(clock + scrub, N + H + 1), N)
  ```

  The scrub `Slider` then runs `0:(N+H)`.

## Leave alone

Two cells are intentionally left unfolded and should not be "tidied":
the `sin(π/3), sqrt(3)/2` scratch cell, and the
`md"## Points of Intersection of Polar Graphs"` cell.

## Kick-off phrase for a fresh session

> This is my MATH201 Pluto notebook, open in the browser tab.
> Read `MATH201\notes\notes\NOTEBOOK_MARKERS.md`, then scan the live page for `#@`
> markers and
> report what's pending.
