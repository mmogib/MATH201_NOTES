### A Pluto.jl notebook ###
# v0.20.24

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
    See here [Term 252 - MATH201 - Syllabus](https://math.kfupm.edu.sa/docs/default-source/css-library/math201-252.pdf)
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

Informally, the values of
```math
\frac{\partial f}{\partial x} \quad \text{and} \quad \frac{\partial f}{\partial y}
```
at the point ``(x_0, y_0, z_0)`` denote the __slopes
of the surface__ in the ``x-``and ``y-``directions, respectively
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

- a. Find the rate of change of ``A`` with respect to ``a`` for ``a=10, b=20``, and ``\theta=\pi / 6``.
- b. Find the rate of change of ``A`` with respect to ``\theta`` for ``a=10, b=20``, and ``\theta=\pi / 6``.
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
Show that ``f_{x z}=f_{z x}`` and ``f_{x z z}=f_{z x z}=f_{z z x}`` for the function
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
md"## Increments and Differentials"

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
# cm"""
# $(ex(3,"Finding Partial Derivatives by Substitution"))
# Find ``\partial w / \partial s`` and ``\partial w / \partial t`` for ``w=2 x y``, where ``x=s^2+t^2`` and ``y=s / t``

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

# """

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

# ╔═╡ 49ef1c3a-2cc9-488e-a92f-8477d2cabfda
let
    f(x,y) = x^2 + 2y^2-2x+3
    f(x::Vector)=f(x...)
    g(x,y)=x^2+y^2-10
    g(x::Vector)=g(x...)
    A = a,b1,b2,c1,c2=[1,0], [-1,-3], [-1,3], [sqrt(10),0],[-sqrt(10),0]
    map(x->abs(g(x))<=1e-12,A)
    map(x->"$x=>$(f(x))",A)
end

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
    T(A...), T(B...), T(C...), T(D...)
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
CommonMark = "~0.9.1"
ForwardDiff = "~1.2.2"
Groebner = "~0.10.0"
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.4.0"
Latexify = "~0.16.10"
Nemo = "~0.52.3"
PlotThemes = "~3.3.0"
Plots = "~1.41.1"
PlutoExtras = "~0.7.16"
PlutoUI = "~0.7.73"
PrettyTables = "~3.1.0"
QRCoders = "~1.4.5"
Symbolics = "~6.57.0"
Unitful = "~1.25.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "676df27baecaecff2557233cea90ba46b7661a91"

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
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

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
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

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
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

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
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

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
git-tree-sha1 = "351d6f4eaf273b753001b2de4dffb8279b100769"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.9.1"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

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
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

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

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

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
git-tree-sha1 = "27af30de8b5445644e8ffe3bcb0d72049c089cf1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.3+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.ExproniconLite]]
git-tree-sha1 = "c13f0b150373771b0fdc1713c97860f8df12e6c2"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.10.14"

[[deps.Extents]]
git-tree-sha1 = "b309b36a9e02fe7be71270dd8c0fd873625332b4"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.6"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "ccc81ba5e42497f4e76553a5545665eed577a663"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.0.0+0"

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
git-tree-sha1 = "d60eb76f37d7e5a40cc2e7c36974d864b82dc802"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.1"
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

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "b5c7fe9cea653443736d264b85466bad8c574f4a"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.9.9"

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
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

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

[[deps.GeoFormatTypes]]
git-tree-sha1 = "8e233d5167e63d708d41f87597433f59a0f213fe"
uuid = "68eda718-8dee-11e9-39e7-89f7f65f511f"
version = "0.4.4"

[[deps.GeoInterface]]
deps = ["DataAPI", "Extents", "GeoFormatTypes"]
git-tree-sha1 = "294e99f19869d0b0cb71aef92f19d03649d028d5"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.4.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "b62f2b2d76cee0d61a2ef2b3118cd2a3215d3134"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.11"

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
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

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
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

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
git-tree-sha1 = "d670e8e3adf0332f57054955422e85a4aec6d0b0"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.2005+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

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
git-tree-sha1 = "5fbb102dcb8b1a858111ae81d56682376130517d"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.11"
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
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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
git-tree-sha1 = "4255f0032eafd6451d707a51d5f0248b8a165e4d"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.3+0"

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

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

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
git-tree-sha1 = "3acf07f130a76f87c041cfb2ff7d7284ca67b072"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2a7a12fc0a4e7fb773450d17975322aa77142106"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.2+0"

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
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

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
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

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
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

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
git-tree-sha1 = "386b47442468acfb1add94bf2d85365dea10cbab"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.0"

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
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

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
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

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
git-tree-sha1 = "12ce661880f8e309569074a61d3767e5756a199f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.1"

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
git-tree-sha1 = "fed8c477f3028dcbffbc12b957d6b328196dcc00"
uuid = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
version = "0.7.16"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "3faff84e6f97a7f18e0dd24373daa229fd358db5"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.73"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "6b8e2f0bae3f678811678065c09571c1619da219"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.1.0"

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
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

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
git-tree-sha1 = "f2685b435df2613e25fc10ad8c26dddb8640f547"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.6.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "b8693004b385c842357406e3af647701fe783f98"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.15"
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
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

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
git-tree-sha1 = "725421ae8e530ec29bcbdddbe91ff8053421d023"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.1"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "9537ef82c42cdd8c5d443cbc359110cbb36bae10"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.21"

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = ["GPUArraysCore", "KernelAbstractions"]
    StructArraysLinearAlgebraExt = "LinearAlgebra"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

    [deps.StructArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

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
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

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
deps = ["ColorTypes", "Contour", "Crayons", "Dates", "FileIO", "FreeTypeAbstraction", "LazyModules", "LinearAlgebra", "MarchingCubes", "NaNMath", "Printf", "SparseArrays", "StaticArrays", "StatsBase", "Unitful"]
git-tree-sha1 = "ae67ab0505b9453655f7d5ea65183a1cd1b3cfa0"
uuid = "b8865327-cd53-5732-bb35-84acbb429228"
version = "2.12.4"

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
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

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
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

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
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

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
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

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
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

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
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╔═╡ 00000000-0000-0000-0000-000000000001
# ╔═╡ 00000000-0000-0000-0000-000000000002
# ╔═╡ 9858d0f8-ba7e-44fe-bcfc-4af064b7985c
# ╔═╡ 83571d10-7eff-11f0-10db-391640417d07
# ╔═╡ f25c97aa-47a9-4bcd-9f27-3e8eb17857e1
# ╔═╡ 8ce83819-cf7f-46fc-aded-773e3a716244
# ╔═╡ 286b172a-8bfe-430c-b13b-83e0e14798d1
# ╔═╡ f7f0dbe3-ab41-4ff2-ad97-5927f657d5a4
# ╔═╡ c7a8937d-6d27-41c3-ac54-8d59db9c8937
# ╔═╡ 0c5c4f1e-2145-4333-bed0-9b1d53c665db
# ╔═╡ 0658ce85-2ae3-4595-9105-5a2a187a1d73
# ╔═╡ 441227fb-8b43-402e-a3ec-976c3fcd266f
# ╔═╡ a7e74141-12a3-43c5-81d6-887df215d3c4
# ╔═╡ 46462c56-05b0-4efb-aa16-54672b0bf1d4
# ╔═╡ 6a6ff203-3789-4a1a-8c62-e9628239e0c4
# ╔═╡ 8f59471c-fd22-4337-ae80-088b2fb84bf4
# ╔═╡ e65f9504-8096-4d04-add3-b000929fea8d
# ╔═╡ b0312347-074e-4d02-9541-827625366a1f
# ╔═╡ 0980c680-12bf-45bb-8b51-9af548d75809
# ╔═╡ e33d3119-d369-48b1-b298-d381d0f56539
# ╔═╡ abe05e1f-f4de-4ff3-ae24-baca1163e808
# ╔═╡ 48130cd8-69ad-4b14-b4a5-84aeb560aae0
# ╔═╡ 52ef6ea9-888c-48b3-a2d4-5ca86c5e6b1b
# ╔═╡ fa71c9a5-1d30-49e3-930e-757c681e5028
# ╔═╡ 7222448d-c176-4441-bb0d-46203177d93a
# ╔═╡ 62e49e96-01b0-447a-a742-9b8491b35fcc
# ╔═╡ 1e13cf69-7303-4086-90b9-fe2232a08327
# ╔═╡ 959ca089-7ed7-44aa-b4a1-9321cf1d2ce4
# ╔═╡ 1915cc7d-1d34-480e-a413-fcd64b4e76bf
# ╔═╡ 9779271b-19cf-4034-9901-0983454edef1
# ╔═╡ 837b01a0-948d-472f-b17c-c9763f2e5f0e
# ╔═╡ c5270de3-1db9-4dbb-87e5-0e9f18ea34b2
# ╔═╡ e125198b-ea6e-4703-8b0b-8ec2b191fc39
# ╔═╡ 04442eaa-9336-4ebd-865b-7e1fdbe4b8bc
# ╔═╡ 4b19a3ac-1f97-40e3-a8ff-cd57a3f14fdc
# ╔═╡ d8fc27f5-de91-4bc3-83b5-c48ae17acf97
# ╔═╡ 3f146078-120b-4f4a-bf9b-392ef6afb5c4
# ╔═╡ 69528b92-41b9-4a90-a809-dfd86c3feb04
# ╔═╡ 85b9bece-47e3-4de1-b21c-650b8b841e0d
# ╔═╡ c982e7a9-9563-4ad6-8bde-2baa9c538650
# ╔═╡ 450ae414-927f-4497-8a05-0a1c0f7290b6
# ╔═╡ 39226cb1-d58a-4bac-8d2c-dfa0b916aada
# ╔═╡ b15b1448-9b88-4b70-91ad-0d00d8e9aeb0
# ╔═╡ f5e000db-7586-47b9-a673-1829f8e47fd7
# ╔═╡ 2cc5584a-586a-4ae7-bfc3-71ff77fbf3d9
# ╔═╡ 7a1c7ca9-659d-4f66-ab27-21a02201e60d
# ╔═╡ 4ed53690-acca-4128-90ee-d935afc71e7c
# ╔═╡ baa0d2e0-ac0d-4371-803e-9cc22d016af7
# ╔═╡ ae48b156-e2e5-43e1-bd8d-ab995cc393a0
# ╔═╡ 4bf026b7-7a1c-4134-a4b1-4c8a9069a73d
# ╔═╡ 64acd27c-8af7-4051-b018-2f8dd0615b34
# ╔═╡ 0cd9a65d-1d2b-42a4-85b6-a5c2541889d8
# ╔═╡ 853380dd-f790-4462-bcec-e0744274dc2e
# ╔═╡ 256acb74-41ef-4352-b14a-f74a9a723deb
# ╔═╡ 4b5c59b6-7670-482c-a4de-795530e38b75
# ╔═╡ 235057bb-ea29-4b9a-8665-f750cde0d002
# ╔═╡ a57476c4-7f42-40aa-a453-b7b29e7b9f7d
# ╔═╡ 068a3704-aa26-47ea-8f4a-ed4aacbb1985
# ╔═╡ b64466d6-b4fb-408b-99e4-9ff0ed7bf95a
# ╔═╡ 17cb54f7-f893-47b1-b089-d6f0e5fe6c0c
# ╔═╡ ebabd01a-2a02-4a8c-9f01-23b347a9f6a7
# ╔═╡ 14852a74-f0a5-41c7-a9ef-d110a4bd8807
# ╔═╡ a54bcc59-6b84-4553-878f-4a4abfd6e9d6
# ╔═╡ fdbca96e-0f9c-4edb-8f60-cb53c1dad95e
# ╔═╡ 9fe522bd-dfdb-4d65-a8d1-3d2d4618e4f7
# ╔═╡ de197844-f3d6-469c-b41c-995d5ba542ca
# ╔═╡ 957e0ca3-72b6-4687-a7c5-69b6da416f5b
# ╔═╡ d859bc8d-fce7-4eb6-9e0a-12750dc76275
# ╔═╡ e08331c1-1e6c-48be-a570-e33a908d830f
# ╔═╡ d444124f-7afa-4de4-bdcd-f9667f3e9732
# ╔═╡ e53f41aa-45cd-488a-9123-7dfa22ec3ef7
# ╔═╡ cc9031ef-476d-498b-8850-2b355125f98a
# ╔═╡ 108a234a-2272-4971-b762-f7f665133955
# ╔═╡ 3de8b2fd-5d34-4a02-b821-a969b439e571
# ╔═╡ d850bcda-5bf4-4db6-b920-ca87514bfbc6
# ╔═╡ 527952f0-6be5-4be3-9676-3eb063188706
# ╔═╡ d8943cd3-6930-4447-a5a0-6c6cf8797e81
# ╔═╡ 47fe0a92-3fb5-4a1b-9618-87eec99c068e
# ╔═╡ 69abaecb-13d5-4e81-a401-567b581e8eda
# ╔═╡ ab0c80dd-8916-499d-aa3e-c01984a2c0d7
# ╔═╡ 81fad03e-4540-460c-a149-7681a0c61fb4
# """

# ╔═╡ 2127153a-edfd-49dc-8c45-8743629af637
# ╔═╡ 21c9124f-ab99-4d80-b4f7-4ba8ab35c20d
# ╔═╡ 47cdd95c-53a5-4e07-9b26-c91b3b1706d9
# ╔═╡ 7e4fb221-9750-4abd-b4f8-5b511629d7f5
# ╔═╡ e3d38fd9-0997-4286-aa2e-762c70b360d1
# ╔═╡ 6aa7ee9d-263f-4768-ac9b-67d0692d0e66
# ╔═╡ 5fe3745a-4a75-4ece-b04a-bd71f7810c6f
# ╔═╡ 92b3ab49-db16-4a05-8929-1dbd3362d470
# ╔═╡ ddd97e19-227f-42ec-9a38-663c926adc86
# ╔═╡ 45ba9ada-2921-41d6-b9a1-e4df2963ed0b
# ╔═╡ ca36e483-976e-4bd3-87f9-4c4a5a12d91d
# ╔═╡ 31cfcab4-5d77-4f9a-abd7-0bfed85396a3
# ╔═╡ 034acc9b-59bb-4d06-9ed6-c0d6a0101cc9
# ╔═╡ 4cb8757a-ab68-4a51-b11a-44a02c4ec8c5
# ╔═╡ b639b1fb-4aea-495f-9580-c4d383a0a1e8
# ╔═╡ 960c605c-d254-4b2e-9d6d-0acba4121c0e
# ╔═╡ fda44fd8-0ad6-4f02-a993-791b47ebb90c
# ╔═╡ 5b535710-51b1-470b-8f9b-18319b908d20
# ╔═╡ 9dc755ae-8dae-4fcd-969c-a4558ba1a78d
# ╔═╡ 2b95a8f3-ffe2-439a-b735-969c4a5ce363
# ╔═╡ 9ebe06f1-f95b-43ae-99dd-d4c837060b8f
# ╔═╡ 71c57b83-ec10-47aa-910f-e2b5d9a65db8
# ╔═╡ fdfdc211-c9c5-4695-911e-b2a767f2b228
# ╔═╡ b2b9dd54-3392-4dfd-8918-6fb29b41ff98
# ╔═╡ 67fc91d3-8058-4f2a-a903-fc667b655514
# ╔═╡ a2c7699c-344e-434e-a603-4cf3c4c4b67b
# ╔═╡ d55584d1-6c00-4eda-b526-4663851315e9
# ╔═╡ ae52cc95-7cca-44cf-9742-9791a484c6fe
# ╔═╡ 5d8c80b9-c201-4d6f-8212-9924caa88a2a
# ╔═╡ f2ad6464-e3f3-41e5-96d7-2eb72c6c4cd8
# ╔═╡ 0b586670-9290-469a-a7cf-70e1654a9e86
# ╔═╡ d4c38abc-7cae-4f3e-ba5f-1dc9377fbeaa
# ╔═╡ 6c75f38d-40ab-4862-9749-7b63fcdfce29
# ╔═╡ d879263c-10a0-4cb6-8a05-7342208662ea
# ╔═╡ 55ddac47-88aa-40c6-8986-5ed07731f6e2
# ╔═╡ 3fd5e38e-ab5e-40be-91f7-65fd05f60eff
# ╔═╡ 55643865-1506-42a1-ae0a-9a8e20511d7c
# ╔═╡ e2ebeec5-e944-4fde-8230-d431a674cb52
# ╔═╡ 6d392830-65ff-4c10-83d1-20e320341735
# ╔═╡ 6a9f17ae-f24d-492b-a540-a9f0e7424c09
# ╔═╡ 399b4977-95ff-431d-84b1-c57865b49a48
# ╔═╡ 19940b6b-901c-4175-84e4-ca151dc49841
# ╔═╡ bc58fba0-a0b2-45c7-a415-6edc6af3a315
# ╔═╡ 2de29067-b788-4419-bddd-f6092e8b5307
# ╔═╡ a3ac719d-a13d-4f92-8395-8f95bd8f0ded
# ╔═╡ 1d703048-9186-4dc6-af7e-94f3f03d4f15
# ╔═╡ 28be8f50-1905-481e-ace4-ee1682f11514
# ╔═╡ 66c8f04d-cada-4eaf-b41e-b16966735c4e
# ╔═╡ 63ac5301-28e2-4551-bb2f-8e8ad7987a9f
# ╔═╡ 789955de-1f40-4b07-9abf-994437e3685f
# ╔═╡ dfb5b0ec-6cf3-4233-8b2d-6ef8834d6441
# ╔═╡ 51dbf095-a024-4f99-ab90-330d4b18b8eb
# ╔═╡ a0997724-2959-43c1-9fc0-3ee68f8c6b2a
# ╔═╡ 19ec57cc-aecf-42f6-a337-b7f273834934
# ╔═╡ a8fc5873-2add-4061-8977-c6cd6a1d2433
# ╔═╡ 7d633d24-9d0a-472b-8fbe-9ce7f6a14447
# ╔═╡ 64acf4d6-8655-44cb-b3ea-5e09b829912b
# ╔═╡ d07c578c-1386-45ce-9fec-9bf20632333c
# ╔═╡ 1a572f06-ae70-44fa-af1f-95415a05d7be
# ╔═╡ 028284e2-e901-4c25-bdc6-cde904279799
# ╔═╡ 11db793f-dabc-4b76-bf50-c6d40eb4d497
# ╔═╡ e2afac2b-f375-49ec-a020-e934aaa104a9
# ╔═╡ 6941cc03-75e1-48cb-bde1-837f8f809132
# ╔═╡ 9fc8e26a-c45f-41c6-bcf4-bb065fcfc70b
# ╔═╡ ff678064-7f1e-4c70-a269-980fbb16daf4
# ╔═╡ 98a8402d-0d73-4223-b565-9f1861753b25
# ╔═╡ 75ab0065-074b-466e-9230-228c33696a81
# ╔═╡ 75fa570d-37d4-4fe0-be67-e765b4db8a06
# ╔═╡ d5863d29-8a7d-4042-b9b3-ced734168e0e
# ╔═╡ 49ef1c3a-2cc9-488e-a92f-8477d2cabfda
# ╔═╡ 6e770f8d-b25d-4263-abc0-97dbd6d421ac
# ╔═╡ 5f7365cc-ee95-41f1-b402-f7953fb20535
# ╔═╡ 9c7dcf4d-5cf7-4b5c-a3a6-cc4c5e07d1c3
