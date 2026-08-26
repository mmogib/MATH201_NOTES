### A Pluto.jl notebook ###
# v1.0.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 83571d10-7eff-11f0-10db-391640417d07
begin
    using CommonMark
    using PlutoUI, PlutoExtras
    using Plots, PlotThemes, LaTeXStrings
    # using PyPlot
    using Latexify
    using HypertextLiteral
    using Colors
    using LinearAlgebra, Random, Printf, SparseArrays
    using Symbolics, Nemo, Groebner
    # using SymPy
    using QRCoders
    using PrettyTables
    # using Primes
    # using LinearSolve
    # using NonlinearSolve
    using ForwardDiff
    # using Integrals
    # using OrdinaryDiffEq
    using Unitful
end

# ╔═╡ 9858d0f8-ba7e-44fe-bcfc-4af064b7985c
TableOfContents(title="📚 MATH201: Calculus III", indent=true, depth=4)

# ╔═╡ 286b172a-8bfe-430c-b13b-83e0e14798d1
begin
    struct LocalImage
        filename
    end

    function Base.show(io::IO, ::MIME"image/png", w::LocalImage)
        write(io, read(w.filename))
    end
end

# ╔═╡ dc65d765-0bef-4c49-93af-1cd0ebabe632
md"""# 10.2 Plane Curves and Parametric equations

__Objectives__:

> - Sketch the graph of a curve given by a set of parametric equations.
> - Eliminate the parameter in a set of parametric equations.
> - Find a set of parametric equations to represent a curve.
> - __(READ ONLY)__Understand two classic calculus problems, the tautochrone and brachistochrone problems.
## Plane Curves and Parametric Equations
"""

# ╔═╡ bf29e57e-d859-4d73-876c-46d6a7805228
md"""
Consider the equation
```math
y = -x^2 + x + 10
```

Imagine an a person is walking and following this path.
This equation
- tell you where the person has been
- __BUT does NOT tell__ when the object was at a given point ``(x, y)``.

"""

# ╔═╡ c0fe5d64-6d06-4daf-a827-87e2a98b7389
begin
    s10_2_t_slider = @bind s10_2_t Slider(0:10, show_value=true)
    s10_2_xt_input = @bind s10_2_xt TextField(20, default="t", placeholder="Enter a function of t")
    cm"""
    t = $s10_2_t_slider

    x = $s10_2_xt_input
    """
end

# ╔═╡ b15e87af-7574-48a7-b014-ef0ad8f3ea62
let 
    f(y) = -y^2 + y + 1; xf = eval(Meta.parse("t -> ($s10_2_xt)")); xv = Base.invokelatest(xf, s10_2_t); p = plot(f; framestyle=:origin, xlimits=(0, 2), label=L"y=-x^2 + x + 1"); scatter(p, [xv], [f(xv)], label="Person") 
end

# ╔═╡ 7ab904a8-91e2-4814-9eba-3e55f35f0503
## Cell 7
let
    t = [-2, -1, 0, 1, 2, 3]
    x(t) = t^2 - 4
    y(t) = t / 2

    annot(t) = (x(t) + 0.52, y(t) + 0.1, L"t=%$t", 8)

    p = plot(x.(t[1]:0.1:t[end]), y.(t[1]:0.1:t[end]), label=nothing)
    p = scatter(p, x.(t), y.(t), aspect_ratio=1, framestyle=:origin, xlimits=(-5, 6), ylimits=(-2, 4), label=nothing, annotations=annot.(t))
    function get_table()
        tbl_str = "<table>
              <thead>
                  <tr>
                      <th>t</th>
                      <th>x</th>
                      <th>y</th>
                  </tr>
              </thead>
              <tbody>"

        for ti in t
            tbl_str *= "<tr><td> $ti </td><td> $(x(ti))</td><td> $(y(ti))</td></tr>"
        end
        tbl_str *= "</tbody></table>"
    end
    cm"""
    $(get_table())

    $p
    """
end

# ╔═╡ 3fad0402-00d4-4c3b-9ca7-bed4897452c2

## Cell 8
md"##  Eliminating the Parameter"

# ╔═╡ ef07b8c6-a4a8-4daa-8843-39d522f995ef
begin
    s10_2_t_e2_slider = @bind s10_2_t_e2 Slider(-0.99:1:100, show_value=true)
    cm"""
    t = $s10_2_t_e2_slider

    """
end

# ╔═╡ 4ba93c73-86c0-447e-bc4e-c4eafe68d3ca
let
    x(t) = 1/sqrt(1+t)
    y(t) = t/(1+t)
    ts = -0.999:0.1:s10_2_t_e2
    p = plot(x.(ts),y.(ts); framestyle=:origin, xlimits=(-0.1, 2), ylimits=(-1,2),label=L"y=1-x^2")
    scatter(p, [x(s10_2_t_e2)], [y(s10_2_t_e2)], label=nothing)
    # ""
end

# ╔═╡ 9c8987f5-a609-45df-94f0-99c372e5876d
#✓ SOL 10.2 ex3
begin
    s10_2_ex3_sol_box = @bind s10_2_ex3_show_sol CheckBox(default=true)
    cm"""
$(s10_2_ex3_sol_box) **Show Solution**
"""
end


# ╔═╡ 15a0e2e8-382e-487a-a297-12feaaab6f91

## Cell 13
begin
    s10_2_ex3_input = @bind s10_2_ex3 NumberField(0:0.1:2π+0.1)
    cm"""
    ``\theta = `` $(s10_2_ex3_input)
    """
end

# ╔═╡ 948e5b3a-40a2-4081-85f8-12c42837ae3a

## Cell 14
let
    a = 0.0
    b = s10_2_ex3
    x(t) = 3cos(t)
    y(t) = 4sin(t)
    t = a:0.01:b
    p = plot(x.(t), y.(t), aspect_ratio=1, framestyle=:origin, label=nothing, xlimit=(-5, 5), ylimits=(-5, 5))
    scatter(p, [x(b)], [y(b)], label=nothing)
end

# ╔═╡ b8d18b8b-43e7-4ce8-8942-d01454614f3d
## Cell 18
md"##  Finding Parametric Equations"

# ╔═╡ d3f76ebe-9587-4f85-aa8c-c068478855e3
#✓ SOL 10.2 ex4b
begin
    s10_2_ex4_sol_box = @bind s10_2_ex4_show_sol CheckBox(default=true)
    cm"""
$(s10_2_ex4_sol_box) **Show Solution**
"""
end


# ╔═╡ 8f4206ed-c4de-42f9-8539-ffabf79306b2
#✓ ANIM 10.2 ex4b
begin
    s10_2_ex4_clock_box = @bind s10_2_ex4_k Clock(0.12)
    s10_2_ex4_scrub_box = @bind s10_2_ex4_j Slider(0:60, default=0)
    cm"""
**Animate** $(s10_2_ex4_clock_box)

**Scrub** $(s10_2_ex4_scrub_box)
"""
end


# ╔═╡ c4d041e7-214a-4eb4-8e4a-f4308efd6a83
let
    N = 60
    n = mod(s10_2_ex4_k + s10_2_ex4_j, N + 1)
    s = n / N
    f(x) = 1 - x^2
    xs = range(-2, 2, length=250)

    t = -2 + 4s
    m = -4 + 8s
    ta = range(-2, t, length=150)
    mb = range(-4, m, length=150)
    xb = -m / 2
    yb = 1 - m^2 / 4

    opts = (framestyle=:origin, xlims=(-2.6, 2.6), ylims=(-3.8, 2.2),
        legend=false, titlefontsize=10, grid=false)

    pa = plot(xs, f.(xs); color=:gray, lw=1, alpha=0.5,
        title=L"(a)\quad x=t,\ \ y=1-t^2", opts...)
    plot!(pa, ta, f.(ta); color=:red, lw=3)
    scatter!(pa, [t], [f(t)]; color=:red, ms=6)
    annotate!(pa, 0, -3.4, text("t = $(round(t, digits=2))   (moving right)", 9, :red))

    pb = plot(xs, f.(xs); color=:gray, lw=1, alpha=0.5,
        title=L"(b)\quad x=-m/2,\ \ y=1-m^2/4", opts...)
    plot!(pb, -mb ./ 2, 1 .- (mb .^ 2) ./ 4; color=:blue, lw=3)
    scatter!(pb, [xb], [yb]; color=:blue, ms=6)
    annotate!(pb, 0, -3.4, text("m = $(round(m, digits=2))   (moving left)", 9, :blue))

    plot(pa, pb; layout=(1, 2), size=(760, 330))
end


# ╔═╡ efb426c5-ac63-4360-86e4-b579b847b69a
## Cell 21
begin
    s10_2_ex5_slider = @bind s10_2_ex5 Slider(0:0.1:10π)
    cm"""
    ``\theta = `` $s10_2_ex5_slider
    """

end

# ╔═╡ 0d8c28f3-b885-4b16-95ef-99708a6bb179
## Cell 22
let
    a = 2
    θ = s10_2_ex5
    b = a * θ
    x(t) = a * sin(t) + b
    y(t) = a * cos(t) + a
    xs(t) = a * (t - sin(t))
    ys(t) = a * (1 - cos(t))
    ts = 0.0:0.01:2π+0.01
    p = plot(x.(ts), y.(ts), framestyle=:origin, aspect_ratio=1, label=nothing)
    p = plot(p, xticks=(collect(0:π:10π), ["$(i)π" for i in 1:10]), xlimits=(-a - 1, 10π), ylimits=(-1, 2a + 1))
    p = plot(p, xs.(0:0.01:θ), ys.(0:0.01:θ), label=nothing)
    p = scatter(p, [xs(θ)], [ys(θ)], label=nothing)
    annotate!(p, [(5π, 2a + 5, L"x=a(\theta-\sin{\theta})"), (5π, 2a + 3, L"y=a(1-\cos{\theta)}")])
end

# ╔═╡ 310a267a-288d-4ab7-a8c6-4700b951703a
#✓ PARAM 10.2 hypocycloid
begin
    s10_2_hypo_A_box = @bind s10_2_hypo_A Slider(2:40, default=32, show_value=true)
    s10_2_hypo_B_box = @bind s10_2_hypo_B Slider(1:40, default=14, show_value=true)
    cm"""
**Hypocycloid** ``H(A,B)`` — drag to change the radii (we need ``B \lt A``)

``A = `` $(s10_2_hypo_A_box)

``B = `` $(s10_2_hypo_B_box)
"""
end


# ╔═╡ 676045ab-7fa0-48ab-a215-1e0a9abfdf1e
#✓ PARAM 10.2 epicycloid
begin
    s10_2_epi_A_box = @bind s10_2_epi_A Slider(1:40, default=7, show_value=true)
    s10_2_epi_B_box = @bind s10_2_epi_B Slider(1:40, default=5, show_value=true)
    cm"""
**Epicycloid** ``E(A,B)`` — drag to change the radii

``A = `` $(s10_2_epi_A_box)

``B = `` $(s10_2_epi_B_box)
"""
end


# ╔═╡ ebc1271e-0fcf-47bc-bf74-850b1d2ed425
let
    A = s10_2_epi_A
    B = s10_2_epi_B

    d = gcd(A, B)
    tmax = 2 * pi * B / d
    t = range(0, tmax, length=4000)
    c = range(0, 2 * pi, length=400)

    x = (A + B) .* cos.(t) .- B .* cos.((A + B) / B .* t)
    y = (A + B) .* sin.(t) .- B .* sin.((A + B) / B .* t)

    R = A + 2B + 1
    p = plot(A .* cos.(c), A .* sin.(c);
        color=:gray, ls=:dash, lw=1, label="fixed circle, radius A = $(A)")
    plot!(p, x, y;
        aspect_ratio=:equal, lw=1.4, color=:red, label="E($(A),$(B))",
        framestyle=:origin, xlims=(-R, R), ylims=(-R, R),
        title="Epicycloid  E($(A),$(B))   -   $(div(A, d)) cusps",
        titlefontsize=11, size=(560, 560))
    xlabel!(p, "x")
    ylabel!(p, "y")
    p
end


# ╔═╡ 96b650e7-d4ce-478f-878f-d9cd6d10f2b6
# Section 10.3: Parametric Equations and Calculus - Verbatim Content

## Cell 1
md"# 10.3 Parametric Equations and Calculus"

## Cell 2

# ╔═╡ b64864dc-953d-41c5-bae6-5ede6734c8af
cm"""
__Objectives__

> 1. Find the slope of a tangent line to a curve given by a set of parametric equations.
> 1. Find the arc length of a curve given by a set of parametric equations.
> 1. Find the area of a surface of revolution (parametric form).
"""

## Cell 3

# ╔═╡ 76ace408-0ae7-458e-9b0a-cc6c3a314cd2
md"##  Slope and Tangent Lines"

## Cell 4

# ╔═╡ 58873013-9dd1-4a76-84a7-6f43462dbcb6
#✓ SOL 10.3 ex2
begin
    s10_3_ex2_sol_box = @bind s10_3_ex2_show_sol CheckBox(default=true)
    cm"""
$(s10_3_ex2_sol_box) **Show Solution**
"""
end


# ╔═╡ 2ac5fa04-03d8-4725-88d0-6f76213e5fa6
#✓ SOL 10.3 ex3
begin
    s10_3_ex3_sol_box = @bind s10_3_ex3_show_sol CheckBox(default=true)
    cm"""
$(s10_3_ex3_sol_box) **Show Solution**
"""
end


# ╔═╡ 29c142be-48e3-488f-b8fb-3b9c34de64b0
begin
    s10_3_ex3_slider = @bind s10_3_ex3_t Slider(-2:0.1:2, show_value=true)
    cm"""
    ``t = `` $s10_3_ex3_slider
    """
end

## Cell 10

# ╔═╡ 698c533c-4bca-44ae-ab4b-68a107e1db2a
let
    ts = -2.0:0.001:s10_3_ex3_t
    x(t) = 2t - π * sin(t)
    y(t) = 2 - π * cos(t)
    p = plot(x.(ts), y.(ts),
        frame_style=:origin, aspect_ratio=1,
        title="Prolate cycloid",
        label=nothing,
        xlimits=(-7, 7), xticks=([-π, 0, π], [L"-\pi", L"0", L"\pi"]),
        ylimits=(-3, 7), yticks=(collect(-2:2:6), [L"%$i" for i in -2:2:6]),
        c=:black
    )

    scatter!([x(s10_3_ex3_t)], [y(s10_3_ex3_t)], label=nothing, m=(2, 3))
    if s10_3_ex3_t >= 1.9
        plot!([x -> x * (-π / 2) + 2, x -> x * (π / 2) + 2], c=:blue, lw=0.6, label=nothing)
    end
    p
end

## Cell 11

# ╔═╡ 48467e30-614d-4ab9-852d-6e7f19bd2a3b
md"## Arc Length"

## Cell 12

# ╔═╡ 2497c799-3aad-451d-abc6-30aa20aa6924
#✓ SOL 10.3 ex4
begin
    s10_3_ex4_sol_box = @bind s10_3_ex4_show_sol CheckBox(default=true)
    cm"""
$(s10_3_ex4_sol_box) **Show Solution**
"""
end


# ╔═╡ d6ccee4f-40be-429b-860e-f53067077a14
begin
    s10_3_ex4_slider = @bind s10_3_ex4 Slider(0:0.1:2π, show_value=true)
    cm"""
    ``t = `` $s10_3_ex4_slider
    """

end

## Cell 15

# ╔═╡ c65a1abc-85c1-44a1-bce1-adddb8d8781c
let
    ts = 0.0:0.01:2π+0.1
    tsd = 0.0:0.01:s10_3_ex4
    r = 1
    R = 4 + r
    h, k = R * cos(s10_3_ex4), R * sin(s10_3_ex4)
    P = [R * cos(s10_3_ex4) - cos(R * s10_3_ex4), R * sin(s10_3_ex4) - sin(R * s10_3_ex4)]
    p = plot(4sin.(ts), 4cos.(ts),
        frame_style=:origin, aspect_ratio=1,
        title="Epicycloid",
        label=nothing,
        xlimits=(-7, 7), xticks=(collect(-6:2:6), [L"%$i" for i in -6:2:6]),
        ylimits=(-7, 7), yticks=(collect(-6:2:6), [L"%$i" for i in -6:2:6]),
        c=:black, lw=0.5
    )
    plot!(h .+ r * sin.(ts), k .+ r * cos.(ts), label=nothing)
    plot!([P[1]], [P[2]], series=scatter, seriestype=:scatter, label=nothing)
    plot!(R * cos.(tsd) - cos.(R * tsd), R * sin.(tsd) - sin.(R * tsd), label=nothing)
end

## Cell 16

# ╔═╡ b2c1aaf8-c0e8-4ff2-a32c-69e797063a16
md"## Area of a Surface of Revolution"

## Cell 17

# ╔═╡ 46c3a799-1982-419c-9254-9604ad95c926
sin(π/3), sqrt(3)/2

# ╔═╡ 7c1266f6-2f5d-4fdf-af5a-67fa202ddae2
#✓ SOL 10.3 ex5
begin
    s10_3_ex5_sol_box = @bind s10_3_ex5_show_sol CheckBox(default=true)
    cm"""
$(s10_3_ex5_sol_box) **Show Solution**
"""
end


# ╔═╡ 01984662-0b51-4178-97cd-584628c58ed2
#✓ PLOT 10.3 Kahoot Q7
let
    t = range(0, pi / 3, length=300)
    c = range(0, 2 * pi, length=400)
    xe, ye = 1.5, 3 * sqrt(3) / 2

    p = plot(3 .* cos.(c), 3 .* sin.(c);
        color=:gray, ls=:dash, lw=1, label=L"x^2+y^2=9",
        aspect_ratio=:equal, framestyle=:origin,
        xlims=(-4.2, 4.6), ylims=(-4.0, 4.0),
        legend=:bottomleft, size=(580, 500))

    plot!(p, [-4.0, 4.4], [0, 0]; color=:steelblue, lw=3, alpha=0.45,
        label="axis of revolution")

    plot!(p, [0, xe], [0, ye]; color=:gray, ls=:dot, lw=1, label=nothing)
    plot!(p, [0, 3], [0, 0]; color=:gray, ls=:dot, lw=1, label=nothing)

    plot!(p, 3 .* cos.(t), 3 .* sin.(t); color=:red, lw=4, label=L"C")
    scatter!(p, [3, xe], [0, ye]; color=:red, ms=6, label=nothing)

    annotate!(p, 3.1, -0.4, text(L"(3,0)", 9, :red, :left))
    annotate!(p, 1.7, 3.05, text(L"(\frac{3}{2},\frac{3\sqrt{3}}{2})", 9, :red, :left))
    annotate!(p, 1.15, 0.6, text(L"\theta=\frac{\pi}{3}", 9, :gray))
    p
end


# ╔═╡ ac75c8fb-3d69-43c6-ad31-a281650366dd
#✓ ANIM 10.3 Kahoot Q7 -- 3D revolution
begin
    kahoot10_3_q7_clock_box = @bind kahoot10_3_q7_k Clock(0.15)
    kahoot10_3_q7_scrub_box = @bind kahoot10_3_q7_j Slider(0:80, default=0)
    cm"""
**Revolve** $(kahoot10_3_q7_clock_box)

**Scrub** $(kahoot10_3_q7_scrub_box)
"""
end


# ╔═╡ 9ffec60d-5310-4587-a50f-0ac4994caa5f
let
    N = 48
    n = mod(kahoot10_3_q7_k + kahoot10_3_q7_j, N + 1)
    phimax = 2 * pi * n / N

    R = 3.0
    tt = range(0, pi / 3, length=80)
    cc = range(0, 2 * pi, length=200)
    L = 3.4

    gen(f) = (R .* cos.(tt), R .* sin.(tt) .* cos(f), R .* sin.(tt) .* sin(f))

    p = plot([-L, L], [0, 0], [0, 0];
        color=:steelblue, lw=3, alpha=0.5, label="axis of revolution",
        xlims=(-L, L), ylims=(-L, L), zlims=(-L, L),
        camera=(35, 20), legend=:topright, size=(640, 560),
        xlabel="x", ylabel="y", zlabel="z", titlefontsize=11,
        title="Revolving C about the x-axis    phi = $(round(Int, rad2deg(phimax))) deg")

    plot!(p, R .* cos.(cc), R .* sin.(cc), zeros(length(cc));
        color=:gray, ls=:dash, lw=1, alpha=0.35, label=nothing)

    if n > 0
        np = max(2, ceil(Int, 160 * phimax / (2 * pi)) + 2)
        ff = range(0, phimax, length=np)
        for t in range(pi / 24, pi / 3, length=6)
            plot!(p, fill(R * cos(t), np), R * sin(t) .* cos.(ff), R * sin(t) .* sin.(ff);
                color=:gray, lw=1, alpha=0.6, label=nothing)
        end
        for f in 0:(pi/6):phimax
            gx, gy, gz = gen(f)
            plot!(p, gx, gy, gz; color=:gray, lw=1, alpha=0.6, label=nothing)
        end
    end

    gx0, gy0, gz0 = gen(0.0)
    plot!(p, gx0, gy0, gz0; color=:red, lw=4, label="C  (generating arc)")

    if n > 0
        gx1, gy1, gz1 = gen(phimax)
        plot!(p, gx1, gy1, gz1; color=:orange, lw=4, label="leading edge")
    end

    scatter!(p, [3.0, 1.5], [0.0, 0.0], [0.0, 0.0]; color=:red, ms=4, label=nothing)
    p
end


# ╔═╡ b4223dd0-faaa-4508-813f-0a9babbcdc09
# Section 10.4: Polar coordinates and Polar Graphs - Verbatim Content

## Cell 1
md"# 10.4 Polar coordinates and Polar Graphs"

## Cell 2

# ╔═╡ 5f6b7fce-fbc0-4464-a0cc-9fa179937ebb
cm"""
> __Objectives__
> 1. Understand the polar coordinate system.
> 1. Rewrite rectangular coordinates and equations in polar form and vice versa.
> 1. Sketch the graph of an equation given in polar form.
> 1. Find the slope of a tangent line to a polar graph.
> 1.  Identify several types of special polar graphs.
"""

## Cell 3

# ╔═╡ ae5f7e4b-9f4f-4066-9595-3ec65257b4f9
md"## Polar Coordinates"

## Cell 4

# ╔═╡ e5df9962-b908-4219-bfaf-7be799b8c8a8
let
    n = 0
    P = (2, π / 3 + n * 2π)
    plot([P[2]], [P[1]];
        proj=:polar, seriestype=:scatter, thetaticks=([0, 1, π], [0, 1, 2]), label=L"P%$P", grid=5)
    # plot!(;proj=:cart)
end

## Cell 6

# ╔═╡ fc8794db-0fa4-4641-865d-34a199d843c0
md"## Coordinate Conversion"

## Cell 7

# ╔═╡ c653f8bc-a222-4734-822a-51f9347d9a39
#✓ SOL 10.4 ex1
begin
    s10_4_ex1_sol_box = @bind s10_4_ex1_show_sol CheckBox(default=true)
    cm"""
$(s10_4_ex1_sol_box) **Show Solution**
"""
end

# ╔═╡ 932105fb-25b6-4fd6-9d26-b7c66ed70c26
#✓ SOL 10.4 ex2
begin
    s10_4_ex2_sol_box = @bind s10_4_ex2_show_sol CheckBox(default=true)
    cm"""
$(s10_4_ex2_sol_box) **Show Solution**
"""
end

# ╔═╡ 09ad3cf9-ccc7-4508-b20a-2b541fba963b
md"###### Kahoot it 🎯📱🎉✨"

# ╔═╡ c86f3735-7430-4216-a8e8-d018c844142e
md"## Polar Graphs"

## Cell 14

# ╔═╡ 2b853097-db70-4f47-988f-f9caed5a042f
md"[Plotting Guidelines](https://www.dropbox.com/scl/fi/6537efq8elmarwa6sqyqf/guides_plotting_polar.pdf?rlkey=ccna60nezql5ilq8wqdko9yvk&raw=1)"

# ╔═╡ e1e067d5-5416-4d8e-be65-5c52ae95b24b
let
    θs = range(0, 2π, length=200)
    θssec = repeat([1], 100)
    r(θ) = 2
    p1 = plot(
        θs, r.(θs);
        proj=:polar,
        label=L"r=2"
    )
    plot!(
        repeat([π / 3], 400), [range(0, 3, length=200)..., -range(0, 3, length=200)...];
        proj=:polar,
        label=L"\theta=\frac{\pi}{3}"
    )
    p2 = plot(θssec, map(ti -> ti[1] > 50 ? (100 - ti[1]) * ti[2] : -ti[1] * ti[2], enumerate(θssec));
        label=L"r=\sec(\theta)",
        ylimits=(-3, 3),
        aspectratio=1,
        frame_style=:origin
    )
    cm"""
    $p1

    $p2
    """
end

## Cell 17

# ╔═╡ 003f7d8c-b316-4a2b-8170-ff148ccb9f50
let
    θ = [0, π / 6, π / 3, π / 2, 2π / 3, 5π / 6, π]
    θs = ["0", "π/6", "π/3", "π/2", "2π/3", "5π/6", "π"]
    r(θ) = 2 * cos(3 * θ)
    table = vcat(
        θ',
        r.(θ)')
    r1 = map(x -> "<td> $x </td>", θs)
    r2 = map(x -> "<td> $(round(x,digits=2)) </td>", r.(θ))
    cm"""
    <table>

    <tr>
    <td>

    ``\theta``

    </td>

    $r1

    </tr>

    <tr>

    <td>

    ``r``

    </td>

    $r2

    </tr>


    </table>
    """
end

## Cell 19

# ╔═╡ 2abd04ed-edf8-4bf0-bebf-e9c299927551
begin
    s10_4_ex4_slider = @bind s10_4_ex4 NumberField(0:π/6:π)
    cm"""
    ``\theta = `` $(s10_4_ex4_slider)
    """
end

## Cell 20

# ╔═╡ 5b7101e1-7f13-4825-8e0e-a9725e0e0438
let
    n = 3
    a = 2
    θs = 0:0.01:s10_4_ex4
    r(θ) = a * cos(n * θ)
     # Define tick positions and labels
    tick_positions = 0:π/6:2π
    tick_labels = ["0", "π/6", "π/3", "π/2", "2π/3", "5π/6", "π", "7π/6", "4π/3", "3π/2", "5π/3", "11π/6", "2π"]

    plot(θs, r.(θs);
        proj=:polar, label=nothing,
        thetaticks =(tick_positions,tick_labels))
    # plot!(;proj=:cart)
end

## Cell 21

# ╔═╡ 31b384d2-9194-4ddd-8b6c-d1a137692dbc
md"##  Slope and Tangent Lines"

## Cell 22

# ╔═╡ c3b0bf91-fdf0-4a2b-8309-3728c64421e4
let

    r(θ) = sin(θ)
    plot(r;
        proj=:polar, label=nothing,)
    # plot!(;proj=:cart)
end

## Cell 27

# ╔═╡ d82b0993-b72e-4d46-9b68-8855f05b86ce
#✓ SOL 10.4 ex5
begin
    s10_4_ex5_sol_box = @bind s10_4_ex5_show_sol CheckBox(default=true)
    cm"""
$(s10_4_ex5_sol_box) **Show Solution**
"""
end

# ╔═╡ 70c36a66-d9b4-4ae1-b662-8b3c8af28546
if s10_4_ex5_show_sol
    let
        ts = range(0, π, length=400)
        r(t) = sin(t)
        X(t) = r(t) * cos(t)
        Y(t) = r(t) * sin(t)
        hs = [0.0, π/2]
        vs = [π/4, 3π/4]
        p = plot(X.(ts), Y.(ts), lw=2, label=nothing,
            frame_style=:origin, aspect_ratio=1,
            xlimits=(-0.9, 0.9), ylimits=(-0.25, 1.25),
            title=L"r=\sin\theta")
        for t in hs
            plot!(p, [X(t)-0.4, X(t)+0.4], [Y(t), Y(t)], ls=:dash, c=:red, label=nothing)
        end
        for t in vs
            plot!(p, [X(t), X(t)], [Y(t)-0.4, Y(t)+0.4], ls=:dash, c=:green, label=nothing)
        end
        scatter!(p, X.(vcat(hs, vs)), Y.(vcat(hs, vs)), c=:black, ms=4, label=nothing)
        p
    end
else
    md""
end

# ╔═╡ fae0a60d-8bb5-4be4-a22f-01a951804800
let

    r(θ) = 2(1 - cos(θ))
    plot(r;
        proj=:polar, label=nothing,)
    # plot!(;proj=:cart)
end

## Cell 29

# ╔═╡ 0f12e41e-01b1-443b-9bbc-031fa52fa753
#✓ SOL 10.4 ex6
begin
    s10_4_ex6_sol_box = @bind s10_4_ex6_show_sol CheckBox(default=true)
    cm"""
$(s10_4_ex6_sol_box) **Show Solution**
"""
end

# ╔═╡ 00359215-ca8b-4b81-b1b5-c7d67de003e1
if s10_4_ex6_show_sol
    let
        ts = range(0, 2π, length=600)
        r(t) = 2 * (1 - cos(t))
        X(t) = r(t) * cos(t)
        Y(t) = r(t) * sin(t)
        hs = [2π/3, 4π/3]
        vs = [π/3, π, 5π/3]
        p = plot(X.(ts), Y.(ts), lw=2, label=nothing,
            frame_style=:origin, aspect_ratio=1,
            xlimits=(-5.0, 1.8), ylimits=(-3.6, 3.6),
            title=L"r=2(1-\cos\theta)")
        for t in hs
            plot!(p, [X(t)-1.3, X(t)+1.3], [Y(t), Y(t)], ls=:dash, c=:red, label=nothing)
        end
        for t in vs
            plot!(p, [X(t), X(t)], [Y(t)-1.3, Y(t)+1.3], ls=:dash, c=:green, label=nothing)
        end
        scatter!(p, X.(vcat(hs, vs)), Y.(vcat(hs, vs)), c=:black, ms=4, label=nothing)
        p
    end
else
    md""
end

# ╔═╡ afeb2022-35c7-42ca-b6a9-fc7ff8b61de0
md"##  Special Polar Graphs"

## Cell 31

# ╔═╡ 135756cf-c917-4974-bb36-eae97ddf00b7
begin
    limacons_html_a = @bind limacons_a NumberField(2:2:6, default=2)
    limacons_html_b = @bind limacons_b NumberField(2:4, default=2)
    cm"""

    ``a = ``$limacons_html_a  ``\qquad``    ``b = ``$limacons_html_b
    """
end

# ╔═╡ 81e9e206-ed9b-4fc6-b936-2307621558f1
let
    a = limacons_a
    b = limacons_b
    r(θ) = a + b * cos(θ)
    p = plot(r;
        proj=:polar, label=nothing,title=L"r=a+b\cos(\theta); \qquad a/b=%$(round(a/b;digits=2)) ")
    cm"""
    __Limaçons__

    $p
    """

end

## Cell 32

# ╔═╡ 942ad12e-f0b2-4d1d-b3c6-d664f4293bcc
md"---"

# ╔═╡ e37317fb-b219-410c-bfc0-653ebe20a632
begin
    roses_html_a = @bind roses_a NumberField(1:2:6, default=2)
    roses_html_n = @bind roses_n NumberField(2:8, default=2)
    cm"""

    ``a = ``$roses_html_a  ``\qquad``    ``n = ``$roses_html_n
    """
end

# ╔═╡ 7f15a20e-adc7-4028-a5d1-2a1af197f390
let
    a = roses_a
    n = roses_n
    r(θ) = a * cos(n * θ)
    p = plot(r;
        proj=:polar, label=nothing,title=L"r=%$a+\cos(%$n\theta); \qquad n=%$(n), a=%$a ")
    cm"""
     __Rose Curves__

    $p
    """

end

## Cell 33

# ╔═╡ 9c06bcf6-403e-4da2-a2b1-06bc10af44a8
md"---"

# ╔═╡ 005bfac2-bf5c-4456-8889-c4cecb7d3228
begin
    Lemniscates_html_a = @bind Lemniscates_a NumberField(1:2:6, default=1)
    Lemniscates_html_n = @bind Lemniscates_n NumberField(2:8, default=2)
    cm"""

    ``a = ``$Lemniscates_html_a  ``\qquad``    ``n = ``$Lemniscates_html_n
    """
end

# ╔═╡ efd1ef70-c4ae-4112-8fb5-db0490269102
let
    a = Lemniscates_a
    n = Lemniscates_n
    # θs = range(0,2π,length=200)
    # r(θ) = cos(2*θ)>=0 && abs(a)*abs(cos(n*θ))
    r1(θ) = sin(n * θ) >= 0 && abs(a) * abs(sin(n * θ))
    r2(θ) = cos(n * θ) >= 0 && abs(a) * abs(cos(n * θ))
    p1 = plot(r1;
        proj=:polar, label=nothing,
             thetaticks=2,
             title=L"r^2=%$(a==1 ? ' ' : a^2)\sin(%$n\theta); \qquad n=%$(n), a=%$a")
    p2 = plot(r2;
        proj=:polar, label=nothing,
             thetaticks=2,
             title=L"r^2=%$(a==1 ? ' ' : a^2)\cos(%$n\theta); \qquad n=%$(n), a=%$a")
    cm"""
__Circles and Lemniscates__

   ``r^2  = a^2 \sin^2\theta``

   $p1

---

``r^2  = a^2 \cos^2\theta``

   $p2

   """

end

# ╔═╡ fac91f7f-4b2b-4576-9435-e2e9b8bae16e
# let
#     θ = range(0, 2π, length=500)
# r = 1 .+ sin.(θ)

# plot(θ, r, proj=:polar, label="r = 1 + sinθ",
#      xticks=(0:π/6:2π, ["0", "π/6", "π/3", "π/2", "2π/3", "5π/6",
#                         "π", "7π/6", "4π/3", "3π/2", "5π/3", "11π/6", "2π"]))
# end

# ╔═╡ 87dfeb75-613d-49a3-bce2-46dbd0d33429
md"""
# 10.5 Area and Arc Length in Polar Coordinates
> __Objectives__
> 1. Find the area of a region bounded by a polar graph.
> 1. Find the points of intersection of two polar graphs.
> 1. Find the arc length of a polar graph.
> 1. Find the area of a surface of revolution (polar form).
"""

# ╔═╡ bd3e2109-3aa0-4a9c-9082-d6d196f7932b
md"##  Area of a Polar Region"

# ╔═╡ 6c577bcb-2f01-41e2-b8cc-7593372f4cf6
let
    r(θ) = 3 * cos(3 * θ)
    ts = -π/6:0.01:π/6
    p = plot(ts, r.(ts), fill=true, proj=:polar, label=nothing)
    plot!(r;
        proj=:polar, label=nothing,
        l=(2, :black))
    plot!(repeat([π / 6], 100), range(-3, 3, length=100);
        proj=:polar, label=nothing,
        l=(2, :red, :dash),
        annotations=[(0.5cos(π / 6), 0.7sin(π / 6), L"\theta=\pi/6")])
    plot!(repeat([-π / 6], 100), range(-3, 3, length=100);
        proj=:polar, label=nothing,
        l=(2, :red, :dash),
        annotations=[(0.5cos(-π / 6), 0.7sin(-π / 6), L"\theta=-\pi/6")])
    cm"""
    __Rose__

   ``r  = 3\cos 3\theta``

   $p
   """

end

# ╔═╡ 65179ab3-0475-4ae2-b7e1-5a7caf5a8e66
let
    r(θ) = 1 - 2sin(θ)
    ts = π/6:0.01:5π/6
    p = plot(ts, r.(ts), proj=:polar, label=nothing)
    plot!(r;
        proj=:polar, label=nothing,
        l=(2, :black),
        fill=true,)
    plot!(repeat([π / 6], 100), range(0, 3, length=100);
        proj=:polar, label=nothing,
        l=(2, :red, :dash),
        annotations=[(0.5cos(π / 6), 0.9sin(π / 6), L"\theta=\pi/6")])
    plot!(repeat([5π / 6], 100), range(0, 3, length=100);
        proj=:polar, label=nothing,
        l=(2, :red, :dash),
        annotations=[(0.5cos(5π / 6), 0.9sin(5π / 6), L"\theta=5\pi/6")])
    cm"""
    __Rose__

   ``r  = 1-2\sin \theta``

   $p

   ``A_1 = \text{area of inner loop} = \pi - \frac{3\sqrt{3}}{2}``

   ``A_2 = \text{area of outer loop} = 2\pi + \frac{3\sqrt{3}}{2}``


   ``A = \text{area between loops} = A_2-A_1 = \pi - 3\sqrt{3}``


   """

end

# ╔═╡ 770456f6-fe19-4aec-86d2-482834cc419f
md"##  Points of Intersection of Polar Graphs"

# ╔═╡ 2e4f2876-a92d-4b3d-a473-ef12341baacc
let
    r1(θ) = -6.0cos(θ)
    r2(θ) = 2.0 - 2cos(θ)
    # ts = range(2π/3,4π/3,length=100)
    ts = range(π / 2, 3π / 2, length=500)
    r3(t) = t >= 2π / 3 && t <= 4π / 3 ? r2(t) : r1(t)
    p = plot(ts, r3.(ts), fill=true, proj=:polar, label=nothing)
    plot!(r1;
        proj=:polar, label=nothing,
        l=(2, :black),)
    plot!(r2;
        proj=:polar, label=nothing,
        l=(1, :grey),)
    # plot!(repeat([π/6],100),range(0,3,length=100);
    # proj=:polar,label=nothing,
    #     l=(2,:red,:dash),
    #     annotations=[(0.5cos(π/6),0.9sin(π/6),L"\theta=\pi/6")]

    # )
    # plot!(repeat([5π/6],100),range(0,3,length=100);
    # proj=:polar,label=nothing,
    #     l=(2,:red,:dash),
    #     annotations=[(0.5cos(5π/6),0.9sin(5π/6),L"\theta=5\pi/6")]

    # )
    cm"""

   $p


   ``A = \text{area between the curves} = \frac{5\pi}{2}``


   """

end

# ╔═╡ 782bd8fb-e3c7-471a-9bce-668d45b911af
md"##  Arc Length in Polar Form"

# ╔═╡ 8ad44287-5a21-477b-b0fd-0d710440dc25
let
    r(θ) = 2 - 2cos(θ)
    p = plot(r;
        proj=:polar, label=nothing,)
    cm"""


   $p
   """

end

# ╔═╡ ba8dc58b-5c37-4713-9bef-930c735850bf
md"## Area of a Surface of Revolution"

# ╔═╡ 0ce9a97b-dab5-4b5b-829d-f03fb823b3d3
let
    r(θ) = cos(θ)
    p = plot(r;
        proj=:polar, label=nothing,)
    cm"""


   $p
   """

end

# ╔═╡ f25c97aa-47a9-4bcd-9f27-3e8eb17857e1
begin
    initialize_eqref()
    function add_space(n=1)
        repeat("&nbsp;", n)
    end
    function post_img(img::String, w=500)
        res = Resource(img, :width => w)
        cm"""
      <div class="img-container">

      $(res)

      </div>"""
    end
    function poolcode()
        cm"""
      <div class="img-container">

      $(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

      </div>"""
    end
    function define(t="")
        beginBlock("Definition", t)
    end
    function remark(t="")
        beginBlock("Remark", t)
    end
    function remarks(t="")
        beginBlock("Remarks", t)
    end
    function bbl(t)
        beginBlock(t, "")
    end
    function bbl(t, s)
        beginBlock(t, s)
    end
    ebl() = endBlock()
    function theorem(s)
        bth(s)
    end
    function bth(s)
        beginTheorem(s)
    end
    eth() = endTheorem()
    ex(n::Int; s::String="") = ex("Example $n", s)
    ex(t::Int, s::String) = example("Example $t", s)
    ex(t, s) = example(t, s)
    function beginBlock(title, subtitle)
        """<div style="box-sizing: border-box;">
           <div style="display: flex;flex-direction: column;border: 6px solid rgba(200,200,200,0.5);box-sizing: border-box;">
           <div style="display: flex;">
           <div style="background-color: #FF9733;
               border-left: 10px solid #df7300;
               padding: 5px 10px;
               color: #fff!important;
               clear: left;
               margin-left: 0;font-size: 112%;
               line-height: 1.3;
               font-weight: 600;">$title</div>  <div style="olor: #000!important;
               margin: 0 0 20px 25px;
               float: none;
               clear: none;
               padding: 5px 0 0 0;
               margin: 0 0 0 20px;
               background-color: transparent;
               border: 0;
               overflow: hidden;
               min-width: 100px;font-weight: 600;
               line-height: 1.5;">$subtitle</div>
           </div>
           <p style="padding:5px;">
       """
    end
    function beginTheorem(subtitle)
        beginBlock("Theorem", subtitle)
    end
    function endBlock()
        """</p></div></div>"""
    end
    function endTheorem()
        endBlock()
    end
    ex() = example("Example", "")
    function example(lable, desc)
        """<div class="example-box">
    <div class="example-header">
      $lable
    </div>
    <div class="example-title">
      $desc
    </div>
    <div class="example-content">

  </div>
  """
    end
    # function example(lable, desc)
    #        """<div style="display:flex;">
    #       <div style="
    #       font-size: 112%;
    #           line-height: 1.3;
    #           font-weight: 600;
    #           color: #f9ce4e;
    #           float: left;
    #           background-color: #5c5c5c;
    #           border-left: 10px solid #474546;
    #           padding: 5px 10px;
    #           margin: 0 12px 20px 0;
    #           border-radius: 0;
    #       ">$lable:</div>
    #       <div style="flex-grow:3;
    #       line-height: 1.3;
    #           font-weight: 600;
    #           float: left;
    #           padding: 5px 10px;
    #           margin: 0 12px 20px 0;
    #           border-radius: 0;
    #       ">$desc</div>
    #       </div>"""
    #    end
    function warning_box(title="⚠️ Common Error", content="")
        """
        <div style="
            border: 2px solid #ff6b6b;
            border-radius: 8px;
            background: linear-gradient(135deg, #fff5f5 0%, #ffe8e8 100%);
            margin: 15px 0;
            padding: 0;
            box-shadow: 0 2px 8px rgba(255, 107, 107, 0.2);
        ">
            <div style="
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
                color: white;
                padding: 8px 15px;
                font-weight: bold;
                font-size: 14px;
                border-radius: 6px 6px 0 0;
                border-bottom: 1px solid #ff5252;
            ">
                $title
            </div>
            <div style="
                padding: 15px;
                line-height: 1.6;
                color: #333;
            ">
                $content
            </div>
        </div>
        """
    end

    # Alternative: Create a tip box for helpful hints
    function tip_box(title="💡 Helpful Tip", content="")
        """
        <div style="
            border: 2px solid #4CAF50;
            border-radius: 8px;
            background: linear-gradient(135deg, #f8fff8 0%, #e8f5e8 100%);
            margin: 15px 0;
            padding: 0;
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.2);
        ">
            <div style="
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 8px 15px;
                font-weight: bold;
                font-size: 14px;
                border-radius: 6px 6px 0 0;
                border-bottom: 1px solid #45a049;
            ">
                $title
            </div>
            <div style="
                padding: 15px;
                line-height: 1.6;
                color: #333;
            ">
                $content
            </div>
        </div>
        """
    end
    @htl("")
end

# ╔═╡ f7f0dbe3-ab41-4ff2-ad97-5927f657d5a4

# __ChatGPT:__ (Course AI assistant)
# $(post_img("https://www.dropbox.com/scl/fi/8scavzk19ewiqd6s7ubj5/chatgpt_qrcode.png?rlkey=5jlmqhovlfd1byh0s7ya93b47&dl=1"))

cm"""
__Course website:__ (Notes, Syllabus)
$(post_img("https://www.dropbox.com/scl/fi/swxz2urvoq9olrlpu2xfi/mshahrani_qrcode.png?rlkey=w5ojh9lpnf49qadivxuv1un4b&dl=1"))

---


"""

# ╔═╡ c7a8937d-6d27-41c3-ac54-8d59db9c8937
begin
    text_book = post_img("https://www.dropbox.com/scl/fi/upln00gqvnbdy7whr23pj/larson_book.jpg?rlkey=wlkgmzw2ernadd9b8v8qwu2jd&dl=1", 200)
    md""" # Syllabus
    ## Syallbus
    See here [Term 261 - MATH201 - Syllabus](https://math.kfupm.edu.sa/docs/default-source/css-library/math201-261.pdf)
    ## Textbook
    __Textbook: Edwards, C. H., Penney, D. E., and Calvis, D. T., Differential Equations and Linear Algebra, Fourth edition, Pearson, 2021__
    $text_book

    ## Office Hours
    I strongly encourage all students to make use of my office hours. These dedicated times are a valuable opportunity for you to ask questions, seek clarification on lecture material, discuss challenging problems, and get personalized feedback on your work. Engaging with me during office hours can greatly enhance your understanding of the course content and improve your performance. Whether you're struggling with a specific concept or simply want to delve deeper into the subject, I am here to support your learning journey. Don't hesitate to drop by; __your success is my priority__.

    | Day       | Time        |
    |-----------|-------------|
    | Sunday    | 11:00-11:50AM |
    | Tuesday | 11:00-11:50AM |
    Also you can ask for an online meeting through __TEAMS__.
    """
end

# ╔═╡ e3eaab8a-46db-45f1-a57c-5fe61e583919
## Cell 5
cm"""
$(define("a Plane Curve"))
If ``f`` and ``g`` are continuous functions of ``t`` on an interval ``I``, then the equations
```math
x=f(t) \quad \text { and } \quad y=g(t)
```
are __parametric equations__ and ``t`` is the __parameter__. The set of points ``(x, y)`` obtained as ``t`` varies over the interval ``I`` is the __graph__ of the parametric equations. Taken together, the parametric equations and the graph are a __plane curve__, denoted by ``C``.
"""

# ╔═╡ bd0ffc3a-0773-4368-b179-e6502a3fbee7
## Cell 6
cm"""
$(ex(1,"Sketching a Curve"))
Sketch the curve described by the parametric equations
```math
x=f(t)=t^2-4
```
and
```math
y=g(t)=\frac{t}{2}
```
where ``-2 \leq t \leq 3``.
"""

# ╔═╡ 72eaba37-67d9-4d52-b1a6-e108401aa93e

## Cell 9
HTML(warning_box(
    "⚠️ Common Errors When Eliminating Parameters",
    """
    <strong>Three major mistakes students make:</strong>
    <ol>
        <li><strong>Forgetting domain restrictions:</strong> The parameter t might have limits that affect x and y</li>
        <li><strong>Losing orientation:</strong> Parametric curves have direction; rectangular equations don't</li>
        <li><strong>Incomplete elimination:</strong> Make sure your final equation has no parameter left!</li>
    </ol>
    <em>Always verify: Does your rectangular equation represent the same curve over the same domain?</em>
    """
))

# ╔═╡ 0f02e8df-9945-4d41-af5f-290dd991db92
## Cell 10
cm"""

$(post_img("https://www.dropbox.com/scl/fi/7ijq8twppy0b4urn2ct3c/fig0_10_2.png?rlkey=abd13ney9wz9ya3vjxcrddo10&raw=1",500))
"""

# ╔═╡ 1e7b4218-ca92-4384-83db-31e97fa5545f

## Cell 11
cm"""
$(ex(2,"Adjusting the Domain"))
Sketch the curve represented by the equations
```math
x=\frac{1}{\sqrt{t+1}} \quad \text { and } \quad y=\frac{t}{t+1}, \quad t>-1
```
by eliminating the parameter and adjusting the domain of the resulting rectangular equation.
"""

# ╔═╡ 0870140d-366c-4953-9f84-1316c2419bad

## Cell 12
cm"""
$(ex(3,"Using Trigonometry to Eliminate a Parameter"))
See LarsonCalculus.com for an interactive version of this type of example.
Sketch the curve represented by
```math
x=3 \cos \theta \quad \text { and } \quad y=4 \sin \theta, \quad 0 \leq \theta \leq 2 \pi
```
by eliminating the parameter and finding the corresponding rectangular equation.
"""

# ╔═╡ 62ad6901-4883-4cdb-9b8b-0d2e4b409d4e
if s10_2_ex3_show_sol
    cm"""
$(bbl("Solution",""))
Solve each equation for the trigonometric function

``\cos\theta = \dfrac{x}{3} \qquad\text{and}\qquad \sin\theta = \dfrac{y}{4}``

and use the Pythagorean identity ``\sin^2\theta+\cos^2\theta=1``

```math
\left(\frac{x}{3}\right)^2+\left(\frac{y}{4}\right)^2=\cos^2\theta+\sin^2\theta=1
```

so the rectangular equation is

```math
\frac{x^2}{9}+\frac{y^2}{16}=1.
```

This is an **ellipse** centered at the origin, with

- vertices ``(0,\pm 4)``: major axis on the ``y``-axis of length ``8``,
- co-vertices ``(\pm 3,0)``: minor axis on the ``x``-axis of length ``6``.

**Orientation and domain.** As ``\theta`` increases from ``0`` to ``2\pi``, the point traces the **entire** ellipse exactly once in the **counterclockwise** direction, starting and ending at ``(3,0)``

``\theta=0 \to (3,0),\quad \theta=\dfrac{\pi}{2} \to (0,4),\quad \theta=\pi \to (-3,0),\quad \theta=\dfrac{3\pi}{2} \to (0,-4).``

Note that the rectangular equation alone carries neither the starting point nor the direction of motion.
$(ebl())
"""
else
    md""
end


# ╔═╡ b05fcc39-dad9-4bdf-874e-6dedf75fe36c

## Cell 15
HTML(warning_box(
    "⚠️ Trigonometric Parameter Elimination Mistakes",
    """
    When using sin²θ + cos²θ = 1, watch out for these errors:
    <br><br>
    <strong>✗ Wrong:</strong> x² + y² = 1<br>
    <strong>✗ Wrong:</strong> (x/3) + (y/4) = 1<br>
    <strong>✓ Correct:</strong> (x/3)² + (y/4)² = 1
    <br><br>
    <strong>Why?</strong> We have x = 3cos(θ), so cos(θ) = x/3<br>
    Similarly, y = 4sin(θ), so sin(θ) = y/4<br>
    Therefore: (x/3)² + (y/4)² = cos²(θ) + sin²(θ) = 1
    """
))

# ╔═╡ 577dbd65-1377-4dd1-bb8f-52e4202ae745
## Cell 16
HTML(tip_box(
    "💡 Quick Check",
    """
    <strong>Verify your elimination:</strong>
    <ul>
        <li>Substitute a simple value (like θ = 0) into both forms</li>
        <li>Do you get the same point? ✓</li>
        <li>Check the shape: This gives an ellipse with semi-axes 3 and 4</li>
    </ul>
    """
))

# ╔═╡ cab568b8-a82e-4886-8988-7766297153c6
## Cell 17
HTML(warning_box(
    "⚠️ Don't Forget: Direction Matters!",
    """
    <strong>Parametric equations show direction of motion:</strong>
    <ul>
        <li>As θ increases from 0 to 2π, the point moves <strong>counterclockwise</strong></li>
        <li>The rectangular equation x²/9 + y²/16 = 1 just shows the ellipse shape</li>
        <li>It doesn't tell us the starting point or direction of travel</li>
    </ul>
    <strong>Try the slider above:</strong> Watch how the point traces the curve as θ increases!
    """
))

# ╔═╡ 66b48d42-742f-49f9-8e97-684f2d790b32
## Cell 19
cm"""
$(ex(4,"Finding Parametric Equations for a Given Graph"))
Find a set of parametric equations that represents the graph of ``y=1-x^2``, using each of the following parameters.

- __(a.)__ ``t=x``
- __(b.)__ The slope ``m=\frac{d y}{d x}`` at the point ``(x, y)``

"""

# ╔═╡ aaea1a28-8b28-496d-b575-a7711beda83d
if s10_2_ex4_show_sol
    cm"""
$(bbl("Solution",""))
**(a) Using the parameter ``t=x``.** Substituting ``x=t`` in ``y=1-x^2`` gives

```math
x=t,\qquad y=1-t^2,\qquad t\in \mathbb{R}.
```

**(b) Using the slope ``m=\dfrac{dy}{dx}`` as parameter.** Differentiating ``y=1-x^2``

```math
m=\frac{dy}{dx}=-2x \qquad\Longrightarrow\qquad x=-\frac{m}{2},
```

and substituting this ``x`` back in ``y=1-x^2``

```math
y=1-\left(-\frac{m}{2}\right)^2=1-\frac{m^2}{4},
```

so

```math
x=-\frac{m}{2},\qquad y=1-\frac{m^2}{4},\qquad m\in \mathbb{R}.
```

**Check.** ``\dfrac{dy}{dx}=\dfrac{dy/dm}{dx/dm}=\dfrac{-m/2}{-1/2}=m``, so the parameter really is the slope.

**Same graph, different motion.**

- Both parametrizations trace the **same** parabola ``y=1-x^2``, and both sit at the vertex ``(0,1)`` when the parameter is ``0``.
- In **(a)** the point moves **left to right**, since ``x=t`` increases with ``t``. In **(b)** it moves **right to left**, since ``x=-m/2`` decreases as ``m`` increases.
- In **(b)** the point sweeps the curve at **half the rate**: to cover ``-2\le x\le 2`` the parameter ``t`` runs over ``[-2,2]``, while ``m`` must run over ``[-4,4]``.

Press play on the animation below to see both effects at once.
$(ebl())
"""
else
    md""
end


# ╔═╡ 6f2b9ee3-1579-4685-9b2d-c7fa7b07a828
## Cell 20
cm"""
$(ex(5,"Parametric Equations for a Cycloid"))
Determine the curve traced by a point ``P`` on the circumference of a circle of radius ``a`` rolling along a straight line in a plane. Such a curve is called a __cycloid__.
"""

# ╔═╡ 98951c5f-438a-4b27-b0b1-5aef88c6bfab
## Cell 23
cm"""
$(define("Smooth Curve"))
A curve ``C`` represented by ``x=f(t)`` and ``y=g(t)`` on an interval ``I`` is called __smooth__ when ``f^{\prime}`` and ``g^{\prime}`` are continuous on ``I`` and not simultaneously ``0`` , except possibly at the endpoints of ``I``. The curve ``C`` is called __piecewise smooth__ when it is smooth on each subinterval of some partition of ``I``.
"""

# ╔═╡ d1029e12-aacd-49bf-aebf-ded4a3a31ca6
cm"""
$(bbl("Hypocycloid", "H(A, B)"))
The path traced by a fixed point on a circle of radius ``B`` as it rolls around the inside of a circle of radius ``A``
```math
\begin{aligned}
& x=(A-B) \cos t+B \cos \left(\frac{A-B}{B}\right) t \\
& y=(A-B) \sin t-B \sin \left(\frac{A-B}{B}\right) t
\end{aligned}
```
"""

# ╔═╡ 080c8917-6a7f-46ab-9ce7-4a19d2062375
let
    A = s10_2_hypo_A
    B = s10_2_hypo_B

    if B >= A
        cm"""
$(bbl("Note",""))
For a **hypo**cycloid the rolling circle must roll **inside** the fixed circle, so we need ``B \lt A``.
Right now ``A`` = $(A) and ``B`` = $(B): decrease ``B`` (or increase ``A``) to see the curve.
$(ebl())
"""
    else
        d = gcd(A, B)
        tmax = 2 * pi * B / d
        t = range(0, tmax, length=4000)
        c = range(0, 2 * pi, length=400)

        x = (A - B) .* cos.(t) .+ B .* cos.((A - B) / B .* t)
        y = (A - B) .* sin.(t) .- B .* sin.((A - B) / B .* t)

        R = A + 1
        p = plot(A .* cos.(c), A .* sin.(c);
            color=:gray, ls=:dash, lw=1, label="fixed circle, radius A = $(A)")
        plot!(p, x, y;
            aspect_ratio=:equal, lw=1.4, color=:red, label="H($(A),$(B))",
            framestyle=:origin, xlims=(-R, R), ylims=(-R, R),
            title="Hypocycloid  H($(A),$(B))   -   $(div(A, d)) cusps",
            titlefontsize=11, size=(560, 560))
        xlabel!(p, "x")
        ylabel!(p, "y")
        p
    end
end


# ╔═╡ 46cb1033-5bdc-4978-a8b8-3caf5da336b9
cm"""
$(bbl("Epicycloid","E(A, B)"))
The path traced by a fixed point on a circle of radius ``B`` as it rolls around the outside of a circle of radius ``A``
```math
\begin{aligned}
& x=(A+B) \cos t-B \cos \left(\frac{A+B}{B}\right) t \\
& y=(A+B) \sin t-B \sin \left(\frac{A+B}{B}\right) t
\end{aligned}
```
"""

# ╔═╡ c9e03dab-763a-4ddf-aa8f-36c1f85143a4
cm"""
$(bth("Parametric Form of the Derivative"))
If a smooth curve ``C`` is given by the equations
```math
x=f(t) \quad \text { and } \quad y=g(t)
```
then the slope of ``C`` at ``(x, y)`` is
```math
\frac{d y}{d x}=\frac{d y / d t}{d x / d t}, \quad \frac{d x}{d t} \neq 0 .
```
"""

## Cell 5

# ╔═╡ 2861e7e5-c7d4-4764-a52e-9422fff637b5
cm"""
$(ex(1,"Differentiation and Parametric Form"))
Find ``d y / d x`` for the curve given by
```math
x=\sin t\quad \text{and} \quad y=\cos t.
```
"""

## Cell 6

# ╔═╡ 92b10e3c-8187-4785-a4bb-b724eb120476
cm"""
$(bbl("Remark",""))
```math
\begin{aligned} & \frac{d^2 y}{d x^2}=\frac{d}{d x}\left[\frac{d y}{d x}\right]=\frac{\frac{d}{d t}\left[\frac{d y}{d x}\right]}{d x / d t} \\ & \frac{d^3 y}{d x^3}=\frac{d}{d x}\left[\frac{d^2 y}{d x^2}\right]=\frac{\frac{d}{d t}\left[\frac{d^2 y}{d x^2}\right]}{d x / d t} .\end{aligned}
```
"""

## Cell 7

# ╔═╡ 3e357741-353d-4aca-9110-a96208c7f60c
cm"""
$(ex(2,"Finding Slope and Concavity"))
For the curve given by
```math
x=\sqrt{t} \quad \text { and } \quad y=\frac{1}{4}\left(t^2-4\right), \quad t \geq 0
```
find the slope and concavity at the point ``(2,3)``.
"""

## Cell 8

# ╔═╡ a87bd52c-86ad-43ac-8766-04f56a196b88
if s10_3_ex2_show_sol
    cm"""
$(bbl("Solution",""))
The point ``(2,3)`` corresponds to ``t=4``: from ``x=\sqrt{t}=2`` we get ``t=4``, and then ``y=\frac{1}{4}(4^2-4)=3``.

**Slope.** Since ``\dfrac{dx}{dt}=\dfrac{1}{2\sqrt{t}}`` and ``\dfrac{dy}{dt}=\dfrac{t}{2}``,

```math
\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=\frac{t/2}{1/\left(2\sqrt{t}\right)}=t\sqrt{t}=t^{3/2}.
```

At ``t=4`` the slope is ``\dfrac{dy}{dx}=4^{3/2}=8``.

**Concavity.** Differentiate ``dy/dx`` with respect to ``t`` and divide by ``dx/dt``

```math
\frac{d^2y}{dx^2}=\frac{\dfrac{d}{dt}\left[\dfrac{dy}{dx}\right]}{dx/dt}
=\frac{\dfrac{3}{2}\sqrt{t}}{\dfrac{1}{2\sqrt{t}}}=3t.
```

At ``t=4`` this gives ``\dfrac{d^2y}{dx^2}=12>0``, so the curve is **concave upward** at ``(2,3)``.
$(ebl())
"""
else
    md""
end


# ╔═╡ a0adc254-80b7-4ef3-a880-e864851f937a
cm"""
$(ex(3,"A Curve with Two Tangent Lines at a Point"))
The prolate cycloid given by
```math
x=2 t-\pi \sin t \quad \text { and } \quad y=2-\pi \cos t
```
crosses itself at the point ``(0,2)``. Find the equations of both tangent lines at this point.
"""

## Cell 9

# ╔═╡ bdb0938d-658d-4abc-94ed-e38edc55adb4
if s10_3_ex3_show_sol
    cm"""
$(bbl("Solution",""))
**Find the parameters at the point.** Set ``y=2``

```math
2-\pi\cos t=2 \quad\Longrightarrow\quad \cos t=0 \quad\Longrightarrow\quad t=-\frac{\pi}{2}\ \text{ or }\ t=\frac{\pi}{2},
```

and both values give ``x=0``:

``t=\dfrac{\pi}{2}:\ x=2\left(\dfrac{\pi}{2}\right)-\pi(1)=0`` and ``t=-\dfrac{\pi}{2}:\ x=-\pi-\pi(-1)=0``.

So the curve passes through ``(0,2)`` **twice**, at two different parameter values — that is why there are two tangent lines.

**Slope.** ``\dfrac{dx}{dt}=2-\pi\cos t`` and ``\dfrac{dy}{dt}=\pi\sin t``, so

```math
\frac{dy}{dx}=\frac{\pi\sin t}{2-\pi\cos t}.
```

At ``t=\dfrac{\pi}{2}``: ``\dfrac{dy}{dx}=\dfrac{\pi(1)}{2-0}=\dfrac{\pi}{2}``.

At ``t=-\dfrac{\pi}{2}``: ``\dfrac{dy}{dx}=\dfrac{\pi(-1)}{2-0}=-\dfrac{\pi}{2}``.

**The two tangent lines** at ``(0,2)`` are therefore

```math
y=2+\frac{\pi}{2}x \qquad\text{and}\qquad y=2-\frac{\pi}{2}x.
```
$(ebl())
"""
else
    md""
end


# ╔═╡ 3ff7e63b-0e3f-4933-a58a-b538f0bd4307
cm"""
$(bth("Arc Length in Parametric Form"))
If a smooth curve ``C`` is given by ``x=f(t)`` and ``y=g(t)`` such that ``C`` does not intersect itself on the interval ``a \leq t \leq b`` (except possibly at the endpoints), then the arc length of ``C`` over the interval is given by
```math
s=\int_a^b \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t=\int_a^b \sqrt{\left[f^{\prime}(t)\right]^2+\left[g^{\prime}(t)\right]^2} d t
```
"""

## Cell 13

# ╔═╡ 567cc54f-b6ed-4934-8f6c-c843f722bb98
cm"""
$(ex(4,"Finding Arc Length"))

A circle of radius 1 rolls around the circumference of a larger circle of radius 4, as shown below The epicycloid traced by a point on the circumference of the smaller circle is given by
```math
x=5 \cos t-\cos 5 t \quad \text { and } \quad y=5 \sin t-\sin 5 t .
```

Find the distance traveled by the point in one complete trip about the larger circle.
"""

## Cell 14

# ╔═╡ 0daa50ef-abb0-4f10-a3c0-6081beab4bfb
if s10_3_ex4_show_sol
    cm"""
$(bbl("Solution",""))
The point makes one complete trip as ``t`` runs from ``0`` to ``2\pi``. Differentiating,

```math
\frac{dx}{dt}=-5\sin t+5\sin 5t, \qquad \frac{dy}{dt}=5\cos t-5\cos 5t.
```

**Simplify the integrand.**

```math
\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2
=25\left[2-2\left(\sin 5t\sin t+\cos 5t\cos t\right)\right]
=50\left(1-\cos 4t\right),
```

using ``\cos 5t\cos t+\sin 5t\sin t=\cos(5t-t)=\cos 4t``. Now apply ``1-\cos 4t=2\sin^2 2t``:

```math
\sqrt{50\left(1-\cos 4t\right)}=\sqrt{100\sin^2 2t}=10\left|\sin 2t\right|.
```

**Integrate.** By symmetry (``|\sin 2t|`` has period ``\pi/2``),

```math
s=\int_0^{2\pi}10\left|\sin 2t\right|\,dt=4\int_0^{\pi/2}10\sin 2t\,dt
=40\left[-\frac{\cos 2t}{2}\right]_0^{\pi/2}=40.
```

The point travels a distance of ``40`` in one complete trip about the larger circle.
$(ebl())
"""
else
    md""
end


# ╔═╡ 66c7ab95-a158-418d-a276-84042e882aa0
cm"""
$(bth("Area of a Surface of Revolution"))
If a smooth curve ``C`` given by ``x=f(t)`` and ``y=g(t)`` does not cross itself on an interval ``a \leq t \leq b``, then the area ``S`` of the surface of revolution formed by revolving ``C`` about the coordinate axes is given by the following.

__``(1)``__ ``S=2 \pi \int_a^b g(t) \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t``

Revolution about the ``x``-axis: ``g(t) \geq 0``

__``(2)``__ ``S=2 \pi \int_a^b f(t) \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t``

Revolution about the ``y``-axis: ``f(t) \geq 0``
"""

## Cell 18

# ╔═╡ 13beada8-dd59-4252-a730-aedb5c6c09e6
cm"""
$(ex(5,"Finding the Area of a Surface of Revolution"))

Let ``C`` be the arc of the circle ``x^2+y^2=9`` from ``(3,0)`` to
```math
\left(\frac{3}{2}, \frac{3 \sqrt{3}}{2}\right)
```
Find the area of the surface formed by revolving ``C`` about the ``x``-axis.
"""

# ╔═╡ 195378cf-cda9-43e4-97b6-3d20cb41069f
if s10_3_ex5_show_sol
    cm"""
$(bbl("Solution",""))
**Parametrize the arc.** The circle ``x^2+y^2=9`` is ``x=3\cos t``, ``y=3\sin t``. The endpoints give

``(3,0):\ t=0`` and ``\left(\dfrac{3}{2},\dfrac{3\sqrt{3}}{2}\right):\ \cos t=\dfrac{1}{2},\ \sin t=\dfrac{\sqrt{3}}{2}\ \Rightarrow\ t=\dfrac{\pi}{3}``,

so ``0\le t\le \dfrac{\pi}{3}``.

**The radical collapses.** Since ``\dfrac{dx}{dt}=-3\sin t`` and ``\dfrac{dy}{dt}=3\cos t``,

```math
\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}=\sqrt{9\sin^2t+9\cos^2t}=3.
```

**Revolve about the ``x``-axis**, so use ``S=2\pi\displaystyle\int_a^b g(t)\sqrt{\cdots}\,dt`` with ``g(t)=3\sin t``:

```math
S=2\pi\int_0^{\pi/3}(3\sin t)(3)\,dt=18\pi\Big[-\cos t\Big]_0^{\pi/3}
=18\pi\left(1-\frac{1}{2}\right)=9\pi.
```
$(ebl())
"""
else
    md""
end


# ╔═╡ f1211824-c65f-4e55-9bbd-974c1dea6a49
#✓ KAHOOT 10.3 Q7
begin
	kahoot10_3_q7_box = @bind kahoot10_3_q7_show CheckBox(default=true)
	cm"""
$(bbl("Note",""))**Kahoot Q7 (Section 10.3).** Let ``C`` be the arc of the circle ``x^2+y^2=9`` from ``(3,0)`` to ``\left(\dfrac{3}{2},\dfrac{3\sqrt{3}}{2}\right)``. Revolve ``C`` about the ``x``-axis and find the area of the resulting surface.

$(kahoot10_3_q7_box) **Show Solution**
"""
end

# ╔═╡ eb220b5f-614d-4944-9626-e3d27dde779a
if kahoot10_3_q7_show
	cm"""
$(bbl("Solution",""))**Parametrize the arc.** The circle ``x^2+y^2=9`` is ``x=3\cos t``, ``y=3\sin t``. The endpoint ``(3,0)`` gives ``t=0``, and ``\left(\dfrac{3}{2},\dfrac{3\sqrt{3}}{2}\right)`` gives ``\cos t=\dfrac{1}{2}``, ``\sin t=\dfrac{\sqrt{3}}{2}``, so ``t=\dfrac{\pi}{3}``. Hence ``0\le t\le\dfrac{\pi}{3}``.

**The radical collapses.** Since ``\dfrac{dx}{dt}=-3\sin t`` and ``\dfrac{dy}{dt}=3\cos t``,

```math
\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}=\sqrt{9\sin^2 t+9\cos^2 t}=3.
```

**Revolve about the ``x``-axis**, so use ``S=2\pi\displaystyle\int_a^b g(t)\sqrt{\cdots}\,dt`` with ``g(t)=3\sin t``:

```math
S=2\pi\int_0^{\pi/3}(3\sin t)(3)\,dt=18\pi\Big[-\cos t\Big]_0^{\pi/3}=18\pi\left(1-\frac{1}{2}\right)=9\pi.
```

So the correct Kahoot answer is **``9\pi``**.

*Why the distractors are wrong:* ``18\pi`` forgets to evaluate ``1-\cos\dfrac{\pi}{3}``; ``\dfrac{9\pi}{2}`` drops the factor ``2\pi``; ``3\pi`` uses the speed ``3`` as the whole integral.
"""
end

# ╔═╡ 0d9600d8-087d-4900-bcb2-c81a745bb131
cm"""
$(bbl("",""))
To form the polar coordinate system in the plane,
- fix a point ``O``, called __the pole (or origin)__, and
- construct from ``O`` an initial ray called the __polar axis__,

Then each point ``P`` in the plane can be assigned polar coordinates
```math
(r, \theta)
```
as follows.
```math
\begin{aligned}
& r=\text { directed distance from } O \text { to } P \\
& \theta=\text { directed angle, counterclockwise from polar axis to segment } \overline{O P}
\end{aligned}
```

"""

## Cell 5

# ╔═╡ cb4b3d81-67c9-4012-ae28-04247ddd9125
cm"""
$(bth("Coordinate Conversion"))
The polar coordinates ``(r, \theta)`` of a point are related to the rectangular coordinates ``(x, y)`` of the point as follows.
```math
\begin{array}{ll}
\text { Polar-to-Rectangular } & \text { Rectangular-to-Polar } \\
x=r \cos \theta & \tan \theta=\frac{y}{x} \\
y=r \sin \theta & r^2=x^2+y^2
\end{array}
```
"""

## Cell 8

# ╔═╡ c0d4716c-fd9c-4a11-8c0c-f5ccb0dd7217
HTML(warning_box(
    "⚠️ Common Coordinate Conversion Mistakes",
    """
    <strong>Most frequent errors:</strong>
    <ol>
        <li><strong>Wrong quadrant:</strong> θ = arctan(y/x) only works in Quadrants I & IV</li>
        <li><strong>Forgetting absolute value:</strong> r = √(x² + y²), not just √(x² + y²)</li>
        <li><strong>Angle confusion:</strong> Adding 2π doesn't change the point, but adding π does!</li>
    </ol>
    <br>
    <strong>Safe approach:</strong> Always check which quadrant your point is in before finding θ.
    """
))

## Cell 9

# ╔═╡ 3b1c8db6-6db2-4bf5-a107-366e3d3c53d5
cm"""
$(ex(1,"Polar-to-Rectangular Conversion"))


- (a) For the point ``(r, \theta)=(2, \pi)``,
- (b) For the point ``(r, \theta)=(\sqrt{3}, \pi / 6)``,

"""

## Cell 10

# ╔═╡ 8f77ceb8-634d-4146-8687-179905ebaa9c
if s10_4_ex1_show_sol
    cm"""
$(bbl("Solution",""))
For each point, use ``x=r\cos\theta`` and ``y=r\sin\theta``.

**(a)** For ``(r,\theta)=(2,\pi)``,

```math
x = 2\cos\pi = -2, \qquad y = 2\sin\pi = 0.
```

So the rectangular coordinates are ``(x,y)=(-2,0)``.

**(b)** For ``(r,\theta)=\left(\sqrt{3},\dfrac{\pi}{6}\right)``,

```math
x = \sqrt{3}\cos\frac{\pi}{6} = \sqrt{3}\left(\frac{\sqrt{3}}{2}\right) = \frac{3}{2}
\qquad\text{and}\qquad
y = \sqrt{3}\sin\frac{\pi}{6} = \sqrt{3}\left(\frac{1}{2}\right) = \frac{\sqrt{3}}{2}.
```

So the rectangular coordinates are ``(x,y)=\left(\dfrac{3}{2},\dfrac{\sqrt{3}}{2}\right)``.
$(ebl())
"""
else
    md""
end

# ╔═╡ b5699352-1bca-4040-bbd9-2bc64085460c
HTML(tip_box(
    "💡 Polar-to-Rectangular is Easy!",
    """
    <strong>Always straightforward:</strong>
    <ul>
        <li>x = r cos(θ) ← Just substitute and calculate</li>
        <li>y = r sin(θ) ← No quadrant worries here!</li>
        <li>These formulas work for ANY r and θ values</li>
    </ul>
    <em>The hard direction is rectangular-to-polar...</em>
    """
))

## Cell 11

# ╔═╡ 26479599-3609-4814-9750-3406df4fba1f
cm"""
$(ex(2,"Rectangular-to-Polar Conversion"))
- __(a)__ For the second-quadrant point ``(x, y)=(-1,1)``,
- __(a)__ For the second-quadrant point ``(x, y)=(0,2)``,
"""

## Cell 12

# ╔═╡ 16bc3457-8de1-4b46-9caf-fd916476986e
if s10_4_ex2_show_sol
    cm"""
$(bbl("Solution",""))
For each point, use ``\tan\theta=\dfrac{y}{x}`` and ``r^{2}=x^{2}+y^{2}``, and choose ``\theta`` so that the point falls in the correct quadrant.

**(a)** For ``(x,y)=(-1,1)``,

```math
\tan\theta = \frac{y}{x} = \frac{1}{-1} = -1
\qquad\text{and}\qquad
r^{2} = (-1)^{2}+1^{2} = 2 .
```

Because the point lies in the **second quadrant**, take ``\theta=\dfrac{3\pi}{4}`` and ``r=\sqrt{2}``. One set of polar coordinates is

```math
(r,\theta)=\left(\sqrt{2},\frac{3\pi}{4}\right).
```

**(b)** For ``(x,y)=(0,2)``, the point lies on the **positive ``y``-axis**, so ``\theta=\dfrac{\pi}{2}``, and

```math
r^{2} = 0^{2}+2^{2} = 4 \quad\Longrightarrow\quad r = 2 .
```

One set of polar coordinates is ``(r,\theta)=\left(2,\dfrac{\pi}{2}\right)``.

Keep in mind that polar coordinates are **not unique** — adding any multiple of ``2\pi`` to ``\theta`` names the same point.
$(ebl())
"""
else
    md""
end

# ╔═╡ 4564edd1-7611-45b1-8f4c-26088d4c6d97
let
    warn = HTML(warning_box(
        "⚠️ Rectangular-to-Polar: Watch the Quadrant!",
        """
        <strong>For point (-1, 1) in Quadrant II:</strong>
        <br><br>
        <strong>✗ Wrong approach:</strong><br>
        θ = arctan(y/x) = arctan(1/(-1)) = arctan(-1) = -π/4
        <br><br>
        <strong>✓ Correct approach:</strong><br>
        • Point is in Quadrant II<br>
        • θ = π + arctan(y/x) = π + (-π/4) = 3π/4<br>
        <br>
        <strong>Quick check:</strong> cos(3π/4) = -1/√2 ✓ and sin(3π/4) = 1/√2 ✓
        """
    ))

    tip = HTML(tip_box(
        "💡 Quadrant Reference Guide",
        """
        <table style="border-collapse: collapse; width: 100%;">
        <tr style="background-color: #f0f0f0;">
            <th style="border: 1px solid #ddd; padding: 8px;">Quadrant</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Signs (x,y)</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Angle Range</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Formula</th>
        </tr>
        <tr>
            <td style="border: 1px solid #ddd; padding: 8px;">I</td>
            <td style="border: 1px solid #ddd; padding: 8px;">(+,+)</td>
            <td style="border: 1px solid #ddd; padding: 8px;">0 to π/2</td>
            <td style="border: 1px solid #ddd; padding: 8px;">θ = arctan(y/x)</td>
        </tr>
        <tr>
            <td style="border: 1px solid #ddd; padding: 8px;">II</td>
            <td style="border: 1px solid #ddd; padding: 8px;">(-,+)</td>
            <td style="border: 1px solid #ddd; padding: 8px;">π/2 to π</td>
            <td style="border: 1px solid #ddd; padding: 8px;">θ = π + arctan(y/x)</td>
        </tr>
        <tr>
            <td style="border: 1px solid #ddd; padding: 8px;">III</td>
            <td style="border: 1px solid #ddd; padding: 8px;">(-,-)</td>
            <td style="border: 1px solid #ddd; padding: 8px;">π to 3π/2</td>
            <td style="border: 1px solid #ddd; padding: 8px;">θ = π + arctan(y/x)</td>
        </tr>
        <tr>
            <td style="border: 1px solid #ddd; padding: 8px;">IV</td>
            <td style="border: 1px solid #ddd; padding: 8px;">(+,-)</td>
            <td style="border: 1px solid #ddd; padding: 8px;">3π/2 to 2π</td>
            <td style="border: 1px solid #ddd; padding: 8px;">θ = 2π + arctan(y/x)</td>
        </tr>
        </table>
        """
    ))

    md"""
    $(warn)

    $(tip)
    """
end

## Cell 13

# ╔═╡ 6fbc1529-ed21-4e53-91de-a026a9a4ee26
HTML(warning_box(
    "⚠️ Polar Graphing Mistakes",
    """
    <strong>Common graphing errors:</strong>
    <ul>
        <li><strong>Negative r values:</strong> r = -2 means go 2 units in the opposite direction</li>
        <li><strong>Period confusion:</strong> cos(3θ) has period 2π/3, not 2π!</li>
        <li><strong>Forgetting restrictions:</strong> Some curves need r ≥ 0 constraints</li>
    </ul>
    <br>
    <strong>Pro tip:</strong> Always check a few key points (θ = 0, π/2, π, 3π/2) first!
    """
))

## Cell 15

# ╔═╡ 602ac6a2-80a3-445c-abc2-bc5b01e44d7b
cm"""
$(ex(3,"
Graphing Polar Equations"))
Describe the graph of each polar equation. Confirm each description by converting to a rectangular equation.
- __(a.)__ ``r=2``
- __(b.)__ ``\theta=\frac{\pi}{3}``
- __(c.)__ ``r=\sec \theta``
"""

## Cell 16

# ╔═╡ 6f5ea5bc-0e8e-4c4e-893a-3266e5ecbe47
cm"""
$(ex(4,"
Sketching a Polar Graph"))
Sketch the graph of ``r=2 \cos 3 \theta``.
"""

## Cell 18

# ╔═╡ e303f5bf-f37e-4cb8-abe9-5d4891f08e77
cm"""
$(bth("Slope in Polar Form"))
If ``f`` is a differentiable function of ``\theta``, then the slope of the tangent line to the graph of ``r=f(\theta)`` at the point ``(r, \theta)`` is
```math
\frac{d y}{d x}=\frac{d y / d \theta}{d x / d \theta}=\frac{f(\theta) \cos \theta+f^{\prime}(\theta) \sin \theta}{-f(\theta) \sin \theta+f^{\prime}(\theta) \cos \theta}
```
provided that ``d x / d \theta \neq 0`` at ``(r, \theta)``.
"""

## Cell 23

# ╔═╡ a2b14cca-72f5-4e27-b198-a7b3deb9893a
cm"""
$(bbl("Remarks",""))

- Solutions of ``\frac{d y}{d \theta}=0`` yield horizontal tangents, provided that ``\frac{d x}{d \theta} \neq 0``.
- Solutions of ``\frac{d x}{d \theta}=0`` yield vertical tangents, provided that ``\frac{d y}{d \theta} \neq 0``.

- If ``d y / d \theta`` and ``d x / d \theta`` are simultaneously 0 , then no conclusion can be drawn about tangent lines.
"""

## Cell 24

# ╔═╡ 35429393-e411-4ac8-9719-c90523ade5ea
HTML(warning_box(
    "⚠️ Polar Slope Formula Confusion",
    """
    <strong>Don't mix up the formulas!</strong>
    <br><br>
    <strong>In rectangular coordinates:</strong><br>
    dy/dx = f'(x)
    <br><br>
    <strong>In polar coordinates:</strong><br>
    dy/dx = (r cos θ + r' sin θ)/(-r sin θ + r' cos θ)
    <br><br>
    <strong>Key difference:</strong> Polar slope depends on BOTH r and θ, not just the rate of change of r!
    """
))

## Cell 25

# ╔═╡ 2bc60f92-4577-4866-9344-d7f0b397c637
cm"""
$(ex(5,"Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines of ``r=\sin \theta``, where ``0 \leq \theta<\pi``.
"""

## Cell 26

# ╔═╡ da33d6d3-4601-40f4-9dcd-ffdb41497dea
if s10_4_ex5_show_sol
    cm"""
$(bbl("Solution",""))
Begin by writing the curve in parametric form, using ``\theta`` as the parameter. Because ``r=\sin\theta``,

```math
x = r\cos\theta = \sin\theta\cos\theta
\qquad\text{and}\qquad
y = r\sin\theta = \sin^{2}\theta .
```

**Horizontal tangent lines.** Set ``\dfrac{dy}{d\theta}=0``.

```math
\frac{dy}{d\theta} = 2\sin\theta\cos\theta = \sin 2\theta = 0
\quad\Longrightarrow\quad
\theta = 0, \ \frac{\pi}{2}
```

So the graph has horizontal tangent lines at ``(0,0)`` and ``\left(1,\dfrac{\pi}{2}\right)``.

**Vertical tangent lines.** Set ``\dfrac{dx}{d\theta}=0``.

```math
\frac{dx}{d\theta} = \cos^{2}\theta-\sin^{2}\theta = \cos 2\theta = 0
\quad\Longrightarrow\quad
\theta = \frac{\pi}{4}, \ \frac{3\pi}{4}
```

So the graph has vertical tangent lines at ``\left(\dfrac{\sqrt{2}}{2},\dfrac{\pi}{4}\right)`` and ``\left(\dfrac{\sqrt{2}}{2},\dfrac{3\pi}{4}\right)``.

The graph of ``r=\sin\theta`` is the circle of radius ``\dfrac{1}{2}`` centred at ``\left(0,\dfrac{1}{2}\right)``, which confirms these four points.
$(ebl())
"""
else
    md""
end

# ╔═╡ 3722b027-a69b-4646-bf4d-c8ebe1cb27ea
cm"""
$(ex(6,"
Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines to the graph of ``r=2(1-\cos \theta)``, where ``0 \leq \theta<2 \pi``.
"""

## Cell 28

# ╔═╡ 455cd3d3-eaaf-43fe-ad26-c0f1e949fa15
if s10_4_ex6_show_sol
    cm"""
$(bbl("Solution",""))
Because ``r=2(1-\cos\theta)``, write the cardioid in parametric form.

```math
x = r\cos\theta = 2(1-\cos\theta)\cos\theta
\qquad\text{and}\qquad
y = r\sin\theta = 2(1-\cos\theta)\sin\theta .
```

**Horizontal tangent lines.** Set ``\dfrac{dy}{d\theta}=0``.

```math
\frac{dy}{d\theta} = 2\left[(1-\cos\theta)\cos\theta+\sin^{2}\theta\right]
= -2(2\cos\theta+1)(\cos\theta-1) = 0
```

So ``\cos\theta=-\dfrac{1}{2}`` or ``\cos\theta=1``, which gives ``\theta=\dfrac{2\pi}{3},\ \dfrac{4\pi}{3},\ 0``.

**Vertical tangent lines.** Set ``\dfrac{dx}{d\theta}=0``.

```math
\frac{dx}{d\theta} = 2\left[-(1-\cos\theta)\sin\theta+\cos\theta\sin\theta\right]
= 2\sin\theta(2\cos\theta-1) = 0
```

So ``\sin\theta=0`` or ``\cos\theta=\dfrac{1}{2}``, which gives ``\theta=0,\ \pi,\ \dfrac{\pi}{3},\ \dfrac{5\pi}{3}``.

From these values, the cardioid has

- horizontal tangent lines at ``\left(3,\dfrac{2\pi}{3}\right)`` and ``\left(3,\dfrac{4\pi}{3}\right)``, and
- vertical tangent lines at ``\left(1,\dfrac{\pi}{3}\right)``, ``(4,\pi)``, and ``\left(1,\dfrac{5\pi}{3}\right)``.

Notice that both ``\dfrac{dy}{d\theta}`` and ``\dfrac{dx}{d\theta}`` are ``0`` when ``\theta=0``, so this test alone tells you nothing about the tangent line at the pole. Using the theorem on tangent lines at the pole, however, you can see that the graph has a **cusp** at the pole.
$(ebl())
"""
else
    md""
end

# ╔═╡ 0bc9dc7c-d62f-4d00-bb6e-7b34af0f66ca
cm"""
$(bth("Tangent Lines at the Pole"))
If ``f(\alpha)=0`` and ``f^{\prime}(\alpha) \neq 0``, then the line ``\theta=\alpha`` is tangent at the pole to the graph of ``r=f(\theta)``.
"""

## Cell 30

# ╔═╡ 3dbb47a8-9310-4013-a4db-0514614d0d4d
HTML(tip_box(
    "💡 Rose Curve Quick Facts",
    """
    <strong>Number of petals:</strong>
    <ul>
        <li><strong>n odd:</strong> exactly n petals</li>
        <li><strong>n even:</strong> exactly 2n petals</li>
    </ul>
    <br>
    <strong>Examples:</strong><br>
    • r = cos(3θ) → 3 petals<br>
    • r = cos(4θ) → 8 petals<br>
    • r = cos(5θ) → 5 petals
    <br><br>
    <em>Try changing n in the interactive plot above to see this pattern!</em>
    """
))

## Cell 34

# ╔═╡ 3c52a17c-75e9-4e2f-ae64-afc05fc110d4
cm"""
__What is the area of a sector of a circle?__

$(post_img("https://www.dropbox.com/scl/fi/sgx7mh1hbsj2zbc2ka19t/fig48_10_5.png?rlkey=7dc54g4fkrlnkdt6ijebxga2w&dl=1",300))

__How to find the area of the region bounded by the graph of the function ``f`` and the radial lines ``\theta = \alpha`` and ``\theta = \beta``?__

$(post_img("https://www.dropbox.com/scl/fi/6ks10wxt27god0jec8ae7/fig49_a_10_5.png?rlkey=5xb3cva5jq1tbe3477d46z98i&dl=1",300))


"""

# ╔═╡ 09c29e2e-3561-479a-8b71-627be4e214df
cm"""
$(bth("Area in Polar Coordinates"))
If ``f`` is continuous and nonnegative on the interval ``[\alpha, \beta], 0<\beta-\alpha \leq 2 \pi``, then the area of the region bounded by the graph of ``r=f(\theta)`` between the radial lines ``\theta=\alpha`` and ``\theta=\beta`` is
```math
A=\frac{1}{2} \int_\alpha^\beta[f(\theta)]^2 d \theta
```
```math
=\frac{1}{2} \int_\alpha^\beta r^2 d \theta . \quad 0<\beta-\alpha \leq 2 \pi
```
"""

# ╔═╡ 7620fe26-1c9d-4a41-b358-eaef9f52d52d
cm"""
$(ex(1,"
Finding the Area of a Polar Region"))
Find the area of one petal of the rose curve ``r=3 \cos 3 \theta``.
"""

# ╔═╡ 8bae4edc-d910-4927-9cab-79bc8387b2c5
cm"""
$(ex(2,"Finding the Area Bounded by a Single Curve"))
Find the area of the region lying between the inner and outer loops of the limaçon ``r=1-2 \sin \theta``.
"""

# ╔═╡ 8ba3bd5c-8b24-4c42-8c59-af5cd88305e6
cm"""
$(ex(3,"Finding the Area of a Region Between Two Curves"))
Find the area of the region common to the two regions bounded by the curves
```math
r=-6 \cos \theta \qquad \color{red}{\text{Circle}}
```
and
```math
r=2-2 \cos \theta  \qquad \color{red}{\text{Cardioid}}
```

"""

# ╔═╡ ca18659d-269d-4fc6-9872-26946aca3a2e
cm"""
$(bth("Arc Length of a Polar Curve"))
Let ``f`` be a function whose derivative is continuous on an interval ``\alpha \leq \theta \leq \beta``. The length of the graph of ``r=f(\theta)`` from ``\theta=\alpha`` to ``\theta=\beta`` is
```math
s=\int_\alpha^\beta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta=\int_\alpha^\beta \sqrt{r^2+\left(\frac{d r}{d \theta}\right)^2} d \theta
```
"""

# ╔═╡ 04b58a60-31a9-4d68-b496-5ff73bb9a864
cm"""
$(ex(4,"Finding the Length of a Polar Curve"))
Find the length of the arc from ``\theta=0`` to ``\theta=2 \pi`` for the cardioid ``r=f(\theta)=2-2 \cos \theta``
"""

# ╔═╡ c970ee3e-53ae-4914-84a1-91091fc9bac8
cm"""
$(bth("Area of a Surface of Revolution"))
Let ``f`` be a function whose derivative is continuous on an interval ``\alpha \leq \theta \leq \beta``. The area of the surface formed by revolving the graph of ``r=f(\theta)`` from ``\theta=\alpha`` to ``\theta=\beta`` about the indicated line is as follows.
1. ``\displaystyle S=2 \pi \int_\alpha^\beta f(\theta) \sin \theta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta \quad \color{red}{\text{About the polar axis}}``



2. ``\displaystyle S=2 \pi \int_\alpha^\beta f(\theta) \cos \theta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta\quad \color{red}{\text{About the line } \theta=\frac{\pi}{2}}``
$(ebl())

$(ex(5,"Finding the Area of a Surface of Revolution"))
Find the area of the surface formed by revolving the circle ``r=f(\theta)=\cos \theta`` about the line ``\theta=\pi / 2``
"""

# ╔═╡ 8ce83819-cf7f-46fc-aded-773e3a716244
@htl("""
<style>
@import url("https://mmogib.github.io/math102/custom.css");

ul {
  list-style: none;
}

ul li:before {
  content: '💡 ';
}

.p40 {
    padding-left: 40px;
}

example-box {
      max-width: 600px;           /* Limits the box width */
      margin: 2rem auto;          /* Centers the box and adds vertical spacing */
      border: 1px solid #ccc;     /* Light border */
      border-radius: 4px;         /* Slightly rounded corners */
      overflow: hidden;           /* Ensures the box boundary clips its children */
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
      font-family: Arial, sans-serif;
    }

    /* Header area for "EXAMPLE 1" */
    .example-header {
      background: linear-gradient(90deg, #cc0000, #990000);
      color: #fff;
      font-weight: bold;
      font-size: 1.1rem;
      padding: 0.75rem 1rem;
      border-bottom: 1px solid #990000;
    }

    /* Sub-header area for the title or subtitle */
    .example-title {
      background-color: #f9f9f9;
      font-weight: 600;
      font-size: 1rem;
      padding: 0.75rem 1rem;
      margin: 0;                  /* Remove default heading margins */
      border-bottom: 1px solid #eee;
    }

    /* Main content area for the mathematical statement or instructions */
    .example-content {
      padding: 1rem;
      line-height: 1.5;
    }

    /* Optional styling for inline math or emphasis */
    em {
      font-style: italic;
      color: #333;
    }
</style>
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
Groebner = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Nemo = "2edaba10-b0f1-5616-af89-8c11ac63239a"
PlotThemes = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoExtras = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
QRCoders = "f42e9828-16f3-11ed-2883-9126170b272d"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
Colors = "~0.12.11"
CommonMark = "~1.0.1"
ForwardDiff = "~1.2.2"
Groebner = "~0.10.0"
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.4.0"
Latexify = "~0.16.10"
Nemo = "~0.52.3"
PlotThemes = "~3.3.0"
Plots = "~1.41.6"
PlutoExtras = "~0.7.18"
PlutoUI = "~0.7.80"
PrettyTables = "~3.3.2"
QRCoders = "~1.4.5"
Symbolics = "~6.57.0"
Unitful = "~1.25.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "8f77f2a32de6eb5c5324ae11dbc41b9b01712021"

[[deps.ADTypes]]
git-tree-sha1 = "27cecae79e5cc9935255f90c53bb831cc3c870d7"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.18.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesConstructionBaseExt = "ConstructionBase"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

[[deps.AbstractAlgebra]]
deps = ["LinearAlgebra", "MacroTools", "Preferences", "Random", "RandomExtensions", "SparseArrays"]
git-tree-sha1 = "dc5edff637f5e6737128ea226c32fa242ebba3c0"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.47.3"
weakdeps = ["Test"]

    [deps.AbstractAlgebra.extensions]
    TestExt = "Test"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "6c3913f4e9bdf6ba3c08041a446fb1332716cbc2"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.0"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "3b86719127f50670efe356bc11073d84b4ed7a5d"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.42"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "7e35fca2bdfba44d797c53dfe63a51fabf39bfc0"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.4.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "d81ae5489e13bc03567d4fbbb06c546a5e53c857"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.22.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = ["CUDSS", "CUDA"]
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceMetalExt = "Metal"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Atomix]]
deps = ["UnsafeAtomics"]
git-tree-sha1 = "29bb0eb6f578a587a49da16564705968667f5fa8"
uuid = "a9b6321e-bd34-4604-b9c9-b65b8de01458"
version = "1.1.2"

    [deps.Atomix.extensions]
    AtomixCUDAExt = "CUDA"
    AtomixMetalExt = "Metal"
    AtomixOpenCLExt = "OpenCL"
    AtomixoneAPIExt = "oneAPI"

    [deps.Atomix.weakdeps]
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    OpenCL = "08131aa3-fb12-5dee-8b74-c09406e224a2"
    oneAPI = "8f75cd03-7ff8-4ecb-9b8f-daf728133b1b"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "4126b08903b777c88edf1754288144a0492c05ad"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.8"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bijections]]
git-tree-sha1 = "a2d308fcd4c2fb90e943cf9cd2fbfa9c32b69733"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.2.2"

[[deps.BitFlags]]
git-tree-sha1 = "bbe1079eecf9c9fbb52765193ad2bae27ae09bc8"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.10"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d0efe2c6fdcdaa1c161d206aa8b933788397ec71"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.6+0"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e4c6a16e77171a5f5e25e9646617ab1c276c5607"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.26.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "970758a3d591a2a5c2a907c53f2e2f8c1b1d3537"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.9"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b5278586822443594ff615963b0c09755771b3e0"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.26.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonMark]]
deps = ["PrecompileTools"]
git-tree-sha1 = "019ad9e55bb3549403f2d5a9b314fbb29a806ecb"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "1.0.1"

    [deps.CommonMark.extensions]
    CommonMarkMarkdownASTExt = "MarkdownAST"
    CommonMarkMarkdownExt = "Markdown"

    [deps.CommonMark.weakdeps]
    Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
    MarkdownAST = "d0879d2d-cac2-40c8-9cee-1863dc0c7391"

[[deps.CommonSolve]]
git-tree-sha1 = "78ea4ddbcf9c241827e7035c3a03e2e456711470"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.6"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.CompositeTypes]]
git-tree-sha1 = "bce26c3dab336582805503bed209faab1c279768"
uuid = "b152e2b5-7a66-4b01-a709-34e65c35f657"
version = "0.1.4"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "3c9be947934c38475bafe822c6d61aaed17f0738"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.6.0"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3bc002af51045ca3b47d2e1787d6ce02e68b943a"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.122"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "c249d86e97a7e8398ce2068dce4c078a1c3464de"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.7.16"

    [deps.DomainSets.extensions]
    DomainSetsMakieExt = "Makie"
    DomainSetsRandomExt = "Random"

    [deps.DomainSets.weakdeps]
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.DynamicPolynomials]]
deps = ["Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Reexport", "Test"]
git-tree-sha1 = "9a3ae38b460449cc9e7dd0cfb059c76028724627"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.6.1"

[[deps.EnumX]]
git-tree-sha1 = "bddad79635af6aec424f53ed8aad5d7555dc6f00"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.5"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f4d39eee89f1e58c26bf447f1d4156c0125d6838"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.8.3+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.ExproniconLite]]
git-tree-sha1 = "c13f0b150373771b0fdc1713c97860f8df12e6c2"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.10.14"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "66381d7059b5f3f6162f28831854008040a4e905"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.0.1+1"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FLINT_jll]]
deps = ["Artifacts", "GMP_jll", "JLLWrappers", "Libdl", "MPFR_jll", "OpenBLAS32_jll"]
git-tree-sha1 = "65248c4cbdd4392072d39dff23b385bac47e7b12"
uuid = "e134572f-a0d5-539d-bddf-3cad8db41a82"
version = "301.300.102+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "6522cfb3b8fe97bec632252263057996cbd3de20"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.18.0"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "5bfcd42851cf2f1b303f51525a54dc5e98d408a3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.15.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "ba6ce081425d0afb2bedd00d9884464f764a9225"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "1.2.2"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "70329abc09b886fd2c5d94ad2d9527639c421e3e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.14.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers"]
git-tree-sha1 = "b104d487b34566608f8b4e1c39fb0b10aa279ff8"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "0.1.3"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "b7bfd56fa66616138dfe5237da4dc13bbd83c67f"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.1+0"

[[deps.GMP_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "781609d7-10c4-51f6-84f2-b8444358ff6d"
version = "6.3.0+2"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "83cf05ab16a73219e5f6bd1bdfa9848fa24ac627"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.2.0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "f52c27dd921390146624f3aab95f4e8614ad6531"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.18"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b0406b866ea9fdbaf1148bc9c0b887e59f9af68"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.18+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "24f6def62397474a297bfcec22384101609142ed"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.3+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Groebner]]
deps = ["AbstractAlgebra", "Atomix", "Combinatorics", "Logging", "Nemo", "PrecompileTools", "Primes", "Printf", "Random", "TimerOutputs"]
git-tree-sha1 = "b15f687fe3572da785945e8bf3480a447c3edbbe"
uuid = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
version = "0.10.0"
weakdeps = ["DynamicPolynomials"]

    [deps.Groebner.extensions]
    GroebnerDynamicPolynomialsExt = "DynamicPolynomials"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "51059d23c8bb67911a2e6fd5130229113735fc7e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.11.0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "437abb322a41d527c197fa800455f79d414f0a3c"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.8"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e64ab2f0da7b928c8ae889c514a52741debc1c2"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.2"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Bzip2_jll", "FFTW_jll", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "Zstd_jll", "libpng_jll", "libwebp_jll", "libzip_jll"]
git-tree-sha1 = "2c232857f2eb9ecfa3ab534df7f060c9afbeb187"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.2011+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dcc8d0cd653e55213df9b75ebc6fe4a8d3254c65"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.2.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "4c1acff2dc6b6967e7e750633c50bc3b8d83e617"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalSets]]
git-tree-sha1 = "d966f85b3b7a8e49d034d27a189e9a4874b4391a"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.13"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "c7345ab1a7ca4dc8a02c9f6510da0d9857bbe513"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.7.1"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.Jieko]]
deps = ["ExproniconLite"]
git-tree-sha1 = "2f05ed29618da60c06a87e9c033982d4f71d0b6c"
uuid = "ae98c720-c025-4a4a-838c-29b094483192"
version = "0.2.1"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6893345fd6658c8e475d40155789f4860ac3b21"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.4+0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "97bbca976196f2a1eb9607131cb108c69ec3f8a6"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d0205286d9eceadc518742860bf23f703779a3d6"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.3+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "8e6a74641caf3b84800f2ccd55dc7ab83893c10b"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.17.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MPFR_jll]]
deps = ["Artifacts", "GMP_jll", "Libdl"]
uuid = "3a97d323-0669-5f0c-9066-3539efd106a3"
version = "4.2.2+0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.MappedArrays]]
git-tree-sha1 = "0ee4497a4e80dbd29c058fcee6493f5219556f40"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.3"

[[deps.MarchingCubes]]
deps = ["PrecompileTools", "StaticArrays"]
git-tree-sha1 = "0e893025924b6becbae4109f8020ac0e12674b01"
uuid = "299715c1-40a9-479a-aaf9-4a633d36f717"
version = "0.1.11"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "8785729fa736197687541f7053f6d8ab7fc44f92"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.10"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ff69a2b1330bcb730b9ac1ab7dd680176f5896b8"
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.1010+0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.Moshi]]
deps = ["ExproniconLite", "Jieko"]
git-tree-sha1 = "53f817d3e84537d84545e0ad749e483412dd6b2a"
uuid = "2e0e35c7-a2e4-4343-998d-7ef72827ed2d"
version = "0.3.7"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "fade91fe9bee7b142d332fc6ab3f0deea29f637b"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.5.9"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "22df8573f8e7c593ac205455ca088989d0a2c7a0"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.6.7"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.Nemo]]
deps = ["AbstractAlgebra", "FLINT_jll", "LinearAlgebra", "Random", "RandomExtensions", "SHA"]
git-tree-sha1 = "23895d5462d6019efbc877108ab1182421acf493"
uuid = "2edaba10-b0f1-5616-af89-8c11ac63239a"
version = "0.52.3"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS32_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ece4587683695fe4c5f20e990da0ed7e83c351e7"
uuid = "656ef2d0-ae68-5445-9ca0-591084a874a2"
version = "0.3.29+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "135492b7e97fc86d9b132b96a54d2d3dd3e0c6a8"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.4.8+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "215a6666fee6d6b3a6e75f2cc22cb767e2dd393a"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.5+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "1d1aaa7d449b58415f97d2839c318b70ffb525a0"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "94ba93778373a53bfd5a0caaf7d809c445292ff4"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.44.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "f07c06228a1c670ae4c87d1276b92c7c597fdda0"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.35"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0662b083e11420952f2e62e17eddae7fc07d5997"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.57.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "3de8f5e6e90ebfa8d6d1f86997d6cdcd6a912ff3"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.7"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "26ca162858917496748aad52bb5d3be4d26a228a"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "cb20a4eacda080e517e4deb9cfb6c7c518131265"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.6"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoExtras]]
deps = ["AbstractPlutoDingetjes", "DocStringExtensions", "HypertextLiteral", "InteractiveUtils", "Markdown", "PlutoUI", "REPL", "Random"]
git-tree-sha1 = "ba293b0d67584aa71badebdf8e5e572ba61d0246"
uuid = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
version = "0.7.18"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "fbc875044d82c113a9dee6fc14e16cf01fd48872"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.80"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "624de6279ab7d94fc9f672f0068107eb6619732c"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.3.2"

    [deps.PrettyTables.extensions]
    PrettyTablesTypstryExt = "Typstry"

    [deps.PrettyTables.weakdeps]
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "25cdd1d20cd005b52fc12cb6be3f75faaf59bb9b"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.7"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "fbb92c6c56b34e1a2c4c36058f68f332bec840e7"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "472daaa816895cb7aee81658d4e7aec901fa1106"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.2"

[[deps.QRCoders]]
deps = ["FileIO", "ImageCore", "ImageIO", "ImageMagick", "StatsBase", "UnicodePlots"]
git-tree-sha1 = "b3e5fcc7a7ade2d43f0ffd178c299b7a264c268a"
uuid = "f42e9828-16f3-11ed-2883-9126170b272d"
version = "1.4.5"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "34f7e5d2861083ec7596af8b8c092531facf2192"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "8f528b0851b5b7025032818eb5abbeb8a736f853"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "b8a399e95663485820000f26b6a43c794e166a49"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.4"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterface", "DocStringExtensions", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables"]
git-tree-sha1 = "f8726bd5a8b7f5f5d3f6c0ce4793454a599b5243"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "3.36.0"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsFastBroadcastExt = "FastBroadcast"
    RecursiveArrayToolsForwardDiffExt = "ForwardDiff"
    RecursiveArrayToolsKernelAbstractionsExt = "KernelAbstractions"
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsReverseDiffExt = ["ReverseDiff", "Zygote"]
    RecursiveArrayToolsSparseArraysExt = ["SparseArrays"]
    RecursiveArrayToolsStructArraysExt = "StructArrays"
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    FastBroadcast = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "5b3d50eb374cea306873b371d3f8d3915a018f0b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.9.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "2f609ec2295c452685d3142bc4df202686e555d2"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.16"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "e24dc23107d426a096d3eae6c165b921e74c18e4"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.2"

[[deps.SciMLBase]]
deps = ["ADTypes", "Accessors", "ArrayInterface", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "Moshi", "PrecompileTools", "Preferences", "Printf", "RecipesBase", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLOperators", "SciMLStructures", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface"]
git-tree-sha1 = "1f7cf417da3771b98f0e3f32ce0bb813e9fe91fa"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "2.85.0"

    [deps.SciMLBase.extensions]
    SciMLBaseChainRulesCoreExt = "ChainRulesCore"
    SciMLBaseMLStyleExt = "MLStyle"
    SciMLBaseMakieExt = "Makie"
    SciMLBasePartialFunctionsExt = "PartialFunctions"
    SciMLBasePyCallExt = "PyCall"
    SciMLBasePythonCallExt = "PythonCall"
    SciMLBaseRCallExt = "RCall"
    SciMLBaseZygoteExt = ["Zygote", "ChainRulesCore"]

    [deps.SciMLBase.weakdeps]
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MLStyle = "d8e11817-5142-5d16-987a-aa16d5891078"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    PartialFunctions = "570af359-4316-4cb7-8c74-252c00c2016b"
    PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
    PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
    RCall = "6f49c342-dc21-5d91-9882-a32aef131414"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.SciMLOperators]]
deps = ["Accessors", "ArrayInterface", "DocStringExtensions", "LinearAlgebra", "MacroTools"]
git-tree-sha1 = "1c4b7f6c3e14e6de0af66e66b86d525cae10ecb4"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "0.3.13"
weakdeps = ["SparseArrays", "StaticArraysCore"]

    [deps.SciMLOperators.extensions]
    SciMLOperatorsSparseArraysExt = "SparseArrays"
    SciMLOperatorsStaticArraysCoreExt = "StaticArraysCore"

[[deps.SciMLPublic]]
git-tree-sha1 = "ed647f161e8b3f2973f24979ec074e8d084f1bee"
uuid = "431bcebd-1456-4ced-9d72-93c2757fff0b"
version = "1.0.0"

[[deps.SciMLStructures]]
deps = ["ArrayInterface"]
git-tree-sha1 = "566c4ed301ccb2a44cbd5a27da5f885e0ed1d5df"
uuid = "53ae85a6-f571-4167-b2af-e1d143709226"
version = "1.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "be8eeac05ec97d379347584fa9fe2f5f76795bcb"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.5"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.12.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2700b235561b0335d5bef7097a111dc513b8655e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.7.2"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "4f96c596b8c8258cc7d3b19797854d368f243ddc"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.4"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "246a8bb2e6667f832eea063c3a56aef96429a3db"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.18"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "91f091a8716a6bb38417a6e6f274602a19aaa685"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.2"
weakdeps = ["ChainRulesCore", "InverseFunctions"]

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "d05693d339e37d6ab134c5ab53c29fce5ee5d7d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.4"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "2d0fc55c61321ba245c47be599570d11bac50303"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.8.5"

    [deps.StructUtils.extensions]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

[[deps.SymbolicIndexingInterface]]
deps = ["Accessors", "ArrayInterface", "RuntimeGeneratedFunctions", "StaticArraysCore"]
git-tree-sha1 = "94c58884e013efff548002e8dc2fdd1cb74dfce5"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.3.46"
weakdeps = ["PrettyTables"]

    [deps.SymbolicIndexingInterface.extensions]
    SymbolicIndexingInterfacePrettyTablesExt = "PrettyTables"

[[deps.SymbolicLimits]]
deps = ["SymbolicUtils"]
git-tree-sha1 = "f75c7deb7e11eea72d2c1ea31b24070b713ba061"
uuid = "19f23fe9-fdab-4a78-91af-e7b7767979c3"
version = "0.2.3"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "ArrayInterface", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "ExproniconLite", "LinearAlgebra", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "TaskLocalValues", "TermInterface", "TimerOutputs", "Unityper"]
git-tree-sha1 = "a85b4262a55dbd1af39bb6facf621d79ca6a322d"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "3.32.0"

    [deps.SymbolicUtils.extensions]
    SymbolicUtilsLabelledArraysExt = "LabelledArrays"
    SymbolicUtilsReverseDiffExt = "ReverseDiff"

    [deps.SymbolicUtils.weakdeps]
    LabelledArrays = "2ee39098-c373-598a-b85f-a56591580800"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.Symbolics]]
deps = ["ADTypes", "ArrayInterface", "Bijections", "CommonWorldInvalidations", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "DynamicPolynomials", "LaTeXStrings", "Latexify", "Libdl", "LinearAlgebra", "LogExpFunctions", "MacroTools", "Markdown", "NaNMath", "OffsetArrays", "PrecompileTools", "Primes", "RecipesBase", "Reexport", "RuntimeGeneratedFunctions", "SciMLBase", "SciMLPublic", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArraysCore", "SymbolicIndexingInterface", "SymbolicLimits", "SymbolicUtils", "TermInterface"]
git-tree-sha1 = "8206e177903a41519145f577cb7f3793f3b7c960"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "6.57.0"

    [deps.Symbolics.extensions]
    SymbolicsD3TreesExt = "D3Trees"
    SymbolicsForwardDiffExt = "ForwardDiff"
    SymbolicsGroebnerExt = "Groebner"
    SymbolicsLuxExt = "Lux"
    SymbolicsNemoExt = "Nemo"
    SymbolicsPreallocationToolsExt = ["PreallocationTools", "ForwardDiff"]
    SymbolicsSymPyExt = "SymPy"
    SymbolicsSymPyPythonCallExt = "SymPyPythonCall"

    [deps.Symbolics.weakdeps]
    D3Trees = "e3df1716-f71e-5df9-9e2d-98e193103c45"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Groebner = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
    Lux = "b2108857-7c20-44ae-9111-449ecde12c47"
    Nemo = "2edaba10-b0f1-5616-af89-8c11ac63239a"
    PreallocationTools = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "0f38a06c83f0007bbab3cf911262841c9a0f07e0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.13.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TaskLocalValues]]
git-tree-sha1 = "67e469338d9ce74fc578f7db1736a74d93a49eb8"
uuid = "ed4db957-447d-4319-bfb6-7fa9ae7ecf34"
version = "0.1.3"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.TermInterface]]
git-tree-sha1 = "d673e0aca9e46a2f63720201f55cc7b3e7169b16"
uuid = "8ea1fca8-c5ef-4a55-8b96-4e9afe9c9a3c"
version = "2.0.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "38f139cc4abf345dd4f22286ec000728d5e8e097"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.2"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "3748bd928e68c7c346b52125cf41fff0de6937d0"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.29"

    [deps.TimerOutputs.extensions]
    FlameGraphsExt = "FlameGraphs"

    [deps.TimerOutputs.weakdeps]
    FlameGraphs = "08572546-2f56-4bcf-ba4e-bab62c3a3f89"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "908fec9df6c5de98548ead82a468c95ccf6cd263"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.UnicodePlots]]
deps = ["Contour", "Crayons", "Dates", "LinearAlgebra", "MarchingCubes", "NaNMath", "SparseArrays", "StaticArrays", "StatsBase"]
git-tree-sha1 = "66f9127e995e4eab4041c5f01d644a7278ac8bc2"
uuid = "b8865327-cd53-5732-bb35-84acbb429228"
version = "2.8.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "83360bda12f61c250835830cc40b64f487cc2230"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.25.1"
weakdeps = ["ConstructionBase", "ForwardDiff", "InverseFunctions", "LaTeXStrings", "Latexify", "Printf"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    LatexifyExt = ["Latexify", "LaTeXStrings"]
    PrintfExt = "Printf"

[[deps.Unityper]]
deps = ["ConstructionBase"]
git-tree-sha1 = "25008b734a03736c41e2a7dc314ecb95bd6bbdb0"
uuid = "a7c27f48-0311-42f6-a7f8-2c11e75eb415"
version = "0.1.6"

[[deps.UnsafeAtomics]]
git-tree-sha1 = "b13c4edda90890e5b04ba24e20a310fbe6f249ff"
uuid = "013be700-e6cd-48c3-b4a1-df204f14c38f"
version = "0.3.0"

    [deps.UnsafeAtomics.extensions]
    UnsafeAtomicsLLVM = ["LLVM"]

    [deps.UnsafeAtomics.weakdeps]
    LLVM = "929cbde3-209d-540e-8aea-75f648917ca0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9cce64c0fdd1960b597ba7ecda2950b5ed957438"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.2+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "808090ede1d41644447dd5cbafced4731c56bd2f"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.13+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "4909eb8f1cbf6bd4b1c30dd18b2ead9019ef2fad"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.18.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "63aac0bcb0b582e11bad965cef4a689905456c03"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.125+1"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e2a7072fc0cdd7949528c1455a3e5da4122e1153"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.56+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "7dbf96baae3310fe2fa0df0ccbb3c6288d5816c9"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.23.0+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "4e4282c4d846e11dce56d74fa8040130b7a95cb3"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.6.0+0"

[[deps.libzip_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "OpenSSL_jll", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "86addc139bca85fdf9e7741e10977c45785727b7"
uuid = "337d8026-41b4-5cde-a456-74a10e5b31d1"
version = "1.11.3+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"
"""

# ╔═╡ Cell order:
# ╟─9858d0f8-ba7e-44fe-bcfc-4af064b7985c
# ╟─286b172a-8bfe-430c-b13b-83e0e14798d1
# ╟─f7f0dbe3-ab41-4ff2-ad97-5927f657d5a4
# ╟─c7a8937d-6d27-41c3-ac54-8d59db9c8937
# ╟─dc65d765-0bef-4c49-93af-1cd0ebabe632
# ╟─bf29e57e-d859-4d73-876c-46d6a7805228
# ╟─c0fe5d64-6d06-4daf-a827-87e2a98b7389
# ╟─b15e87af-7574-48a7-b014-ef0ad8f3ea62
# ╟─e3eaab8a-46db-45f1-a57c-5fe61e583919
# ╟─bd0ffc3a-0773-4368-b179-e6502a3fbee7
# ╟─7ab904a8-91e2-4814-9eba-3e55f35f0503
# ╟─3fad0402-00d4-4c3b-9ca7-bed4897452c2
# ╟─72eaba37-67d9-4d52-b1a6-e108401aa93e
# ╟─0f02e8df-9945-4d41-af5f-290dd991db92
# ╟─1e7b4218-ca92-4384-83db-31e97fa5545f
# ╟─ef07b8c6-a4a8-4daa-8843-39d522f995ef
# ╟─4ba93c73-86c0-447e-bc4e-c4eafe68d3ca
# ╟─0870140d-366c-4953-9f84-1316c2419bad
# ╟─9c8987f5-a609-45df-94f0-99c372e5876d
# ╟─62ad6901-4883-4cdb-9b8b-0d2e4b409d4e
# ╟─15a0e2e8-382e-487a-a297-12feaaab6f91
# ╟─948e5b3a-40a2-4081-85f8-12c42837ae3a
# ╟─b05fcc39-dad9-4bdf-874e-6dedf75fe36c
# ╟─577dbd65-1377-4dd1-bb8f-52e4202ae745
# ╟─cab568b8-a82e-4886-8988-7766297153c6
# ╟─b8d18b8b-43e7-4ce8-8942-d01454614f3d
# ╟─66b48d42-742f-49f9-8e97-684f2d790b32
# ╟─d3f76ebe-9587-4f85-aa8c-c068478855e3
# ╟─aaea1a28-8b28-496d-b575-a7711beda83d
# ╟─8f4206ed-c4de-42f9-8539-ffabf79306b2
# ╟─c4d041e7-214a-4eb4-8e4a-f4308efd6a83
# ╟─6f2b9ee3-1579-4685-9b2d-c7fa7b07a828
# ╟─efb426c5-ac63-4360-86e4-b579b847b69a
# ╟─0d8c28f3-b885-4b16-95ef-99708a6bb179
# ╟─98951c5f-438a-4b27-b0b1-5aef88c6bfab
# ╟─d1029e12-aacd-49bf-aebf-ded4a3a31ca6
# ╟─310a267a-288d-4ab7-a8c6-4700b951703a
# ╟─080c8917-6a7f-46ab-9ce7-4a19d2062375
# ╟─46cb1033-5bdc-4978-a8b8-3caf5da336b9
# ╟─676045ab-7fa0-48ab-a215-1e0a9abfdf1e
# ╟─ebc1271e-0fcf-47bc-bf74-850b1d2ed425
# ╟─96b650e7-d4ce-478f-878f-d9cd6d10f2b6
# ╟─b64864dc-953d-41c5-bae6-5ede6734c8af
# ╟─76ace408-0ae7-458e-9b0a-cc6c3a314cd2
# ╟─c9e03dab-763a-4ddf-aa8f-36c1f85143a4
# ╟─2861e7e5-c7d4-4764-a52e-9422fff637b5
# ╟─92b10e3c-8187-4785-a4bb-b724eb120476
# ╟─3e357741-353d-4aca-9110-a96208c7f60c
# ╟─58873013-9dd1-4a76-84a7-6f43462dbcb6
# ╟─a87bd52c-86ad-43ac-8766-04f56a196b88
# ╟─a0adc254-80b7-4ef3-a880-e864851f937a
# ╟─2ac5fa04-03d8-4725-88d0-6f76213e5fa6
# ╟─bdb0938d-658d-4abc-94ed-e38edc55adb4
# ╟─29c142be-48e3-488f-b8fb-3b9c34de64b0
# ╟─698c533c-4bca-44ae-ab4b-68a107e1db2a
# ╟─48467e30-614d-4ab9-852d-6e7f19bd2a3b
# ╟─3ff7e63b-0e3f-4933-a58a-b538f0bd4307
# ╟─567cc54f-b6ed-4934-8f6c-c843f722bb98
# ╟─2497c799-3aad-451d-abc6-30aa20aa6924
# ╟─0daa50ef-abb0-4f10-a3c0-6081beab4bfb
# ╟─d6ccee4f-40be-429b-860e-f53067077a14
# ╟─c65a1abc-85c1-44a1-bce1-adddb8d8781c
# ╟─b2c1aaf8-c0e8-4ff2-a32c-69e797063a16
# ╟─66c7ab95-a158-418d-a276-84042e882aa0
# ╠═46c3a799-1982-419c-9254-9604ad95c926
# ╟─13beada8-dd59-4252-a730-aedb5c6c09e6
# ╟─7c1266f6-2f5d-4fdf-af5a-67fa202ddae2
# ╟─195378cf-cda9-43e4-97b6-3d20cb41069f
# ╟─f1211824-c65f-4e55-9bbd-974c1dea6a49
# ╟─01984662-0b51-4178-97cd-584628c58ed2
# ╟─eb220b5f-614d-4944-9626-e3d27dde779a
# ╟─ac75c8fb-3d69-43c6-ad31-a281650366dd
# ╟─9ffec60d-5310-4587-a50f-0ac4994caa5f
# ╟─b4223dd0-faaa-4508-813f-0a9babbcdc09
# ╟─5f6b7fce-fbc0-4464-a0cc-9fa179937ebb
# ╟─ae5f7e4b-9f4f-4066-9595-3ec65257b4f9
# ╟─0d9600d8-087d-4900-bcb2-c81a745bb131
# ╟─e5df9962-b908-4219-bfaf-7be799b8c8a8
# ╟─fc8794db-0fa4-4641-865d-34a199d843c0
# ╟─cb4b3d81-67c9-4012-ae28-04247ddd9125
# ╟─c0d4716c-fd9c-4a11-8c0c-f5ccb0dd7217
# ╟─3b1c8db6-6db2-4bf5-a107-366e3d3c53d5
# ╟─c653f8bc-a222-4734-822a-51f9347d9a39
# ╟─8f77ceb8-634d-4146-8687-179905ebaa9c
# ╟─b5699352-1bca-4040-bbd9-2bc64085460c
# ╟─26479599-3609-4814-9750-3406df4fba1f
# ╟─932105fb-25b6-4fd6-9d26-b7c66ed70c26
# ╟─16bc3457-8de1-4b46-9caf-fd916476986e
# ╟─4564edd1-7611-45b1-8f4c-26088d4c6d97
# ╟─09ad3cf9-ccc7-4508-b20a-2b541fba963b
# ╟─c86f3735-7430-4216-a8e8-d018c844142e
# ╟─6fbc1529-ed21-4e53-91de-a026a9a4ee26
# ╟─2b853097-db70-4f47-988f-f9caed5a042f
# ╟─602ac6a2-80a3-445c-abc2-bc5b01e44d7b
# ╟─e1e067d5-5416-4d8e-be65-5c52ae95b24b
# ╟─6f5ea5bc-0e8e-4c4e-893a-3266e5ecbe47
# ╟─003f7d8c-b316-4a2b-8170-ff148ccb9f50
# ╟─2abd04ed-edf8-4bf0-bebf-e9c299927551
# ╟─5b7101e1-7f13-4825-8e0e-a9725e0e0438
# ╟─31b384d2-9194-4ddd-8b6c-d1a137692dbc
# ╟─e303f5bf-f37e-4cb8-abe9-5d4891f08e77
# ╟─a2b14cca-72f5-4e27-b198-a7b3deb9893a
# ╟─35429393-e411-4ac8-9719-c90523ade5ea
# ╟─2bc60f92-4577-4866-9344-d7f0b397c637
# ╟─c3b0bf91-fdf0-4a2b-8309-3728c64421e4
# ╟─d82b0993-b72e-4d46-9b68-8855f05b86ce
# ╟─da33d6d3-4601-40f4-9dcd-ffdb41497dea
# ╟─70c36a66-d9b4-4ae1-b662-8b3c8af28546
# ╟─3722b027-a69b-4646-bf4d-c8ebe1cb27ea
# ╟─fae0a60d-8bb5-4be4-a22f-01a951804800
# ╟─0f12e41e-01b1-443b-9bbc-031fa52fa753
# ╟─455cd3d3-eaaf-43fe-ad26-c0f1e949fa15
# ╟─00359215-ca8b-4b81-b1b5-c7d67de003e1
# ╟─0bc9dc7c-d62f-4d00-bb6e-7b34af0f66ca
# ╟─afeb2022-35c7-42ca-b6a9-fc7ff8b61de0
# ╟─135756cf-c917-4974-bb36-eae97ddf00b7
# ╟─81e9e206-ed9b-4fc6-b936-2307621558f1
# ╟─942ad12e-f0b2-4d1d-b3c6-d664f4293bcc
# ╟─e37317fb-b219-410c-bfc0-653ebe20a632
# ╟─7f15a20e-adc7-4028-a5d1-2a1af197f390
# ╟─3dbb47a8-9310-4013-a4db-0514614d0d4d
# ╟─9c06bcf6-403e-4da2-a2b1-06bc10af44a8
# ╟─005bfac2-bf5c-4456-8889-c4cecb7d3228
# ╟─efd1ef70-c4ae-4112-8fb5-db0490269102
# ╟─fac91f7f-4b2b-4576-9435-e2e9b8bae16e
# ╟─87dfeb75-613d-49a3-bce2-46dbd0d33429
# ╟─bd3e2109-3aa0-4a9c-9082-d6d196f7932b
# ╟─3c52a17c-75e9-4e2f-ae64-afc05fc110d4
# ╟─09c29e2e-3561-479a-8b71-627be4e214df
# ╟─7620fe26-1c9d-4a41-b358-eaef9f52d52d
# ╟─6c577bcb-2f01-41e2-b8cc-7593372f4cf6
# ╟─8bae4edc-d910-4927-9cab-79bc8387b2c5
# ╟─65179ab3-0475-4ae2-b7e1-5a7caf5a8e66
# ╠═770456f6-fe19-4aec-86d2-482834cc419f
# ╟─8ba3bd5c-8b24-4c42-8c59-af5cd88305e6
# ╟─2e4f2876-a92d-4b3d-a473-ef12341baacc
# ╟─782bd8fb-e3c7-471a-9bce-668d45b911af
# ╟─ca18659d-269d-4fc6-9872-26946aca3a2e
# ╟─04b58a60-31a9-4d68-b496-5ff73bb9a864
# ╟─8ad44287-5a21-477b-b0fd-0d710440dc25
# ╟─ba8dc58b-5c37-4713-9bef-930c735850bf
# ╟─c970ee3e-53ae-4914-84a1-91091fc9bac8
# ╟─0ce9a97b-dab5-4b5b-829d-f03fb823b3d3
# ╟─83571d10-7eff-11f0-10db-391640417d07
# ╟─f25c97aa-47a9-4bcd-9f27-3e8eb17857e1
# ╟─8ce83819-cf7f-46fc-aded-773e3a716244
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
