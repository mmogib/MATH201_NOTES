### A Pluto.jl notebook ###
# v0.20.20

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

# ╔═╡ f7f0dbe3-ab41-4ff2-ad97-5927f657d5a4
cm"""
__Course website:__ (Notes, Syllabus)
$(post_img("https://www.dropbox.com/scl/fi/swxz2urvoq9olrlpu2xfi/mshahrani_qrcode.png?rlkey=w5ojh9lpnf49qadivxuv1un4b&dl=1"))

---

__ChatGPT:__ (Course AI assistant)
$(post_img("https://www.dropbox.com/scl/fi/8scavzk19ewiqd6s7ubj5/chatgpt_qrcode.png?rlkey=5jlmqhovlfd1byh0s7ya93b47&dl=1"))

"""

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
    f(x) = -x^2 + x + 1
    eval(Meta.parse("x(t)=$s10_2_xt"))
    p = plot(f; framestyle=:origin, xlimits=(0, 2), label=L"y=-x^2 + x + 1")
    scatter(p, [x(s10_2_t)], [f(x(s10_2_t))], label="Person")
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
end

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

# ╔═╡ 66b48d42-742f-49f9-8e97-684f2d790b32
## Cell 19
cm"""
$(ex(4,"Finding Parametric Equations for a Given Graph"))
Find a set of parametric equations that represents the graph of ``y=1-x^2``, using each of the following parameters.

- __(a.)__ ``t=x``
- __(b.)__ The slope ``m=\frac{d y}{d x}`` at the point ``(x, y)``

"""

# ╔═╡ 6f2b9ee3-1579-4685-9b2d-c7fa7b07a828
## Cell 20
cm"""
$(ex(5,"Parametric Equations for a Cycloid"))
Determine the curve traced by a point ``P`` on the circumference of a circle of radius ``a`` rolling along a straight line in a plane. Such a curve is called a __cycloid__.
"""

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
	
	# Parameters
	A = 32 # 24
	B = 14 # 3
	
	# Range of parameter t
	t = range(0, 20π, length=2000)  # enough to complete the curve
	
	# Parametric equations
	x = (A - B) * cos.(t) .- B * cos.((A - B)/B .* t)
	y = (A - B) * sin.(t) .- B * sin.((A - B)/B .* t)
	
	# Plot
	plot(x, y, 
		 aspect_ratio=:equal, 
		 linewidth=1.2, 
		 color=:red, 
		 label="Hypocycloid E($A,$B)",
		 frame_style=:origin)
	xlabel!("x")
	ylabel!("y")
	title!("Hypocycloid E($A,$B)")
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

# ╔═╡ ebc1271e-0fcf-47bc-bf74-850b1d2ed425
let
	
	# Parameters
	A = 24 # 24
	B = 7
	
	# Range of parameter t
	t = range(0, 20π, length=2000)  # enough to complete the curve
	
	# Parametric equations
	x = (A + B) * cos.(t) .- B * cos.((A + B)/B .* t)
	y = (A + B) * sin.(t) .- B * sin.((A + B)/B .* t)
	
	# Plot
	plot(x, y, 
		 aspect_ratio=:equal, 
		 linewidth=1.2, 
		 color=:red, 
		 label="Epicycloid E($A,$B)",
		 frame_style=:origin)
	xlabel!("x")
	ylabel!("y")
	title!("Epicycloid E($A,$B)")
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

# ╔═╡ 46c3a799-1982-419c-9254-9604ad95c926
sin(π/3), sqrt(3)/2

# ╔═╡ 13beada8-dd59-4252-a730-aedb5c6c09e6
cm"""
$(ex(5,"Finding the Area of a Surface of Revolution"))

Let ``C`` be the arc of the circle ``x^2+y^2=9`` from ``(3,0)`` to
```math
\left(\frac{3}{2}, \frac{3 \sqrt{3}}{2}\right)
```
Find the area of the surface formed by revolving ``C`` about the ``x``-axis.
"""

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

# ╔═╡ 3b1c8db6-6db2-4bf5-a107-366e3d3c53d5
cm"""
$(ex(1,"Polar-to-Rectangular Conversion"))


- (a) For the point ``(r, \theta)=(2, \pi)``,
- (b) For the point ``(r, \theta)=(\sqrt{3}, \pi / 6)``,

"""

## Cell 10

# ╔═╡ 26479599-3609-4814-9750-3406df4fba1f
cm"""
$(ex(2,"Rectangular-to-Polar Conversion"))
- __(a)__ For the second-quadrant point ``(x, y)=(-1,1)``,
- __(a)__ For the second-quadrant point ``(x, y)=(0,2)``,
"""

## Cell 12

# ╔═╡ c86f3735-7430-4216-a8e8-d018c844142e
md"## Polar Graphs"

## Cell 14

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

# ╔═╡ 6f5ea5bc-0e8e-4c4e-893a-3266e5ecbe47
cm"""
$(ex(4,"
Sketching a Polar Graph"))
Sketch the graph of ``r=2 \cos 3 \theta``.
"""

## Cell 18

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

# ╔═╡ 2bc60f92-4577-4866-9344-d7f0b397c637
cm"""
$(ex(5,"Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines of ``r=\sin \theta``, where ``0 \leq \theta<\pi``.
"""

## Cell 26

# ╔═╡ c3b0bf91-fdf0-4a2b-8309-3728c64421e4
let

    r(θ) = sin(θ)
    plot(r;
        proj=:polar, label=nothing,)
    # plot!(;proj=:cart)
end

## Cell 27

# ╔═╡ 3722b027-a69b-4646-bf4d-c8ebe1cb27ea
cm"""
$(ex(6,"
Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines to the graph of ``r=2(1-\cos \theta)``, where ``0 \leq \theta<2 \pi``.
"""

## Cell 28

# ╔═╡ fae0a60d-8bb5-4be4-a22f-01a951804800
let

    r(θ) = 2(1 - cos(θ))
    plot(r;
        proj=:polar, label=nothing,)
    # plot!(;proj=:cart)
end

## Cell 29

# ╔═╡ 0bc9dc7c-d62f-4d00-bb6e-7b34af0f66ca
cm"""
$(bth("Tangent Lines at the Pole"))
If ``f(\alpha)=0`` and ``f^{\prime}(\alpha) \neq 0``, then the line ``\theta=\alpha`` is tangent at the pole to the graph of ``r=f(\theta)``.
"""

## Cell 30

# ╔═╡ afeb2022-35c7-42ca-b6a9-fc7ff8b61de0
md"##  Special Polar Graphs"

## Cell 31

# ╔═╡ 135756cf-c917-4974-bb36-eae97ddf00b7
begin
	limacons_html_a = @bind limacons_a NumberField(2:2:6, default=2)
	limacons_html_b = @bind limacons_b NumberField(2:4, default=2)
	cm"""

	``a = ``$limacons_html_a  ``\qquad``	``b = ``$limacons_html_b
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

	``a = ``$roses_html_a  ``\qquad``	``n = ``$roses_html_n
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

	``a = ``$Lemniscates_html_a  ``\qquad``	``n = ``$Lemniscates_html_n
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
# 	θ = range(0, 2π, length=500)
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

# ╔═╡ 8bae4edc-d910-4927-9cab-79bc8387b2c5
cm"""
$(ex(2,"Finding the Area Bounded by a Single Curve"))
Find the area of the region lying between the inner and outer loops of the limaçon ``r=1-2 \sin \theta``.
"""

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
    # 	l=(2,:red,:dash),
    # 	annotations=[(0.5cos(π/6),0.9sin(π/6),L"\theta=\pi/6")]

    # )
    # plot!(repeat([5π/6],100),range(0,3,length=100);
    # proj=:polar,label=nothing,
    # 	l=(2,:red,:dash),
    # 	annotations=[(0.5cos(5π/6),0.9sin(5π/6),L"\theta=5\pi/6")]

    # )
    cm"""
    __Rose__

   ``r  = 1-2\sin \theta``

   $p

   	
   ``A = \text{area between the curves} = \frac{5\pi}{2}``


   """

end

# ╔═╡ 782bd8fb-e3c7-471a-9bce-668d45b911af
md"##  Arc Length in Polar Form"

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

# ╔═╡ 0ce9a97b-dab5-4b5b-829d-f03fb823b3d3
let
    r(θ) = cos(θ)
    p = plot(r;
        proj=:polar, label=nothing,)
    cm"""


   $p
   """

end

# ╔═╡ 004e5898-ebff-4e99-a515-a90a09d347ac
md"""#  11.1 Vectors in the Plan
> __Objectives__
> 1. Write the component form of a vector.
> 2. Perform vector operations and interpret the results geometrically.
> 3. Write a vector as a linear combination of standard unit vectors.

"""

# let
# 	n = 100
# 	ts = range(-5, stop = 5, length = n)
# 	z = 1:n
# 	plot(ts,ts, (x,y)->x + x^2 - y^2, zcolor = reverse(z),  leg = false, cbar = false, w = 5, camera=(30,30),st=:surface)
# 	# plot!(zeros(n), zeros(n), 1:n, w = 10)
# end

# ╔═╡ b9fce471-306a-4ba2-9a99-fcb7e14deac7
md"## Component Form of a Vector"

# ╔═╡ 1c4d70e7-f245-4963-bd97-f0773f9d6588
cm"""

Quantities in geometry and physics can be divided into two types:  

1. __Scalar quantities:__ These are described by a single real number (with units). Examples: area, volume, temperature, mass, and time.  

2. __Vector quantities:__ These require both \emph{magnitude} and \emph{direction}. Examples: force, velocity, and acceleration.  

A __directed line segment__ is used to represent a vector.  
- If ``P`` is the initial point and ``Q`` is the terminal point, the vector is denoted as  
  ``\vec{v} = \overrightarrow{PQ}``.  
- The magnitude (length) of the vector is written as ``\|\overrightarrow{PQ}\|``.  

Two directed line segments are considered __equivalent__ if they have the same length and direction.  

The set of all equivalent directed segments forms the same vector.  

In typeset notation, vectors are usually denoted by bold lowercase letters (e.g., ``\mathbf{v}``) or with an arrow on top (e.g., ``\vec{v}``).  

"""

# ╔═╡ 0a923d1b-4f8a-4622-a418-0e989e4648b9
let
    plot(
        [0; 1], [0; 1],
        frame_style=:none,
        label=:none, arrow=true, lw=6, color=:black,
        aspect_ratio=1,
        annotations=[
            (0, 0.1, L"P"),
            (0, -0.1, "Initial point"),
            (1, 1.1, L"Q"),
            (1.3, 0.9, "Terminal point"),
            (0.8, 0.5, L"\textbf{v}=\vec{PQ}"),
        ],
        ylimits=(-0.2, 1.2)
    )
    scatter!([0; 1], [0; 1], label=:none, m=5, c=:black)

end

# ╔═╡ 1785a7a4-ba84-42f8-863c-747b9ec9cd50
cm"""
$(ex(1,"Vector Representation: Directed Line Segments"))
Let ``\mathbf{v}`` be represented by the directed line segment from ``(0,0)`` to ``(3,2)``, and let ``\mathbf{u}`` be represented by the directed line segment from ``(1,2)`` to ``(4,4)``. Show that ``\mathbf{v}`` and ``\mathbf{u}`` are equivalent.
"""

# ╔═╡ b6845b47-9f90-4a4b-b439-6eeeb7d9519e
cm"""
$(define("Component Form of a Vector in the Plane"))
If ``\mathbf{v}`` is a vector in the plane whose initial point is the origin and whose terminal point is ``\left(v_1, v_2\right)``, then the __component form__ of ``\mathbf{v}`` is ``\mathbf{v}=\left\langle v_1, v_2\right\rangle``. The coordinates ``v_1`` and ``v_2`` are called the __components of ``\mathbf{v}``__. If both the initial point and the terminal point lie at the origin, then ``\mathbf{v}`` is called the __zero vector__ and is denoted by ``\mathbf{0}=\langle 0,0\rangle``.

Moreover, the length (or magnitude) of ``\textbf{v}`` is
```math
\begin{aligned}
\|\mathbf{v}\| 
& =\sqrt{v_1^2+v_2^2} \quad \color{red}{\text{Length of a vector}}
\end{aligned}
```
"""

# ╔═╡ 9c69eac1-148d-4b24-8962-4ab3922bf606
cm"""
$(ex(2,"Component Form and Length of a Vector"))
Find the component form and length of the vector ``\mathbf{v}`` that has initial point ``(3,-7)`` and terminal point ``(-2,5)``.
"""

# ╔═╡ 208b862e-da48-4a79-aaee-2df466adfa17
md"## Vector Operations"

# ╔═╡ 6c418467-c0c2-4dc4-ae7d-97f7ffc88888
cm"""
$(define("Vector Addition and Scalar Multiplication"))
Let ``\mathbf{u}=\left\langle u_1, u_2\right\rangle`` and ``\mathbf{v}=\left\langle v_1, v_2\right\rangle`` be vectors and let ``c`` be a scalar.
1. The vector sum of ``\mathbf{u}`` and ``\mathbf{v}`` is the vector ``\mathbf{u}+\mathbf{v}=\left\langle u_1+v_1, u_2+v_2\right\rangle``.
2. The scalar multiple of ``c`` and ``\mathbf{u}`` is the vector
```math
c \mathbf{u}=\left\langle c u_1, c u_2\right\rangle
```
3. The negative of ``\mathbf{v}`` is the vector
```math
-\mathbf{v}=(-1) \mathbf{v}=\left\langle-v_1,-v_2\right\rangle
```
4. The difference of ``\mathbf{u}`` and ``\mathbf{v}`` is
```math
\mathbf{u}-\mathbf{v}=\mathbf{u}+(-\mathbf{v})=\left\langle u_1-v_1, u_2-v_2\right\rangle .
```
"""

# ╔═╡ 5ce29b80-bb95-40db-a3c7-4c3d5c94ba0d
let
    v1 = (2, 0.5)
    v2 = (0.5, 1.5)
    vs = [v1; v2]
    p = plot(; frame_style=:origin, xlimits=(-1, 3), ylimits=(-1, 3))
    for (i, v) in enumerate(vs)
        plot!(p, [0; v[1]], [0, v[2]], arrow=true, annotations=[((v .+ 0.1)..., L"v_%$i")], label=:none, c=:black)
    end
    v = v1 .+ v2
    plot!(p, [0; v[1]], [0, v[2]], arrow=true, annotations=[((v .+ 0.1)..., L"v_1+v_2", :red)], label=:none, c=:red)
    v = v1 .- v2
    plot!(p, [0; v[1]], [0, v[2]], arrow=true, annotations=[((v .+ 0.1)..., L"v_1-v_2", :blue)], label=:none, c=:blue)

    p
end

# ╔═╡ 1e084154-e54f-455d-8bd4-12870c25990d
cm"""
$(ex(3,"Vector Operations"))
For ``\mathbf{v}=\langle-2,5\rangle`` and ``\mathbf{w}=\langle 3,4\rangle``, find each of the vectors.
- (a.) ``\frac{1}{2} \mathbf{v}``
- (b.) ``\mathbf{w}-\mathbf{v}``
- (c.) ``\mathbf{v}+2 \mathbf{w}``
"""

# ╔═╡ 2b149b3a-deab-40d5-8f8b-32b7531a7165
cm"""
$(bth("Properties of Vector Operations"))
Let ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` be vectors in the plane, and let ``c`` and ``d`` be scalars.
1. ``\mathbf{u}+\mathbf{v}=\mathbf{v}+\mathbf{u} \hspace{5cm} \color{red}{\text{Commutative Property}}``  


2. ``(\mathbf{u}+\mathbf{v})+\mathbf{w}=\mathbf{u}+(\mathbf{v}+\mathbf{w}) \hspace{2.2cm} \color{red}{\text{Associative Property}}``

3. ``\mathbf{u}+\mathbf{0}=\mathbf{u}\hspace{5.8cm} \color{red}{\text{Additive Identity Property}}``

4. ``\mathbf{u}+(-\mathbf{u})=\mathbf{0}\hspace{5cm} \color{red}{\text{Additive Inverse Property}}``

5. ``c(d \mathbf{u})=(c d) \mathbf{u}\hspace{5cm} \color{red}{\text{Associative Property}}``

6. ``(c+d) \mathbf{u}=c \mathbf{u}+d \mathbf{u}\hspace{5cm} \color{red}{\text{Distributive Property}}``


7. ``c(\mathbf{u}+\mathbf{v})=c \mathbf{u}+c \mathbf{v}\hspace{5cm} \color{red}{\text{Distributive Property}}``


8. ``1(\mathbf{u})=\mathbf{u}, 0(\mathbf{u})=\mathbf{0}\hspace{5cm}``
"""

# ╔═╡ 8e3fcc38-1f61-4937-affb-82045e4cfaf9
cm"""
$(bth("Length of a Scalar Multiple"))
Let ``\mathbf{v}`` be a vector and let ``c`` be a scalar. Then
```math
\|c \mathbf{v}\|=|c|\|\mathbf{v}\|
```
``|c|`` is the absolute value of ``c``.
"""

# ╔═╡ 6b72dabd-148c-46aa-8e5d-2bd1f19fde10
cm"""
$(bth("Unit Vector in the Direction of  v"))
If ``\mathbf{v}`` is a nonzero vector in the plane, then the vector
```math
\mathbf{u}=\frac{\mathbf{v}}{\|\mathbf{v}\|}=\frac{1}{\|\mathbf{v}\|} \mathbf{v}
```
has length 1 and the same direction as ``\mathbf{v}``.
"""

# ╔═╡ f9b08784-8a16-432e-8012-d5f84e2c97a0
cm"""
$(bbl("triangle inequality for vectors",""))
```math
\|\mathbf{u}+\mathbf{v}\| \leq\|\mathbf{u}\|+\|\mathbf{v}\|
```

"""

# ╔═╡ 1c8cad4e-4bca-4425-9c47-b074e052d582
cm"""
$(ex(4,"Finding a Unit Vector"))
Find a unit vector in the direction of ``\mathbf{v}=\langle-2,5\rangle`` and verify that it has length 1.
"""

# ╔═╡ c23c83d4-4d34-44c7-8dee-f2aa824eda44
md"## Standard Unit Vectors"

# ╔═╡ 2cfa4e94-e5ff-4eea-a9fb-6db2cf51cf25
cm"""

The unit vectors ``\langle 1,0\rangle`` and ``\langle 0,1\rangle`` are called the standard unit vectors in the plane and are denoted by
```math
\mathbf{i}=\langle 1,0\rangle \text { and } \mathbf{j}=\langle 0,1\rangle
```

__Standard unit vectors__
"""

# ╔═╡ 9f218dbe-4296-4b33-87c1-20ffa7ce4a4f
cm"""
$(ex(5,"Writing a Linear Combination of Unit Vectors"))
Let ``\mathbf{u}`` be the vector with initial point ``(2,-5)`` and terminal point ``(-1,3)``, and let ``\mathbf{v}=2 \mathbf{i}-\mathbf{j}``. Write each vector as a linear combination of ``\mathbf{i}`` and ``\mathbf{j}``.
1. ``u``
2. ``w = 2u − 3v``
"""

# ╔═╡ a6f3a648-a960-414b-8bca-e52ec129881c
cm"""
$(ex(6,"Writing a Vector of Given Magnitude and Direction"))
The vector ``\mathbf{v}`` has a magnitude of 3 and makes an angle of ``30^{\circ}=\pi / 6`` with the positive ``x``-axis. Write ``\mathbf{v}`` as a linear combination of the unit vectors ``\mathbf{i}`` and ``\mathbf{j}``.
"""

# ╔═╡ 571a0a6a-b0f2-4899-9b22-4e7948f358e2
cm"""


$(ex(7,"Finding the Resultant Force"))

Two tugboats are pushing an ocean liner, as shown in Figure below. Each boat is exerting a force of 400 pounds. What is the resultant force on the ocean liner?

$(post_img("https://www.dropbox.com/scl/fi/y479puutvr1z41k7aqy70/fig11.12.png?rlkey=f1kwce8m1vsrmdk2kim9l4d18&dl=1"))
"""

# ╔═╡ 6419f344-a1b3-4d60-8f27-8469a6e6b022
md"""
# 11.2 Space Coordinates and Vectors in Space
> __Objectivaes__
> 1. Understand the three-dimensional rectangular coordinate system.
> 2. Analyze vectors in space.
"""

# ╔═╡ f6836f13-5370-4ac3-813a-50fc012bfcab
md"## Coordinates in Space"

# ╔═╡ 94194246-ad29-43d1-9925-126fe9e5e696
cm"""
$(ex(1,"Finding the Distance Between Two Points in Space"))
Find the distance between the points ``(2,-1,3)`` and ``(1,0,-2)``.
"""

# ╔═╡ e3363ab4-1543-421f-a68c-cb1685a2f06a
let
	u=[2;-1;3]
	v=[1;0;-2]
	norm(u-v), sqrt(sum((u[i]-v[i])^2 for i in 1:3))
end

# ╔═╡ 2c4b3a89-8257-48fa-8e3a-30f059e0187d
cm"""
$(ex(2,"Finding the equation of a Sphere"))
Find the standard equation of the sphere that has the points

``(5, −2, 3)`` and ``(0, 4, −3)``

 as endpoints of a diameter.
"""

# ╔═╡ 734ef678-1329-4d59-8753-0797b6a675c7
let
	u=[5;-2;3]
	v=[0;4;-3//1]
	d_squared = sum((u .- v) .^2)
	# r_squared = d_squared/4
	# center = (u+v)/2
	
end

# ╔═╡ 0a7b91d0-5ca6-4006-9b59-f9e077a8c3db
let
    # Center of the sphere
    h, k, l = 5 / 2, 1, 0

    # Radius of the sphere
    r = sqrt(97) / 2

    # Generate points on the sphere using spherical coordinates
    u = LinRange(0, 2π, 100)  # Azimuthal angle
    v = LinRange(0, π, 100)   # Polar angle

    # Create a grid of u and v values
    u_grid = repeat(u', length(v), 1)
    v_grid = repeat(v, 1, length(u))

    # Parametric equations for the sphere
    x = h .+ r * sin.(v_grid) .* cos.(u_grid)
    y = k .+ r * sin.(v_grid) .* sin.(u_grid)
    z = l .- r * cos.(v_grid)

    # Plot the sphere
    surface(x, y, z,
        color=RGBA{Float64}(1, 0, 0, 0.1),
        camera=(30, 30),
        xlimits=(-10, 10),
        ylimits=(-10, 10),
        zlimits=(-10, 10),
        frame_style=:origin,
        legend=false,
        # xlabel = "x", ylabel = "y", zlabel = "z", 
        title="Sphere with Center " * L"(2.5, 1, 0)" * "and Radius " * L"\sqrt{97}/2")
end

# ╔═╡ 7bb3abcb-525c-45a4-9989-74c42fee5fe2
cm"""

[Geogebra Graph](https://www.geogebra.org/classic/vjqqpvzw?embed)



"""

# ╔═╡ 574ab398-71d0-4427-86dc-fd99482feffc
md"## Vectors in Space"

# ╔═╡ 7e3feecd-7106-4591-b22a-97a7aa064b6c
cm"""
$(bbl("Vectors in Space",""))
Let ``\mathbf{u}=\left\langle u_1, u_2, u_3\right\rangle`` and ``\mathbf{v}=\left\langle v_1, v_2, v_3\right\rangle`` be vectors in space and let ``c`` be a scalar.
1. Equality of Vectors: ``\mathbf{u}=\mathbf{v}`` if and only if ``u_1=v_1, u_2=v_2``, and ``u_3=v_3``.
2. Component Form: If ``\mathbf{v}`` is represented by the directed line segment from ``P\left(p_1, p_2, p_3\right)`` to ``Q\left(q_1, q_2, q_3\right)``, then
```math
\mathbf{v}=\left\langle v_1, v_2, v_3\right\rangle=\left\langle q_1-p_1, q_2-p_2, q_3-p_3\right\rangle
```
3. Length: ``\|\mathbf{v}\|=\sqrt{v_1^2+v_2^2+v_3^2}``
4. Unit Vector in the Direction of ``\mathbf{v}: \frac{\mathbf{v}}{\|\mathbf{v}\|}=\left(\frac{1}{\|\mathbf{v}\|}\right)\left\langle v_1, v_2, v_3\right\rangle, \quad \mathbf{v} \neq \mathbf{0}``
5. Vector Addition: ``\mathbf{v}+\mathbf{u}=\left\langle v_1+u_1, v_2+u_2, v_3+u_3\right\rangle``
6. Scalar Multiplication: ``c \mathbf{v}=\left\langle c v_1, c v_2, c v_3\right\rangle``
"""

# ╔═╡ 108475eb-bae3-426d-88db-f0f5dc177c65
cm"""
$(ex(3,"Finding the Component Form of a Vector in Space"))
Find the component form and magnitude of the vector ``\mathbf{v}`` having initial point ``(-2,3,1)`` and terminal point ``(0,-4,4)``. Then find a unit vector in the direction of ``\mathbf{v}``.
"""

# ╔═╡ 75e95211-2367-49ed-a1fd-f0ae39870f04
cm"""
$(define("Parallel Vectors"))
Two nonzero vectors ``\mathbf{u}`` and ``\mathbf{v}`` are parallel when there is some scalar ``c`` such that ``\mathbf{u}=c \mathbf{v}``.
"""

# ╔═╡ 847f0197-beab-45d7-ae4c-27385719aeb1
cm"""
$(ex(4,"Parallel Vectors"))
Vector ``\mathbf{w}`` has initial point ``(2,-1,3)`` and terminal point ``(-4,7,5)``. Which of the following vectors is parallel to ``\mathbf{w}`` ?

1. ``\mathbf{u}=\langle 3,-4,-1\rangle``
2. ``\mathbf{v}=\langle 12,-16,4\rangle``
"""

# ╔═╡ b9f88efe-fb3f-466e-93f8-a9a99eb30a2e
cm"""
$(ex(5,"Using Vectors to Determine Collinear Points"))
Determine whether the points
```math
P(1,-2,3), \quad Q(2,1,0), \quad \text { and } \quad R(4,7,-6)
```
are collinear.
"""

# ╔═╡ 8fd1741d-62d4-4a07-8d2c-7ca7f9d41da9
cm"""
$(ex(6,"Standard Unit Vector Notation"))

- __(a.)__ Write the vector ``\mathbf{v}=4 \mathbf{i}-5 \mathbf{k}`` in component form.
- __(b.)__ Find the terminal point of the vector ``\mathbf{v}=7 \mathbf{i}-\mathbf{j}+3 \mathbf{k}``, given that the initial point is ``P(-2,3,5)``.

- __(c.)__ Find the magnitude of the vector ``\mathbf{v}=-6 \mathbf{i}+2 \mathbf{j}-3 \mathbf{k}``. Then find a unit vector in the direction of ``\mathbf{v}``.
"""

# ╔═╡ 1a2c15f9-af65-4fe5-b517-98d26a3998fd
cm"""
$(ex(7,"Measuring Force"))
A television camera weighing ``120`` pounds is supported by a tripod, as shown below. Represent the force exerted on each leg of the tripod as a vector. 

$(post_img("https://www.dropbox.com/scl/fi/avv2vzzviidm4m8opc3uk/fig_11_23.png?rlkey=o3rnxynprpdg5lt0jkbh6wp9p&dl=1"))
"""

# ╔═╡ 554f972f-8c43-4b67-845a-5f7e85cabfda
md"""
# 11.3 The Dot Product of Two Vectors
> __Objectives__
> 1. Use properties of the dot product of two vectors.
> 1. Find the angle between two vectors using the dot product.
> 1. Find the direction cosines of a vector in space.
> 1. Find the projection of a vector onto another vector.
> 1. Use vectors to find the work done by a constant force.

"""

# ╔═╡ ce3fdcff-d13d-4224-b394-ae73ca08d7b7
md"##  The Dot Product"

# ╔═╡ e4d12bd7-039a-42a8-b278-05a5e8fe0841
cm"""
$(define("Dot Product"))
The dot product of ``\mathbf{u}=\left\langle u_1, u_2\right\rangle`` and ``\mathbf{v}=\left\langle v_1, v_2\right\rangle`` is
```math
\mathbf{u} \cdot \mathbf{v}=u_1 v_1+u_2 v_2
```

The dot product of ``\mathbf{u}=\left\langle u_1, u_2, u_3\right\rangle`` and ``\mathbf{v}=\left\langle v_1, v_2, v_3\right\rangle`` is
```math
\mathbf{u} \cdot \mathbf{v}=u_1 v_1+u_2 v_2+u_3 v_3
```
$(ebl())

$(bth("Properties of the Dot Product"))
Let ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` be vectors in the plane or in space and let ``c`` be a scalar.

1. ``\mathbf{u} \cdot \mathbf{v}=\mathbf{v} \cdot \mathbf{u}\qquad \color{red}{\text{Commutative Property}}``

2. ``\mathbf{u} \cdot(\mathbf{v}+\mathbf{w})=\mathbf{u} \cdot \mathbf{v}+\mathbf{u} \cdot \mathbf{w}\qquad \color{red}{\text{Distributive Property}}``

3. ``c(\mathbf{u} \cdot \mathbf{v})=c \mathbf{u} \cdot \mathbf{v}=\mathbf{u} \cdot c \mathbf{v}\qquad \qquad\color{red}{\text{Associative Property}}``
4. ``\mathbf{0} \cdot \mathbf{v}=0``
5. ``\mathbf{v} \cdot \mathbf{v}=\|\mathbf{v}\|^2``
"""

# ╔═╡ 79d33f0f-6b03-420f-a0c1-98108e43ab6b
cm"""
$(ex(1,"Finding Dot Products"))

Let ``\mathbf{u}=\langle 2,-2\rangle, \mathbf{v}=\langle 5,8\rangle``, and ``\mathbf{w}=\langle-4,3\rangle``.

- (a.) ``\mathbf{u} \cdot \mathbf{v}=\langle 2,-2\rangle \cdot\langle 5,8\rangle=2(5)+(-2)(8)=-6``
- (b.) ``(\mathbf{u} \cdot \mathbf{v}) \mathbf{w}=-6\langle-4,3\rangle=\langle 24,-18\rangle``
- (c.) ``\mathbf{u} \cdot(2 \mathbf{v})=2(\mathbf{u} \cdot \mathbf{v})=2(-6)=-12``
- (d.) ``\|\mathbf{w}\|^2=\mathbf{w} \cdot \mathbf{w}=\langle-4,3\rangle \cdot\langle-4,3\rangle=(-4)(-4)+(3)(3)=25``
"""

# ╔═╡ ebbfa978-69b9-4a06-8747-792cb04992eb
md"## Angle Between Two Vectors"

# ╔═╡ 66eb4dd6-f558-479a-b193-8e852c345721
cm"""
$(bth("Angle Between Two Vectors"))
If ``\theta`` is the angle between two nonzero vectors ``\mathbf{u}`` and ``\mathbf{v}``, where ``0 \leq \theta \leq \pi``, then
```math
\cos \theta=\frac{\mathbf{u} \cdot \mathbf{v}}{\|\mathbf{u}\|\|\mathbf{v}\|}
```
"""

# ╔═╡ 4fc2f92f-3773-4e53-82c6-c4e441f164b3
cm"""
$(bbl("Remark",""))
```math
\mathbf{u} \cdot \mathbf{v}=\|\mathbf{u}\|\|\mathbf{v}\| \cos \theta\qquad \color{red}{\text{Alternative form of dot product}}
```
"""

# ╔═╡ 788ea369-4509-4970-9a2d-ea887194b790
cm"""
$(define(" Definition of Orthogonal Vectors"))
 The vectors ``u`` and ``v`` are orthogonal when ``u∙v=0``
"""

# ╔═╡ de23e5af-1d2d-4b22-9743-dd59bc903a9c
cm"""
$(ex(2,"Finding the Angle Between Two Vectors"))
For ``\mathbf{u}=\langle 3,-1,2\rangle, \mathbf{v}=\langle-4,0,2\rangle, \mathbf{w}=\langle 1,-1,-2\rangle``, and ``\mathbf{z}=\langle 2,0,-1\rangle``, find the angle between each pair of vectors.

- (a.) ``\mathbf{u}`` and ``\mathbf{v}``
- (b.) ``\mathbf{u}`` and ``\mathbf{w}``
- (c.) ``\mathbf{v}`` and ``\mathbf{z}``
"""

# ╔═╡ 4fe2dba9-e764-4f30-a41a-75da08728858
let
	u,v,w,z = [3,-1,2],[-4,0,2],[1,-1,-2],[2,0,-1]
	get_angle(v1,v2) = acos(v1⋅v2/(norm(v1)*norm(v2)))
	get_angle(u,v)
	get_angle(u,w)≈π/2
end

# ╔═╡ bc67920c-1bee-4fcc-8469-adf01e1d33e8
cm"""
$(ex(3,"Alternative Form of the Dot Product"))
Given that ``\|\mathbf{u}\|=10,\|\mathbf{v}\|=7``, and the angle between ``\mathbf{u}`` and ``\mathbf{v}`` is ``\pi / 4``, find ``\mathbf{u} \cdot \mathbf{v}``.
"""

# ╔═╡ 70ffdb35-aba3-4b8a-834c-f3e996e5c278
md"## Direction Cosines"

# ╔═╡ bf3af1b5-3959-447f-85ac-b2b0b1ab737f
cm"""

$(post_img("https://www.dropbox.com/scl/fi/yoip1oldetoeth472ju81/fig_11_26.png?rlkey=g71oyxboekwrwumo2znb7mqtg&dl=1",400))

"""

# ╔═╡ eca05d58-1cab-444f-ae15-df4e3177323f
cm"""
```math
\begin{aligned}
& \cos \alpha=\frac{v_1}{\|\mathbf{v}\|} 
\qquad\color{red}{ \alpha \text{ is the angle between } \mathbf{v} \text{ and } \mathbf{i}.}
\\
& \cos \beta=\frac{v_2}{\|\mathbf{v}\|} 
\qquad\color{red}{ \alpha \text{ is the angle between } \mathbf{v} \text{ and } \mathbf{i}.}
\\
& \cos \gamma=\frac{v_3}{\|\mathbf{v}\|}
\qquad\color{red}{ \gamma \text{ is the angle between } \mathbf{v} \text{ and } \mathbf{k}.}
\end{aligned}
```

```math
\cos^2\alpha +\cos^2\beta +\cos^2\gamma =1
```
"""

# ╔═╡ c925f9ff-245f-4d0a-b085-b703adc1daaf
cm"""
$(ex(4,"Finding Direction Angles"))
Find the direction cosines and angles for the vector ``\mathbf{v}=2 \mathbf{i}+3 \mathbf{j}+4 \mathbf{k}``, and show that ``\cos ^2 \alpha+\cos ^2 \beta+\cos ^2 \gamma=1``
"""

# ╔═╡ c27df0f0-d524-4193-8188-271ea5779d04
let
	get_dir_angles(v) = begin
		ln = norm(v)
		map(i->acos(v[i]/ln),1:3)
	end
	v =[2,3,4]
	get_dir_angles(v) |> a->map(v->v*180/π,a)
	get_dir_angles(v) |> a->map(v->(cos(v))^2,a) |> sum
	sum(map(v->(cos(v))^2,get_dir_angles(v)))
end

# ╔═╡ 1b9821e9-f325-475a-ba9c-70a889a5504c
md"## Projections and Vector Components"

# ╔═╡ c1dee7b3-6118-493e-9c9a-4629cd2af8c3
cm"""
$(define("Projection and Vector Components"))
Let ``\mathbf{u}`` and ``\mathbf{v}`` be nonzero vectors. Moreover, let
```math
\mathbf{u}=\mathbf{w}_1+\mathbf{w}_2
```
where ``\mathbf{w}_1`` is parallel to ``\mathbf{v}`` and ``\mathbf{w}_2`` is orthogonal to ``\mathbf{v}``, as shown in Figure below.
1. ``\mathbf{w}_1`` is called the projection of ``\mathbf{u}`` onto ``\mathbf{v}`` or the vector component of ``\mathbf{u}`` along ``\mathbf{v}``, and is denoted by ``\mathbf{w}_1=\operatorname{proj}_{\mathbf{v}} \mathbf{u}``.
2. ``\mathbf{w}_2=\mathbf{u}-\mathbf{w}_1`` is called the vector component of ``\mathbf{u}`` orthogonal to ``\mathbf{v}``.

$(post_img("https://www.dropbox.com/scl/fi/dek860uer157a294ebkhg/fig_11_29.png?rlkey=yft18nd2xr98ot3s7345x4p6l&dl=1",500))
"""

# ╔═╡ 8bb57498-9a49-4b45-8d82-fb790465b1ae
cm"""
$(ex(5,"Finding a Vector Component of <span style='font-style:italic;font-weight:200;'>u</span> Orthogonal to <span style='font-style:italic;font-weight:200;'>v</span>"))
Find the vector component of ``\mathbf{u}=\langle 5,10\rangle`` that is orthogonal to ``\mathbf{v}=\langle 4,3\rangle``, given that
```math
\mathbf{w}_1=\operatorname{proj}_{\mathbf{v}} \mathbf{u}=\langle 8,6\rangle
```
and
```math
\mathbf{u}=\langle 5,10\rangle=\mathbf{w}_1+\mathbf{w}_2 .
```
"""

# ╔═╡ aac34993-c94d-4fa1-8f45-e249740c914d
cm"""
$(bth("Projection Using the Dot Product"))
If ``\mathbf{u}`` and ``\mathbf{v}`` are nonzero vectors, then the projection of ``\mathbf{u}`` onto ``\mathbf{v}`` is
```math
\operatorname{proj}_{\mathbf{v}} \mathbf{u}=\left(\frac{\mathbf{u} \cdot \mathbf{v}}{\|\mathbf{v}\|^2}\right) \mathbf{v}
```
"""

# ╔═╡ 3eded575-d9c4-424e-8151-3958dababb38
cm"""
$(ex(6,"Decomposing a Vector into Vector Components"))
Find the projection of ``\mathbf{u}`` onto ``\mathbf{v}`` and the vector component of ``\mathbf{u}`` orthogonal to ``\mathbf{v}`` for ``\mathbf{u}=3 \mathbf{i}-5 \mathbf{j}+2 \mathbf{k}`` and ``\quad \mathbf{v}=7 \mathbf{i}+\mathbf{j}-2 \mathbf{k}``.
"""

# ╔═╡ 29a43516-0209-4a2e-930b-0157237c981f
let
	u = [3,-5,2]
	v = [7,1,-2]
	u ⋅ v
	# w1 = (u⋅v) * v/(v⋅v)
	# w2 = u-w1
end

# ╔═╡ 97b10d17-61c1-494b-aefe-131a436e374e
cm"""
$(ex(7,"Finding a Force"))
A 600-pound boat sits on a ramp inclined at ``30^{\circ}``, as shown in Figure below. What force is required to keep the boat from rolling down the ramp?
$(post_img("https://www.dropbox.com/scl/fi/9h16n07tc8x569rwdx5j7/fig_11_32.png?rlkey=rv5hgssgbggmveuj0tcj81ovk&dl=1",500))
"""

# ╔═╡ ca13f691-7ec8-4293-b271-8c197b2e0ccf
md"## Work (Reading)"

# ╔═╡ b1c3ec5b-003d-42ab-8c6b-806e083a2047
cm"""

The work ``W`` done by the constant force ``\mathbf{F}`` acting along the line of motion of an object is given by
```math
W=(\text { magnitude of force })(\text { distance })=\|\mathbf{F}\|\|\stackrel{\rightharpoonup}{P Q}\|
```
as shown in Figure 11.33(a). When the constant force ``\mathbf{F}`` is not directed along the line of motion, you can see from Figure 11.33(b) that the work ``W`` done by the force is
```math
W=\left\|\operatorname{proj}_{\overrightarrow{P Q}} \mathbf{F}\right\|\|\overrightarrow{P Q}\|=(\cos \theta)\|\mathbf{F}\|\|\overrightarrow{P Q}\|=\mathbf{F} \cdot \overrightarrow{P Q}
```

$(post_img("https://www.dropbox.com/scl/fi/qafxufq3s8tcrxnbisru2/fig_11_33.png?rlkey=4uypkytgkkby8yaomav0jszhr&dl=1",400))

This notion of work is summarized in the next definition.

$(define("Work"))
The work ``W`` done by a constant force ``\mathbf{F}`` as its point of application moves along the vector ``\overrightarrow{P Q}`` is one of the following.
1. ``W=\left\|\operatorname{proj}_{\overrightarrow{P Q}} \mathbf{F}\right\|\|\overrightarrow{P Q}\| \quad`` Projection form
2. ``W=\mathbf{F} \cdot \stackrel{\rightharpoonup}{P Q}`` Dot product form
$(ebl())

$(ex(8,"Finding Work"))
To close a sliding door, a person pulls on a rope with a constant force of 50 pounds at a constant angle of ``60^{\circ}``, as shown in Figure below. Find the work done in moving the door 12 feet to its closed position.

$(post_img("https://www.dropbox.com/scl/fi/8wn5s5kestb1dtzxulldc/fig_11_34.png?rlkey=r0g1mc0s9vakiye1dkxd5oxrd&dl=1",400))
"""

# ╔═╡ 99b860bf-9374-4e00-8a92-822af52d403f
md"# 11.4 The Cross Product of Two Vectors in Space"

# ╔═╡ d49cf3fa-c325-4efd-9ee5-f27eafa6e2bf
md"""
> __Objectives__
> 1. Find the cross product of two vectors in space.
> 2. Use the triple scalar product of three vectors in space.
"""

# ╔═╡ 495c292f-fbcb-4420-93a3-fbcd6a34d17a
md"## The Cross Product"

# ╔═╡ cce4a136-a23c-45c8-a3e4-78f744cc2836
cm"""
$(define("Cross Product of Two Vectors in Space"))
Let
```math
\mathbf{u}=u_1 \mathbf{i}+u_2 \mathbf{j}+u_3 \mathbf{k} \quad \text { and } \quad \mathbf{v}=v_1 \mathbf{i}+v_2 \mathbf{j}+v_3 \mathbf{k}
```
be vectors in space. The cross product of ``\mathbf{u}`` and ``\mathbf{v}`` is the vector
```math
\mathbf{u} \times \mathbf{v}=\left(u_2 v_3-u_3 v_2\right) \mathbf{i}-\left(u_1 v_3-u_3 v_1\right) \mathbf{j}+\left(u_1 v_2-u_2 v_1\right) \mathbf{k}
```
"""

# ╔═╡ 1b792a4f-e23e-441d-9f6c-a64465505e2b
cm"""
$(bbl("Remark",""))
A convenient way to calculate ``\mathbf{u} \times \mathbf{v}`` is to use the determinant form with cofactor expansion shown below. (This ``3 \times 3`` determinant form is used simply to help remember the formula for the cross product. The corresponding array is technically not a matrix because its entries are not all numbers.)
```math
\mathbf{u} \times \mathbf{v}=
\left|\begin{array}{ccc}
\mathbf{i} & \mathbf{j} & \mathbf{k} \\
u_1 & u_2 & u_3 \\
v_1 & v_2 & v_3
\end{array}\right| \begin{array}{ll}
\text{}\\
\longleftarrow \text { Put "u" in Row } 2 .\\
\longleftarrow \text { Put "v" in Row } 3 .
\end{array}
```

"""

# ╔═╡ a58b8141-f330-46d8-82d2-b4caa5417887
md"""
##### Right-Hand Rule for Cross Products

"""

# ╔═╡ 771e9a89-d4eb-421b-a19f-a64810766812
# begin
#     rhr_u_angle = @bind rhr_u_slider Slider(0:15:180, default=45, show_value=true)
#     rhr_v_angle = @bind rhr_v_slider Slider(0:15:180, default=120, show_value=true)
#     rhr_scale = @bind rhr_scale_slider Slider(1:0.5:3, default=2, show_value=true)

#     cm"""
#     **Interactive Right-Hand Rule Demo:**

#     u angle: $rhr_u_angle degrees

#     v angle: $rhr_v_angle degrees  

#     Scale: $rhr_scale_slider
#     """
# end

# ╔═╡ 1b1f9a05-1792-4004-a1e1-e8b71a1925e9
# let
#     # Convert to radians
#     u_angle = rhr_u_slider * π / 180
#     v_angle = rhr_v_slider * π / 180

#     # Create vectors in 2D (we'll show the 3D result)
#     u_vec = [rhr_scale_slider * cos(u_angle), rhr_scale_slider * sin(u_angle), 0]
#     v_vec = [rhr_scale_slider * cos(v_angle), rhr_scale_slider * sin(v_angle), 0]

#     # Calculate cross product (will point in z direction)
#     cross_prod = u_vec[1] * v_vec[2] - u_vec[2] * v_vec[1]  # z-component
#     cross_vec = [0, 0, cross_prod]

#     # Create the plot
#     p = plot(aspect_ratio=1, xlims=(-4, 4), ylims=(-4, 4),
#         title="Right-Hand Rule Demonstration\nCross Product: u × v",
#         legend=:topright)

#     # Plot vectors u and v
#     quiver!(p, [0], [0], quiver=([u_vec[1]], [u_vec[2]]),
#         color=:blue, linewidth=3, label="u")
#     quiver!(p, [0], [0], quiver=([v_vec[1]], [v_vec[2]]),
#         color=:red, linewidth=3, label="v")

#     # Add vector labels
#     annotate!(p, u_vec[1] * 0.6, u_vec[2] * 0.6, text("u", :blue, 12))
#     annotate!(p, v_vec[1] * 0.6, v_vec[2] * 0.6, text("v", :red, 12))

#     # Show the angle between vectors
#     angle_diff = v_angle - u_angle
#     if angle_diff < 0
#         angle_diff += 2π
#     end

#     # Arc to show angle
#     arc_angles = range(u_angle, v_angle, length=20)
#     arc_x = 0.8 * cos.(arc_angles)
#     arc_y = 0.8 * sin.(arc_angles)
#     plot!(p, arc_x, arc_y, color=:green, linewidth=2, label="")

#     # Show cross product direction
#     if cross_prod > 0
#         direction_text = "u × v points OUT of page ⊙\n(Right-hand rule: thumb up)"
#         color = :green
#     else
#         direction_text = "u × v points INTO page ⊗\n(Right-hand rule: thumb down)"
#         color = :purple
#     end

#     # Add direction indicator
#     plot!(p, [0], [0], seriestype=:scatter, markersize=15,
#         color=color, label="")
#     annotate!(p, 0, -3.5, text(direction_text, color, 10, :center))

#     # Add magnitude
#     mag = abs(cross_prod)
#     annotate!(p, 0, 3.5, text("||u × v|| = $(round(mag, digits=2))", :black, 10, :center))

#     p
# end

# ╔═╡ 1b3fb3c8-c5fb-4a33-9630-211e4e29dc87
# md"""
# ##### Applications of the Right-Hand Rule

# The right-hand rule appears throughout physics and engineering:
# """

# ╔═╡ 3018f183-3db6-48e5-90fa-f0ff37d8f216
# md"""
# ##### Memory Aids for the Right-Hand Rule
# """

# ╔═╡ 5121dfa0-5f6a-453a-9795-dddc8d6bdbfb
# md"""
# ##### Quick Verification Tool
# """

# ╔═╡ e0ffce55-f749-439e-8399-7d67cf7ef0c9
# let
#     # Create standard basis verification
#     p1 = plot(title="Standard Basis Vectors", aspect_ratio=1,
#         xlims=(-2, 2), ylims=(-2, 2))

#     # i vector (red)
#     quiver!(p1, [0], [0], quiver=([1], [0]),
#         color=:red, linewidth=4, label="i")
#     annotate!(p1, 1.2, 0, text("i", :red, 14))

#     # j vector (blue)  
#     quiver!(p1, [0], [0], quiver=([0], [1]),
#         color=:blue, linewidth=4, label="j")
#     annotate!(p1, 0, 1.2, text("j", :blue, 14))

#     # Show i × j = k (into page)
#     plot!(p1, [0], [0], seriestype=:scatter, markersize=20,
#         color=:green, label="i × j = +k")
#     annotate!(p1, 0, -1.5, text("i × j = +k (out of page ⊙)", :green, 12, :center))

#     p1
# end

# ╔═╡ b18adead-c917-450c-9a3c-7253d6d91442
cm"""
$(ex(1,"Finding the Cross Product"))
For ``\mathbf{u}=\mathbf{i}-2 \mathbf{j}+\mathbf{k}`` and ``\mathbf{v}=3 \mathbf{i}+\mathbf{j}-2 \mathbf{k}``, find each of the following.
- (a.) ``\mathbf{u} \times \mathbf{v}``
- (b.) ``\mathbf{v} \times \mathbf{u}``
- (c.) ``\mathbf{v} \times \mathbf{v}``
"""

# ╔═╡ 79735eb1-16e1-4cf3-a43a-88d1ade37279
cm"""
$(bth("Algebraic Properties of the Cross Product"))
Let ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` be vectors in space, and let ``c`` be a scalar.
1. ``\mathbf{u} \times \mathbf{v}=-(\mathbf{v} \times \mathbf{u})``
2. ``\mathbf{u} \times(\mathbf{v}+\mathbf{w})=(\mathbf{u} \times \mathbf{v})+(\mathbf{u} \times \mathbf{w})``
3. ``c(\mathbf{u} \times \mathbf{v})=(c \mathbf{u}) \times \mathbf{v}=\mathbf{u} \times(c \mathbf{v})``
4. ``\mathbf{u} \times \mathbf{0}=\mathbf{0} \times \mathbf{u}=\mathbf{0}``
5. ``\mathbf{u} \times \mathbf{u}=\mathbf{0}``
6. ``\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})=(\mathbf{u} \times \mathbf{v}) \cdot \mathbf{w}``
"""

# ╔═╡ f85ad3e4-f7ba-4563-b548-ceb803d13d2c
cm"""
$(bth("Geometric Properties of the Cross Product"))
Let ``\mathbf{u}`` and ``\mathbf{v}`` be nonzero vectors in space, and let ``\theta`` be the angle between ``\mathbf{u}`` and ``\mathbf{v}``.
1. ``\mathbf{u} \times \mathbf{v}`` is orthogonal to both ``\mathbf{u}`` and ``\mathbf{v}``.
2. ``\|\mathbf{u} \times \mathbf{v}\|=\|\mathbf{u}\|\|\mathbf{v}\| \sin \theta``
3. ``\mathbf{u} \times \mathbf{v}=\mathbf{0}`` if and only if ``\mathbf{u}`` and ``\mathbf{v}`` are scalar multiples of each other.
4. ``\|\mathbf{u} \times \mathbf{v}\|=`` area of parallelogram having ``\mathbf{u}`` and ``\mathbf{v}`` as adjacent sides.
"""

# ╔═╡ 1fb44f1d-547e-4bea-b7ad-f171ebed5b20
cm"""
$(ex(2," Using the Cross Product"))
Find a unit vector that is orthogonal to both
```math
\mathbf{u}=\mathbf{i}-4 \mathbf{j}+\mathbf{k}
```
and
```math
\mathbf{v}=2 \mathbf{i}+3 \mathbf{j}
```
"""

# ╔═╡ 4fb037ae-7f8e-40a7-9988-26da22529d2e
let
    u = [1; -4; 1]
    v = [2; 3; 0]
    w = u × v
	w = w/norm(w)
end

# ╔═╡ 948bbe03-1560-4b79-904f-133256b6423f
cm"""
$(ex(3,"Geometric Application of the Cross Product"))
The vertices of a quadrilateral are listed below. Show that the quadrilateral is a parallelogram and find its area.
```math
\begin{array}{ll}
A=(5,2,0) & B=(2,6,1) \\
C=(2,4,7) & D=(5,0,6)
\end{array}
```
"""

# ╔═╡ 12d1fa2a-9a6c-4edc-821e-2f54b4da454e
let
    A = [5; 2; 0.0]
    B = [2; 6; 1.0]
    C = [2; 4; 7.0]
    D = [5; 0; 6.0]
    AB = B - A
    AD = D - A
    area = norm(AB × AD)
end

# ╔═╡ bb8ca18e-ecba-40e0-b1c9-caf920ff7586
cm"""

[Geogebra Graph](https://www.geogebra.org/classic/k64hdfn9?embed)


"""

# ╔═╡ d6fc1ea1-f463-46a5-94e6-9a4e6f914fc8
md"## Application"

# ╔═╡ f9621820-d9f7-41dc-bb7c-185d3cbbf8f4
cm"""
$(bbl("Torque",""))
In physics, the cross product can be used to measure torque-the moment M of a force ``\mathbf{F}`` about a point ``\boldsymbol{P}``, as shown below
$(post_img("https://www.dropbox.com/scl/fi/691imwz7wog1wxr2vx3jt/fig_11_39.png?rlkey=v4e50kju4mvmy8zd0vjy4v1ef&dl=1",300))

If the point of application of the force is ``Q``, then the moment of ``\mathbf{F}`` about ``P`` is
```math
\mathbf{M}=\stackrel{\rightharpoonup}{P Q} \times \mathbf{F} . \quad \text { Moment of } \mathbf{F} \text { about } P
```

The magnitude of the moment ``\mathbf{M}`` measures the tendency of the vector ``\overrightarrow{P Q}`` to rotate counterclockwise (using the right-hand rule) about an axis directed along the vector ``\mathbf{M}``.
"""

# ╔═╡ 6f42f537-305f-4e0a-b593-5071e1d7af7b
cm"""
$(ex(4,"An Application of the Cross Product"))
A vertical force of 50 pounds is applied to the end of a one-foot lever that is attached to an axle at point ``P``, as shown below. 

$(post_img("https://www.dropbox.com/scl/fi/9sqxf39xyyukd1zbqjv8o/fig_11_40.png?rlkey=szapu3urbrqd9pe9gfl7qfyai&dl=1",300))

Find the moment of this force about the point ``P`` when ``\theta=60^{\circ}``.
"""

# ╔═╡ 30596df7-5297-4369-ae8c-1970df3da531
md"## The Triple Scalar Product"

# ╔═╡ 183998e1-735f-4c38-ae61-7f2471fa1ae5
cm"""
For vectors ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` in space, the dot product of ``\mathbf{u}`` and ``\mathbf{v} \times \mathbf{w}``
```math
\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})
```
is called the __triple scalar product__,

$(bth("The Triple Scalar Product"))
For ``\mathbf{u}=u_1 \mathbf{i}+u_2 \mathbf{j}+u_3 \mathbf{k}, \mathbf{v}=v_1 \mathbf{i}+v_2 \mathbf{j}+v_3 \mathbf{k}``, and ``\mathbf{w}=w_1 \mathbf{i}+w_2 \mathbf{j}+w_3 \mathbf{k}``, the triple scalar product is
```math
\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})=\left|\begin{array}{rrr}
u_1 & u_2 & u_3 \\
v_1 & v_2 & v_3 \\
w_1 & w_2 & w_3
\end{array}\right|
```
"""

# ╔═╡ ece4c6d9-8393-43c9-b60d-93df66a95999
cm"""
$(bth("Geometric Property of the Triple Scalar Product"))
The volume ``V`` of a parallelepiped with vectors ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` as adjacent edges is
```math
V=|\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})| .
```
$(ebl())

$(post_img("https://www.dropbox.com/scl/fi/5hf3ibte2ppgtlx0vegr1/fig_11_41.png?rlkey=z0qrbw2p1z30iyhae0mf2xdfo&dl=1",300))
"""

# ╔═╡ 8b67f393-e954-4b33-9cc9-c382d7a41b37
cm"""
$(ex(5,"Volume by the Triple Scalar Product"))
Find the volume of the parallelepiped shown below having
```math
\begin{aligned}
\mathbf{u} & =3 \mathbf{i}-5 \mathbf{j}+\mathbf{k} \\
\mathbf{v} & =2 \mathbf{j}-2 \mathbf{k}
\end{aligned}
```
and
```math
\mathbf{w}=3 \mathbf{i}+\mathbf{j}+\mathbf{k}
```
as adjacent edges.

"""

# ╔═╡ b35ca1c3-621d-40af-afb7-a96b6fae35a8
let
    u = [3; -5; 1]
    v = [0; 2; -2]
    w = [3; 1; 1]
    volume = abs(u ⋅ (w × v))
	A = [u';v';w']
	det(A)
    volume = abs(w ⋅ (u × v))
end

# ╔═╡ 4d59ce5f-85f1-4d35-8fdb-e6b3f9040eb5
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/b5xwbxrg?embed)

"""

# ╔═╡ b1a879f4-3d78-4309-9f4f-117bcb0765da
cm"""
$(bbl("Remark",""))

The volume of the parallelepiped is ``0`` if and only if the three vectors are __coplanar__. 

That is, when the vectors ``\mathbf{u}=\left\langle u_1, u_2, u_3\right\rangle``, ``\mathbf{v}=\left\langle v_1, v_2, v_3\right\rangle``, and ``\mathbf{w}=\left\langle w_1, w_2, w_3\right\rangle`` have the same initial point, they lie in the same plane if and only if
```math
\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})=\left|\begin{array}{ccc}
u_1 & u_2 & u_3 \\
v_1 & v_2 & v_3 \\
w_1 & w_2 & w_3
\end{array}\right|=0
```
"""

# ╔═╡ c9fdf367-035b-4716-9f45-e62d82ec8a6e
md"""
# 11.5 Lines and Planes in Space
> __Objectives__
> 1. Write a set of parametric equations for a line in space.
> 1. Write a linear equation to represent a plane in space.
> 1. Sketch the plane given by a linear equation.
> 1. Find the distances between points, planes, and lines in space.
"""

# ╔═╡ 07ffeef2-9434-49d5-b77b-072c00a80d76
md"## Lines in Space"

# ╔═╡ b3cc1aa3-6360-4f59-9a30-ac5e44f133bc
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/a87nndfp?embed)

"""

# ╔═╡ 0e941631-0e52-4dc3-bdf1-056f36e77499
cm"""
$(bth("Parametric Equations of a Line in Space"))

A line ``L`` parallel to the vector ``\mathbf{v}=\langle a, b, c\rangle`` and passing through the point ``P\left(x_1, y_1, z_1\right)`` is represented by the parametric equations
```math
x=x_1+a t, \quad y=y_1+b t, \quad \text { and } \quad z=z_1+c t .
```
$(ebl())

If the direction numbers ``a, b``, and ``c`` are all nonzero, then you can eliminate the parameter ``t`` in the parametric equations to obtain symmetric equations of the line.
```math
\frac{x-x_1}{a}=\frac{y-y_1}{b}=\frac{z-z_1}{c} \quad \color{red}{\text{Symmetric equations}}
```


$(ex(1,"Finding Parametric and Symmetric Equations"))
Find parametric and symmetric equations of the line ``L`` that passes through the point ``(1,-2,4)`` and is parallel to ``\mathbf{v}=\langle 2,4,-4\rangle``, as shown in Below.

"""

# ╔═╡ ca27664a-8f75-4131-9d61-044ea96979de
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/a87nndfp?embed)


"""

# ╔═╡ 44dcb641-81a8-429a-b0eb-e85ffa0ea3ff
md"##  Planes in Space"

# ╔═╡ 23a92df7-77d9-4804-86a5-08cdfea8651c
cm"""
$(post_img("https://www.dropbox.com/scl/fi/9vzo9clna5s3ugrufyons/fig_11_45.png?rlkey=dyblrdq5uvbjp1wmdl8y5mryl&dl=1",400))

$(bth("Standard Equation of a Plane in Space"))
The plane containing the point ``\left(x_1, y_1, z_1\right)`` and having normal vector
```math
\mathbf{n}=\langle a, b, c\rangle
```
can be represented by the standard form of the equation of a plane
```math
a\left(x-x_1\right)+b\left(y-y_1\right)+c\left(z-z_1\right)=0 .
```
"""

# ╔═╡ 391ff8aa-056a-4867-90db-3d9f4537fe80
cm"""
$(bbl("Remark",""))
```math
a x+b y+c z+d=0 \qquad \color{red}{\text{General form of equation of plane}}
```
"""

# ╔═╡ 8e46e68e-0099-430b-864e-683b14ed2fbd
cm"""
$(ex(3,"Finding an Equation of a Plane in Three-Space"))
Find an equation (in standard form and in general form) of the plane containing the points ``(2,1,1), \quad(1,4,1), \quad`` and ``\quad(-2,0,4)``.
"""

# ╔═╡ 71a93732-10ff-480f-aacf-6ea729d636b9
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/a87nndfp?embed)

"""

# ╔═╡ 1809ee14-dd65-40f4-8efa-92554a5398ea
let
	A=[2,1,1]
	B=[1,4,1]
	C=[-2,0,4]
	AB=B-A
	AC=C-A
	n = AB × AC
	@variables x::Real, y::Real, z::Real
	P = B
	Q = [x,y,z]
	PQ = Q-P
	n ⋅ PQ ~ 0
	# n ⋅ ([x,y,z]) - n⋅A ~ 0
end

# ╔═╡ 902fbee4-194f-499d-9e9d-ad7bfb08131e
cm"""
$(bbl("Angle between two planes",""))
```math
\cos \theta=\frac{\left|\mathbf{n}_1 \cdot \mathbf{n}_2\right|}{\left\|\mathbf{n}_1\right\|\left\|\mathbf{n}_2\right\|}
```


"""

# ╔═╡ 772af978-5d7d-467d-bfc5-98dcf5bdd872
cm"""
$(bbl("Remark",""))
Two planes with normal vectors ``\bf n_1`` and ``\bf n_2`` are
* __perpendicular__ when ``{\bf n_1} \cdot {\bf n_2} = 0``.
* __parallel__ when ``\bf n_1`` is a scalar multiple of ``\bf n_2``.
"""

# ╔═╡ 6e53795f-016a-4113-ae5d-5dc2a02758a7
cm"""
$(ex(4,"Finding the Line of Intersection of Two Planes"))
Find the angle between the two planes ``x-2 y+z=0`` and ``2 x+3 y-2 z=0``. Then find parametric equations of their line of intersection.
"""

# ╔═╡ 21b654c3-e9e3-4277-914d-32c81dc86604
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/tg4tezst?embed)

"""

# ╔═╡ d041d81f-b61f-4dfe-9fc0-472cef882098
let
    n1 = [1; -2; 1]
    n2 = [2; 3; -2]
    α = acos(abs(n1 ⋅ n2) / (norm(n1) * norm(n2))) |> u"°"
	# acos(sqrt(6/17)) |> u"°"
	u = n1 × n2
	
end

# ╔═╡ 99fddbde-28de-4a43-977b-a8d9559fe997
md"## Sketching Planes in Space"

# ╔═╡ 7ebe69ae-4d5a-4f4f-a114-15dc3ddd6876
cm"""
Sketch the plane
```math
3x+2y+4z=12
```
"""

# ╔═╡ 5c0b0103-d1b8-46e6-8ef3-a65da4dc2db2
md"## Distances Between Points, Planes, and Lines"

# ╔═╡ 9c4292c7-f292-4fc8-9bfd-45ad4b4ccce5
cm"""
$(bth("Distance Between a Point and a Plane"))
$(post_img("https://www.dropbox.com/scl/fi/5l5deuushije2ffszddg4/fig_11_52.png?rlkey=gz5llqi698cjwz5iuwwfruap4&dl=1",300))
The distance between a plane and a point ``Q`` (not in the plane) is
```math
D=\left\|\operatorname{proj}_{\mathbf{n}} \stackrel{\rightharpoonup}{P Q}\right\|=\frac{|\stackrel{\rightharpoonup}{P Q} \cdot \mathbf{n}|}{\|\mathbf{n}\|}
```
where ``P`` is a point in the plane and ``\mathbf{n}`` is normal to the plane.


$(ebl())

$(ex(5,"Finding the Distance Between a Point and a Plane"))
Find the distance between the point ``Q(1,5,-4)`` and the plane ``3 x-y+2 z=6``.
"""

# ╔═╡ 1b6deda2-a68d-4684-8741-275628b24ecf
let
    Q = (1, 5, -4)
    P = (2, 0, 0)
    n = (3, -1, 2)
    on_plane(P) = n ⋅ P == 6
    PQ = Q .- P
    D = abs(PQ ⋅ n) / norm(n)
end

# ╔═╡ 1aca8a3e-feb4-4665-a059-8a0c2171198a
cm"""
$(bbl("Distance between a point and a plane"))
Let ``Q(x_0,y_0,z_0)`` be any point. The distance between ``Q`` and the plane ``ax+by+cz+d=0`` is given by
```math
D=\frac{\left|a x_0+b y_0+c z_0+d\right|}{\sqrt{a^2+b^2+c^2}}
```
where ``P(x_1.y_1,z_2)`` on the plane.

"""

# ╔═╡ bea8fbd0-1ac1-43fd-aeba-6eb968e548e1
cm"""
$(ex(6,"Finding the Distance Between Two Parallel Planes"))
Two parallel planes, ``3 x-y+2 z-6=0`` and ``6 x-2 y+4 z+4=0``, find the distance between them.
"""

# ╔═╡ 7932b9ab-1041-44ee-8e31-f10870a58d90
let
    f1(x, y, z) = 3x - y + 2z - 6
    f2(x, y, z) = 6x - 2y + 4z + 4
    Q = (0, -6, 0)
    # P = (0, 0, -1)
    # PQ = Q .- P
    n = (6, -2, 4)
    # D = abs(PQ ⋅ n) / norm(n)
	d = abs(12+4)/norm(n)

end

# ╔═╡ b829aed8-9618-44ea-9a2d-2c5d36416e62
cm"""
$(bth("Distance Between a Point and a Line in Space"))
The distance between a point ``Q`` and a line in space is
```math
D=\frac{\|\overrightarrow{P Q} \times \mathbf{u}\|}{\|\mathbf{u}\|}
```
where ``\mathbf{u}`` is a direction vector for the line and ``P`` is a point on the line.

$(post_img("https://www.dropbox.com/scl/fi/y9ty0d9njoshc2ki0skey/fig_11_54.png?rlkey=wicvn44wlqvc72niqy28dfs1w&dl=1",300))
$(ebl())

$(ex(7,"Finding the Distance Between a Point and a Line"))
Find the distance between the point ``Q(3,-1,4)`` and the line
```math
x=-2+3 t, \quad y=-2 t, \quad \text { and } \quad z=1+4 t
```
"""

# ╔═╡ 8934159d-2dc6-4e4d-a5c4-2125831e0c52
let
    Q = [3,-1, 4]
	P = [-2,0, 1]
	u = [3,-2,4]
	PQ = Q-P
	norm(PQ × u)/norm(u)
	
end

# ╔═╡ 2407b715-09cd-4568-bf81-4b9f5cf4065e
md"## Skew lines"

# ╔═╡ 037e8495-26d6-45d9-a855-4d1c88917561
cm"""
$(define("Skew Lines"))
Two lines in space are __skew__ if they are neither parallel nor intersecting.
"""

# ╔═╡ 5e96be6d-4801-4056-ae2c-0b1b95307ac4
cm"""
$(ex())
Consider the following two lines in space.
```math
\begin{aligned}
& L_1: x=4+5 t, y=5+5 t, z=1-4 t \\
& L_2: x=4+s, y=-6+8 s, z=7-3 s
\end{aligned}
```
- (i) Show that these lines are not parallel.
- (ii) Show that these lines do not intersect and therefore are skew lines.
- (iii) Show that the two lines lie in parallel planes.
- (iv) Find the distance between the parallel planes from part (iii). This is the distance between the original skew lines.
"""

# ╔═╡ eacf6145-a437-45e9-8eee-fb587077be60
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/r488tpxz?embed)
"""

# ╔═╡ 8143a2ac-b6dc-42b3-95a7-79006bc8916c
let
    @variables x::Real, y::Real, z::Real, t::Real, s::Real
    P1 = [4; 5; 1]
    P2 = [4; -6; 7]
    v1 = [5; 5; -4]
    v2 = [1; 8; -3]

    L1(t) = P1 + v1 * t
    L2(s) = P2 + v2 * s
    n1 = v1 × v2
    f1(x::Vector) = x ⋅ n1 - P1 ⋅ n1
    PL1 = f1([x; y; z]) ~ 0
    # # # # # L1(t)
    f2(x::Vector) = x ⋅ n1 - P2 ⋅ n1
    PL2 = f2([x; y; z]) ~ 0
    # PL1, PL2
    # P1P2 = L2(0) - L1(5)
    # D = abs(n1 ⋅ P1P2) / norm(n1)
    # # # expand(f1(L1(t)))
    # expand(f2(L2(t)))
end

# ╔═╡ b1f8da27-e3d9-4253-b481-071b5722d1a1
md"""
# 11.6 Surfaces in Space
> __Ovjectives__ 
> 1. Recognize and write equations of cylindrical surfaces.
> 2. Recognize and write equations of quadric surfaces.
> 3. Recognize and write equations of surfaces of revolution __(X)__
"""

# ╔═╡ cfbda53f-da9b-422b-b888-28f6acb96ee0
md"## Cylindrical Surfaces"

# ╔═╡ 203ef45b-a6c3-4d04-a773-43ee348eaabd
cm"""
$(define("Cylinder"))
Let ``C`` be a curve in a plane and let ``L`` be a line not in a parallel plane. The set of all lines parallel to ``L`` and intersecting ``C`` is a __cylinder__. The curve ``C`` is the __generating curve__ (or __directrix__) of the cylinder, and the parallel lines are __rulings__.

$(post_img("https://www.dropbox.com/scl/fi/q0pbnl6g4n9ouhf0kbf4v/fig_11_57.png?rlkey=k0julsbb28j2liez5723p4hz7&dl=1"))
"""

# ╔═╡ fcb7503a-7145-44ce-9354-80631b966912
cm"""
__Equations of Cylinders__
The equation of a cylinder whose rulings are parallel to one of the coordinate 
axes contains only the variables corresponding to the other two axes.
"""

# ╔═╡ 3bae6577-7e58-4423-a954-e40eceeceab8
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/fm9cnxfr?embed)

"""

# ╔═╡ f91da06c-b2ed-4b31-9fa6-af1e79c2167a
cm"""
$(ex(1,"Sketching a Cylinder"))
Sketch the surface represented by each equation.
- (a.) ``z=y^2``
- (b.) ``z=\sin x, \quad 0 \leq x \leq 2 \pi``
"""

# ╔═╡ 8054a733-294a-49f6-881c-938c0e032484
cm"""
[Geogebra Graph](https://www.geogebra.org/classic/bjkrnchk?embed)

"""

# ╔═╡ 58d41760-0c3d-4512-9829-7553ba5cc8a1
md"## Quadric Surfaces"

# ╔═╡ 11ce75b3-0867-441d-958d-1ff5ed3d9eaf
cm"""
$(define("Quadric Surface"))
The equation of a quadric surface in space is a second-degree equation in three variables. The general form of the equation is
```math
A x^2+B y^2+C z^2+D x y+E x z+F y z+G x+H y+I z+J=0
```

There are six basic types of quadric surfaces: 
1. __ellipsoid__, 
2. __hyperboloid of one sheet__, 
3. __hyperboloid of two sheets__, 
4. __elliptic cone__, 
5. __elliptic paraboloid__, and 
6. __hyperbolic paraboloid__.
"""

# ╔═╡ 2fa97dda-c94d-4dae-bde8-aff4b9e2ca7e
cm"""
$(post_img("https://www.dropbox.com/scl/fi/loxxo1654l5ae0czqq0hg/quadratic_surfaces_1.png?rlkey=l7entrslfedfizipo2kae4ja4&dl=1",800))

$(post_img("https://www.dropbox.com/scl/fi/gie6mrs9mrd2do68ukysh/quadratic_surfaces_2.png?rlkey=dqtmhedg3h6078bgbiifm4hey&dl=1",800))
"""

# ╔═╡ d936afce-e80d-49c9-9e55-cd4432c6e392
cm"""
$(ex(2,"Sketching a Quadric Surface"))
Classify and sketch the surface
```math
4 x^2-3 y^2+12 z^2+12=0
```
"""

# ╔═╡ bd9cb96f-ab81-4bb8-82a8-56577a0412a6
cm"""
$(ex(3,"Sketching a Quadric Surface"))
Classify and sketch the surface
```math
x-y^2-4 z^2=0
```
"""

# ╔═╡ ba23c565-f547-4df9-9027-d623bacf8fa6
cm"""
$(ex(4,"A Quadric Surface Not Centered at the Origin"))
Classify and sketch the surface
```math
x^2+2 y^2+z^2-4 x+4 y-2 z+3=0
```
"""

# ╔═╡ 0c5c4f1e-2145-4333-bed0-9b1d53c665db
md""" # 13.1 Introduction to Functions of Several Variables
> __Objectives__
> 1. Understand the notation for a function of several variables.
> 1. Sketch the graph of a function of two variables.
> 1. Sketch level curves for a function of two variables.
> 1. Sketch level surfaces for a function of three variables.
> 1. Use computer graphics to graph a function of two variables.
 """

# ╔═╡ 0658ce85-2ae3-4595-9105-5a2a187a1d73
cm"""
$(define("Function of Two Variables"))
Let ``D`` be a set of ordered pairs of real numbers. If to each ordered pair ``(x, y)`` in ``D`` there corresponds a unique real number ``f(x, y)``, then ``f`` is a function of ``\boldsymbol{x}`` and ``\boldsymbol{y}``. The set ``D`` is the domain of ``f``, and the corresponding set of values for ``f(x, y)`` is the range of ``f``. For the function
```math
z=f(x, y)
```
``x`` and ``y`` are called the independent variables and ``z`` is called the dependent variable.
"""

# ╔═╡ 441227fb-8b43-402e-a3ec-976c3fcd266f
cm"""
$(ex(1,"Domains of Functions of Several Variables"))
Find the domain of each function.
- (a.) ``f(x, y)=\frac{\sqrt{x^2+y^2-9}}{x}``
- (b.) ``g(x, y, z)=\frac{x}{\sqrt{9-x^2-y^2-z^2}}``
"""

# ╔═╡ a7e74141-12a3-43c5-81d6-887df215d3c4
md"## The Graph of a Function of Two Variables"

# ╔═╡ 46462c56-05b0-4efb-aa16-54672b0bf1d4
cm"""
$(ex(2,"Describing the Graph of a Function of Two Variables"))

Consider the function given by
```math
f(x, y)=\sqrt{16-4 x^2-y^2} .
```
- (a.) Find the domain and range of the function.
- (b.) Describe the graph of ``f``.
"""

# ╔═╡ 6a6ff203-3789-4a1a-8c62-e9628239e0c4
cm"""
[Geogebra Plot](https://www.geogebra.org/classic/p2pwhv6k?embed)
"""

# ╔═╡ 8f59471c-fd22-4337-ae80-088b2fb84bf4
md"## Level Curves"

# ╔═╡ e65f9504-8096-4d04-add3-b000929fea8d
cm"""
We use __a scalar field__ in which the scalar
```math
z =f(x, y)
```
is assigned to the point (x, y). 

- A scalar field can be characterized by __level curves__ (or 
__contour lines__) along which the value of f(x, y) is constant. 

$(post_img("https://www.dropbox.com/scl/fi/hwccmtn3kckbo8orqxodc/fig_13_5.png?rlkey=7o7qgkgwtxpexc9efihxq0mpd&dl=1"))
"""

# ╔═╡ b0312347-074e-4d02-9541-827625366a1f
cm"""
$(ex(3,"Sketching a Contour Map"))
Consider the hemisphere
```math
f(x, y)=\sqrt{64-x^2-y^2}
```
Sketch a contour map of this surface using level curves corresponding to ``c=0,1,2, \ldots, 8``.
"""

# ╔═╡ 0980c680-12bf-45bb-8b51-9af548d75809
# let
#     # Define the function f(x, y)
#     g(x, y) = 64 - x^2 - y^2
#     f(x, y) = sqrt(g(x, y))

#     # Define ranges for x and y
#     # x in [-2, 2] and y in [-2, 2]
#     xs = range(-2, 2, length=300)
#     ys = range(-2, 2, length=300)

#     # Compute function values over the grid.
#     # Use a ternary operator to ensure that the function is evaluated only when the argument is nonnegative.
#     Z = [(g(x, y) >= 0 ? f(x, y) : NaN) for x in xs, y in ys]

#     # Plot the contour lines
#     contour(xs, ys, Z,
#         title="Contour Plot of f(x,y) = √(16-4x²-y²)",
#         xlabel="x", ylabel="y",
#         fill=true,
#         colorbar=true)
# end

# ╔═╡ e33d3119-d369-48b1-b298-d381d0f56539
cm"""
**Plot Backend:**
$(@bind backend_choice Select(["gr" => "GR (Fast)", 
                                "plotly" => "Plotly (Interactive)"]))

**Select which level curves to display:** 
$(@bind show_levels MultiCheckBox(0:8, default=[0,2,4,6,8]))


**View Mode:**
$(@bind view_mode Select(["contour"=>"Contour Only", 
                          "surface" => "3D Surface Only",
                          "both" => "Side by Side",
                          "overlay" => "Overlay"]))

**Show Grid:** $(@bind show_grid CheckBox(default=true))

**Show Labels:** $(@bind show_labels CheckBox(default=true))
"""


# ╔═╡ abe05e1f-f4de-4ff3-ae24-baca1163e808
let 
	f(x, y) = sqrt(max(0, 64 - x^2 - y^2))

	# Switch backend based on user selection
	if backend_choice == "plotly"
		plotly()
	else
		gr()
	end
	# Create coordinate grid
	x_range = -8:0.1:8
	y_range = -8:0.1:8
	
	# Contour plot
	function create_contour_plot()
		levels =  if backend_choice == "plotly" 
					(0:1:8) 
				else
					[i for i in 0:8]
				end
			
		p = contour(x_range, y_range, f,
			levels=levels,
			fill = true,
			linewidth = 2,
			color = :viridis,
			xlabel = "x",
			ylabel = "y",
			title = "Contour Map (Top View)",
			aspect_ratio = :equal,
			size = (500, 500),
			xlims = (-9, 9),
			ylims = (-9, 9),
			grid = show_grid,
			clims = (0, 8),
			colorbar_title = "Height (z)")
		
		# Add circle annotations for level curves up to animation_frame
		for c in show_levels
			r = sqrt(64 - c^2)
			θ = 0:0.01:2π
			plot!(p, r.*cos.(θ), r.*sin.(θ), 
				color = :black, 
				linewidth = 2,
				label = show_labels ? "c = $c" : "",
				linestyle = :solid)
		end
		
		return p
	end
	
	# 3D surface plot
	function create_3d_plot()
		x_3d = -8:0.3:8
		y_3d = -8:0.3:8
		z_surface = [f(x, y) for y in y_3d, x in x_3d]
		
		p = surface(x_3d, y_3d, z_surface,
			color = :viridis,
			xlabel = "x",
			ylabel = "y",
			zlabel = "z = f(x,y)",
			title = "3D Hemisphere",
			camera = (30, 30),
			size = (500, 500),
			colorbar_title = "Height",
			clims = (0, 8),
			zlims = (0, 9),
			xlims = (-9, 9),
			ylims = (-9, 9)
		)
		# Add level curve rings on the surface
		for c in show_levels
			if c > 0
				r = sqrt(64 - c^2)
				θ = 0:0.05:2π
				x_circle = r.*cos.(θ)
				y_circle = r.*sin.(θ)
				z_circle = fill(Float64(c), length(θ))
				plot!(p, x_circle, y_circle, z_circle,
					color = :red,
					linewidth = 3,
					label = "")
			end
		end
		# Add major axes
	# plot!(p, [-10, 10], [0, 0], [0, 0], color = :black, linewidth = 2, label = "x-axis")
	# plot!(p, [0, 0], [-10, 10], [0, 0], color = :black, linewidth = 2, label = "y-axis")
	# plot!(p, [0, 0], [0, 0], [-12, 12], color = :black, linewidth = 4, label = "z-axis")
		return p
	end
	
	# Overlay plot
	function create_overlay_plot()
		p = plot(legend = :topright, size = (600, 600))
		
		# Draw filled contours
		contourf!(p, x_range, y_range, f,
			levels = 0:0.5:8,
			color = :viridis,
			alpha = 0.6,
			xlabel = "x",
			ylabel = "y",
			title = "Contour Map with Level Curve Radii",
			aspect_ratio = :equal,
			xlims = (-9, 9),
			ylims = (-9, 9),
			colorbar_title = "Height (z)")
		
		# Highlight selected level curves
		for c in sort(show_levels)
			r = sqrt(64 - c^2)
			θ = 0:0.01:2π
			plot!(p, r.*cos.(θ), r.*sin.(θ),
				color = :red,
				linewidth = 3,
				label = show_labels ? "r = $(round(r, digits=2)) (c=$c)" : "")
		
		end
		
		return p
	end
	
	# Display based on selected view mode
	if view_mode == "contour"
		create_contour_plot()
	elseif view_mode == "surface"
		create_3d_plot()
		
	elseif view_mode == "both"
		plot(create_3d_plot(), create_contour_plot(), 
			layout = (1, 2), size = (1000, 500))
		
	else  # overlay
		create_overlay_plot()
		
	end
end


# ╔═╡ 48130cd8-69ad-4b14-b4a5-84aeb560aae0
cm"""
$(ex(4,"Sketching a Contour Map"))
Sketch a contour map of the hyperbolic paraboloid
```math
z=y^2-x^2
```

"""

# ╔═╡ 52ef6ea9-888c-48b3-a2d4-5ca86c5e6b1b
md"## Level Surfaces"

# ╔═╡ fa71c9a5-1d30-49e3-930e-757c681e5028
cm"""
The concept of a __level curve__ can be extended by one dimension to define a __level surface__. 
If f is a function of three variables and c is a constant, then the graph of the 
equation
```math
f(x, y, z) = c
```
is a level surface of ``f``, as shown in
$(post_img("https://www.dropbox.com/scl/fi/ulqs8j9cnilxdmiuqtvnh/fig_13_14.png?rlkey=vub0vzuj1effvid8gnhh7cllh&dl=1"))
"""

# ╔═╡ 7222448d-c176-4441-bb0d-46203177d93a
cm"""
$(ex(6,"Level Surfaces"))
Describe the level surfaces of
```math
f(x, y, z)=4 x^2+y^2+z^2
```

"""

# ╔═╡ 62e49e96-01b0-447a-a742-9b8491b35fcc
md"""
# 13.2 Limits and Continuity
> __Objectives__
> 1. Understand the definition of a neighborhood in the plane.
> 1. Understand and use the definition of the limit of a function of two variables.
> 1. Extend the concept of continuity to a function of two variables.
> 1. Extend the concept of continuity to a function of three variables.
"""

# ╔═╡ 1e13cf69-7303-4086-90b9-fe2232a08327
md"## Neighborhoods in the Plane"

# ╔═╡ 959ca089-7ed7-44aa-b4a1-9321cf1d2ce4
md"## Limit of a Function of Two Variables"

# ╔═╡ 1915cc7d-1d34-480e-a413-fcd64b4e76bf
cm"""
$(define("the Limit of a Function of Two Variables"))
Let ``f`` be a function of two variables defined, except possibly at ``\left(x_0, y_0\right)``, on an open disk centered at ``\left(x_0, y_0\right)``, and let ``L`` be a real number. Then
```math
\lim _{(x, y) \rightarrow\left(x_0, y_0\right)} f(x, y)=L
```
if for each ``\varepsilon>0`` there corresponds a ``\delta>0`` such that
```math
|f(x, y)-L|<\varepsilon \quad \text { whenever } \quad 0<\sqrt{\left(x-x_0\right)^2+\left(y-y_0\right)^2}<\delta
```
"""

# ╔═╡ 9779271b-19cf-4034-9901-0983454edef1
cm"""
[Geogebra Plot](https://www.geogebra.org/classic/a3zakjet?embed)
"""

# ╔═╡ 837b01a0-948d-472f-b17c-c9763f2e5f0e
cm"""
$(bbl("Remark","")) 

Limits of functions of several variables have the same properties regarding sums, 
differences, products, and quotients as do limits of functions of single variables.
"""

# ╔═╡ c5270de3-1db9-4dbb-87e5-0e9f18ea34b2
cm"""
$(ex(2,"Finding a Limit"))
Find the limit.
```math
\lim _{(x, y) \rightarrow(1,2)} \frac{5 x^2 y}{x^2+y^2}
```
"""

# ╔═╡ e125198b-ea6e-4703-8b0b-8ec2b191fc39
cm"""
$(ex(3,"Finding a Limit"))
Find the limit: 
```math
\lim _{(x, y) \rightarrow(0,0)} \frac{5 x^2 y}{x^2+y^2}
```
"""

# ╔═╡ 04442eaa-9336-4ebd-865b-7e1fdbe4b8bc
cm"""
$(ex(4,"A Limit That Does Not Exist"))
Show that the limit does not exist.
```math
\lim _{(x, y) \rightarrow(0,0)}\left(\frac{x^2-y^2}{x^2+y^2}\right)^2
```
[See Graph](https://www.geogebra.org/calculator/w96w7g6w)
"""

# ╔═╡ 4b19a3ac-1f97-40e3-a8ff-cd57a3f14fdc
md"## Continuity of a Function of Two Variables"

# ╔═╡ d8fc27f5-de91-4bc3-83b5-c48ae17acf97
cm"""
$(define("Continuity of a Function of Two Variables"))
A function ``f`` of two variables is continuous at a point ``\left(\boldsymbol{x}_{\mathbf{0}}, \boldsymbol{y}_{\mathbf{0}}\right)`` in an open region ``R`` if ``f\left(x_0, y_0\right)`` is defined and is equal to the limit of ``f(x, y)`` as ``(x, y)`` approaches ``\left(x_0, y_0\right)``. That is,
```math
\lim _{(x, y) \rightarrow\left(x_0, y_0\right)} f(x, y)=f\left(x_0, y_0\right)
```

The function ``f`` is continuous in the open region ``\boldsymbol{R}`` if it is continuous at every point in ``R``.
"""

# ╔═╡ 3f146078-120b-4f4a-bf9b-392ef6afb5c4
cm"""
$(bth("Continuous Functions of Two Variables"))
If ``k`` is a real number and ``f(x, y)`` and ``g(x, y)`` are continuous at ``\left(x_0, y_0\right)``, then the following functions are also continuous at ``\left(x_0, y_0\right)``.
1. Scalar multiple: ``k f``
2. Sum or difference: ``f \pm g``
3. Product: ``f g``
4. Quotient: ``f / g, g\left(x_0, y_0\right) \neq 0``
"""

# ╔═╡ 69528b92-41b9-4a90-a809-dfd86c3feb04
cm"""
$(bth("Continuity of a Composite Function"))

If ``h`` is continuous at ``\left(x_0, y_0\right)`` and ``g`` is continuous at ``h\left(x_0, y_0\right)``, then the composite function given by ``(g \circ h)(x, y)=g(h(x, y))`` is continuous at ``\left(x_0, y_0\right)``. That is,
```math
\lim _{(x, y) \rightarrow\left(x_0, y_0\right)} g(h(x, y))=g\left(h\left(x_0, y_0\right)\right)
```
"""

# ╔═╡ 85b9bece-47e3-4de1-b21c-650b8b841e0d
cm"""
$(ex(5,"Testing for Continuity"))
Discuss the continuity of each function.
- (a.) ``\displaystyle f(x, y)=\frac{x-2 y}{x^2+y^2}``
- (b.) ``\displaystyle g(x, y)=\frac{2}{y-x^2}``


"""

# ╔═╡ c982e7a9-9563-4ad6-8bde-2baa9c538650
cm"""
$(ex(6,"Testing Continuity of a Function of Three Variables"))
Discuss the continuity of
```math
f(x, y, z)=\frac{1}{x^2+y^2-z}
```
"""

# ╔═╡ 450ae414-927f-4497-8a05-0a1c0f7290b6
md"""
# 13.3 Partial Derivatives
> __Objectives__
> 1. Find and use partial derivatives of a function of two variables.
> 1. Find and use partial derivatives of a function of three or more variables.
> 1. Find higher-order partial derivatives of a function of two or three variables.
"""

# ╔═╡ 39226cb1-d58a-4bac-8d2c-dfa0b916aada
cm"## Partial Derivatives of a Function of Two Variables"

# ╔═╡ b15b1448-9b88-4b70-91ad-0d00d8e9aeb0
cm"""
$(define("Partial Derivatives of a Function of Two Variables"))
If ``z=f(x, y)``, then the first partial derivatives of ``f`` with respect to ``x`` and ``y`` are the functions ``f_x`` and ``f_y`` defined by
```math
f_x(x, y)=\lim _{\Delta x \rightarrow 0} \frac{f(x+\Delta x, y)-f(x, y)}{\Delta x}
```

Partial derivative with respect to ``x``
and
```math
f_y(x, y)=\lim _{\Delta y \rightarrow 0} \frac{f(x, y+\Delta y)-f(x, y)}{\Delta y}
```

Partial derivative with respect to ``y``
provided the limits exist.
"""

# ╔═╡ f5e000db-7586-47b9-a673-1829f8e47fd7
cm"""
$(ex(1,"Finding Partial Derivatives"))
__(a)__ Consider 
```math
f(x, y)=3 x-x^2 y^2+2 x^3 y
```
Find ``f_x`` and ``f_y``.

__(b)__ Consider 
```math
f(x, y)=(\ln x)\left(\sin x^2 y\right),
```

Find ``f_x`` and ``f_y``.
"""

# ╔═╡ 2cc5584a-586a-4ae7-bfc3-71ff77fbf3d9
cm"""
$(bbl("Notation for First Partial Derivatives"))
For ``z=f(x, y)``, the partial derivatives ``f_x`` and ``f_y`` are denoted by
```math
\frac{\partial}{\partial x} f(x, y)=f_x(x, y)=z_x=\frac{\partial z}{\partial x} \quad \text { Partial derivative with respect to } x
```
and
```math
\frac{\partial}{\partial y} f(x, y)=f_y(x, y)=z_y=\frac{\partial z}{\partial y} . \quad \text { Partial derivative with respect to } y
```

The first partials evaluated at the point ``(a, b)`` are denoted by
```math
\left.\frac{\partial z}{\partial x}\right|_{(a, b)}=f_x(a, b)
```
and
```math
\left.\frac{\partial z}{\partial y}\right|_{(a, b)}=f_y(a, b)
```
"""

# ╔═╡ 7a1c7ca9-659d-4f66-ab27-21a02201e60d
cm"""
$(ex(2,"Finding and Evaluating Partial Derivatives"))
For ``f(x, y)=x e^{x^2 y}``, find ``f_x`` and ``f_y``, and evaluate each at the point ``(1, \ln 2)``.
"""

# ╔═╡ 4ed53690-acca-4128-90ee-d935afc71e7c
cm"""
$(ex(3,"Finding the Slopes of a Surface"))
Find the slopes in the ``x``-direction and in the ``y``-direction of the surface
```math
f(x, y)=-\frac{x^2}{2}-y^2+\frac{25}{8}
```
at the point ``\left(\frac{1}{2}, 1,2\right)``.
"""

# ╔═╡ baa0d2e0-ac0d-4371-803e-9cc22d016af7
cm"""
$(ex(4,"Finding the Slopes of a Surface"))
Find the slopes of the surface
```math
f(x, y)=1-(x-1)^2-(y-2)^2
```
at the point ``(1,2,1)`` in the ``x``-direction and in the ``y``-direction.
"""

# ╔═╡ ae48b156-e2e5-43e1-bd8d-ab995cc393a0
cm"""
$(ex(5,"Using Partial Derivatives to Find Rates of Change"))
The area of a parallelogram with adjacent sides ``a`` and ``b`` and included angle ``\theta`` is given by ``A=a b \sin \theta``, as shown below
$(post_img("https://www.dropbox.com/scl/fi/jahlir2ftz4fz3ngbwpkh/fig13.33.png?rlkey=2iaac1h3pmm0qmwwzejhr8rfm&dl=1"))
"""

# ╔═╡ 4bf026b7-7a1c-4134-a4b1-4c8a9069a73d
md"## Partial Derivatives of a Function of Three or More Variables"

# ╔═╡ 64acd27c-8af7-4051-b018-2f8dd0615b34
cm"""
$(ex(6,"Finding Partial Derivative"))
__(a)__
```math
 f(x, y, z) = xy + yz^2 + xz 
```
__(b)__
```math
 f(x, y, z) =  z sin(xy^2 + 2z) 
```

"""

# ╔═╡ 0cd9a65d-1d2b-42a4-85b6-a5c2541889d8
md"## Higher-Order Partial Derivatives"

# ╔═╡ 853380dd-f790-4462-bcec-e0744274dc2e
cm"""
Let 
```math
z = f(x,y)
```
1. Differentiate twice with respect to ``x`` :
```math
\frac{\partial}{\partial x}\left(\frac{\partial f}{\partial x}\right)=\frac{\partial^2 f}{\partial x^2}=f_{x x}
```
2. Differentiate twice with respect to ``y`` :
```math
\frac{\partial}{\partial y}\left(\frac{\partial f}{\partial y}\right)=\frac{\partial^2 f}{\partial y^2}=f_{y y}
```
3. Differentiate first with respect to ``x`` and then with respect to ``y`` :
```math
\frac{\partial}{\partial y}\left(\frac{\partial f}{\partial x}\right)=\frac{\partial^2 f}{\partial y \partial x}=f_{x y} .
```
4. Differentiate first with respect to ``y`` and then with respect to ``x`` :
```math
\frac{\partial}{\partial x}\left(\frac{\partial f}{\partial y}\right)=\frac{\partial^2 f}{\partial x \partial y}=f_{y x}
```

The third and fourth cases are called __mixed partial derivatives__.

"""

# ╔═╡ 256acb74-41ef-4352-b14a-f74a9a723deb
cm"""
$(ex(7,"Finding Second Partial Derivatives"))

Find the second partial derivatives of
```math
f(x, y)=3 x y^2-2 y+5 x^2 y^2
```
and determine the value of ``f_{x y}(-1,2)``.
"""

# ╔═╡ 4b5c59b6-7670-482c-a4de-795530e38b75
cm"""
$(bth("Equality of Mixed Partial Derivatives"))
If ``f`` is a function of ``x`` and ``y`` such that ``f_{x y}`` and ``f_{y x}`` are continuous on an open disk ``R``, then, for every ``(x, y)`` in ``R``,
```math
f_{x y}(x, y)=f_{y x}(x, y)
```
"""

# ╔═╡ 235057bb-ea29-4b9a-8665-f750cde0d002
cm"""
$(ex())
Consider the function defined by
```math
f(x, y)= \begin{cases}\frac{x y\left(x^2-y^2\right)}{x^2+y^2}, & (x, y) \neq(0,0) \\ 0, & (x, y)=(0,0)^{-}\end{cases}
```
- (a) Find ``f_x(x, y)`` and ``f_y(x, y)`` for ``(x, y) \neq(0,0)``.
- (b) Use the definition of partial derivatives to find ``f_x(0,0)`` and ``f_y(0,0)``.

- (c) Use the definition of partial derivatives to find ``f_{\mathrm{xy}}(0,0)`` and ``f_{yx}(0,0)``.
- (d) Using Theorem 13.3 and the result of part (c), what can be said about ``f_{x y}`` or ``f_{y x}`` ?
"""

# ╔═╡ a57476c4-7f42-40aa-a453-b7b29e7b9f7d
cm"""
$(ex(8,"Finding Higher-Order Partial Derivatives"))
Show that ``f_{x z}=f_{z x}`` and ``f_{x z z}=f_{z z z}=f_{z z x}`` for the function
```math
f(x, y, z)=y e^x+x \ln z .
```
"""

# ╔═╡ 068a3704-aa26-47ea-8f4a-ed4aacbb1985
md"""
# 13.4 Differentials
> __Objectives__
> 1. Understand the concepts of increments and differentials.
> 1. Extend the concept of differentiability to a function of two variables.
> 1. Use a differential as an approximation.
"""

# ╔═╡ b64466d6-b4fb-408b-99e4-9ff0ed7bf95a
md"## Increments and Differentialsp"

# ╔═╡ 17cb54f7-f893-47b1-b089-d6f0e5fe6c0c
cm"""
$(define("Total Differential"))
If ``z=f(x, y)`` and ``\Delta x`` and ``\Delta y`` are increments of ``x`` and ``y``, then the differentials of the independent variables ``x`` and ``y`` are
```math
d x=\Delta x \quad \text { and } \quad d y=\Delta y
```
and the total differential of the dependent variable ``z`` is
```math
d z=\frac{\partial z}{\partial x} d x+\frac{\partial z}{\partial y} d y=f_x(x, y) d x+f_y(x, y) d y
```
"""

# ╔═╡ ebabd01a-2a02-4a8c-9f01-23b347a9f6a7
cm"""
$(ex(1,"Finding the Total Differential"))
Find the total differential for each function.
- (a.) ``z=2 x \sin y-3 x^2 y^2``
- (b.) ``w=x^2+y^2+z^2``
"""

# ╔═╡ 14852a74-f0a5-41c7-a9ef-d110a4bd8807
md"## Differentiability"

# ╔═╡ a54bcc59-6b84-4553-878f-4a4abfd6e9d6
cm"""
$(define("Differentiability"))
A function ``f`` given by ``z=f(x, y)`` is differentiable at ``\left(x_0, y_0\right)`` if ``\Delta z`` can be written in the form
```math
\Delta z=f_x\left(x_0, y_0\right) \Delta x+f_y\left(x_0, y_0\right) \Delta y+\varepsilon_1 \Delta x+\varepsilon_2 \Delta y
```
where both ``\varepsilon_1`` and ``\varepsilon_2 \rightarrow 0`` as
```math
(\Delta x, \Delta y) \rightarrow(0,0)
```

The function ``f`` is differentiable in a region ``\boldsymbol{R}`` if it is differentiable at each point in ``R``.
"""

# ╔═╡ fdbca96e-0f9c-4edb-8f60-cb53c1dad95e
cm"""
$(ex(2,"Showing that a Function Is Differentiable"))
Show that the function
```math
f(x, y)=x^2+3 y
```
is differentiable at every point in the plane.
"""

# ╔═╡ 9fe522bd-dfdb-4d65-a8d1-3d2d4618e4f7
cm"""
$(bth("Sufficient Condition for Differentiability"))
If ``f`` is a function of ``x`` and ``y``, where ``f_x`` and ``f_y`` are continuous in an open region ``R``, then ``f`` is differentiable on ``R``.

"""

# ╔═╡ de197844-f3d6-469c-b41c-995d5ba542ca
md"## Approximation by Differentials"

# ╔═╡ 957e0ca3-72b6-4687-a7c5-69b6da416f5b
cm"""
For small ``\Delta x`` and ``\Delta y``, you can use the approximation
```math
\Delta z \approx d z . \quad \color{red}{\text { Approximate change in } z}
```
"""

# ╔═╡ d859bc8d-fce7-4eb6-9e0a-12750dc76275
cm"""
$(ex(3,"Using a Differential as an Approximation"))
Use the differential ``d z`` to approximate the change in
```math
z=\sqrt{4-x^2-y^2}
```
as ``(x, y)`` moves from the point ``(1,1)`` to the point ``(1.01,0.97)``. Compare this approximation with the exact change in ``z``.
"""

# ╔═╡ e08331c1-1e6c-48be-a570-e33a908d830f
let
    @variables x::Real, y::Real, z::Real
    @variables dx::Real, dy::Real, dz::Real, Δz::Real
    Δx, Δy = (1.01, 0.97) .- (1, 1)
    f(x, y) = sqrt(4 - x^2 - y^2)
    z ~ f(x, y)
    E = dz ~ ForwardDiff.gradient(x -> f(x...), [x; y]) ⋅ [dx; dy]
	E1 = Δz ~ f(1.01, 0.97) - f(1, 1)
    substitute(E, Dict([x => 1, y =>1, dy=> Δy, dx => Δx, dy => Δy])), E1

end

# ╔═╡ d444124f-7afa-4de4-bdcd-f9667f3e9732
cm"""
$(ex(4,"Error Analysis"))
The possible error involved in measuring each dimension of a rectangular box is ``\pm 0.1`` millimeter. The dimensions of the box are ``x=50`` centimeters, ``y=20`` centimeters, and ``z=15`` centimeters, as shown below. Use ``d V`` to estimate the propagated error and the relative error in the calculated volume of the box.

$(post_img("https://www.dropbox.com/scl/fi/1y1dnb0lijtqu1p8vl8z5/fig_13_37.png?rlkey=4xpdeaxy3lcn940i0y3vwyq31&dl=1"))
"""

# ╔═╡ e53f41aa-45cd-488a-9123-7dfa22ec3ef7
let
    @variables x::Real, y::Real, z::Real, dx::Real, dy::Real, dz::Real, dV::Real, V::Real
    v(x, y, z) = x * y * z
    Volume = V ~ v(x, y, z)
    E = dV ~ ForwardDiff.gradient(x -> v(x...), [x; y; z]) ⋅ [dx; dy; dz]
    dv = substitute(E, Dict([
        x => 50,
        y => 20,
        z => 15,
        dx => 0.01,
        dy => 0.01,
        dz => 0.01,
    ]))
    v_value = 50 * 20 * 15
    # dv = 20
    dv.rhs/v_value 
end

# ╔═╡ cc9031ef-476d-498b-8850-2b355125f98a
cm"""
$(bth("Differentiability Implies Continuity"))
If a function of ``x`` and ``y`` is differentiable at ``\left(x_0, y_0\right)``, then it is continuous at ``\left(x_0, y_0\right)``.
"""

# ╔═╡ 108a234a-2272-4971-b762-f7f665133955
cm"""
$(ex(5,"A Function That Is Not Differentiable"))
For the function
```math
f(x, y)= \begin{cases}\frac{-3 x y}{x^2+y^2}, & (x, y) \neq(0,0) \\ 0, & (x, y)=(0,0)\end{cases}
```
show that ``f_x(0,0)`` and ``f_y(0,0)`` both exist but that ``f`` is not differentiable at ``(0,0)``.
"""

# ╔═╡ 3de8b2fd-5d34-4a02-b821-a969b439e571
md"""
# 13.5 Chain Rules for Functions of Several Variables
> __Objectives__
> 1. Use the Chain Rules for functions of several variables.
> 2. Find partial derivatives implicitly.
"""

# ╔═╡ d850bcda-5bf4-4db6-b920-ca87514bfbc6
cm"""
$(bth("Chain Rule: One Independent Variable"))
Let ``w=f(x, y)``, where ``f`` is a differentiable function of ``x`` and ``y``. If ``x=g(t)`` and ``y=h(t)``, where ``g`` and ``h`` are differentiable functions of ``t``, then ``w`` is a differentiable function of ``t``, and
```math
\frac{d w}{d t}=\frac{\partial w}{\partial x} \frac{d x}{d t}+\frac{\partial w}{\partial y} \frac{d y}{d t}
```
$(ebl())

$(ex(1,"Chain Rule: One Independent Variable"))
Let ``w=x^2 y-y^2``, where ``x=\sin t`` and ``y=e^t``. Find ``d w / d t`` when ``t=0``.
"""

# ╔═╡ 527952f0-6be5-4be3-9676-3eb063188706
rand(1:29,6)

# ╔═╡ d8943cd3-6930-4447-a5a0-6c6cf8797e81
cm"""
$(ex(2,"An Application of a Chain Rule to Related Rates"))
Two objects are traveling in elliptical paths given by the following parametric equations.
```math
\begin{array}{lllr}
x_1=4 \cos t & \text{and} & y_1=2 \sin t & \color{red}{\text{first object}}\\
x_2=2 \sin 2 t& \text{and} & y_2=3 \cos 2 t & \color{red}{\text{second object}}
\end{array}
``` 

At what rate is the distance between the two objects changing when ``t=\pi`` ?
"""

# ╔═╡ 47fe0a92-3fb5-4a1b-9618-87eec99c068e
cm"""
$(ex(3,"Finding Partial Derivatives by Substitution"))
Find ``\partial w / \partial s`` and ``\partial w / \partial t`` for ``w=2 x y``, where ``x=s^2+t^2`` and ``y=s / t``
"""

# ╔═╡ 69abaecb-13d5-4e81-a401-567b581e8eda
cm"""
$(bth("Chain Rule: Two Independent Variables"))
Let ``w=f(x, y)``, where ``f`` is a differentiable function of ``x`` and ``y``. If ``x=g(s, t)`` and ``y=h(s, t)`` such that the first partials ``\partial x / \partial s, \partial x / \partial t, \partial y / \partial s``, and ``\partial y / \partial t`` all exist, then ``\partial w / \partial s`` and ``\partial w / \partial t`` exist and are given by
```math
\frac{\partial w}{\partial s}=\frac{\partial w}{\partial x} \frac{\partial x}{\partial s}+\frac{\partial w}{\partial y} \frac{\partial y}{\partial s}
```
and
```math
\frac{\partial w}{\partial t}=\frac{\partial w}{\partial x} \frac{\partial x}{\partial t}+\frac{\partial w}{\partial y} \frac{\partial y}{\partial t}
```
"""

# ╔═╡ ab0c80dd-8916-499d-aa3e-c01984a2c0d7
cm"""
$(ex(4,"The Chain Rule with Two Independent Variables"))
 Use the Chain Rule to find ``\partial w / \partial s`` and ``\partial w / \partial t`` for ``w=2 x y``, where ``x=s^2+t^2`` and ``y=s / t``
"""

# ╔═╡ 81fad03e-4540-460c-a149-7681a0c61fb4
cm"""
$(ex(5,"The Chain Rule for a Function of Three Variables"))
Find ``\partial w / \partial s`` and ``\partial w / \partial t`` when ``s=1`` and ``t=2 \pi`` for
```math
w=x y+y z+x z
```
where ``x=s \cos t, y=s \sin t``, and ``z=t``.
"""

# ╔═╡ 2127153a-edfd-49dc-8c45-8743629af637
md"## Implicit Partial Differentiation"

# ╔═╡ 21c9124f-ab99-4d80-b4f7-4ba8ab35c20d
cm"""
$(bth("Chain Rule: Implicit Differentiation"))
If the equation ``F(x, y)=0`` defines ``y`` implicitly as a differentiable function of ``x``, then
```math
\frac{d y}{d x}=-\frac{F_x(x, y)}{F_y(x, y)}, \quad F_y(x, y) \neq 0 .
```

If the equation ``F(x, y, z)=0`` defines ``z`` implicitly as a differentiable function of ``x`` and ``y``, then
```math
\frac{\partial z}{\partial x}=-\frac{F_x(x, y, z)}{F_z(x, y, z)} \quad \text { and } \quad \frac{\partial z}{\partial y}=-\frac{F_y(x, y, z)}{F_z(x, y, z)}, \quad F_z(x, y, z) \neq 0
```
"""

# ╔═╡ 47cdd95c-53a5-4e07-9b26-c91b3b1706d9
cm"""
$(ex(6,"Finding a Derivative Implicitly"))
Find ``d y / d x`` for
```math
y^3+y^2-5 y-x^2+4=0
```

$(ex(7,"Finding Partial Derivatives Implicitly"))
Find ``\partial z / \partial x`` and ``\partial z / \partial y`` for
```math
3 x^2 z-x^2 y^2+2 z^3+3 y z-5=0
```
"""

# ╔═╡ 7e4fb221-9750-4abd-b4f8-5b511629d7f5
md"""
# 13.6 Directional Derivatives and Gradients
> __Objectives__
> 1. Find and use directional derivatives of a function of two variables.
> 1. Find the gradient of a function of two variables.
> 1. Use the gradient of a function of two variables in applications.
> 1. Find directional derivatives and gradients of functions of three variables.
"""

# ╔═╡ e3d38fd9-0997-4286-aa2e-762c70b360d1
cm"""

$(define("Directional Derivative"))
Let ``f`` be a function of two variables ``x`` and ``y`` and let ``\mathbf{u}=\cos \theta \mathbf{i}+\sin \theta \mathbf{j}`` be a unit vector. Then the directional derivative of ``f`` in the direction of ``u``, denoted by ``D_{\mathbf{u}} f``, is
```math
D_{\mathbf{u}} f(x, y)=\lim _{t \rightarrow 0} \frac{f(x+t \cos \theta, y+t \sin \theta)-f(x, y)}{t}
```
provided this limit exists.
$(ebl())

$(bth("Directional Derivative"))
If ``f`` is a differentiable function of ``x`` and ``y``, then the directional derivative of ``f`` in the direction of the unit vector ``\mathbf{u}=\cos \theta \mathbf{i}+\sin \theta \mathbf{j}`` is
```math
D_{\mathbf{u}} f(x, y)=f_x(x, y) \cos \theta+f_y(x, y) \sin \theta
```
"""

# ╔═╡ 6aa7ee9d-263f-4768-ac9b-67d0692d0e66
cm"""
$(ex(1,"Finding a Directional Derivative"))
Find the directional derivative of
```math
f(x, y)=4-x^2-\frac{1}{4} y^2 \quad \text { Surface }
```
at ``(1,2)`` in the direction of
```math
\mathbf{u}=\left(\cos \frac{\pi}{3}\right) \mathbf{i}+\left(\sin \frac{\pi}{3}\right) \mathbf{j} . \quad \text { Direction }
```
"""

# ╔═╡ 5fe3745a-4a75-4ece-b04a-bd71f7810c6f
let
    @variables x::Real, y::Real, f(..)
    Dx = Differential(x)
    Dy = Differential(y)
    f(x, y) = 4 - x^2 - (1 // 4) * y^2
    u = Dict(x => 1, y => 2.0)
    d = [cos(π / 3); sin(π / 3)]
    fx(x, y) = Dx(f(x, y))
    fy(x, y) = Dy(f(x, y))
    Ex = fx(x, y) ~ expand_derivatives(fx(x, y))
    Ey = fy(x, y) ~ expand_derivatives(fy(x, y))
    ∇f = Symbolics.gradient(f(x, y), [x, y])
    substitute(∇f, u) ⋅ d
end

# ╔═╡ 92b3ab49-db16-4a05-8929-1dbd3362d470
cm"""
$(ex(2,"Finding a Directional Derivative"))

Find the directional derivative of
```math
f(x, y)=x^2 \sin 2 y \quad \text { Surface }
```
at ``(1, \pi / 2)`` in the direction of
```math
\mathbf{v}=3 \mathbf{i}-4 \mathbf{j}
```
"""

# ╔═╡ ddd97e19-227f-42ec-9a38-663c926adc86
let
    @variables x::Real, y::Real, f(..)
    Dx = Differential(x)
    Dy = Differential(y)
    f(x, y) = x^2 * sin(2y)
    u = Dict(x => 1, y => π / 2)
    v = [3; -4]
    d = v / norm(v)
    fx(x, y) = Dx(f(x, y))
    fy(x, y) = Dy(f(x, y))
    Ex = fx(x, y) ~ expand_derivatives(fx(x, y))
    Ey = fy(x, y) ~ expand_derivatives(fy(x, y))
    ∇f = Symbolics.gradient(f(x, y), [x, y])
    substitute(∇f, u) ⋅ d
end

# ╔═╡ 45ba9ada-2921-41d6-b9a1-e4df2963ed0b
md"## The Gradient of a Function of Two Variables"

# ╔═╡ ca36e483-976e-4bd3-87f9-4c4a5a12d91d
cm"""
$(define("Gradient of a Function of Two Variables"))
Let ``z=f(x, y)`` be a function of ``x`` and ``y`` such that ``f_x`` and ``f_y`` exist. Then the gradient of ``\boldsymbol{f}``, denoted by ``\nabla f(x, y)``, is the vector
```math
\nabla f(x, y)=f_x(x, y) \mathbf{i}+f_y(x, y) \mathbf{j}
```
(The symbol ``\nabla f`` is read as "del ``f``.") Another notation for the gradient is given by ``\operatorname{grad} f(x, y)``. In Figure 13.48 , note that for each ``(x, y)``, the gradient ``\nabla f(x, y)`` is a vector in the plane (not a vector in space).

$(ebl())

$(ex(3,"Finding the Gradient of a Function"))
Find the gradient of
```math
f(x, y)=y \ln x+x y^2
```
at the point ``(1,2)``.
"""

# ╔═╡ 31cfcab4-5d77-4f9a-abd7-0bfed85396a3
cm"""
$(bth("Alternative Form of the Directional Derivative"))
If ``f`` is a differentiable function of ``x`` and ``y``, then the directional derivative of ``f`` in the direction of the unit vector ``\mathbf{u}`` is
```math
D_{\mathbf{u}} f(x, y)=\nabla f(x, y) \cdot \mathbf{u} .
```
"""

# ╔═╡ 034acc9b-59bb-4d06-9ed6-c0d6a0101cc9
cm"""
$(ex(4,"Using ∇f(x, y) to Find a Directional Derivative"))
Find the directional derivative of ``f(x, y)=3 x^2-2 y^2`` at ``\left(-\frac{3}{4}, 0\right)`` in the direction from ``P\left(-\frac{3}{4}, 0\right)`` to ``Q(0,1)``.
"""

# ╔═╡ 4cb8757a-ab68-4a51-b11a-44a02c4ec8c5
md"##  Applications of the Gradient"

# ╔═╡ b639b1fb-4aea-495f-9580-c4d383a0a1e8
cm"""
$(bth("Properties of the Gradient"))
Let ``f`` be differentiable at the point ``(x, y)``.
1. If ``\nabla f(x, y)=\mathbf{0}``, then ``D_{\mathbf{u}} f(x, y)=0`` for all ``\mathbf{u}``.
2. The direction of maximum increase of ``f`` is given by ``\nabla f(x, y)``. The maximum value of ``D_{\mathbf{u}} f(x, y)`` is
```math
\|\nabla f(x, y)\| . \quad \color{red}{\text { Maximum value of } D_{\mathbf{u}} f(x, y)}
```
3. The direction of minimum increase of ``f`` is given by ``-\nabla f(x, y)``. The minimum value of ``D_{\mathbf{u}} f(x, y)`` is
```math
-\|\nabla f(x, y)\| . \quad \color{red}{\text { Minimum value of } D_{\mathbf{u}} f(x, y)}
```
"""

# ╔═╡ 960c605c-d254-4b2e-9d6d-0acba4121c0e
cm"""
$(ex(5,"Finding the Direction of Maximum Increase"))
The temperature in degrees Celsius on the surface of a metal plate is
```math
T(x, y)=20-4 x^2-y^2
```
where ``x`` and ``y`` are measured in centimeters. In what direction from ``(2,-3)`` does the temperature increase most rapidly? What is this rate of increase?

$(ex(6,"Finding the Path of a Heat-Seeking Particle"))
A heat-seeking particle is located at the point ``(2,-3)`` on a metal plate whose temperature at ``(x, y)`` is
```math
T(x, y)=20-4 x^2-y^2
```

Find the path of the particle as it continuously moves in the direction of maximum temperature increase.
"""

# ╔═╡ fda44fd8-0ad6-4f02-a993-791b47ebb90c
let
    # Define the function f(x, y)
    T(x, y) = 20 - 4x^2 - y^2
    ∇T(x, y) = [-8x; -y]

    # Define ranges for x and y
    # x in [-2, 2] and y in [-2, 2]
    xs = range(-3, 3, length=300)
    ys = range(-5.5, 5, length=300)
    ts = range(0.0, 10.0, length=100)
    # Compute function values over the grid.
    # Use a ternary operator to ensure that the function is evaluated only when the argument is nonnegative.
    Z = [T(x, y) for x in xs, y in ys]
    P = [2; -3]
    Q = [2; -3]
    path = map(1:1000) do i
        Q = Q + 0.01 * ∇T(Q...)
        Q
    end
    path = vcat([P], path)
    # Plot the contour lines
    contour(xs, ys, Z,
        title="Contour Plot of " * L" T(x, y) = 20 - 4x^2 - y^2",
        xlabel="x", ylabel="y", frame_style=:origin)
    scatter!([P[1]], [P[2]], label=:none, annotations=[(2.1, -2.7, L"(2,-3)", 10)])
    plot!(first.(path), last.(path), label=:none)
    scatter!([path[end][1]], [path[end][2]], label=:none)
    # T(2,-3)

end

# ╔═╡ 5b535710-51b1-470b-8f9b-18319b908d20
cm"""
$(bth("Gradient Is Normal to Level Curves"))
If ``f`` is differentiable at ``\left(x_0, y_0\right)`` and ``\nabla f\left(x_0, y_0\right) \neq \mathbf{0}``, then ``\nabla f\left(x_0, y_0\right)`` is normal to the level curve through ``\left(x_0, y_0\right)``.
$(ebl())

$(ex(7,"Finding a Normal Vector to a Level Curve"))
Sketch the level curve corresponding to ``c=0`` for the function given by
```math
f(x, y)=y-\sin x
```
and find a normal vector at several points on the curve.
"""

# ╔═╡ 9dc755ae-8dae-4fcd-969c-a4558ba1a78d
md"## Functions of Three Variables"

# ╔═╡ 2b95a8f3-ffe2-439a-b735-969c4a5ce363
cm"""
$(bbl("Directional Derivative and Gradient for Three Variables",""))
Let ``f`` be a function of ``x, y``, and ``z`` with continuous first partial derivatives. The directional derivative of ``f`` in the direction of a unit vector
```math
\mathbf{u}=a \mathbf{i}+b \mathbf{j}+c \mathbf{k}
```
is given by
```math
D_{\mathbf{u}} f(x, y, z)=a f_x(x, y, z)+b f_y(x, y, z)+c f_z(x, y, z)
```

The gradient of ``\boldsymbol{f}`` is defined as
```math
\nabla f(x, y, z)=f_x(x, y, z) \mathbf{i}+f_y(x, y, z) \mathbf{j}+f_z(x, y, z) \mathbf{k}
```

Properties of the gradient are as follows.
1. ``D_{\mathbf{u}} f(x, y, z)=\nabla f(x, y, z) \cdot \mathbf{u}``
2. If ``\nabla f(x, y, z)=\mathbf{0}``, then ``D_{\mathbf{u}} f(x, y, z)=0`` for all ``\mathbf{u}``.
3. The direction of maximum increase of ``f`` is given by ``\nabla f(x, y, z)``. The maximum value of ``D_{\mathbf{u}} f(x, y, z)`` is
```math
\|\nabla f(x, y, z)\| . \quad \quad \text { Maximum value of } D_{\mathbf{u}} f(x, y, z)
```
4. The direction of minimum increase of ``f`` is given by ``-\nabla f(x, y, z)``. The minimum value of ``D_{\mathbf{u}} f(x, y, z)`` is
```math
-\|\nabla f(x, y, z)\| . \quad \quad \text { Minimum value of } D_{\mathbf{u}} f(x, y, z)
```
$(ebl())

$(ex(8,"Finding the Gradient of a Function"))
Find ``\nabla f(x, y, z)`` for the function
```math
f(x, y, z)=x^2+y^2-4 z
```
and find the direction of maximum increase of ``f`` at the point ``(2,-1,1)``.
"""

# ╔═╡ 9ebe06f1-f95b-43ae-99dd-d4c837060b8f
md"""
# 13.7 Tangent Planes and Normal lines
> __Objectives__
> 1. Find equations of tangent planes and normal lines to surfaces.
> 1. Find the angle of inclination of a plane in space.
> 1. Compare the gradients f x, y and Fx, y, z.
"""

# ╔═╡ 71c57b83-ec10-47aa-910f-e2b5d9a65db8
md"## Tangent Plane and Normal Line to a Surface"

# ╔═╡ fdfdc211-c9c5-4695-911e-b2a767f2b228
cm"""
Consider the following __Equation of a surface ``S``__
```math
z = f(x,y)
```
Alternatively, we can see ``S`` as the level surface of a function ``F`` defined as 
```math
F(x,y,z) = f(x,y)-z
```
So ``S`` can be written as 
```math
F(x,y,z)=0
```
"""

# ╔═╡ b2b9dd54-3392-4dfd-8918-6fb29b41ff98
cm"""
$(ex(1,"Writing an Equation of a Surface"))
 For the function
```math
 F(x, y, z) = x^2 + y^2 + z^2 − 4
```
describe the level surface given by
```math
F(x, y, z) = 0.
```
"""

# ╔═╡ 67fc91d3-8058-4f2a-a903-fc667b655514
cm"""
See [Geogebra Graph](https://www.geogebra.org/classic/c6ynw7v2?embed)
"""

# ╔═╡ a2c7699c-344e-434e-a603-4cf3c4c4b67b
cm"""
$(define("Tangent Plane and Normal Line"))
Let ``F`` be differentiable at the point ``P\left(x_0, y_0, z_0\right)`` on the surface ``S`` given by ``F(x, y, z)=0`` such that
```math
\nabla F\left(x_0, y_0, z_0\right) \neq \mathbf{0}
```
1. The plane through ``P`` that is normal to ``\nabla F\left(x_0, y_0, z_0\right)`` is called the __tangent plane to ``S`` at ``P``__.
2. The line through ``P`` having the direction of ``\nabla F\left(x_0, y_0, z_0\right)`` is called the __normal line to ``S`` at ``P``__.
"""

# ╔═╡ d55584d1-6c00-4eda-b526-4663851315e9
cm"""
$(bth("Equation of Tangent Plane"))
If ``F`` is differentiable at ``\left(x_0, y_0, z_0\right)``, then an equation of the tangent plane to the surface given by ``F(x, y, z)=0`` at ``\left(x_0, y_0, z_0\right)`` is
```math
F_x\left(x_0, y_0, z_0\right)\left(x-x_0\right)+F_y\left(x_0, y_0, z_0\right)\left(y-y_0\right)+F_z\left(x_0, y_0, z_0\right)\left(z-z_0\right)=0
```
"""

# ╔═╡ ae52cc95-7cca-44cf-9742-9791a484c6fe
cm"""
$(ex(2,"Finding an Equation of a Tangent Plane"))
Find an equation of the tangent plane to the hyperboloid
```math
z^2 − 2x^2 − 2y^2 = 12
```
 at the point ``(1, −1, 4)``.
"""

# ╔═╡ 5d8c80b9-c201-4d6f-8212-9924caa88a2a
let
    F(x, y, z) = z^2 - 2x^2 - 2y^2 - 12
    dF(x, y, z) = [-4x; -4y; 2z]
    @variables x::Real, y::Real, z::Real
    Dx = Differential(x)
    Dy = Differential(y)
    Dz = Differential(z)
    P = [1; -1; 4]
    Eq = dF(P...) ⋅ ([x; y; z] - P) ~ 0
    # cm""

end

# ╔═╡ f2ad6464-e3f3-41e5-96d7-2eb72c6c4cd8
cm"""
$(ex(3,"Finding an Equation of the Tangent Plane"))
Find an equation of the tangent plane to the paraboloid
```math
z=1-\frac{1}{10}(x^2+4y^2)
```
at the point ``(1, 1, \frac{1}{2})``.
"""

# ╔═╡ 0b586670-9290-469a-a7cf-70e1654a9e86
let
    F(x, y, z) = 1 - (1 // 10) * (x^2 + 4y^2) - z
    @variables x::Real, y::Real, z::Real
    Dx = Differential(x)
    Dy = Differential(y)
    Dz = Differential(z)
    dF = expand_derivatives.([Dx(F(x, y, z)); Dy(F(x, y, z)); Dz(F(x, y, z))])
    df(t, s, u) = substitute(dF, Dict(x => t, y => s, z => u))
    P = [1; 1; 1 // 2]
    df(P...)
    Eq = expand(df(P...) ⋅ ([x; y; z] - P)) ~ 0
    # F(x,y,z)
    # cm""
    # df(x,y,z)

end

# ╔═╡ d4c38abc-7cae-4f3e-ba5f-1dc9377fbeaa
cm"""
$(ex(4,"Finding an Equation of a normal line to a Surface"))
Find a set of symmetric equations for the normal line to the surface
```math
xyz=12
```
at the point ``(2, −2, −3)``.
"""

# ╔═╡ 6c75f38d-40ab-4862-9749-7b63fcdfce29
cm"""
$(ex(5,"Finding the Equation of a Tangent line to a curve"))
Find a set of parametric equations for the tangent line to the curve of intersection of the ellipsoid
```math
 x^2+2y^2+2z^2=20 
```
and the paraboloid
```math
x^2+y^2+z=4 
```
at the point ``(0, 1, 3)``,
"""

# ╔═╡ d879263c-10a0-4cb6-8a05-7342208662ea
cm"""
See [GeoGebra Graph](https://www.geogebra.org/classic/rkhgxuag?embed)
"""

# ╔═╡ 55ddac47-88aa-40c6-8986-5ed07731f6e2
let
    F1(x, y, z) = x^2 + 2y^2 + 2z^2 - 20
    F2(x, y, z) = x^2 + y^2 + z - 4
    @variables x::Real, y::Real, z::Real, t::Real
    Dx = Differential(x)
    Dy = Differential(y)
    Dz = Differential(z)
    dF1 = expand_derivatives.([Dx(F1(x, y, z)); Dy(F1(x, y, z)); Dz(F1(x, y, z))])
    df1(t, s, u) = substitute(dF1, Dict(x => t, y => s, z => u))
    dF2 = expand_derivatives.([Dx(F2(x, y, z)); Dy(F2(x, y, z)); Dz(F2(x, y, z))])
    df2(t, s, u) = substitute(dF2, Dict(x => t, y => s, z => u))
    P = [0; 1; 3]
    g1 = df1(P...)
    g2 = df2(P...)
    n = g1 × g2

    Eq = [x; y; z] ~ P + t * n
    # cm""

end

# ╔═╡ 3fd5e38e-ab5e-40be-91f7-65fd05f60eff
md"## The Angle of Inclination of a Plane"

# ╔═╡ 55643865-1506-42a1-ae0a-9a8e20511d7c
cm"""
$(post_img("https://www.dropbox.com/scl/fi/bk9sray473m2p68840gc5/fig_13_62.png?rlkey=r32kfk81aheipc8h5gt6its5f&dl=1"))
```math
\cos \theta=\frac{|\mathbf{n} \cdot \mathbf{k}|}{\|\mathbf{n}\|\|\mathbf{k}\|}=\frac{|\mathbf{n} \cdot \mathbf{k}|}{\|\mathbf{n}\|}
```

"""

# ╔═╡ e2ebeec5-e944-4fde-8230-d431a674cb52
cm"""
$(ex(6,"Finding the Angle of Inclination of a Tangent Plane"))
Find the angle of inclination of the tangent plane to the ellipsoid
```math
\frac{x^2}{12}+\frac{y^2}{12}+\frac{z^2}{3}=1
```
at the point ``(2,2,1)``.
"""

# ╔═╡ 6d392830-65ff-4c10-83d1-20e320341735
md"## A Comparison of the Gradients ∇f(x, y) and ∇F(x, y, z)"

# ╔═╡ 6a9f17ae-f24d-492b-a540-a9f0e7424c09
cm"""
$(bth("Gradient Is Normal to Level Surfaces"))
If ``F`` is differentiable at ``\left(x_0, y_0, z_0\right)`` and
```math
\nabla F\left(x_0, y_0, z_0\right) \neq \mathbf{0}
```
then ``\nabla F\left(x_0, y_0, z_0\right)`` is normal to the level surface through ``\left(x_0, y_0, z_0\right)``.
"""

# ╔═╡ 399b4977-95ff-431d-84b1-c57865b49a48
md"""
#  13.8 Extrema of Functions of Two Variables
> __Objectives__
> 1. Find absolute and relative extrema of a function of two variables.
> 2. Use the Second Partials Test to find relative extrema of a function of two variables.
"""

# ╔═╡ 19940b6b-901c-4175-84e4-ca151dc49841
md"## Absolute Extrema and Relative Extrema"

# ╔═╡ bc58fba0-a0b2-45c7-a415-6edc6af3a315
cm"""
$(bth("Extreme Value Theorem"))
Let ``f`` be a continuous function of two variables ``x`` and ``y`` defined on a closed bounded region ``R`` in the ``x y``-plane.
1. There is at least one point in ``R`` at which ``f`` takes on a minimum value.
2. There is at least one point in ``R`` at which ``f`` takes on a maximum value.
"""

# ╔═╡ 2de29067-b788-4419-bddd-f6092e8b5307
cm"""
$(define("Relative Extrema"))
Let ``f`` be a function defined on a region ``R`` containing ``\left(x_0, y_0\right)``.
1. The function ``f`` has a relative minimum at ``\left(x_0, y_0\right)`` if
```math
f(x, y) \geq f\left(x_0, y_0\right)
```
$(add_space(10))for all ``(x, y)`` in an open disk containing ``\left(x_0, y_0\right)``.

2. The function ``f`` has a relative maximum at ``\left(x_0, y_0\right)`` if
```math
f(x, y) \leq f\left(x_0, y_0\right)
```
$(add_space(10))for all ``(x, y)`` in an open disk containing ``\left(x_0, y_0\right)``.
"""

# ╔═╡ a3ac719d-a13d-4f92-8395-8f95bd8f0ded
cm"""
$(define("Critical Point"))
Let ``f`` be defined on an open region ``R`` containing ``\left(x_0, y_0\right)``. The point ``\left(x_0, y_0\right)`` is a __critical point__ of ``f`` if one of the following is true.
1. ``f_x\left(x_0, y_0\right)=0`` and ``f_y\left(x_0, y_0\right)=0``
2. ``f_x\left(x_0, y_0\right)`` or ``f_y\left(x_0, y_0\right)`` does not exist.
"""

# ╔═╡ 1d703048-9186-4dc6-af7e-94f3f03d4f15
cm"""
$(bth("Relative Extrema Occur Only at Critical Points"))
If ``f`` has a relative extremum at ``\left(x_0, y_0\right)`` on an open region ``R``, then ``\left(x_0, y_0\right)`` is a critical point of ``f``.
"""

# ╔═╡ 28be8f50-1905-481e-ace4-ee1682f11514
cm"""
$(ex(1,"Finding a Relative Extremum"))
Determine the relative extrema of
```math
f(x, y)=2 x^2+y^2+8 x-6 y+20
```
"""

# ╔═╡ 66c8f04d-cada-4eaf-b41e-b16966735c4e
cm"""
$(ex(2,"Finding a Relative Extremum"))
Determine the relative extrema of
```math
f(x, y)=1-\left(x^2+y^2\right)^{1 / 3}
```
"""

# ╔═╡ 63ac5301-28e2-4551-bb2f-8e8ad7987a9f
md"## The Second Partials Test"

# ╔═╡ 789955de-1f40-4b07-9abf-994437e3685f
cm"""
Consider the surface ``z=y^2-x^2``
"""

# ╔═╡ dfb5b0ec-6cf3-4233-8b2d-6ef8834d6441
cm"""
[GeoGebra](https://www.geogebra.org/classic/j52tbtke?embed)
"""

# ╔═╡ 51dbf095-a024-4f99-ab90-330d4b18b8eb
cm"""
$(bth("Second Partials Test"))
Let ``f`` have continuous second partial derivatives on an open region containing a point ``(a, b)`` for which
```math
f_x(a, b)=0 \quad \text { and } \quad f_y(a, b)=0
```

To test for relative extrema of ``f``, consider the quantity
```math
d=f_{x x}(a, b) f_{y y}(a, b)-\left[f_{x y}(a, b)\right]^2
```
1. If ``d>0`` and ``f_{x x}(a, b)>0``, then ``f`` has a relative minimum at ``(a, b)``.
2. If ``d>0`` and ``f_{x x}(a, b)<0``, then ``f`` has a relative maximum at ``(a, b)``.
3. If ``d<0``, then ``(a, b, f(a, b))`` is a saddle point.
4. The test is inconclusive if ``d=0``.
"""

# ╔═╡ a0997724-2959-43c1-9fc0-3ee68f8c6b2a
cm"""
$(ex(3,"Using the Second Partials Test"))
Find the relative extrema of ``f(x, y)=-x^3+4 x y-2 y^2+1``.
"""

# ╔═╡ 19ec57cc-aecf-42f6-a337-b7f273834934
let
	f(x,y)=-x^3 + 4*x*y - 2*y^2 + 1
	P1 = [0 ; 0]
	P2 = [4//3 ; 4//3]
	fxx(x,y) = -6x
	fxy(x,y) = 4
	fyy(x,y) = -4
	d(x,y) = fxx(x,y)*fyy(x,y) - (fxy(x,y))^2
	fxx(P1...), d(P1...), fxx(P2...), d(P2...)
end

# ╔═╡ a8fc5873-2add-4061-8977-c6cd6a1d2433
cm"""
$(ex(4,"Failure of the Second Partials Test"))
Find the relative extrema of ``f(x, y)=x^2 y^2``. (See Graph [Here](https://www.desmos.com/3d/sv7uie6qrq))

$(ex(5,"Finding Absolute Extrema"))
Find the absolute extrema of the function
```math
f(x, y)=\sin x y
```
on the closed region given by
```math
0 \leq x \leq \pi \quad \text { and } \quad 0 \leq y \leq 1
```
See Graph [Here](https://www.desmos.com/3d/s8ebq9wjeq)
"""

# ╔═╡ 7d633d24-9d0a-472b-8fbe-9ce7f6a14447
md"""
# 13.9 Applications of Extrema
> __Objectives__
> 1. Solve optimization problems involving functions of several variables.

##  Applied Optimization Problems
"""

# ╔═╡ 64acf4d6-8655-44cb-b3ea-5e09b829912b
cm"""
$(ex(1,"Finding Maximum Volume"))
A rectangular box is resting on the ``x y``-plane with one vertex at the origin. The opposite vertex lies in the plane
```math
6 x+4 y+3 z=24
```
as shown below. Find the maximum volume of the box.

$(post_img("https://www.dropbox.com/scl/fi/pzs7r1nm6s7mtig8lydl4/fig_13_73.png?rlkey=7nxhtml9cmplq47x5mrpgwj8v&dl=1"))
"""

# ╔═╡ d07c578c-1386-45ce-9fec-9bf20632333c
let
    V(x, y) = x * y * (24 - 6x - 4y) / 3
    Vxx(x, y) = -4y
    Vyy(x, y) = -8x / 3
    Vxy(x, y) = (1 / 3) * (24 - 12x - 8y)
    d_Det(x) = Vxx(x...) * Vyy(x...) - (Vxy(x...))^2
    A = [0.0; 0.0]
    B = [4.0; 0.0]
    C = [0.0; 6.0]
    D = [4 // 3; 2 // 1]
    # d_Det(A) # saddale point
    # d_Det(B) # saddale point
    # d_Det(C) # saddale point
    d_Det(D), Vxx(D...) # relative max
    V(D...)

end

# ╔═╡ 1a572f06-ae70-44fa-af1f-95415a05d7be
cm"""
$(ex(2,"Finding the Maximum Profit"))
A manufacturer determines that the profit ``P`` (in dollars) obtained by producing and selling ``x`` units of Product 1 and ``y`` units of Product 2 is approximated by the model
```math
P(x, y)=8 x+10 y-(0.001)\left(x^2+x y+y^2\right)-10,000 .
```

Find the production level that produces a maximum profit. What is the maximum profit?
"""

# ╔═╡ 028284e2-e901-4c25-bdc6-cde904279799
let
    @variables x::Real, y::Real
    Dx, Dy = Differential(x), Differential(y)
    P(x, y) = 8x + 10y - (1 // 1000) * (x^2 + x * y + y^2) - 10_000
    Px = expand_derivatives(Dx(P(x, y))) ~ 0
    Py = expand_derivatives(Dy(P(x, y))) ~ 0
    Px, Py, symbolic_solve([Px,Py],[x,y]), P(2_000,4_000)
end

# ╔═╡ 11db793f-dabc-4b76-bf50-c6d40eb4d497
md"""
 # 13.10 Lagrange Multipliers
> __Objectives__
> 1. Understand the Method of Lagrange Multipliers.
> 2. Use Lagrange multipliers to solve constrained optimization problems.
> 3. Use the Method of Lagrange Multipliers with two constraints.
"""

# ╔═╡ e2afac2b-f375-49ec-a020-e934aaa104a9
md"## Lagrange Multipliers"

# ╔═╡ 6941cc03-75e1-48cb-bde1-837f8f809132
cm"""
$(bth("Lagrange's Theorem"))
Let ``f`` and ``g`` have continuous first partial derivatives such that ``f`` has an extremum at a point ``\left(x_0, y_0\right)`` on the smooth constraint curve ``g(x, y)=c``. If ``\nabla g\left(x_0, y_0\right) \neq \mathbf{0}``, then there is a real number ``\lambda`` such that
```math
\nabla f\left(x_0, y_0\right)=\lambda \nabla g\left(x_0, y_0\right)
```
"""

# ╔═╡ 9fc8e26a-c45f-41c6-bcf4-bb065fcfc70b
cm"""
$(bbl("Method of Lagrange Multipliers",""))
Let ``f`` and ``g`` satisfy the hypothesis of Lagrange's Theorem, and let ``f`` have a minimum or maximum subject to the constraint ``g(x, y)=c``. To find the minimum or maximum of ``f``, use these steps.
1. Simultaneously solve the equations ``\nabla f(x, y)=\lambda \nabla g(x, y)`` and ``g(x, y)=c`` by solving the following system of equations.
```math
\begin{aligned}
f_x(x, y) & =\lambda g_x(x, y) \\
f_y(x, y) & =\lambda g_y(x, y) \\
g(x, y) & =c
\end{aligned}
```
2. Evaluate ``f`` at each solution point obtained in the first step. The greatest value yields the maximum of ``f`` subject to the constraint ``g(x, y)=c``, and the least value yields the minimum of ``f`` subject to the constraint ``g(x, y)=c``.
"""

# ╔═╡ ff678064-7f1e-4c70-a269-980fbb16daf4
md"## Constrained Optimization Problems"

# ╔═╡ 98a8402d-0d73-4223-b565-9f1861753b25
cm"""
$(ex(1,"Using a Lagrange Multiplier with One Constraint"))
Find the maximum value of ``f(x, y)=4 x y``, where ``x>0`` and ``y>0``, subject to the constraint ``\left(x^2 / 3^2\right)+\left(y^2 / 4^2\right)=1``.
"""

# ╔═╡ 75ab0065-074b-466e-9230-228c33696a81
cm"""
$(ex(2,"A Business Application"))
The Cobb-Douglas production function (see Section 13.1) for a manufacturer is given by
```math
f(x, y)=100 x^{3 / 4} y^{1 / 4}
```

Objective function
where ``x`` represents the units of labor (at ``\$ 150`` per unit) and ``y`` represents the units of capital (at ``\$ 250`` per unit). The total cost of labor and capital is limited to ``\$ 50,000``. Find the maximum production level for this manufacturer.
"""

# ╔═╡ 75fa570d-37d4-4fe0-be67-e765b4db8a06
cm"""
$(ex(3,"Lagrange Multipliers and Three Variables"))
Find the minimum value of
```math
f(x, y, z)=2 x^2+y^2+3 z^2 \quad \text { Objective function }
```
subject to the constraint ``2 x-3 y-4 z=49``.
"""

# ╔═╡ d5863d29-8a7d-4042-b9b3-ced734168e0e
cm"""
$(ex(4,"Optimization Inside a Region"))
Find the extreme values of
```math
f(x, y)=x^2+2 y^2-2 x+3 \quad \text { Objective function }
```
subject to the constraint ``x^2+y^2 \leq 10``.
"""

# ╔═╡ 6e770f8d-b25d-4263-abc0-97dbd6d421ac
md"## The Method of Lagrange Multipliers with Two Constraints"

# ╔═╡ 5f7365cc-ee95-41f1-b402-f7953fb20535
cm"""
$(ex(5,"Optimization with Two Constraints"))
Let ``T(x, y, z)=20+2 x+2 y+z^2`` represent the temperature at each point on the sphere
```math
x^2+y^2+z^2=11 .
```

Find the extreme temperatures on the curve formed by the intersection of the plane ``x+y+z=3`` and the sphere.
"""

# ╔═╡ 9c7dcf4d-5cf7-4b5c-a3a6-cc4c5e07d1c3
let
    T(x, y, z) = 20 + 2x + 2y + z^2
    A, B = [3; -1; 1], [-1; 3; 1]
    C, D = [3 - 2 * sqrt(3); 3 - 2 * sqrt(3); 3 + 4sqrt(3)] / 3, [3 + 2 * sqrt(3); 3 + 2 * sqrt(3); 3 - 4sqrt(3)] / 3
    T(A...), T(B...)
    T(C...), T(D...) # 91/3
end

# ╔═╡ bbad76b9-34d2-4c7a-8b38-0684a92f10ed
md"""
# 14.1 Iterated Integrals and Area in the Plane
> 1. Evaluate an iterated integral.
> 2. Use an iterated integral to find the area of a plane region
"""

# ╔═╡ ee2764c9-0f99-4aea-b1ce-9ffcc9d05eef
cm"""
$(ex(1,"Integrating with Respect to <b>y</b>"))
Evaluate ``\displaystyle \int_1^x\left(2 x y+3 y^2\right) d y``.
"""

# ╔═╡ 7e075bce-e784-4a4e-abc2-dad5230eeef7
cm"""
$(ex(2,"The Integral of an Integral"))
Evaluate ``\displaystyle\int_1^2\left[\int_1^x\left(2 x y+3 y^2\right) d y\right] d x``.
"""

# ╔═╡ f8c684f5-18f1-414b-8ce1-7f654e53272d
md"## Area of a Plane Region"

# ╔═╡ 67ddb4d2-cbba-4592-ad5a-f9c609d731a8
cm"""
$(bbl("Area of a Region in the Plane",""))
1. If ``R`` is defined by ``a \leq x \leq b`` and ``g_1(x) \leq y \leq g_2(x)``, where ``g_1`` and ``g_2`` are continuous on ``[a, b]``, then the area of ``R`` is
```math
A=\int_a^b \int_{g_1(x)}^{g_2(x)} d y d x
```
$(post_img("https://www.dropbox.com/scl/fi/mutpzct04u49o9zr87y50/fig_14_2.png?rlkey=rka697r0ssbpo5kye5j8fv0x0&dl=1",400))

2. If ``R`` is defined by ``c \leq y \leq d`` and ``h_1(y) \leq x \leq h_2(y)``, where ``h_1`` and ``h_2`` are continuous on ``[c, d]``, then the area of ``R`` is
```math
A=\int_c^d \int_{h_1(y)}^{h_2(y)} d x d y
```
$(post_img("https://www.dropbox.com/scl/fi/pprmgpabyiquf3hnz1uvi/fig_14_3.png?rlkey=ru0ej4j1rx8w1jh0c7jahg6ph&dl=1",400))

"""

# ╔═╡ 79ac9331-c1c7-4f8b-889a-61c850a6a405
cm"""
$(ex(3,"The Area of a Rectangular Region"))
Use an iterated integral to represent the area of the rectangle shown below

$(post_img("https://www.dropbox.com/scl/fi/ikaofyd7gij7oggtkwsu2/fig_14_4.png?rlkey=50moht6bh0x8y5iot9om9rfmq&dl=1",300))
"""

# ╔═╡ 3442098f-2588-4169-8afb-893cd97eb812
cm"""
$(ex(4,"Finding Area by an Iterated Integral"))
Use an iterated integral to find the area of the region bounded by the graphs of
```math
f(x)=\sin x\quad \color{red}{\text{Sine curve forms upper boundary.}}
```


and
```math
g(x)=\cos x\quad \color{red}{\text{Cosine curve forms lower boundary.}}
```


between ``x=\pi / 4`` and ``x=5 \pi / 4``.
"""

# ╔═╡ c1673254-5543-4836-bb87-8a071607d2bf
cm"""
$(ex(5,"Comparing Different Orders of Integration"))
Sketch the region whose area is represented by the integral
```math
\int_0^2 \int_{y^2}^4 d x d y
```

Then find another iterated integral using the order ``d y d x`` to represent the same area and show that both integrals yield the same value.
"""

# ╔═╡ 6ef69b15-cbe3-43be-b918-1fb146dcb871
cm"""
$(ex(6,"An Area Represented by Two Iterated Integrals"))
Find the area of the region ``R`` that lies below the parabola
```math
y=4 x-x^2\quad\color{red}{\text{Parabola forms upper boundary.}}
```


above the ``x``-axis, and above the line
```math
y=-3 x+6\quad\color{red}{\text{Line and x-axis form lower boundary.}}
```


"""

# ╔═╡ 0f57e79f-d33d-4662-802c-e2a6d0ac61f4
md"""
#  14.2 Double Integrals and Volume
> 1. Use a double integral to represent the volume of a solid region and use properties of double integrals.
> 2. Evaluate a double integral as an iterated integral.
> 3. Find the average value of a function over a region.
"""

# ╔═╡ cc2dca66-af82-4a9c-9229-8fee6e12f620
md"## Double Integrals and Volume of a Solid Region"

# ╔═╡ b87bf77d-0ac4-4aa4-89f1-c35bd07b2464
cm"""
Consider the countinuous function ``f(x,y)\geq 0``
$(post_img("https://www.dropbox.com/scl/fi/d1r0zhp46g1wd480a7ih6/fig_14_8.png?rlkey=jfmg0gr1u3ytv3txz2m8vpmvt&dl=1",400))

$(post_img("https://www.dropbox.com/scl/fi/yle6j30u1k0jb6f99wei4/fig_14_9.png?rlkey=3pzli926yppsfxyklmw6jlzrg&dl=1",400))

$(post_img("https://www.dropbox.com/scl/fi/b0urecj17pzrws2bsw8as/fig_14_10.png?rlkey=o370zqxksdf6baidflsrh53z5&dl=1",400))

$(post_img("https://www.dropbox.com/scl/fi/klsbozx2cdqs91fsk4awn/fig_14_11.png?rlkey=e92k2ojdyo465h3lqck0n0h49&dl=1",400))
"""

# ╔═╡ 949a0727-3427-44b9-bca1-cb6c0be55b5a
cm"""
$(ex(1,"Approximating the Volume of a Solid"))
Approximate the volume of the solid lying between the paraboloid
```math
f(x, y)=1-\frac{1}{2} x^2-\frac{1}{2} y^2
```
and the square region ``R`` given by ``0 \leq x \leq 1,0 \leq y \leq 1``. Use a partition made up of squares whose sides have a length of ``\frac{1}{4}``.
"""

# ╔═╡ 09cfe910-5060-4b84-b885-5ce0727a65f6
let
    f(x, y) = 1 - (1 // 2) * x^2 - (1 // 2) * y^2
    n = 1000
    Δx = 1 // n
    xs = [(2i - 1) // 2n for i in 1:n]
    ys = [(2i - 1) // 2n for i in 1:n]
    ms = reshape([(x, y) for y in ys for x in xs], n, n)
    ΔA = 1 // n^2
    V = sum(((x, y),) -> f(x, y) * ΔA, ms)
    Float64(V)
end

# ╔═╡ 363b9d8b-6288-46f4-b321-bf2d28d9e7df
cm"""
$(define("Double Integral"))
If ``f`` is defined on a closed, bounded region ``R`` in the ``x y``-plane, then the double integral of ``f`` over ``R`` is
```math
\int_R \int f(x, y) d A=\lim _{\|\Delta\| \rightarrow 0} \sum_{i=1}^n f\left(x_i, y_i\right) \Delta A_i
```
provided the limit exists. If the limit exists, then ``f`` is integrable over ``R``.
"""

# ╔═╡ f80da3f2-5272-450c-a6e6-81ba4189b6b5
cm"""
$(bbl("Volume of a Solid Region",""))
If ``f`` is integrable over a plane region ``R`` and ``f(x, y) \geq 0`` for all ``(x, y)`` in ``R``, then the volume of the solid region that lies above ``R`` and below the graph of ``f`` is
```math
V=\int_R \int f(x, y) d A
```
$(ebl())

$(bth("Properties of Double Integrals"))
Let ``f`` and ``g`` be continuous over a closed, bounded plane region ``R``, and let ``c`` be a constant.
1. ``\displaystyle\iint_R c f(x, y) d A=c \int_R \int f(x, y) d A``
2. ``\displaystyle\iint_R[f(x, y) \pm g(x, y)] d A=\int_R \int f(x, y) d A \pm \int_R \int g(x, y) d A``
3. ``\displaystyle\iint_R f(x, y) d A \geq 0, \quad`` if ``f(x, y) \geq 0``
4. ``\displaystyle\iint_R \int f(x, y) d A \geq \int_R \int g(x, y) d A, \quad`` if ``f(x, y) \geq g(x, y)``
5. ``\displaystyle\iint_R f(x, y) d A=\int_{R_1} \int f(x, y) d A+\int_{R_2} \int f(x, y) d A``, where ``R`` is the union of two nonoverlapping subregions ``R_1`` and ``R_2``.
"""

# ╔═╡ c53d2dd7-a57c-4688-9682-10cd5947bf03
md"##  Evaluation of Double Integrals"

# ╔═╡ 9aaa5191-16d2-4af7-981e-697ea50f166f
cm"""
$(bth("Fubini's Theorem"))
Let ``f`` be continuous on a plane region ``R``.
1. If ``R`` is defined by ``a \leq x \leq b`` and ``g_1(x) \leq y \leq g_2(x)``, where ``g_1`` and ``g_2`` are continuous on ``[a, b]``, then
```math
\iint_R  f(x, y) d A=\int_a^b \int_{g_1(x)}^{g_2(x)} f(x, y) d y d x
```
2. If ``R`` is defined by ``c \leq y \leq d`` and ``h_1(y) \leq x \leq h_2(y)``, where ``h_1`` and ``h_2`` are continuous on ``[c, d]``, then
```math
\iint_R  f(x, y) d A=\int_c^d \int_{h_1(y)}^{h_2(y)} f(x, y) d x d y .
```
"""

# ╔═╡ 7df7019e-a9b3-4ae1-bae0-44badb94e6bf
cm"""
$(ex(2,"Eevaluating a Double Integral as an Iterated Integral"))

Evaluate
```math
\iint_R \left(1-\frac{1}{2} x^2-\frac{1}{2} y^2\right) d A
```
where ``R`` is the region given by
```math
0 \leq x \leq 1, \quad 0 \leq y \leq 1 .
```
"""

# ╔═╡ 1be798c5-b9a4-42c3-a526-8563d25eb246
cm"""
$(ex(3,"Finding Volume by a Double Integral"))
Find the volume of the solid region bounded by the paraboloid ``z=4-x^2-2 y^2`` and the ``x y``-plane seen  [here](https://www.desmos.com/3d/ine3ie6963)
"""

# ╔═╡ 5c9dc21c-b5ff-422f-9d8e-1d177efb60af
cm"""
$(ex(4,"Comparing Different Orders of Integration"))
Find the volume of the solid region bounded by the surface
```math
f(x, y)=e^{-x^2} \quad \text { Surface }
```
and the planes ``z=0, y=0, y=x``, and ``x=1``, as shown [Here](https://www.desmos.com/3d/fo6kmsxrdj).
"""

# ╔═╡ 229b3153-a41f-4acc-af89-89a7fd35a10f
cm"""
$(ex(5,"Volume of a Region Bounded by Two Surfaces"))
Find the volume of the solid region bounded above by the paraboloid
```math
z=1-x^2-y^2
```

and below by the plane
```math
z=1-y
```

"""

# ╔═╡ a09b7496-29dd-4ecd-9ce5-6e21983a1677
md"##  Average Value of a Function"

# ╔═╡ 6357795f-52f3-4832-8c27-e75f220cd1b5
cm"""
$(define("the Average Value of a Function Over a Region"))
If ``f`` is integrable over the plane region ``R``, then the average value of ``f`` over ``R`` is
```math
\text { Average value }=\frac{1}{A} \int_R \int f(x, y) d A
```
where ``A`` is the area of ``R``.
$(ebl())

$(ex(6,"Finding the Average Value of a Function"))
Find the average value of
```math
f(x, y)=\frac{1}{2} x y
```
over the plane region ``R``, where ``R`` is a rectangle with vertices
```math
(0,0),(4,0),(4,3), \quad \text { and } \quad(0,3)
```
"""

# ╔═╡ bebbd462-5a6d-4649-9105-04f511f27287
md"""
# 14.3 Change of Variables: Polar Coordinates
> 1. Write and evaluate double integrals in polar coordinates.
"""

# ╔═╡ f0349447-b967-421d-9f86-57e37e0df049
md"## Double Integrals in Polar Coordinates"

# ╔═╡ 51d70474-def8-4714-854d-2dd69caebdfa
cm"""
In Section 10.4, you learned that the polar coordinates ``(r, \theta)`` of a point are related to the rectangular coordinates ``(x, y)`` of the point as follows.
```math
\begin{aligned}
& x=r \cos \theta \quad \text { and } \quad y=r \sin \theta \\
& r^2=x^2+y^2 \quad \text { and } \quad \tan \theta=\frac{y}{x}
\end{aligned}
```

$(ex(1,"Using Polar Coordinates to Describe a Region"))
Use polar coordinates to describe each region shown below.

$(post_img("https://www.dropbox.com/scl/fi/5xqj9e61lhwbm1ukw3x1s/fig_14_23.png?rlkey=z0h0t55hzyco3dth6mvme9fac&dl=1"))
"""

# ╔═╡ e47b9235-bce9-42e1-b790-acc15042f4dc
cm"""
We consider the __polar sector__
```math
\mathbf{R}=\left\{(r,\theta): \; r_1\leq r\leq r_2, \quad \theta_1\leq \theta \leq\theta_2\right\}
```
as show here
$(post_img("https://www.dropbox.com/scl/fi/kwu956q8ee8n88pekz85q/fig_14_24.png?rlkey=dwee2k5qjnnudcdp9ambu53zf&dl=1"))

Now, we partition ``\mathbf{R}`` into small polar sectors.
$(post_img("https://www.dropbox.com/scl/fi/tithh34ltodbkhku4rc5a/fig_14_25.png?rlkey=3fa1volfpqkact18ysez9lrb0&dl=1"))

Note that 
```math
\Delta A_i = r_i \Delta r_i\Delta\theta_i
```
So, we have

```math
\int_R \int f(x, y) d A \approx \sum_{i=1}^n f\left(r_i \cos \theta_i, r_i \sin \theta_i\right) r_i \Delta r_i \Delta \theta_i
```

"""

# ╔═╡ 48b1e580-0502-497f-80e7-b6ade3129272
cm"""
$(bth("Change of Variables to Polar Form"))
Let ``R`` be a plane region consisting of all points ``(x, y)=(r \cos \theta, r \sin \theta)`` satisfying the conditions ``0 \leq g_1(\theta) \leq r \leq g_2(\theta), \alpha \leq \theta \leq \beta``, where ``0 \leq(\beta-\alpha) \leq 2 \pi``. If ``g_1`` and ``g_2`` are continuous on ``[\alpha, \beta]`` and ``f`` is continuous on ``R``, then
```math
\int_R \int_R f(x, y) d A=\int_\alpha^\beta \int_{g_1(\theta)}^{g_2(\theta)} f(r \cos \theta, r \sin \theta) r d r d \theta
```
"""

# ╔═╡ 0c2674a1-89f9-4fde-b10f-13001ce0754e
cm"""
$(ex(2,"Evaluating a Double Polar Integral"))
Let ``R`` be the annular region lying between the two circles ``x^2+y^2=1`` and ``x^2+y^2=5``. Evaluate the integral
```math
\int_R \int\left(x^2+y\right) d A
```
"""

# ╔═╡ 818d83db-9154-4e13-853a-7dd83d368773
cm"""
$(ex(3,"Change of Variables to Polar Coordinates"))
Use polar coordinates to find the volume of the solid region bounded above by the hemisphere
```math
z=\sqrt{16-x^2-y^2}\quad \color{red}{\text{Hemisphere forms upper surface.}}
```


and below by the circular region ``R`` given by
```math
x^2+y^2 \leq 4 \quad \color{red}{\text{Circular region forms lower surface.}}
```


as shown brlow.
$(post_img("https://www.dropbox.com/scl/fi/966uofohyhoxpgdvsusc0/fig_14_30.png?rlkey=20elxczfuempbiu24vyhtieyf&dl=1"))
"""

# ╔═╡ c2c834d3-c4d8-4313-b1dd-f75dc04c18d9
cm"""
$(ex(4,"Finding areas of Polar Regions"))
Find the area of the shaded region.
$(post_img("https://www.dropbox.com/scl/fi/wjg5xoy0sm4dlbez8o1n7/fig_14_31.png?rlkey=wmqflrupx0zihz2mjqgui576t&dl=1"))
"""

# ╔═╡ 059e03c2-d921-42e6-9130-13d37f9f05dc
cm"""
$(ex(5,"Integrating with Respect to θ First"))
Find the area of the region bounded above by the spiral ``r=\pi /(3 \theta)`` and below by the polar axis, between ``r=1`` and ``r=2``.
"""

# ╔═╡ b8b7c421-cc02-4143-9854-e182648c92d3
md"""
# 14.6 Triple Integrals and applications
> 1. Use a triple integral to find the volume of a solid region.
> 2. Find the center of mass and moments of inertia of a solid region.
"""

# ╔═╡ 2ebac407-bcda-4646-8ac5-19aa50cb866e
md"##  Triple Integrals"

# ╔═╡ 240b0876-7fa2-4e71-945f-0ffdd017557a
cm"""
$(post_img("https://www.dropbox.com/scl/fi/zf2wz75pe3y12w44peo14/fig_14_52.png?rlkey=7kclyjh0verzyvhr59zh0he5f&dl=1",400))
"""

# ╔═╡ 166b293f-cead-4852-b23b-7f6b699b354e
cm"""
$(define("Triple Integral"))
If ``f`` is continuous over a bounded solid region ``Q``, then the triple integral of ``f`` over ``\boldsymbol{Q}`` is defined as
```math
\iiint_Q f(x, y, z) d V=\lim _{\|\Delta\| \rightarrow 0} \sum_{i=1}^n f\left(x_i, y_i, z_i\right) \Delta V_i
```
provided the limit exists. The volume of the solid region ``Q`` is given by
```math
\text { Volume of } Q=\iiint_Q d V \text {. }
```
"""

# ╔═╡ 032054f9-1ea2-4265-b3a4-93045f23a45a
cm"""
$(bbl("Remarks",""))
Some of the properties of double integrals can be restated in terms of triple integrals.
1. ``\iint_Q \int_Q c f(x, y, z) d V=c \iiint_Q f(x, y, z) d V``
2. ``\iint_Q \int_Q[f(x, y, z) \pm g(x, y, z)] d V=\iiint_Q f(x, y, z) d V \pm \iint_Q g(x, y, z) d V``
3. ``\iiint_Q f(x, y, z) d V=\iiint_{Q_1} f(x, y, z) d V+\iiint_{Q_2} f(x, y, z) d V``
"""

# ╔═╡ f5d90c07-6292-4c14-904c-2851fee7ac1f
cm"""
$(bth("Evaluation by Iterated Integrals"))
Let ``f`` be continuous on a solid region ``Q`` defined by
```math
\begin{aligned}
& a \leq x \leq b \\
& h_1(x) \leq y \leq h_2(x) \\
& g_1(x, y) \leq z \leq g_2(x, y)
\end{aligned}
```
where ``h_1, h_2, g_1``, and ``g_2`` are continuous functions. Then,
```math
\iiint_Q f(x, y, z) d V=\int_a^b \int_{h_1(x)}^{h_2(x)} \int_{g_1(x, y)}^{g_2(x, y)} f(x, y, z) d z d y d x
```
"""

# ╔═╡ 020d8181-06fc-4b38-bb8a-990c2337d1ca
cm"""
$(ex(1,"Evaluating a Triple Iterated Integral"))

Evaluate the triple iterated integral
```math
\int_0^2 \int_0^x \int_0^{x+y} e^x(y+2 z) d z d y d x .
```
"""

# ╔═╡ 3dc9bbb0-6cf9-410a-b3d4-aa8e8859c9a9
cm"""
$(bbl("Remark","Solid Between two surfaces"))
$(post_img("https://www.dropbox.com/scl/fi/3714xtwt50zam9gs7umx5/fig_14_53.png?rlkey=wqo315ryxhasu9q90qmh7q7n6&dl=1"))
```math
\iint\left[\int_{g_1(x, y)}^{g_2(x, y)} f(x, y, z) d z\right] d y d x.
```
"""

# ╔═╡ d75ca2b2-1033-450e-b94d-49fd308c3f5e
cm"""
$(ex(2,"Using a Triple Integral to Find Volume"))

Find the volume of the ellipsoid given by ``4 x^2+4 y^2+z^2=16``.

$(post_img("https://www.dropbox.com/scl/fi/qlwwpf8803wfagzsjjpwr/fig_14_54.png?rlkey=je050lc0u42sc7ecxn3vieavn&dl=1",400))
"""

# ╔═╡ 21fb5570-c41a-4a67-a900-614b4debc7d7
cm"""
$(ex(3,"Changing the Order of Integration"))
Evaluate 
```math
\int_0^{\sqrt{\pi / 2}} \int_x^{\sqrt{\pi / 2}} \int_1^3 \sin \left(y^2\right) d z d y d x.
```
"""

# ╔═╡ 2a2e4a74-0985-4c23-8da7-1694021aa382
cm"""
$(ex(4,"Determining the Limits of Integration"))

Set up a triple integral for the volume of each solid region.
1. The region in the first octant bounded above by the cylinder ``z=1-y^2`` and lying between the vertical planes ``x+y=1`` and ``x+y=3``
2. The upper hemisphere ``z=\sqrt{1-x^2-y^2}``
3. The region bounded below by the paraboloid ``z=x^2+y^2`` and above by the sphere ``x^2+y^2+z^2=6``
"""

# ╔═╡ 2443239f-6d9b-41e1-ae93-f30e784a5073
md"""
# 11.7 Cylindrical and Spherical Coordinates
# 14.7 Triple Integrals in Other Coordinates
> 1. Use cylindrical coordinates to represent surfaces in space.
> 2. Write and evaluate a triple integral in cylindrical coordinates.
> 2. Use spherical coordinates to represent surfaces in space.
> 4. Write and evaluate a triple integral in spherical coordinates.
"""

# ╔═╡ 301c9794-a8a2-4186-84c9-554de27bded3
md"## Cylindrical Coordinates"

# ╔═╡ 0a13199e-f144-4d4e-af7e-1959da3fcac6
cm"""
$(bbl("The Cylindrical Coordinate System",""))
In a __cylindrical coordinate system__, a point ``P`` in space is represented by an ordered triple ``(r, \theta, z)``.
1. ``(r, \theta)`` is a polar representation of the projection of ``P`` in the ``x y``-plane.
2. ``z`` is the directed distance from ``(r, \theta)`` to ``P``.
"""

# ╔═╡ cb1ce385-d5e7-464f-a551-dd024d016d29
cm"""
__Cylindrical to rectangular:__
```math
x=r \cos \theta, \quad y=r \sin \theta, \quad z=z
```

__Rectangular to cylindrical:__
```math
r^2=x^2+y^2, \quad \tan \theta=\frac{y}{x}, \quad z=z
```
"""

# ╔═╡ 009747f2-3aa5-4f64-87e3-31939c20b249
cm"""
$(ex(1,"Cylindrical-to-Rectangular Conversion"))
Convert the point ``(r, \theta, z)=(4,5 \pi / 6,3)`` to rectangular coordinates.
"""

# ╔═╡ f69c98fb-bd73-4c5e-a904-06b7f8920324
cm"""
$(ex(2,"Rectangular-to-Cylindrical Conversion"))

Convert the point
```math
(x, y, z)=(1, \sqrt{3}, 2)
```
to cylindrical coordinates.
"""

# ╔═╡ 7100ef5a-919e-4a8e-9857-40e3d70d1a6e
cm"""
$(ex(3," Rectangular-to-Cylindrical Conversion"))
Find an equation in cylindrical coordinates for the surface represented by each rectangular equation.
- a. ``x^2+y^2=4 z^2``
- b. ``y^2=x``
"""

# ╔═╡ 02132858-b6fa-4ce3-9326-0614b60499d6
cm"""
$(ex(4,"Cylindrical-to-Rectangular Conversion"))
Find an equation in rectangular coordinates for the surface represented by the cylindrical equation
```math
r^2 \cos 2 \theta+z^2+1=0
```
"""

# ╔═╡ c645824c-141c-4236-bf42-d06a9115475c
md"##  Triple Integrals in Cylindrical Coordinates"

# ╔═╡ 7f09eabc-f74d-4a56-9041-30d439012138
cm"""
```math
\displaystyle\iiint_Q f(x, y, z) d V=\int_{\theta_1}^{\theta_2} \int_{g_1(\theta)}^{g_2(\theta)} \int_{h_1(r \cos \theta, r \sin \theta)}^{h_2(r \cos \theta, r \sin \theta)} f(r \cos \theta, r \sin \theta, z) r d z d r d \theta
```
"""

# ╔═╡ c435d1c0-08c6-4fb3-b0a9-d8aaa738ddfe
cm"""
$(ex(1,"Finding Volume in Cylindrical Coordinates"))
Find the volume of the solid region ``Q`` cut from the sphere ``x^2+y^2+z^2=4`` by the cylinder ``r=2 \sin \theta``, as shown below
$(post_img("https://www.dropbox.com/scl/fi/2f38nlmz7q709en50hlcm/fig_14_65.png?rlkey=vzl7tqupj13l4e93d2cdmr3a6&dl=1"))
"""

# ╔═╡ 3d13b289-1bc6-4c79-b60d-abbbc6172cc2
md"##  Spherical Coordinates"

# ╔═╡ e02e7c74-0245-411f-a33e-43c101996220
cm"""
$(bbl("The Spherical Coordinate System",""))
In a __spherical coordinate system__, a point ``P`` in space is represented by an ordered triple ``(\rho, \theta, \phi)``, where ``\rho`` is the lowercase Greek letter rho and ``\phi`` is the lowercase Greek letter phi.
1. ``\rho`` is the distance between ``P`` and the origin, ``\rho \geq 0``.
2. ``\theta`` is the same angle used in cylindrical coordinates for ``r \geq 0``.
3. ``\phi`` is the angle between the positive ``z``-axis and the line segment ``\overrightarrow{O P}``, ``0 \leq \phi \leq \pi``.
Note that the first and third coordinates, ``\rho`` and ``\phi``, are nonnegative.
"""

# ╔═╡ 8cb2f20f-68f2-4ba5-aa85-3fb3ca295cb6
cm"""
$(post_img("https://www.dropbox.com/scl/fi/nni9wg47ehex96kyrhx0x/fig_11_75.png?rlkey=j0yb2brh26jk94g3xoxja57ho&dl=1",400))
"""

# ╔═╡ 1f939754-d4cd-4ca2-8086-fd8d1c3b3f79
cm"""

__Spherical to rectangular:__
```math
x=\rho \sin \phi \cos \theta, \quad y=\rho \sin \phi \sin \theta, \quad z=\rho \cos \phi
```

__Rectangular to spherical:__
```math
\rho^2=x^2+y^2+z^2, \quad \tan \theta=\frac{y}{x}, \quad \phi=\arccos \frac{z}{\sqrt{x^2+y^2+z^2}}
```

To change coordinates between the cylindrical and spherical systems, use the conversion guidelines listed below.

__Spherical to cylindrical ``(r \geq 0)`` :__
```math
r^2=\rho^2 \sin ^2 \phi, \quad \theta=\theta, \quad z=\rho \cos \phi
```

__Cylindrical to spherical ``(r \geq 0)`` :__
```math
\rho=\sqrt{r^2+z^2}, \quad \theta=\theta, \quad \phi=\arccos \frac{z}{\sqrt{r^2+z^2}}
```
"""

# ╔═╡ 1ce44bf4-60d4-4607-95cd-b76f931ed594
cm"""
$(ex(5,"Rectangular-to-Spherical Conversion"))

Find an equation in spherical coordinates for the surface represented by each rectangular equation.
- a. Cone: ``x^2+y^2=z^2``
- b. Sphere: ``x^2+y^2+z^2-4 z=0``
"""

# ╔═╡ e0fa4607-ec15-4751-98db-a8feb04ad558
md"##  Triple Integrals in Spherical Coordinates"

# ╔═╡ ffb2974d-ef66-4397-8fb7-67ef9c5a53ec
cm"""
```math
\iiint_Q f(x, y, z) d V=\int_{\theta_1}^{\theta_2} \int_{\phi_1}^{\phi_2} \int_{\rho_1}^{\rho_2} f(\rho \sin \phi \cos \theta, \rho \sin \phi \sin \theta, \rho \cos \phi) \rho^2 \sin \phi d \rho d \phi d \theta
```
"""

# ╔═╡ 39985a71-8ca8-4892-997a-844fe137dd57
cm"""
$(ex(4,"Finding Volume in Spherical Coordinates"))

Find the volume of the solid region ``Q`` bounded below by the upper nappe of the cone ``z^2=x^2+y^2`` and above by the sphere ``x^2+y^2+z^2=9``, as shown below

$(post_img("https://www.dropbox.com/scl/fi/gaca3jrotv5nxb099eotx/fig_14_70.png?rlkey=oe8rdmtcdwgahcpyt6j9bmawe&dl=1",400))
"""

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

# ╔═╡ c7a8937d-6d27-41c3-ac54-8d59db9c8937
begin
    text_book = post_img("https://www.dropbox.com/scl/fi/upln00gqvnbdy7whr23pj/larson_book.jpg?rlkey=wlkgmzw2ernadd9b8v8qwu2jd&dl=1", 200)
    md""" # Syllabus
    ## Syallbus
    See here [Term 251 - MATH201 - Syllabus](https://math.kfupm.edu.sa/docs/default-source/default-document-library/math201-251.pdf)
    ## Textbook
    __Textbook: Edwards, C. H., Penney, D. E., and Calvis, D. T., Differential Equations and Linear Algebra, Fourth edition, Pearson, 2021__
    $text_book

    ## Office Hours
    I strongly encourage all students to make use of my office hours. These dedicated times are a valuable opportunity for you to ask questions, seek clarification on lecture material, discuss challenging problems, and get personalized feedback on your work. Engaging with me during office hours can greatly enhance your understanding of the course content and improve your performance. Whether you're struggling with a specific concept or simply want to delve deeper into the subject, I am here to support your learning journey. Don't hesitate to drop by; __your success is my priority__.

    | Day       | Time        |
    |-----------|-------------|
    | Sunday    | 01:00-01:50PM |
    | Tuesday | 01:00-01:50PM |
    | Thursday | 01:00-01:50PM |
    Also you can ask for an online meeting through __TEAMS__.
    """
end

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
# ╟─15a0e2e8-382e-487a-a297-12feaaab6f91
# ╟─948e5b3a-40a2-4081-85f8-12c42837ae3a
# ╟─b05fcc39-dad9-4bdf-874e-6dedf75fe36c
# ╟─577dbd65-1377-4dd1-bb8f-52e4202ae745
# ╟─cab568b8-a82e-4886-8988-7766297153c6
# ╟─b8d18b8b-43e7-4ce8-8942-d01454614f3d
# ╟─66b48d42-742f-49f9-8e97-684f2d790b32
# ╟─6f2b9ee3-1579-4685-9b2d-c7fa7b07a828
# ╟─efb426c5-ac63-4360-86e4-b579b847b69a
# ╟─0d8c28f3-b885-4b16-95ef-99708a6bb179
# ╟─98951c5f-438a-4b27-b0b1-5aef88c6bfab
# ╟─d1029e12-aacd-49bf-aebf-ded4a3a31ca6
# ╠═080c8917-6a7f-46ab-9ce7-4a19d2062375
# ╟─46cb1033-5bdc-4978-a8b8-3caf5da336b9
# ╠═ebc1271e-0fcf-47bc-bf74-850b1d2ed425
# ╟─96b650e7-d4ce-478f-878f-d9cd6d10f2b6
# ╟─b64864dc-953d-41c5-bae6-5ede6734c8af
# ╟─76ace408-0ae7-458e-9b0a-cc6c3a314cd2
# ╟─c9e03dab-763a-4ddf-aa8f-36c1f85143a4
# ╟─2861e7e5-c7d4-4764-a52e-9422fff637b5
# ╟─92b10e3c-8187-4785-a4bb-b724eb120476
# ╟─3e357741-353d-4aca-9110-a96208c7f60c
# ╟─a0adc254-80b7-4ef3-a880-e864851f937a
# ╟─29c142be-48e3-488f-b8fb-3b9c34de64b0
# ╟─698c533c-4bca-44ae-ab4b-68a107e1db2a
# ╟─48467e30-614d-4ab9-852d-6e7f19bd2a3b
# ╟─3ff7e63b-0e3f-4933-a58a-b538f0bd4307
# ╟─567cc54f-b6ed-4934-8f6c-c843f722bb98
# ╟─d6ccee4f-40be-429b-860e-f53067077a14
# ╟─c65a1abc-85c1-44a1-bce1-adddb8d8781c
# ╟─b2c1aaf8-c0e8-4ff2-a32c-69e797063a16
# ╟─66c7ab95-a158-418d-a276-84042e882aa0
# ╠═46c3a799-1982-419c-9254-9604ad95c926
# ╟─13beada8-dd59-4252-a730-aedb5c6c09e6
# ╟─b4223dd0-faaa-4508-813f-0a9babbcdc09
# ╟─5f6b7fce-fbc0-4464-a0cc-9fa179937ebb
# ╟─ae5f7e4b-9f4f-4066-9595-3ec65257b4f9
# ╟─0d9600d8-087d-4900-bcb2-c81a745bb131
# ╟─e5df9962-b908-4219-bfaf-7be799b8c8a8
# ╟─fc8794db-0fa4-4641-865d-34a199d843c0
# ╟─cb4b3d81-67c9-4012-ae28-04247ddd9125
# ╟─c0d4716c-fd9c-4a11-8c0c-f5ccb0dd7217
# ╟─3b1c8db6-6db2-4bf5-a107-366e3d3c53d5
# ╟─b5699352-1bca-4040-bbd9-2bc64085460c
# ╟─26479599-3609-4814-9750-3406df4fba1f
# ╟─4564edd1-7611-45b1-8f4c-26088d4c6d97
# ╟─c86f3735-7430-4216-a8e8-d018c844142e
# ╟─6fbc1529-ed21-4e53-91de-a026a9a4ee26
# ╟─602ac6a2-80a3-445c-abc2-bc5b01e44d7b
# ╟─e1e067d5-5416-4d8e-be65-5c52ae95b24b
# ╟─6f5ea5bc-0e8e-4c4e-893a-3266e5ecbe47
# ╟─003f7d8c-b316-4a2b-8170-ff148ccb9f50
# ╟─2abd04ed-edf8-4bf0-bebf-e9c299927551
# ╠═5b7101e1-7f13-4825-8e0e-a9725e0e0438
# ╟─31b384d2-9194-4ddd-8b6c-d1a137692dbc
# ╟─e303f5bf-f37e-4cb8-abe9-5d4891f08e77
# ╟─a2b14cca-72f5-4e27-b198-a7b3deb9893a
# ╟─35429393-e411-4ac8-9719-c90523ade5ea
# ╟─2bc60f92-4577-4866-9344-d7f0b397c637
# ╟─c3b0bf91-fdf0-4a2b-8309-3728c64421e4
# ╟─3722b027-a69b-4646-bf4d-c8ebe1cb27ea
# ╟─fae0a60d-8bb5-4be4-a22f-01a951804800
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
# ╟─770456f6-fe19-4aec-86d2-482834cc419f
# ╟─8ba3bd5c-8b24-4c42-8c59-af5cd88305e6
# ╟─2e4f2876-a92d-4b3d-a473-ef12341baacc
# ╟─782bd8fb-e3c7-471a-9bce-668d45b911af
# ╟─ca18659d-269d-4fc6-9872-26946aca3a2e
# ╟─04b58a60-31a9-4d68-b496-5ff73bb9a864
# ╟─8ad44287-5a21-477b-b0fd-0d710440dc25
# ╟─ba8dc58b-5c37-4713-9bef-930c735850bf
# ╟─c970ee3e-53ae-4914-84a1-91091fc9bac8
# ╟─0ce9a97b-dab5-4b5b-829d-f03fb823b3d3
# ╟─004e5898-ebff-4e99-a515-a90a09d347ac
# ╟─b9fce471-306a-4ba2-9a99-fcb7e14deac7
# ╟─1c4d70e7-f245-4963-bd97-f0773f9d6588
# ╟─0a923d1b-4f8a-4622-a418-0e989e4648b9
# ╟─1785a7a4-ba84-42f8-863c-747b9ec9cd50
# ╟─b6845b47-9f90-4a4b-b439-6eeeb7d9519e
# ╟─9c69eac1-148d-4b24-8962-4ab3922bf606
# ╟─208b862e-da48-4a79-aaee-2df466adfa17
# ╟─6c418467-c0c2-4dc4-ae7d-97f7ffc88888
# ╟─5ce29b80-bb95-40db-a3c7-4c3d5c94ba0d
# ╟─1e084154-e54f-455d-8bd4-12870c25990d
# ╟─2b149b3a-deab-40d5-8f8b-32b7531a7165
# ╟─8e3fcc38-1f61-4937-affb-82045e4cfaf9
# ╟─6b72dabd-148c-46aa-8e5d-2bd1f19fde10
# ╟─f9b08784-8a16-432e-8012-d5f84e2c97a0
# ╟─1c8cad4e-4bca-4425-9c47-b074e052d582
# ╟─c23c83d4-4d34-44c7-8dee-f2aa824eda44
# ╟─2cfa4e94-e5ff-4eea-a9fb-6db2cf51cf25
# ╟─9f218dbe-4296-4b33-87c1-20ffa7ce4a4f
# ╟─a6f3a648-a960-414b-8bca-e52ec129881c
# ╟─571a0a6a-b0f2-4899-9b22-4e7948f358e2
# ╟─6419f344-a1b3-4d60-8f27-8469a6e6b022
# ╟─f6836f13-5370-4ac3-813a-50fc012bfcab
# ╟─94194246-ad29-43d1-9925-126fe9e5e696
# ╠═e3363ab4-1543-421f-a68c-cb1685a2f06a
# ╟─2c4b3a89-8257-48fa-8e3a-30f059e0187d
# ╠═734ef678-1329-4d59-8753-0797b6a675c7
# ╟─0a7b91d0-5ca6-4006-9b59-f9e077a8c3db
# ╟─7bb3abcb-525c-45a4-9989-74c42fee5fe2
# ╟─574ab398-71d0-4427-86dc-fd99482feffc
# ╟─7e3feecd-7106-4591-b22a-97a7aa064b6c
# ╟─108475eb-bae3-426d-88db-f0f5dc177c65
# ╟─75e95211-2367-49ed-a1fd-f0ae39870f04
# ╟─847f0197-beab-45d7-ae4c-27385719aeb1
# ╟─b9f88efe-fb3f-466e-93f8-a9a99eb30a2e
# ╟─8fd1741d-62d4-4a07-8d2c-7ca7f9d41da9
# ╟─1a2c15f9-af65-4fe5-b517-98d26a3998fd
# ╟─554f972f-8c43-4b67-845a-5f7e85cabfda
# ╟─ce3fdcff-d13d-4224-b394-ae73ca08d7b7
# ╟─e4d12bd7-039a-42a8-b278-05a5e8fe0841
# ╟─79d33f0f-6b03-420f-a0c1-98108e43ab6b
# ╟─ebbfa978-69b9-4a06-8747-792cb04992eb
# ╟─66eb4dd6-f558-479a-b193-8e852c345721
# ╟─4fc2f92f-3773-4e53-82c6-c4e441f164b3
# ╟─788ea369-4509-4970-9a2d-ea887194b790
# ╟─de23e5af-1d2d-4b22-9743-dd59bc903a9c
# ╠═4fe2dba9-e764-4f30-a41a-75da08728858
# ╟─bc67920c-1bee-4fcc-8469-adf01e1d33e8
# ╟─70ffdb35-aba3-4b8a-834c-f3e996e5c278
# ╟─bf3af1b5-3959-447f-85ac-b2b0b1ab737f
# ╟─eca05d58-1cab-444f-ae15-df4e3177323f
# ╟─c925f9ff-245f-4d0a-b085-b703adc1daaf
# ╠═c27df0f0-d524-4193-8188-271ea5779d04
# ╟─1b9821e9-f325-475a-ba9c-70a889a5504c
# ╟─c1dee7b3-6118-493e-9c9a-4629cd2af8c3
# ╟─8bb57498-9a49-4b45-8d82-fb790465b1ae
# ╟─aac34993-c94d-4fa1-8f45-e249740c914d
# ╟─3eded575-d9c4-424e-8151-3958dababb38
# ╠═29a43516-0209-4a2e-930b-0157237c981f
# ╟─97b10d17-61c1-494b-aefe-131a436e374e
# ╟─ca13f691-7ec8-4293-b271-8c197b2e0ccf
# ╟─b1c3ec5b-003d-42ab-8c6b-806e083a2047
# ╟─99b860bf-9374-4e00-8a92-822af52d403f
# ╟─d49cf3fa-c325-4efd-9ee5-f27eafa6e2bf
# ╟─495c292f-fbcb-4420-93a3-fbcd6a34d17a
# ╟─cce4a136-a23c-45c8-a3e4-78f744cc2836
# ╟─1b792a4f-e23e-441d-9f6c-a64465505e2b
# ╟─a58b8141-f330-46d8-82d2-b4caa5417887
# ╟─771e9a89-d4eb-421b-a19f-a64810766812
# ╟─1b1f9a05-1792-4004-a1e1-e8b71a1925e9
# ╟─1b3fb3c8-c5fb-4a33-9630-211e4e29dc87
# ╟─3018f183-3db6-48e5-90fa-f0ff37d8f216
# ╟─5121dfa0-5f6a-453a-9795-dddc8d6bdbfb
# ╟─e0ffce55-f749-439e-8399-7d67cf7ef0c9
# ╟─b18adead-c917-450c-9a3c-7253d6d91442
# ╟─79735eb1-16e1-4cf3-a43a-88d1ade37279
# ╟─f85ad3e4-f7ba-4563-b548-ceb803d13d2c
# ╟─1fb44f1d-547e-4bea-b7ad-f171ebed5b20
# ╠═4fb037ae-7f8e-40a7-9988-26da22529d2e
# ╟─948bbe03-1560-4b79-904f-133256b6423f
# ╠═12d1fa2a-9a6c-4edc-821e-2f54b4da454e
# ╟─bb8ca18e-ecba-40e0-b1c9-caf920ff7586
# ╟─d6fc1ea1-f463-46a5-94e6-9a4e6f914fc8
# ╟─f9621820-d9f7-41dc-bb7c-185d3cbbf8f4
# ╟─6f42f537-305f-4e0a-b593-5071e1d7af7b
# ╟─30596df7-5297-4369-ae8c-1970df3da531
# ╟─183998e1-735f-4c38-ae61-7f2471fa1ae5
# ╟─ece4c6d9-8393-43c9-b60d-93df66a95999
# ╟─8b67f393-e954-4b33-9cc9-c382d7a41b37
# ╠═b35ca1c3-621d-40af-afb7-a96b6fae35a8
# ╟─4d59ce5f-85f1-4d35-8fdb-e6b3f9040eb5
# ╟─b1a879f4-3d78-4309-9f4f-117bcb0765da
# ╟─c9fdf367-035b-4716-9f45-e62d82ec8a6e
# ╟─07ffeef2-9434-49d5-b77b-072c00a80d76
# ╟─b3cc1aa3-6360-4f59-9a30-ac5e44f133bc
# ╟─0e941631-0e52-4dc3-bdf1-056f36e77499
# ╟─ca27664a-8f75-4131-9d61-044ea96979de
# ╟─44dcb641-81a8-429a-b0eb-e85ffa0ea3ff
# ╟─23a92df7-77d9-4804-86a5-08cdfea8651c
# ╟─391ff8aa-056a-4867-90db-3d9f4537fe80
# ╟─8e46e68e-0099-430b-864e-683b14ed2fbd
# ╟─71a93732-10ff-480f-aacf-6ea729d636b9
# ╠═1809ee14-dd65-40f4-8efa-92554a5398ea
# ╟─902fbee4-194f-499d-9e9d-ad7bfb08131e
# ╟─772af978-5d7d-467d-bfc5-98dcf5bdd872
# ╟─6e53795f-016a-4113-ae5d-5dc2a02758a7
# ╟─21b654c3-e9e3-4277-914d-32c81dc86604
# ╠═d041d81f-b61f-4dfe-9fc0-472cef882098
# ╟─99fddbde-28de-4a43-977b-a8d9559fe997
# ╟─7ebe69ae-4d5a-4f4f-a114-15dc3ddd6876
# ╟─5c0b0103-d1b8-46e6-8ef3-a65da4dc2db2
# ╟─9c4292c7-f292-4fc8-9bfd-45ad4b4ccce5
# ╠═1b6deda2-a68d-4684-8741-275628b24ecf
# ╟─1aca8a3e-feb4-4665-a059-8a0c2171198a
# ╟─bea8fbd0-1ac1-43fd-aeba-6eb968e548e1
# ╠═7932b9ab-1041-44ee-8e31-f10870a58d90
# ╟─b829aed8-9618-44ea-9a2d-2c5d36416e62
# ╠═8934159d-2dc6-4e4d-a5c4-2125831e0c52
# ╟─2407b715-09cd-4568-bf81-4b9f5cf4065e
# ╟─037e8495-26d6-45d9-a855-4d1c88917561
# ╟─5e96be6d-4801-4056-ae2c-0b1b95307ac4
# ╟─eacf6145-a437-45e9-8eee-fb587077be60
# ╠═8143a2ac-b6dc-42b3-95a7-79006bc8916c
# ╟─b1f8da27-e3d9-4253-b481-071b5722d1a1
# ╟─cfbda53f-da9b-422b-b888-28f6acb96ee0
# ╟─203ef45b-a6c3-4d04-a773-43ee348eaabd
# ╟─fcb7503a-7145-44ce-9354-80631b966912
# ╟─3bae6577-7e58-4423-a954-e40eceeceab8
# ╟─f91da06c-b2ed-4b31-9fa6-af1e79c2167a
# ╟─8054a733-294a-49f6-881c-938c0e032484
# ╟─58d41760-0c3d-4512-9829-7553ba5cc8a1
# ╟─11ce75b3-0867-441d-958d-1ff5ed3d9eaf
# ╟─2fa97dda-c94d-4dae-bde8-aff4b9e2ca7e
# ╟─d936afce-e80d-49c9-9e55-cd4432c6e392
# ╟─bd9cb96f-ab81-4bb8-82a8-56577a0412a6
# ╟─ba23c565-f547-4df9-9027-d623bacf8fa6
# ╟─0c5c4f1e-2145-4333-bed0-9b1d53c665db
# ╟─0658ce85-2ae3-4595-9105-5a2a187a1d73
# ╟─441227fb-8b43-402e-a3ec-976c3fcd266f
# ╟─a7e74141-12a3-43c5-81d6-887df215d3c4
# ╟─46462c56-05b0-4efb-aa16-54672b0bf1d4
# ╟─6a6ff203-3789-4a1a-8c62-e9628239e0c4
# ╟─8f59471c-fd22-4337-ae80-088b2fb84bf4
# ╟─e65f9504-8096-4d04-add3-b000929fea8d
# ╟─b0312347-074e-4d02-9541-827625366a1f
# ╟─0980c680-12bf-45bb-8b51-9af548d75809
# ╟─e33d3119-d369-48b1-b298-d381d0f56539
# ╟─abe05e1f-f4de-4ff3-ae24-baca1163e808
# ╟─48130cd8-69ad-4b14-b4a5-84aeb560aae0
# ╟─52ef6ea9-888c-48b3-a2d4-5ca86c5e6b1b
# ╟─fa71c9a5-1d30-49e3-930e-757c681e5028
# ╟─7222448d-c176-4441-bb0d-46203177d93a
# ╟─62e49e96-01b0-447a-a742-9b8491b35fcc
# ╟─1e13cf69-7303-4086-90b9-fe2232a08327
# ╟─959ca089-7ed7-44aa-b4a1-9321cf1d2ce4
# ╟─1915cc7d-1d34-480e-a413-fcd64b4e76bf
# ╟─9779271b-19cf-4034-9901-0983454edef1
# ╟─837b01a0-948d-472f-b17c-c9763f2e5f0e
# ╟─c5270de3-1db9-4dbb-87e5-0e9f18ea34b2
# ╟─e125198b-ea6e-4703-8b0b-8ec2b191fc39
# ╟─04442eaa-9336-4ebd-865b-7e1fdbe4b8bc
# ╟─4b19a3ac-1f97-40e3-a8ff-cd57a3f14fdc
# ╟─d8fc27f5-de91-4bc3-83b5-c48ae17acf97
# ╟─3f146078-120b-4f4a-bf9b-392ef6afb5c4
# ╟─69528b92-41b9-4a90-a809-dfd86c3feb04
# ╟─85b9bece-47e3-4de1-b21c-650b8b841e0d
# ╟─c982e7a9-9563-4ad6-8bde-2baa9c538650
# ╟─450ae414-927f-4497-8a05-0a1c0f7290b6
# ╟─39226cb1-d58a-4bac-8d2c-dfa0b916aada
# ╟─b15b1448-9b88-4b70-91ad-0d00d8e9aeb0
# ╟─f5e000db-7586-47b9-a673-1829f8e47fd7
# ╟─2cc5584a-586a-4ae7-bfc3-71ff77fbf3d9
# ╟─7a1c7ca9-659d-4f66-ab27-21a02201e60d
# ╟─4ed53690-acca-4128-90ee-d935afc71e7c
# ╟─baa0d2e0-ac0d-4371-803e-9cc22d016af7
# ╟─ae48b156-e2e5-43e1-bd8d-ab995cc393a0
# ╟─4bf026b7-7a1c-4134-a4b1-4c8a9069a73d
# ╟─64acd27c-8af7-4051-b018-2f8dd0615b34
# ╟─0cd9a65d-1d2b-42a4-85b6-a5c2541889d8
# ╟─853380dd-f790-4462-bcec-e0744274dc2e
# ╟─256acb74-41ef-4352-b14a-f74a9a723deb
# ╟─4b5c59b6-7670-482c-a4de-795530e38b75
# ╟─235057bb-ea29-4b9a-8665-f750cde0d002
# ╟─a57476c4-7f42-40aa-a453-b7b29e7b9f7d
# ╟─068a3704-aa26-47ea-8f4a-ed4aacbb1985
# ╟─b64466d6-b4fb-408b-99e4-9ff0ed7bf95a
# ╟─17cb54f7-f893-47b1-b089-d6f0e5fe6c0c
# ╟─ebabd01a-2a02-4a8c-9f01-23b347a9f6a7
# ╟─14852a74-f0a5-41c7-a9ef-d110a4bd8807
# ╟─a54bcc59-6b84-4553-878f-4a4abfd6e9d6
# ╟─fdbca96e-0f9c-4edb-8f60-cb53c1dad95e
# ╟─9fe522bd-dfdb-4d65-a8d1-3d2d4618e4f7
# ╟─de197844-f3d6-469c-b41c-995d5ba542ca
# ╟─957e0ca3-72b6-4687-a7c5-69b6da416f5b
# ╟─d859bc8d-fce7-4eb6-9e0a-12750dc76275
# ╟─e08331c1-1e6c-48be-a570-e33a908d830f
# ╟─d444124f-7afa-4de4-bdcd-f9667f3e9732
# ╠═e53f41aa-45cd-488a-9123-7dfa22ec3ef7
# ╟─cc9031ef-476d-498b-8850-2b355125f98a
# ╟─108a234a-2272-4971-b762-f7f665133955
# ╟─3de8b2fd-5d34-4a02-b821-a969b439e571
# ╟─d850bcda-5bf4-4db6-b920-ca87514bfbc6
# ╠═527952f0-6be5-4be3-9676-3eb063188706
# ╟─d8943cd3-6930-4447-a5a0-6c6cf8797e81
# ╟─47fe0a92-3fb5-4a1b-9618-87eec99c068e
# ╟─69abaecb-13d5-4e81-a401-567b581e8eda
# ╟─ab0c80dd-8916-499d-aa3e-c01984a2c0d7
# ╟─81fad03e-4540-460c-a149-7681a0c61fb4
# ╟─2127153a-edfd-49dc-8c45-8743629af637
# ╟─21c9124f-ab99-4d80-b4f7-4ba8ab35c20d
# ╟─47cdd95c-53a5-4e07-9b26-c91b3b1706d9
# ╟─7e4fb221-9750-4abd-b4f8-5b511629d7f5
# ╟─e3d38fd9-0997-4286-aa2e-762c70b360d1
# ╟─6aa7ee9d-263f-4768-ac9b-67d0692d0e66
# ╠═5fe3745a-4a75-4ece-b04a-bd71f7810c6f
# ╟─92b3ab49-db16-4a05-8929-1dbd3362d470
# ╟─ddd97e19-227f-42ec-9a38-663c926adc86
# ╟─45ba9ada-2921-41d6-b9a1-e4df2963ed0b
# ╟─ca36e483-976e-4bd3-87f9-4c4a5a12d91d
# ╟─31cfcab4-5d77-4f9a-abd7-0bfed85396a3
# ╟─034acc9b-59bb-4d06-9ed6-c0d6a0101cc9
# ╟─4cb8757a-ab68-4a51-b11a-44a02c4ec8c5
# ╟─b639b1fb-4aea-495f-9580-c4d383a0a1e8
# ╟─960c605c-d254-4b2e-9d6d-0acba4121c0e
# ╠═fda44fd8-0ad6-4f02-a993-791b47ebb90c
# ╟─5b535710-51b1-470b-8f9b-18319b908d20
# ╟─9dc755ae-8dae-4fcd-969c-a4558ba1a78d
# ╟─2b95a8f3-ffe2-439a-b735-969c4a5ce363
# ╟─9ebe06f1-f95b-43ae-99dd-d4c837060b8f
# ╟─71c57b83-ec10-47aa-910f-e2b5d9a65db8
# ╟─fdfdc211-c9c5-4695-911e-b2a767f2b228
# ╟─b2b9dd54-3392-4dfd-8918-6fb29b41ff98
# ╟─67fc91d3-8058-4f2a-a903-fc667b655514
# ╟─a2c7699c-344e-434e-a603-4cf3c4c4b67b
# ╟─d55584d1-6c00-4eda-b526-4663851315e9
# ╟─ae52cc95-7cca-44cf-9742-9791a484c6fe
# ╟─5d8c80b9-c201-4d6f-8212-9924caa88a2a
# ╟─f2ad6464-e3f3-41e5-96d7-2eb72c6c4cd8
# ╠═0b586670-9290-469a-a7cf-70e1654a9e86
# ╟─d4c38abc-7cae-4f3e-ba5f-1dc9377fbeaa
# ╟─6c75f38d-40ab-4862-9749-7b63fcdfce29
# ╟─d879263c-10a0-4cb6-8a05-7342208662ea
# ╠═55ddac47-88aa-40c6-8986-5ed07731f6e2
# ╟─3fd5e38e-ab5e-40be-91f7-65fd05f60eff
# ╟─55643865-1506-42a1-ae0a-9a8e20511d7c
# ╟─e2ebeec5-e944-4fde-8230-d431a674cb52
# ╟─6d392830-65ff-4c10-83d1-20e320341735
# ╟─6a9f17ae-f24d-492b-a540-a9f0e7424c09
# ╟─399b4977-95ff-431d-84b1-c57865b49a48
# ╟─19940b6b-901c-4175-84e4-ca151dc49841
# ╟─bc58fba0-a0b2-45c7-a415-6edc6af3a315
# ╟─2de29067-b788-4419-bddd-f6092e8b5307
# ╟─a3ac719d-a13d-4f92-8395-8f95bd8f0ded
# ╟─1d703048-9186-4dc6-af7e-94f3f03d4f15
# ╟─28be8f50-1905-481e-ace4-ee1682f11514
# ╟─66c8f04d-cada-4eaf-b41e-b16966735c4e
# ╟─63ac5301-28e2-4551-bb2f-8e8ad7987a9f
# ╟─789955de-1f40-4b07-9abf-994437e3685f
# ╟─dfb5b0ec-6cf3-4233-8b2d-6ef8834d6441
# ╟─51dbf095-a024-4f99-ab90-330d4b18b8eb
# ╟─a0997724-2959-43c1-9fc0-3ee68f8c6b2a
# ╠═19ec57cc-aecf-42f6-a337-b7f273834934
# ╟─a8fc5873-2add-4061-8977-c6cd6a1d2433
# ╟─7d633d24-9d0a-472b-8fbe-9ce7f6a14447
# ╟─64acf4d6-8655-44cb-b3ea-5e09b829912b
# ╟─d07c578c-1386-45ce-9fec-9bf20632333c
# ╟─1a572f06-ae70-44fa-af1f-95415a05d7be
# ╠═028284e2-e901-4c25-bdc6-cde904279799
# ╟─11db793f-dabc-4b76-bf50-c6d40eb4d497
# ╟─e2afac2b-f375-49ec-a020-e934aaa104a9
# ╟─6941cc03-75e1-48cb-bde1-837f8f809132
# ╟─9fc8e26a-c45f-41c6-bcf4-bb065fcfc70b
# ╟─ff678064-7f1e-4c70-a269-980fbb16daf4
# ╟─98a8402d-0d73-4223-b565-9f1861753b25
# ╟─75ab0065-074b-466e-9230-228c33696a81
# ╟─75fa570d-37d4-4fe0-be67-e765b4db8a06
# ╟─d5863d29-8a7d-4042-b9b3-ced734168e0e
# ╟─6e770f8d-b25d-4263-abc0-97dbd6d421ac
# ╟─5f7365cc-ee95-41f1-b402-f7953fb20535
# ╠═9c7dcf4d-5cf7-4b5c-a3a6-cc4c5e07d1c3
# ╠═bbad76b9-34d2-4c7a-8b38-0684a92f10ed
# ╠═ee2764c9-0f99-4aea-b1ce-9ffcc9d05eef
# ╠═7e075bce-e784-4a4e-abc2-dad5230eeef7
# ╠═f8c684f5-18f1-414b-8ce1-7f654e53272d
# ╠═67ddb4d2-cbba-4592-ad5a-f9c609d731a8
# ╠═79ac9331-c1c7-4f8b-889a-61c850a6a405
# ╠═3442098f-2588-4169-8afb-893cd97eb812
# ╠═c1673254-5543-4836-bb87-8a071607d2bf
# ╠═6ef69b15-cbe3-43be-b918-1fb146dcb871
# ╠═0f57e79f-d33d-4662-802c-e2a6d0ac61f4
# ╠═cc2dca66-af82-4a9c-9229-8fee6e12f620
# ╠═b87bf77d-0ac4-4aa4-89f1-c35bd07b2464
# ╠═949a0727-3427-44b9-bca1-cb6c0be55b5a
# ╠═09cfe910-5060-4b84-b885-5ce0727a65f6
# ╠═363b9d8b-6288-46f4-b321-bf2d28d9e7df
# ╠═f80da3f2-5272-450c-a6e6-81ba4189b6b5
# ╠═c53d2dd7-a57c-4688-9682-10cd5947bf03
# ╠═9aaa5191-16d2-4af7-981e-697ea50f166f
# ╠═7df7019e-a9b3-4ae1-bae0-44badb94e6bf
# ╠═1be798c5-b9a4-42c3-a526-8563d25eb246
# ╠═5c9dc21c-b5ff-422f-9d8e-1d177efb60af
# ╠═229b3153-a41f-4acc-af89-89a7fd35a10f
# ╠═a09b7496-29dd-4ecd-9ce5-6e21983a1677
# ╠═6357795f-52f3-4832-8c27-e75f220cd1b5
# ╠═bebbd462-5a6d-4649-9105-04f511f27287
# ╠═f0349447-b967-421d-9f86-57e37e0df049
# ╠═51d70474-def8-4714-854d-2dd69caebdfa
# ╠═e47b9235-bce9-42e1-b790-acc15042f4dc
# ╠═48b1e580-0502-497f-80e7-b6ade3129272
# ╠═0c2674a1-89f9-4fde-b10f-13001ce0754e
# ╠═818d83db-9154-4e13-853a-7dd83d368773
# ╠═c2c834d3-c4d8-4313-b1dd-f75dc04c18d9
# ╠═059e03c2-d921-42e6-9130-13d37f9f05dc
# ╠═b8b7c421-cc02-4143-9854-e182648c92d3
# ╠═2ebac407-bcda-4646-8ac5-19aa50cb866e
# ╠═240b0876-7fa2-4e71-945f-0ffdd017557a
# ╠═166b293f-cead-4852-b23b-7f6b699b354e
# ╠═032054f9-1ea2-4265-b3a4-93045f23a45a
# ╠═f5d90c07-6292-4c14-904c-2851fee7ac1f
# ╠═020d8181-06fc-4b38-bb8a-990c2337d1ca
# ╠═3dc9bbb0-6cf9-410a-b3d4-aa8e8859c9a9
# ╠═d75ca2b2-1033-450e-b94d-49fd308c3f5e
# ╠═21fb5570-c41a-4a67-a900-614b4debc7d7
# ╠═2a2e4a74-0985-4c23-8da7-1694021aa382
# ╠═2443239f-6d9b-41e1-ae93-f30e784a5073
# ╠═301c9794-a8a2-4186-84c9-554de27bded3
# ╠═0a13199e-f144-4d4e-af7e-1959da3fcac6
# ╠═cb1ce385-d5e7-464f-a551-dd024d016d29
# ╠═009747f2-3aa5-4f64-87e3-31939c20b249
# ╠═f69c98fb-bd73-4c5e-a904-06b7f8920324
# ╠═7100ef5a-919e-4a8e-9857-40e3d70d1a6e
# ╠═02132858-b6fa-4ce3-9326-0614b60499d6
# ╠═c645824c-141c-4236-bf42-d06a9115475c
# ╠═7f09eabc-f74d-4a56-9041-30d439012138
# ╠═c435d1c0-08c6-4fb3-b0a9-d8aaa738ddfe
# ╠═3d13b289-1bc6-4c79-b60d-abbbc6172cc2
# ╠═e02e7c74-0245-411f-a33e-43c101996220
# ╠═8cb2f20f-68f2-4ba5-aa85-3fb3ca295cb6
# ╠═1f939754-d4cd-4ca2-8086-fd8d1c3b3f79
# ╠═1ce44bf4-60d4-4607-95cd-b76f931ed594
# ╠═e0fa4607-ec15-4751-98db-a8feb04ad558
# ╠═ffb2974d-ef66-4397-8fb7-67ef9c5a53ec
# ╠═39985a71-8ca8-4892-997a-844fe137dd57
# ╠═83571d10-7eff-11f0-10db-391640417d07
# ╟─f25c97aa-47a9-4bcd-9f27-3e8eb17857e1
# ╟─8ce83819-cf7f-46fc-aded-773e3a716244
