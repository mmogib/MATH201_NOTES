### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ f2d4c2a5-f486-407b-b31b-d2efcc7476b3
begin
    using CommonMark
    using PlutoUI, PlutoExtras
    using Plots, PlotThemes, LaTeXStrings
    using Latexify
    using HypertextLiteral
    using Colors
    using LinearAlgebra, Random, Printf, SparseArrays
    using Symbolics
    # using SymPy
    using QRCoders
    using PrettyTables
    # using Primes
    # using LinearSolve
    # using NonlinearSolve
    # using ForwardDiff
    # using Integrals
    # using OrdinaryDiffEq
	using Unitful
end

# ╔═╡ 71bc54d5-d0ed-42d3-9bc1-48aa86e91d1d
TableOfContents(title="📚 MATH201: Calculus III", indent=true, depth=4)

# ╔═╡ e414122f-b93a-4510-b8ae-026c303e0df9
begin
    struct LocalImage
        filename
    end

    function Base.show(io::IO, ::MIME"image/png", w::LocalImage)
        write(io, read(w.filename))
    end
end


# ╔═╡ cd269caf-ef81-43d7-a1a8-6668932b6363
# exportqrcode("https://www.mathmatize.com/")
let
    img = LocalImage("./qrcode.png")
end

# ╔═╡ 109ff314-76c9-474f-b516-6bb17f1e0b62
md"""# 10.2 Plane Curves and Parametric equations

__Objectives__:

> - Sketch the graph of a curve given by a set of parametric equations.
> - Eliminate the parameter in a set of parametric equations.
> - Find a set of parametric equations to represent a curve.
> - __(READ ONLY)__Understand two classic calculus problems, the tautochrone and brachistochrone problems.
## Plane Curves and Parametric Equations
"""

# ╔═╡ ee1e2234-cd28-4013-aef6-4af835af9465
md"""
Consider the equation
```math
y = -x^2 + x + 10
```

Imagine an a person is walking and following this path. This equation 

- tell you where the person has been
- __BUT does NOT tell__ when the object was at a given point ``(x, y)``.

"""

# ╔═╡ 73107910-a89d-4f4a-8aeb-567aeca3e717
begin
	s10_2_t_slider = @bind s10_2_t Slider(0:10,show_value=true) 
	s10_2_xt_input = @bind s10_2_xt TextField(20,default="t",placeholder="Enter a function of t") 
	cm"""
	t = $s10_2_t_slider

	x = $s10_2_xt_input
	"""
end

# ╔═╡ 277ad9ab-687c-4034-8a01-65e5cadb9a61
let
	f(x) = -x^2 + x + 1
	eval(Meta.parse("x(t)=$s10_2_xt"))
	p = plot(f;framestyle=:origin,xlimits=(0,2),label=L"y=-x^2 + x + 1")
	scatter(p,[x(s10_2_t)],[f(x(s10_2_t))],label="Person")
end

# ╔═╡ 62611550-7596-412e-b492-1cfcab69d942
let
	t = [-2,-1,0,1,2,3]
	x(t) = t^2-4
	y(t) = t/2
	
	annot(t) = (x(t)+0.52,y(t)+0.1,L"t=%$t",8)
	
	p = plot(x.(t[1]:0.1:t[end]),y.(t[1]:0.1:t[end]),label=nothing)
	p = scatter(p,x.(t),y.(t),aspect_ratio=1, framestyle=:origin, xlimits=(-5,6),ylimits=(-2,4),label=nothing, annotations=annot.(t))
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
		tbl_str*="</tbody></table>"			
	end
	cm"""
	$(get_table())

	$p
	"""
end

# ╔═╡ 356e2c2e-b9dd-4988-81a0-c87036998ec6
md"##  Eliminating the Parameter"

# ╔═╡ 56158e41-0621-413d-958b-afb9939493d2
begin
	s10_2_ex3_input=@bind s10_2_ex3 NumberField(0:0.1:3π/4+0.1)
	cm"""
	``\theta = `` $(s10_2_ex3_input)
	"""
end

# ╔═╡ cb90c129-362b-41c9-aadb-90b89ac1c3c1
let
	a = 0.0
	b = s10_2_ex3
	x(t)=3cos(t)
	y(t)=4sin(t)
	t =a:0.01:b
	p = plot(x.(t),y.(t),aspect_ratio=1,framestyle=:origin,label=nothing,xlimit=(-5,5),ylimits=(-5,5))
	scatter(p,[x(b)],[y(b)],label=nothing)
end

# ╔═╡ ed6f28c3-5edc-48a5-9ab6-99fdb660067a
md"##  Finding Parametric Equations"

# ╔═╡ 586c9e7e-18d2-49ab-b12e-db30611f726b
begin
	s10_2_ex5_slider = @bind s10_2_ex5 Slider(0:0.1:10π)
	cm"""
	``\theta = `` $s10_2_ex5_slider
	"""
	
end

# ╔═╡ ec386f03-b425-4e7d-9539-06060d3b9057
let
	a = 2
	θ =s10_2_ex5
	b = a*θ
	x(t) = a*sin(t)+b
	y(t) = a*cos(t)+a
	xs(t) = a*(t-sin(t))
	ys(t) = a*(1-cos(t))
	ts = 0.0:0.01:2π+0.01
	p = plot(x.(ts),y.(ts),framestyle=:origin,aspect_ratio=1,label=nothing)
	p= plot(p,xticks=(collect(0:π:10π), ["$(i)π" for i in 1:10]),xlimits=(-a-1,10π),ylimits=(-1,2a+1))
	p = plot(p,xs.(0:0.01:θ),ys.(0:0.01:θ),label=nothing)
	p = scatter(p,[xs(θ)],[ys(θ)],label=nothing)
	annotate!(p,[(5π,2a+5,L"x=a(\theta-\sin{\theta})"),(5π,2a+3,L"y=a(1-\cos{\theta)}")])
end

# ╔═╡ e9c17c2a-342a-4de2-a6d7-7464bca2d166
md"# 10.3 Parametric Equations and Calculus"

# ╔═╡ 46c20239-40b8-4336-a575-13b120f42de9
cm"""
__Objectives__

> 1. Find the slope of a tangent line to a curve given by a set of parametric equations.
> 1. Find the arc length of a curve given by a set of parametric equations.
> 1. Find the area of a surface of revolution (parametric form).
"""

# ╔═╡ 1c946ad8-f21c-4030-b4b3-b51ef163c8c0
md"##  Slope and Tangent Lines"

# ╔═╡ d580f679-2677-4bc1-957f-fa3db84403ad
begin
	s10_3_ex3_slider = @bind s10_3_ex3_t Slider(-2:0.1:2,show_value=true)
	cm"""
	``t = `` $s10_3_ex3_slider
	"""
end

# ╔═╡ e0cb37ff-82c1-4ffc-90ef-7ec4b056da85
let
	ts= -2.0:0.001:s10_3_ex3_t
	x(t) = 2t-π*sin(t)
	y(t) = 2-π*cos(t)
	p=plot(x.(ts),y.(ts),
		frame_style=:origin, aspect_ratio=1, 
		title="Prolate cycloid",
		label = nothing,
		xlimits=(-7,7), xticks=([-π,0,π],[L"-\pi",L"0",L"\pi"]),
		ylimits=(-3,7), yticks=(collect(-2:2:6),[L"%$i" for i in -2:2:6]),
		c=:black
	)
	
	scatter!([x(s10_3_ex3_t)],[y(s10_3_ex3_t)],label=nothing,m=(2,3))
	if s10_3_ex3_t>=1.9
		plot!([x->x*(-π/2)+2,x->x*(π/2)+2],c=:blue,lw=0.6,label=nothing)
	end
	p
end

# ╔═╡ 84ee076f-c8f3-406e-8ef9-fb81e54130d0
md"## Arc Length"

# ╔═╡ c0efef5c-a5cb-4b5f-89a1-557d62cecf3b
begin
	s10_3_ex4_slider = @bind s10_3_ex4 Slider(0:0.1:10π)
	cm"""
	``t = `` $s10_3_ex4_slider
	"""
	
end

# ╔═╡ 83eaa558-cf7e-46de-9143-0085b12c2702
let
	ts = 0.0:0.01:2π+0.1
	tsd = 0.0:0.01:s10_3_ex4
	r = 1
	R =4+r
	h,k = R*cos(s10_3_ex4),R*sin(s10_3_ex4) 
	P = [R*cos(s10_3_ex4)-cos(R*s10_3_ex4),R*sin(s10_3_ex4)-sin(R*s10_3_ex4)]
	p = plot(4sin.(ts),4cos.(ts),
		frame_style=:origin, aspect_ratio=1, 
		title="Epicycloid",
		label = nothing,
		xlimits=(-7,7), xticks=(collect(-6:2:6),[L"%$i" for i in -6:2:6]),
		ylimits=(-7,7), yticks=(collect(-6:2:6),[L"%$i" for i in -6:2:6]),
		c=:black,lw=0.5
	)
	plot!(h.+r*sin.(ts),k.+r*cos.(ts),label=nothing)
	plot!([P[1]],[P[2]],series=scatter,seriestype=:scatter, label=nothing)
	plot!(R*cos.(tsd)-cos.(R*tsd),R*sin.(tsd)-sin.(R*tsd),label=nothing)
end

# ╔═╡ 80cd32aa-7156-4896-b76e-78869f8e5000
md"## Area of a Surface of Revolution"

# ╔═╡ 3a115647-a0a9-4a0b-a939-729799a528a4
md"# 10.4 Polar coordinates and Polar Graphs"

# ╔═╡ 5af5e402-69d2-4a09-8dd1-5ba91d482fe2
cm"""
> __Objectives__
> 1. Understand the polar coordinate system.
> 1. Rewrite rectangular coordinates and equations in polar form and vice versa.
> 1. Sketch the graph of an equation given in polar form.
> 1. Find the slope of a tangent line to a polar graph.
> 1.  Identify several types of special polar graphs.
"""

# ╔═╡ aeef6042-2182-4068-8fb0-0fedc2badaec
md"## Polar Coordinates"

# ╔═╡ 7ebe5d0a-e565-4e2a-9fc2-8f2a852bf9c6
let
	n = 0
	P = (2,π/3+n*2π)
	plot([P[2]],[P[1]];
	proj=:polar,seriestype=:scatter,thetaticks=([0,1,π],[0,1,2]),label=L"P%$P",grid=5)
	# plot!(;proj=:cart)
end

# ╔═╡ 3f565a27-fdc0-4209-9105-dc3f3ae3dfc2
 md"## Coordinate Conversion"

# ╔═╡ ff6c91b7-d111-4b5b-88c0-a01e42fa3cf8
md"## Polar Graphs"

# ╔═╡ 78b5718d-6c40-413d-b990-b8bbf6b323ba
let
	θs = range(0,2π,length=200)
	θssec = repeat([1],100)
	r(θ) = 2
	p1=plot(
		θs,r.(θs);
		proj=:polar,
		label=L"r=2"	
	)
	plot!(
		repeat([π/3],400),[range(0,3,length=200)...,-range(0,3,length=200)...];
		proj=:polar,
		label=L"\theta=\frac{\pi}{3}"	
	)
	p2 = plot(θssec,map(ti -> ti[1] > 50 ? (100-ti[1])*ti[2] : -ti[1]*ti[2] ,enumerate(θssec));
		label=L"r=\sec(\theta)",
		ylimits=(-3,3),
		aspectratio=1,
		frame_style=:origin
	)
	cm"""
	$p1

	$p2
	"""
end

# ╔═╡ 390823d7-4567-4782-823b-d7de116c4374
let
	θ = [0,π/6,π/3,π/2,2π/3,5π/6,π]
	θs = ["0","π/6","π/3","π/2","2π/3","5π/6","π"]
	r(θ) = 2*cos(3*θ)
	table = vcat(
		θ',
		r.(θ)'
		
	)
	r1 = map(x->"<td> $x </td>",θs)
	r2 = map(x->"<td> $(round(x,digits=2)) </td>",r.(θ))
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

# ╔═╡ dd8e4284-9ddc-43ba-93cb-00024faff337
begin
	s10_4_ex4_slider = @bind s10_4_ex4 NumberField(0:π/6:π)
	cm"""
	``\theta = `` $(s10_4_ex4_slider)
	"""
end

# ╔═╡ a671c82c-084b-4520-a82b-b66a41b4e5f8
let
	n = 3
	a = 2
	θs = 0:0.01:s10_4_ex4
	r(θ) = a*cos(n*θ) 
	plot(θs,r.(θs);
	proj=:polar,label=nothing,
		
	)
	# plot!(;proj=:cart)
end

# ╔═╡ b69a0131-c8cd-4ba2-a124-548baa1bc52d
md"##  Slope and Tangent Lines"

# ╔═╡ 784aad5e-9618-4ab5-ac7a-0d0394abe25d
let
	
	r(θ) = sin(θ) 
	plot(r;
	proj=:polar,label=nothing,
		
	)
	# plot!(;proj=:cart)
end

# ╔═╡ fee76b84-3a2d-487c-b034-84ba199a1b90
let
	
	r(θ) = 2(1-cos(θ)) 
	plot(r;
	proj=:polar,label=nothing,
		
	)
	# plot!(;proj=:cart)
end

# ╔═╡ bceaaa97-8e13-45a4-ac8c-90d9e9280a75
md"##  Special Polar Graphs"

# ╔═╡ b76eefd7-10a2-4f8c-8a6d-57c0506e7df3
let
	a = 10
	b  = 3
	r(θ) = a + b*cos(θ) 
	p= plot(r;
	proj=:polar,label=nothing,
		
	)
	cm"""
	__Limaçons__
	
	$p
	"""
	
end

# ╔═╡ 1f2859ea-80c9-4918-a4fb-d9db5123cacb
let
	a = 1
	n  = 10
	r(θ) = a*cos(n*θ) 
	p= plot(r;
	proj=:polar,label=nothing,
		
	)
	cm"""
	 __Rose Curves__
	
	$p
	"""
	
end

# ╔═╡ 0abd3e51-8fe7-4d35-9d0b-23e03e01ab34
let
	a = 1/2
	n  = 6
	# θs = range(0,2π,length=200)
	# r(θ) = cos(2*θ)>=0 && abs(a)*abs(cos(n*θ))
	r(θ) = sin(n*θ)>=0 && abs(a)*abs(sin(n*θ))
	p= plot(r;
	proj=:polar,label=nothing,
		
	)
		cm"""
	 __Circles and Lemniscates__

	``r^2  = a^2 \sin^2\theta``
	
	$p
	"""
	
end

# ╔═╡ cd2a10a5-9166-4754-b277-02efd8747eb3
md"""
# 10.5 Area and Arc Length in Polar Coordinates
> __Objectives__ 
> 1. Find the area of a region bounded by a polar graph.
> 1. Find the points of intersection of two polar graphs.
> 1. Find the arc length of a polar graph.
> 1. Find the area of a surface of revolution (polar form).
"""

# ╔═╡ ad06e95d-2879-4039-84bc-07b7856e2d89
md"##  Area of a Polar Region"

# ╔═╡ b6e05c6d-5124-4d6e-8160-c2b36cbee1d6
let
	r(θ) = 3*cos(3*θ)
	ts = -π/6:0.01:π/6
	p= plot(ts, r.(ts),fill=true, proj=:polar,label=nothing)
	plot!(r;
	proj=:polar,label=nothing,
		l=(2,:black)

	)
	plot!(repeat([π/6],100),range(-3,3,length=100);
	proj=:polar,label=nothing,
		l=(2,:red,:dash),
		annotations=[(0.5cos(π/6),0.7sin(π/6),L"\theta=\pi/6")]

	)
	plot!(repeat([-π/6],100),range(-3,3,length=100);
	proj=:polar,label=nothing,
		l=(2,:red,:dash),
		annotations=[(0.5cos(-π/6),0.7sin(-π/6),L"\theta=-\pi/6")]

	)
		cm"""
	 __Rose__

	``r  = 3\cos 3\theta``
	
	$p
	"""
	
end

# ╔═╡ b294b1df-4b78-4aeb-bbb3-f943adcf4c13
let
	r(θ) = 1 - 2sin(θ)
	ts = π/6:0.01:5π/6
	p= plot(ts, r.(ts), proj=:polar,label=nothing)
	plot!(r;
	proj=:polar,label=nothing,
		l=(2,:black),
		fill=true,
		
	)
	plot!(repeat([π/6],100),range(0,3,length=100);
	proj=:polar,label=nothing,
		l=(2,:red,:dash),
		annotations=[(0.5cos(π/6),0.9sin(π/6),L"\theta=\pi/6")]

	)
	plot!(repeat([5π/6],100),range(0,3,length=100);
	proj=:polar,label=nothing,
		l=(2,:red,:dash),
		annotations=[(0.5cos(5π/6),0.9sin(5π/6),L"\theta=5\pi/6")]

	)
		cm"""
	 __Rose__

	``r  = 1-2\sin \theta``
	
	$p

	``A_1 = \text{area of inner loop} = \pi - \frac{3\sqrt{3}}{2}``
		
	``A_2 = \text{area of outer loop} = 2\pi + \frac{3\sqrt{3}}{2}``
	
		
	``A = \text{area between loops} = A_2-A_1 = \pi - 3\sqrt{3}``

	
	"""
	
end

# ╔═╡ 0e42e5fb-6a5b-4636-b8b6-309617e14256
md"##  Points of Intersection of Polar Graphs"

# ╔═╡ d38a523d-ac85-4a47-b099-80a0d2273233
let
	r1(θ) = -6.0cos(θ)
	r2(θ) = 2.0 - 2cos(θ)
	# ts = range(2π/3,4π/3,length=100)
	ts = range(π/2,3π/2,length=500)
	r3(t) = t >=2π/3 && t <=4π/3 ? r2(t) : r1(t)
	p= plot(ts,r3.(ts), fill=true, proj=:polar,label=nothing)
	plot!(r1;
	proj=:polar,label=nothing,
		l=(2,:black),
		
	)
	plot!(r2;
	proj=:polar,label=nothing,
		l=(1,:grey),
		
	)
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

# ╔═╡ 11a883eb-56a3-49ac-89d2-e7c9ffb2c043
md"##  Arc Length in Polar Form"

# ╔═╡ a22ae8b2-7d44-40cf-ae4f-bebe3b5da083
let
	r(θ) = 2 - 2cos(θ)
	p= plot(r;
	proj=:polar,label=nothing,
		
	)
		cm"""

	
	$p
	"""
	
end

# ╔═╡ d8085786-1e5e-4c8a-9847-9948a23643fc
md"## Area of a Surface of Revolution"

# ╔═╡ 40cb2c1d-7387-4d02-a8f2-83d84ddf207f
let
	r(θ) = cos(θ)
	p= plot(r;
	proj=:polar,label=nothing,
		
	)
		cm"""

	
	$p
	"""
	
end

# ╔═╡ 1d54944c-ef82-4237-ad76-62ed4e201577
md"""#  11.1 Vectors in the Plan
> __Objectives__
> 1. Write the component form of a vector.
> 2. Perform vector operations and interpret the results geometrically.
> 3. Write a vector as a linear combination of standard unit vectors.

"""

# ╔═╡ 6f0edbab-49c3-4da1-a099-9ec899060383
# let
# 	n = 100
# 	ts = range(-5, stop = 5, length = n)
# 	z = 1:n
# 	plot(ts,ts, (x,y)->x + x^2 - y^2, zcolor = reverse(z),  leg = false, cbar = false, w = 5, camera=(30,30),st=:surface)
# 	# plot!(zeros(n), zeros(n), 1:n, w = 10)
# end

# ╔═╡ 26e3fb79-48b1-4d69-a1b2-5364168e7a36
md"## Component Form of a Vector"

# ╔═╡ 4b6ded9a-929d-48d9-9649-6cd0a2dc38f7
let
	plot(
		[0;1],[0;1], 
		frame_style=:none, 
		label=:none, arrow=true, lw=6, color=:black,
		aspect_ratio=1,
		annotations=[
			(0,0.1,L"P"),
			(0,-0.1,"Initial point"),
			(1,1.1,L"Q"),
			(1.3,0.9,"Terminal point"),
			(0.8,0.5,L"\textbf{v}=\vec{PQ}"),
		],
		ylimits=(-0.2,1.2)		
	)
	scatter!([0;1],[0;1],label=:none, m=5,c=:black)
	
end

# ╔═╡ 136624c5-6f20-4cc5-82f5-079b8f9c9618
cm"## Vector Operations"

# ╔═╡ 1135fb0d-4ef3-4d84-a487-940b1be56887
let
	v1 =(2,0.5)
	v2 = (0.5,1.5)
	vs = [v1;v2]
	p = plot(;frame_style=:origin,xlimits=(-1,3),ylimits=(-1,3))
	for (i,v) in enumerate(vs)
		plot!(p,[0;v[1]],[0,v[2]],arrow=true,annotations=[((v.+0.1)...,L"v_%$i")],label=:none, c=:black)
	end
	v = v1 .+ v2
	plot!(p,[0;v[1]],[0,v[2]],arrow=true,annotations=[((v.+0.1)...,L"v_1+v_2",:red)],label=:none, c=:red)
	v = v1 .- v2
	plot!(p,[0;v[1]],[0,v[2]],arrow=true,annotations=[((v.+0.1)...,L"v_1-v_2",:blue)],label=:none, c=:blue)

	p
end

# ╔═╡ 3d3598a8-5e3e-478a-ae71-c99772908426
md"## Standard Unit Vectors"

# ╔═╡ ced54357-381f-4ecd-a1f1-c3b397ac8185
cm"""

The unit vectors ``\langle 1,0\rangle`` and ``\langle 0,1\rangle`` are called the standard unit vectors in the plane and are denoted by
```math
\mathbf{i}=\langle 1,0\rangle \text { and } \mathbf{j}=\langle 0,1\rangle
```

__Standard unit vectors__
"""

# ╔═╡ f75a4200-8ab9-421d-8b10-1ad5f6d279ce
md"""
# 11.2 Space Coordinates and Vectors in Space
> __Objectives__
> 1. Understand the three-dimensional rectangular coordinate system.
> 2. Analyze vectors in space.
"""

# ╔═╡ 7dfefa60-23cf-4d9d-b768-c26c2fba8bf6
md"## Coordinates in Space"

# ╔═╡ f01c3fb1-6331-4a1f-acab-9243b577c0b7
let
	# Center of the sphere
	h, k, l = 5/2, 1, 0
	
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
		color = RGBA{Float64}(1, 0, 0, 0.1),
		camera=(30,30),
		xlimits=(-10,10),
		ylimits=(-10,10),
		zlimits=(-10,10),
		frame_style=:origin,
		legend = false, 
		# xlabel = "x", ylabel = "y", zlabel = "z", 
		title = "Sphere with Center " * L"(2.5, 1, 0)" * "and Radius " * L"\sqrt{97}/2")
end

# ╔═╡ b638364c-6b12-44e5-b70b-a1260bd20423
cm"""

<iframe src="https://www.geogebra.org/classic/vjqqpvzw?embed" width="800" height="600" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>

"""

# ╔═╡ 638a3b2e-23ff-45c5-9d4c-da3ea28dc123
md"## Vectors in Space"

# ╔═╡ 641296c7-72ca-4d28-b55a-c6495edcfdd4
md"""
# 11.3 The Dot Product of Two Vectors
> __Objectives__
> 1. Use properties of the dot product of two vectors.
> 1. Find the angle between two vectors using the dot product.
> 1. Find the direction cosines of a vector in space.
> 1. Find the projection of a vector onto another vector.
> 1. Use vectors to find the work done by a constant force.

"""

# ╔═╡ 7752454b-924b-4290-846e-83680faa1807
md"##  The Dot Product"

# ╔═╡ 073611bb-04e2-40a5-8a28-31ea5a435da4
md"## Angle Between Two Vectors"

# ╔═╡ 0859018b-198b-467a-8a64-5f399ccb4c30
md"## Direction Cosines"

# ╔═╡ 9c11772f-dc9b-48f4-8bf5-966cdadc2363
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

# ╔═╡ effc20dc-3097-46bd-a7d6-afe882033a05
md"## Projections and Vector Components"

# ╔═╡ efabadf1-c3c5-4c9c-9bae-4eadd3d5a033
md"## Work (Reading)"

# ╔═╡ 4487bfe5-df36-41d6-93dd-97e1242f2ae3
md"# 11.4 The Cross Product of Two Vectors in Space"

# ╔═╡ a75f9328-3c26-4e09-9688-4da4b11aefc5
md"""
> __Objectives__
> 1. Find the cross product of two vectors in space.
> 2. Use the triple scalar product of three vectors in space.
"""

# ╔═╡ 3235aa71-3bb9-4b19-92c5-3026e5dbd1c5
md"## The Cross Product"

# ╔═╡ 4d568a88-31ee-415d-9b7a-dd68277e76cc
let
	u = [1;-4;1]
	v = [2;3;0]
	u × v
end

# ╔═╡ 97cee0f8-4a2e-4cc1-b289-dfde9ee144c9
let
	A = [5;2;0.0]
	B = [2;6;1.0]
	C = [2;4;7.0]
	D = [5;0;6.0]
	AB = B-A
	AD = D-A
	area = norm(AB × AD)
end

# ╔═╡ b678c8fd-5f4d-4be0-8b89-2b5fd21a109a
cm"""

<iframe src="https://www.geogebra.org/classic/k64hdfn9?embed" width="600" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>

"""

# ╔═╡ 06908953-c831-4351-92f4-926d645eccd1
md"## Application"

# ╔═╡ 6a30bce0-3f06-4676-bd97-53d406f199ee
md"## The Triple Scalar Product"

# ╔═╡ 4a8340ee-1c51-4be2-a703-2e8c5caf37b1
let
	u = [3;-5;1]
	v = [0;2;-2]
	w = [3;1;1]
	volume = abs(u⋅(w × v))
end

# ╔═╡ e81a3b57-1139-40a7-8966-fb3b31e5cd05
cm"""
<iframe src="https://www.geogebra.org/classic/b5xwbxrg?embed" width="600" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
"""

# ╔═╡ 8f2713c1-e74c-4e84-b4c6-b4ab421d919b
md"""
# 11.5 Lines and Planes in Space
> __Objectives__
> 1. Write a set of parametric equations for a line in space.
> 1. Write a linear equation to represent a plane in space.
> 1. Sketch the plane given by a linear equation.
> 1. Find the distances between points, planes, and lines in space.
"""

# ╔═╡ 10e7b1ee-ccdd-49da-9e6e-8b26cd704f5f
md"## Lines in Space"

# ╔═╡ ceffc602-fad0-4310-b3c8-f0909e886879
cm"""
<iframe src="https://www.geogebra.org/classic/a87nndfp?embed" width="650" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>

"""

# ╔═╡ da52c005-f146-4fcc-95f5-627519d0c45e
cm"""
<iframe src="https://www.geogebra.org/classic/a87nndfp?embed" width="650" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>

"""

# ╔═╡ 58d43afd-4045-44cb-a5c0-3883dc886ece
md"##  Planes in Space"

# ╔═╡ 85d082f1-bcc4-4858-b7d1-de721f9ab501
cm"""
<iframe src="https://www.geogebra.org/classic/a87nndfp?embed" width="650" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
"""

# ╔═╡ c015b262-4b35-4c7c-8533-61402e5703e2
cm"""
<iframe src="https://www.geogebra.org/classic/tg4tezst?embed" width="650" height="350" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
"""

# ╔═╡ 63bddd53-9326-468a-89ac-6a8fd49dd32f
let
	n1 = [1;-2;1]
	n2 = [2;3;-2]
	α =acos(abs(n1⋅n2)/(norm(n1)*norm(n2))) |> u"°"
	
end

# ╔═╡ 660ac7bd-7537-4042-9400-5a0dd4532508
md"## Sketching Planes in Space"

# ╔═╡ 8acf5369-439b-4294-bd1c-dd18095e8480
cm"""
Sketch the plane
```math
3x+2y+4z=12
```
"""


# ╔═╡ 18ef6c08-1ded-45cd-a0bb-106acb2552f2
md"## Distances Between Points, Planes, and Lines"

# ╔═╡ 2f7931f0-c907-425e-a582-8014e4e0ca11
let
	Q = (1,5,-4)
	P = (2,0,0)
	n = (3,-1,2)
	on_plane(P) = n⋅P == 6
	PQ = Q .- P
	D = abs(PQ⋅n)/norm(n)
end

# ╔═╡ dd677f71-05e6-4e44-807b-42520c7924f5
let
	f1(x,y,z) = 3x-y+2z-6 
	f2(x,y,z) = 6x-2y+4z+4
	Q=(0,-6,0)
	P=(0,0,-1)
	PQ = Q.-P
	n = (6,-2,4)
	D = abs(PQ⋅n)/norm(n)
	
	
end

# ╔═╡ 2be1d63d-2371-4d2b-b93d-fddeb49c451d


# ╔═╡ d553ce36-0b68-4b9d-a261-992162b0bf58
let
	Q = (3,-1,4)
	P =(-2,0,1)
	u = (3,-2,4)
	PQ = Q .- P
	norm(cross(vcat(PQ...),vcat(u...)))/norm(u)
end

# ╔═╡ 32b036c0-92e1-40f7-8162-a2d8b4b43d90
md"## Skew lines"

# ╔═╡ f317bb32-dd20-45c1-8449-06b7f32672cd
cm"""

<iframe src="https://www.geogebra.org/classic/r488tpxz?embed" width="700" height="300" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>

"""

# ╔═╡ eac26ad2-d636-4b93-a562-d13b155f3609
let
	@variables x::Real, y::Real, z::Real, t::Real, s::Real
	# P1 =[4;5;1]
	# P2 =[4;-6;7]
	# v1 = [5;5;-4]
	# v2 = [1;8;-3]
	
	# L1(t)= P1 + v1 * t
	# L2(s)= P2 + v2 * s
	# n1 = v1 × v2
	# f1(x::Vector) = x ⋅ n1 - P1 ⋅ n1
	# PL1 = f1([x;y;z]) ~ 0
	# # # L1(t)
	# f2(x::Vector) = x ⋅ n1 - P2 ⋅ n1
	# PL2 = f2([x;y;z]) ~ 0
	# PL1, PL2
	# P1P2 = L2(0)-L1(5)
	# D=abs(n1 ⋅ P1P2)/norm(n1)
	# expand(f1(L1(t)))
	# expand(f2(L2(t)))
end

# ╔═╡ f803e12d-617e-478f-8593-5e5849384e1a


# ╔═╡ 5141e6da-d53b-4cb8-ad27-0a2666aac859
md"""
# 11.6 Surfaces in Space
> __Ovjectives__ 
> 1. Recognize and write equations of cylindrical surfaces.
> 2. Recognize and write equations of quadric surfaces.
> 3. Recognize and write equations of surfaces of revolution __(X)__
"""

# ╔═╡ b73636ec-e481-4c1b-acc9-5e77127c6c17
md"## Cylindrical Surfaces"

# ╔═╡ a001c05b-f12f-4dfb-a193-783a082fd0b8
cm"""
__Equations of Cylinders__
The equation of a cylinder whose rulings are parallel to one of the coordinate 
axes contains only the variables corresponding to the other two axes.
"""

# ╔═╡ 439bb6f7-3809-4fc6-83b1-d12ba556583d
cm"""
<iframe src="https://www.geogebra.org/classic/fm9cnxfr?embed" width="800" height="600" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
"""

# ╔═╡ 0346f7e4-c32f-498a-80a3-12fb91431fd5
cm"""
<iframe src="https://www.geogebra.org/classic/bjkrnchk?embed" width="800" height="300" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
"""

# ╔═╡ d7ea9082-e9cb-4386-ba49-6b7812608587
md"## Quadric Surfaces"

# ╔═╡ ef081dfa-b610-4c7a-a039-7258f4f6e80e
begin
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
        """<div style="display:flex;">
       <div style="
       font-size: 112%;
           line-height: 1.3;
           font-weight: 600;
           color: #f9ce4e;
           float: left;
           background-color: #5c5c5c;
           border-left: 10px solid #474546;
           padding: 5px 10px;
           margin: 0 12px 20px 0;
           border-radius: 0;
       ">$lable:</div>
       <div style="flex-grow:3;
       line-height: 1.3;
           font-weight: 600;
           float: left;
           padding: 5px 10px;
           margin: 0 12px 20px 0;
           border-radius: 0;
       ">$desc</div>
       </div>"""
    end
    @htl("")
end

# ╔═╡ 8408e369-40eb-4f9b-a7d7-26cde3e34a74
begin
    text_book = post_img("https://www.dropbox.com/scl/fi/upln00gqvnbdy7whr23pj/larson_book.jpg?rlkey=wlkgmzw2ernadd9b8v8qwu2jd&dl=1", 200)
    md""" # Syllabus
    ## Syallbus
    See here [Term 242 - MATH201 - Syllabus](https://math.kfupm.edu.sa/docs/default-source/default-document-library/math201-242.pdf?sfvrsn=f665d644_1)
    ## Textbook
    __Textbook: Edwards, C. H., Penney, D. E., and Calvis, D. T., Differential Equations and Linear Algebra, Fourth edition, Pearson, 2021__
    $text_book

    ## Office Hours
    I strongly encourage all students to make use of my office hours. These dedicated times are a valuable opportunity for you to ask questions, seek clarification on lecture material, discuss challenging problems, and get personalized feedback on your work. Engaging with me during office hours can greatly enhance your understanding of the course content and improve your performance. Whether you're struggling with a specific concept or simply want to delve deeper into the subject, I am here to support your learning journey. Don't hesitate to drop by; __your success is my priority__.

    | Day       | Time        |
    |-----------|-------------|
    | Sunday    | 02:00-02:50PM |
    | Tuesday | 02:00-02:50PM |
    Also you can ask for an online meeting through __TEAMS__.
    """
end

# ╔═╡ 58eb74fd-b5e5-4e41-bd2f-99d29dbdece8
cm"""
$(define("a Plane Curve"))
If ``f`` and ``g`` are continuous functions of ``t`` on an interval ``I``, then the equations
```math
x=f(t) \quad \text { and } \quad y=g(t)
```
are __parametric equations__ and ``t`` is the __parameter__. The set of points ``(x, y)`` obtained as ``t`` varies over the interval ``I`` is the __graph__ of the parametric equations. Taken together, the parametric equations and the graph are a __plane curve__, denoted by ``C``.
"""

# ╔═╡ 4026f2d0-ec69-4491-b4b7-313c501d7f50
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

# ╔═╡ b2f647d7-9fe4-4ab7-b251-8ba27485ae35
cm"""

$(post_img("https://www.dropbox.com/scl/fi/7ijq8twppy0b4urn2ct3c/fig0_10_2.png?rlkey=abd13ney9wz9ya3vjxcrddo10&raw=1",500))
"""

# ╔═╡ b4eff26d-d34b-49b4-be8a-64cffaf2f431
cm"""
$(ex(2,"Adjusting the Domain"))
Sketch the curve represented by the equations
```math
x=\frac{1}{\sqrt{t+1}} \quad \text { and } \quad y=\frac{t}{t+1}, \quad t>-1
```
by eliminating the parameter and adjusting the domain of the resulting rectangular equation.
"""

# ╔═╡ 8a4f89a9-d0ee-4a4f-9f2e-ed2620247d50
cm"""
$(ex(3,"Using Trigonometry to Eliminate a Parameter"))
See LarsonCalculus.com for an interactive version of this type of example.
Sketch the curve represented by
```math
x=3 \cos \theta \quad \text { and } \quad y=4 \sin \theta, \quad 0 \leq \theta \leq 2 \pi
```
by eliminating the parameter and finding the corresponding rectangular equation.
"""

# ╔═╡ 061935b4-9e9b-42ff-926f-e183cbf2de74
cm"""
$(ex(4,"Finding Parametric Equations for a Given Graph"))
Find a set of parametric equations that represents the graph of ``y=1-x^2``, using each of the following parameters.

- __(a.)__ ``t=x``
- __(b.)__ The slope ``m=\frac{d y}{d x}`` at the point ``(x, y)``

"""

# ╔═╡ 109e181f-e208-4e42-8169-16582873f069
cm"""
$(ex(5,"Parametric Equations for a Cycloid"))
Determine the curve traced by a point ``P`` on the circumference of a circle of radius ``a`` rolling along a straight line in a plane. Such a curve is called a cycloid.
"""

# ╔═╡ be94da4b-60cb-41c2-8dbd-05e96104e6c1
cm"""
$(define("Smooth Curve"))
A curve ``C`` represented by ``x=f(t)`` and ``y=g(t)`` on an interval ``I`` is called __smooth__ when ``f^{\prime}`` and ``g^{\prime}`` are continuous on ``I`` and not simultaneously ``0`` , except possibly at the endpoints of ``I``. The curve ``C`` is called __piecewise smooth__ when it is smooth on each subinterval of some partition of ``I``.
"""

# ╔═╡ 0c0b4d35-5c61-4a3c-b534-6e7437844706
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

# ╔═╡ 99e98559-8b42-4b3e-8667-bfabbcc07c6d
cm"""
$(ex(1,"Differentiation and Parametric Form"))
Find ``d y / d x`` for the curve given by 
```math
x=\sin t\quad \text{and} \quad y=\cos t.
```
"""

# ╔═╡ 161c8ffd-748e-407a-8948-13a9d7481766
cm"""
$(bbl("Remark",""))
```math
\begin{aligned} & \frac{d^2 y}{d x^2}=\frac{d}{d x}\left[\frac{d y}{d x}\right]=\frac{\frac{d}{d t}\left[\frac{d y}{d x}\right]}{d x / d t} \\ & \frac{d^3 y}{d x^3}=\frac{d}{d x}\left[\frac{d^2 y}{d x^2}\right]=\frac{\frac{d}{d t}\left[\frac{d^2 y}{d x^2}\right]}{d x / d t} .\end{aligned}
```
"""

# ╔═╡ 7e0aaff0-9f10-4f26-a204-4f5ccc0b7ed0
cm"""
$(ex(2,"Finding Slope and Concavity"))
For the curve given by
```math
x=\sqrt{t} \quad \text { and } \quad y=\frac{1}{4}\left(t^2-4\right), \quad t \geq 0
```
find the slope and concavity at the point ``(2,3)``.
"""

# ╔═╡ 1701aff4-76d8-4cbe-a477-8bd10987dd2f
cm"""
$(ex(3,"A Curve with Two Tangent Lines at a Point"))
The prolate cycloid given by
```math
x=2 t-\pi \sin t \quad \text { and } \quad y=2-\pi \cos t
```
crosses itself at the point ``(0,2)``. Find the equations of both tangent lines at this point.
"""

# ╔═╡ 110286ce-3cec-4d66-88f2-311972ff9285
cm"""
$(bth("Arc Length in Parametric Form"))
If a smooth curve ``C`` is given by ``x=f(t)`` and ``y=g(t)`` such that ``C`` does not intersect itself on the interval ``a \leq t \leq b`` (except possibly at the endpoints), then the arc length of ``C`` over the interval is given by
```math
s=\int_a^b \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t=\int_a^b \sqrt{\left[f^{\prime}(t)\right]^2+\left[g^{\prime}(t)\right]^2} d t
```
"""

# ╔═╡ cf66301b-be6e-4507-b471-b9b38481ef0e
cm"""
$(ex(4,"Finding Arc Length"))

A circle of radius 1 rolls around the circumference of a larger circle of radius 4, as shown below The epicycloid traced by a point on the circumference of the smaller circle is given by
```math
x=5 \cos t-\cos 5 t \quad \text { and } \quad y=5 \sin t-\sin 5 t .
```

Find the distance traveled by the point in one complete trip about the larger circle.
"""

# ╔═╡ 0726ebd1-a83e-42ee-82f5-74dd930266f0
cm"""
$(bth("Area of a Surface of Revolution"))
If a smooth curve ``C`` given by ``x=f(t)`` and ``y=g(t)`` does not cross itself on an interval ``a \leq t \leq b``, then the area ``S`` of the surface of revolution formed by revolving ``C`` about the coordinate axes is given by the following.

__``(1)``__ ``S=2 \pi \int_a^b g(t) \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t``

Revolution about the ``x``-axis: ``g(t) \geq 0``

__``(2)``__ ``S=2 \pi \int_a^b f(t) \sqrt{\left(\frac{d x}{d t}\right)^2+\left(\frac{d y}{d t}\right)^2} d t``

Revolution about the ``y``-axis: ``f(t) \geq 0``
"""

# ╔═╡ 2bef46e1-44b2-4dd3-92b1-d50b1a395b97
cm"""
$(ex(5,"Finding the Area of a Surface of Revolution"))

Let ``C`` be the arc of the circle ``x^2+y^2=9`` from ``(3,0)`` to
```math
\left(\frac{3}{2}, \frac{3 \sqrt{3}}{2}\right)
```
Find the area of the surface formed by revolving ``C`` about the ``x``-axis.
"""

# ╔═╡ c1fe9952-c638-479a-a166-e95956f879ca
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

# ╔═╡ 056b4af6-c433-497e-81e0-70bb3096bc3c
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

# ╔═╡ ca784670-8225-4c3e-a4ee-8f7ab59adc85
cm"""
$(ex(1,"Polar-to-Rectangular Conversion"))
- (a) For the point ``(r, \theta)=(2, \pi)``,
- (b) For the point ``(r, \theta)=(\sqrt{3}, \pi / 6)``,

"""

# ╔═╡ f8dcab6d-2926-43d3-ba9f-b4a50316038e
cm"""
$(ex(2,"Rectangular-to-Polar Conversion"))
- __(a)__ For the second-quadrant point ``(x, y)=(-1,1)``,
- __(a)__ For the second-quadrant point ``(x, y)=(0,2)``,
"""

# ╔═╡ c602fc93-2bdc-444f-9b2d-d20caf751a8f
cm"""
$(ex(3,"
Graphing Polar Equations"))
Describe the graph of each polar equation. Confirm each description by converting to a rectangular equation.
- __(a.)__ ``r=2``
- __(b.)__ ``\theta=\frac{\pi}{2}``
- __(c.)__ ``r=\sec \theta``
"""

# ╔═╡ 519d7317-a639-4d2d-9cb5-8647d6992eb2
cm"""
$(ex(4,"
Sketching a Polar Graph"))
Sketch the graph of ``r=2 \cos 3 \theta``.
"""

# ╔═╡ 5c4a9aa7-9223-46d7-91f9-f958e3be6eeb
cm"""
$(bth("Slope in Polar Form"))
If ``f`` is a differentiable function of ``\theta``, then the slope of the tangent line to the graph of ``r=f(\theta)`` at the point ``(r, \theta)`` is
```math
\frac{d y}{d x}=\frac{d y / d \theta}{d x / d \theta}=\frac{f(\theta) \cos \theta+f^{\prime}(\theta) \sin \theta}{-f(\theta) \sin \theta+f^{\prime}(\theta) \cos \theta}
```
provided that ``d x / d \theta \neq 0`` at ``(r, \theta)``. 
"""

# ╔═╡ c3b508e4-913c-4e33-b759-7d15d31de0b4
cm"""
$(bbl("Remarks",""))

- Solutions of ``\frac{d y}{d \theta}=0`` yield horizontal tangents, provided that ``\frac{d x}{d \theta} \neq 0``.
- Solutions of ``\frac{d x}{d \theta}=0`` yield vertical tangents, provided that ``\frac{d y}{d \theta} \neq 0``.

- If ``d y / d \theta`` and ``d x / d \theta`` are simultaneously 0 , then no conclusion can be drawn about tangent lines.
"""


# ╔═╡ 0fe1255e-5df0-477e-8999-4b93750b2a6f
cm"""
$(ex(5,"Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines of ``r=\sin \theta``, where ``0 \leq \theta<\pi``.
"""

# ╔═╡ 35220a5b-a101-495e-b617-361510394818
cm"""
$(ex(6,"
Finding Horizontal and Vertical Tangent Lines"))
Find the horizontal and vertical tangent lines to the graph of ``r=2(1-\cos \theta)``, where ``0 \leq \theta<2 \pi``.
"""

# ╔═╡ 11bbb488-8f5a-47ae-b8a6-c05d7cd01f45
cm"""
$(bth("Tangent Lines at the Pole"))
If ``f(\alpha)=0`` and ``f^{\prime}(\alpha) \neq 0``, then the line ``\theta=\alpha`` is tangent at the pole to the graph of ``r=f(\theta)``.
"""

# ╔═╡ 352c4204-c676-47a6-887d-a3bdd5cc7d66
cm"""
__What is the area of a sector of a circle?__

$(post_img("https://www.dropbox.com/scl/fi/sgx7mh1hbsj2zbc2ka19t/fig48_10_5.png?rlkey=7dc54g4fkrlnkdt6ijebxga2w&dl=1",300))

__How to find the area of the region bounded by the graph of the function ``f`` and the radial lines ``\theta = \alpha`` and ``\theta = \beta``?__

$(post_img("https://www.dropbox.com/scl/fi/6ks10wxt27god0jec8ae7/fig49_a_10_5.png?rlkey=5xb3cva5jq1tbe3477d46z98i&dl=1",300))


"""
	

# ╔═╡ f886e4c9-1fa1-45fa-b1b8-ffbca56c522a
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

# ╔═╡ 362222c0-5e65-4d84-8766-7d2fd678dd7b
cm"""
$(ex(1,"
Finding the Area of a Polar Region"))
Find the area of one petal of the rose curve ``r=3 \cos 3 \theta``.
"""

# ╔═╡ 96397bdb-4add-4b15-af28-076a0057e88b
cm"""
$(ex(2,"Finding the Area Bounded by a Single Curve"))
Find the area of the region lying between the inner and outer loops of the limaçon ``r=1-2 \sin \theta``.
"""

# ╔═╡ 709ebbe9-c14a-4461-9367-adc512422e9e
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

# ╔═╡ 603bd8f0-a602-453a-9caf-a73303b78559
cm"""
$(bth("Arc Length of a Polar Curve"))
Let ``f`` be a function whose derivative is continuous on an interval ``\alpha \leq \theta \leq \beta``. The length of the graph of ``r=f(\theta)`` from ``\theta=\alpha`` to ``\theta=\beta`` is
```math
s=\int_\alpha^\beta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta=\int_\alpha^\beta \sqrt{r^2+\left(\frac{d r}{d \theta}\right)^2} d \theta
```
"""

# ╔═╡ f7c6fc51-4c31-4eca-a79b-766068558894
cm"""
$(ex(4,"Finding the Length of a Polar Curve"))
Find the length of the arc from ``\theta=0`` to ``\theta=2 \pi`` for the cardioid ``r=f(\theta)=2-2 \cos \theta``
"""

# ╔═╡ c0475c93-9b5b-4f13-a045-114b824c1af2
cm"""
$(bth("Area of a Surface of Revolution"))
Let ``f`` be a function whose derivative is continuous on an interval ``\alpha \leq \theta \leq \beta``. The area of the surface formed by revolving the graph of ``r=f(\theta)`` from ``\theta=\alpha`` to ``\theta=\beta`` about the indicated line is as follows.
1. ``\displaystyle S=2 \pi \int_\alpha^\beta f(\theta) \sin \theta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta \quad \color{red}{\text{About the polar axis}}``



2. ``\displaystyle S=2 \pi \int_\alpha^\beta f(\theta) \cos \theta \sqrt{[f(\theta)]^2+\left[f^{\prime}(\theta)\right]^2} d \theta\quad \color{red}{\text{About the line } \theta=\frac{\pi}{2}}``
$(ebl())

$(ex(5,"Finding the Area of a Surface of Revolution"))
Find the area of the surface formed by revolving the circle ``r=f(\theta)=\cos \theta`` about the line ``\theta=\pi / 2``
"""

# ╔═╡ 16395162-789a-4822-aaff-8a34b4e246f3
cm"""
$(ex(1,"Vector Representation: Directed Line Segments"))
Let ``\mathbf{v}`` be represented by the directed line segment from ``(0,0)`` to ``(3,2)``, and let ``\mathbf{u}`` be represented by the directed line segment from ``(1,2)`` to ``(4,4)``. Show that ``\mathbf{v}`` and ``\mathbf{u}`` are equivalent.
"""

# ╔═╡ 8ba6d7b2-5a2b-4874-b31c-ef56dd617097
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

# ╔═╡ fe2376f2-8de3-4163-94f1-b77c3c0e092e
cm"""
$(ex(2,"Component Form and Length of a Vector"))
Find the component form and length of the vector ``\mathbf{v}`` that has initial point ``(3,-7)`` and terminal point ``(-2,5)``.
"""

# ╔═╡ 81101ecd-e335-4cc1-a503-4a62bd964118
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

# ╔═╡ ee6a4043-a6e8-466f-a262-f6ec04372c7d
cm"""
$(ex(3,"Vector Operations"))
For ``\mathbf{v}=\langle-2,5\rangle`` and ``\mathbf{w}=\langle 3,4\rangle``, find each of the vectors.
- (a.) ``\frac{1}{2} \mathbf{v}``
- (b.) ``\mathbf{w}-\mathbf{v}``
- (c.) ``\mathbf{v}+2 \mathbf{w}``
"""

# ╔═╡ c448ff49-ac48-4019-9520-0d6ead2c5bd9
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

# ╔═╡ 1c3a4171-ffc3-46f9-8618-e74abeaef721
cm"""
$(bth("Length of a Scalar Multiple"))
Let ``\mathbf{v}`` be a vector and let ``c`` be a scalar. Then
```math
\|c \mathbf{v}\|=|c|\|\mathbf{v}\|
```
``|c|`` is the absolute value of ``c``.
"""

# ╔═╡ 6e84190d-302e-401c-91b8-775451b4dc37
cm"""
$(bth("Unit Vector in the Direction of  v"))
If ``\mathbf{v}`` is a nonzero vector in the plane, then the vector
```math
\mathbf{u}=\frac{\mathbf{v}}{\|\mathbf{v}\|}=\frac{1}{\|\mathbf{v}\|} \mathbf{v}
```
has length 1 and the same direction as ``\mathbf{v}``.
"""

# ╔═╡ c68d34a8-bdf0-4516-a72c-cb047ebd4c7c
cm"""
$(bbl("triangle inequality for vectors",""))
```math
\|\mathbf{u}+\mathbf{v}\| \leq\|\mathbf{u}\|+\|\mathbf{v}\|
```

"""

# ╔═╡ 2ec1ab72-fec7-43fe-9c5e-f4415bcb9f6a
cm"""
$(ex(4,"Finding a Unit Vector"))
Find a unit vector in the direction of ``\mathbf{v}=\langle-2,5\rangle`` and verify that it has length 1.
"""

# ╔═╡ a17a0d9d-ebeb-4893-aba7-f0618e045511
cm"""
$(ex(5,"Writing a Linear Combination of Unit Vectors"))
Let ``\mathbf{u}`` be the vector with initial point ``(2,-5)`` and terminal point ``(-1,3)``, and let ``\mathbf{v}=2 \mathbf{i}-\mathbf{j}``. Write each vector as a linear combination of ``\mathbf{i}`` and ``\mathbf{j}``.
"""

# ╔═╡ adad65b4-1106-41a3-a0ac-413e4072b0a1
cm"""
$(ex(6,"Writing a Vector of Given Magnitude and Direction"))
The vector ``\mathbf{v}`` has a magnitude of 3 and makes an angle of ``30^{\circ}=\pi / 6`` with the positive ``x``-axis. Write ``\mathbf{v}`` as a linear combination of the unit vectors ``\mathbf{i}`` and ``\mathbf{j}``.
"""

# ╔═╡ 8629cb44-2eda-40c1-afe1-e2a80f207ff0
cm"""
$(ex(1,"Finding the Distance Between Two Points in Space"))
Find the distance between the points ``(2,-1,3)`` and ``(1,0,-2)``.
"""

# ╔═╡ 15b84eda-16bc-4255-9e0b-8eb04abdf931
cm"""
$(ex(2,"Finding the equation of a Sphere"))
Find the standard equation of the sphere that has the points

``(5, −2, 3)`` and ``(0, 4, −3)``

 as endpoints of a diameter.
"""

# ╔═╡ e409714e-9620-4699-86db-3371f34a3286
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

# ╔═╡ dfa813df-1e71-4004-8327-d333a326648b
cm"""
$(ex(3,"Finding the Component Form of a Vector in Space"))
Find the component form and magnitude of the vector ``\mathbf{v}`` having initial point ``(-2,3,1)`` and terminal point ``(0,-4,4)``. Then find a unit vector in the direction of ``\mathbf{v}``.
"""

# ╔═╡ 67eaf1f0-d71d-4fb1-b782-d7b0e73e21fc
cm"""
$(define("Parallel Vectors"))
Two nonzero vectors ``\mathbf{u}`` and ``\mathbf{v}`` are parallel when there is some scalar ``c`` such that ``\mathbf{u}=c \mathbf{v}``.
"""

# ╔═╡ 9ffd817f-3680-4fdc-a369-f3f55e62c4a0
cm"""
$(ex(4,"Parallel Vectors"))
Vector ``\mathbf{w}`` has initial point ``(2,-1,3)`` and terminal point ``(-4,7,5)``. Which of the following vectors is parallel to ``\mathbf{w}`` ?
a. ``\mathbf{u}=\langle 3,-4,-1\rangle``
b. ``\mathbf{v}=\langle 12,-16,4\rangle``
"""

# ╔═╡ e982617c-8230-4818-bd2f-223d31638735
cm"""
$(ex(5,"Using Vectors to Determine Collinear Points"))
Determine whether the points
```math
P(1,-2,3), \quad Q(2,1,0), \quad \text { and } \quad R(4,7,-6)
```
are collinear.
"""

# ╔═╡ 4a8731dd-a218-41eb-83ee-18afe812b53d
cm"""
$(ex(6,"Standard Unit Vector Notation"))
- __(a.)__ Write the vector ``\mathbf{v}=4 \mathbf{i}-5 \mathbf{k}`` in component form.
- __(b.)__ Find the terminal point of the vector ``\mathbf{v}=7 \mathbf{i}-\mathbf{j}+3 \mathbf{k}``, given that the initial point is ``P(-2,3,5)``.
c. Find the magnitude of the vector ``\mathbf{v}=-6 \mathbf{i}+2 \mathbf{j}-3 \mathbf{k}``. Then find a unit vector in the direction of ``\mathbf{v}``.
"""

# ╔═╡ 8dea5ec4-8f71-42bb-bb4d-178db354a8de
cm"""
$(ex(7,"Measuring Force"))
A television camera weighing ``120`` pounds is supported by a tripod, as shown below. Represent the force exerted on each leg of the tripod as a vector. 

$(post_img("https://www.dropbox.com/scl/fi/avv2vzzviidm4m8opc3uk/fig_11_23.png?rlkey=o3rnxynprpdg5lt0jkbh6wp9p&dl=1"))
"""

# ╔═╡ 6a4c706b-ee37-4a33-82b0-99e8e8db6fa9
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

# ╔═╡ 1e816ba7-2ec6-46bd-b349-bea20140111c
cm"""
$(ex(1,"Finding Dot Products"))

Let ``\mathbf{u}=\langle 2,-2\rangle, \mathbf{v}=\langle 5,8\rangle``, and ``\mathbf{w}=\langle-4,3\rangle``.

- (a.) ``\mathbf{u} \cdot \mathbf{v}=\langle 2,-2\rangle \cdot\langle 5,8\rangle=2(5)+(-2)(8)=-6``
- (b.) ``(\mathbf{u} \cdot \mathbf{v}) \mathbf{w}=-6\langle-4,3\rangle=\langle 24,-18\rangle``
- (c.) ``\mathbf{u} \cdot(2 \mathbf{v})=2(\mathbf{u} \cdot \mathbf{v})=2(-6)=-12``
- (d.) ``\|\mathbf{w}\|^2=\mathbf{w} \cdot \mathbf{w}=\langle-4,3\rangle \cdot\langle-4,3\rangle=(-4)(-4)+(3)(3)=25``
"""

# ╔═╡ a97991f4-dab7-473a-b5a5-d9002384cafc
cm"""
$(bth("Angle Between Two Vectors"))
If ``\theta`` is the angle between two nonzero vectors ``\mathbf{u}`` and ``\mathbf{v}``, where ``0 \leq \theta \leq \pi``, then
```math
\cos \theta=\frac{\mathbf{u} \cdot \mathbf{v}}{\|\mathbf{u}\|\|\mathbf{v}\|}
```
"""

# ╔═╡ 0c5db57b-b294-4d8c-9984-0b289e1d1495
cm"""
$(bbl("Remark",""))
```math
\mathbf{u} \cdot \mathbf{v}=\|\mathbf{u}\|\|\mathbf{v}\| \cos \theta\qquad \color{red}{\text{Alternative form of dot product}}
```
"""

# ╔═╡ da6a09ec-523d-4612-979d-3c55b28288ce
cm"""
$(define(" Definition of Orthogonal Vectors"))
 The vectors ``u`` and ``v`` are orthogonal when ``u∙v=0``
"""

# ╔═╡ 869abdcb-84b5-4d96-a101-0293a2d4c1e2
cm"""
$(ex(2,"Finding the Angle Between Two Vectors"))
For ``\mathbf{u}=\langle 3,-1,2\rangle, \mathbf{v}=\langle-4,0,2\rangle, \mathbf{w}=\langle 1,-1,-2\rangle``, and ``\mathbf{z}=\langle 2,0,-1\rangle``, find the angle between each pair of vectors.

- (a.) ``\mathbf{u}`` and ``\mathbf{v}``
- (b.) ``\mathbf{u}`` and ``\mathbf{w}``
- (c.) ``\mathbf{v}`` and ``\mathbf{z}``
"""

# ╔═╡ dd53c61c-fa51-4788-ba6a-4599c67b9313
cm"""
$(ex(3,"Alternative Form of the Dot Product"))
Given that ``\|\mathbf{u}\|=10,\|\mathbf{v}\|=7``, and the angle between ``\mathbf{u}`` and ``\mathbf{v}`` is ``\pi / 4``, find ``\mathbf{u} \cdot \mathbf{v}``.
"""

# ╔═╡ 7253a177-0997-4620-84cd-4c362412b723
cm"""

$(post_img("https://www.dropbox.com/scl/fi/yoip1oldetoeth472ju81/fig_11_26.png?rlkey=g71oyxboekwrwumo2znb7mqtg&dl=1",400))

"""

# ╔═╡ c139972c-24bd-445f-b95e-ded16e2eba64
cm"""
$(ex(4,"Finding Direction Angles"))
Find the direction cosines and angles for the vector ``\mathbf{v}=2 \mathbf{i}+3 \mathbf{j}+4 \mathbf{k}``, and show that ``\cos ^2 \alpha+\cos ^2 \beta+\cos ^2 \gamma=1``
"""

# ╔═╡ c3980348-6644-48e6-97f4-8d6ed91547bc
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

# ╔═╡ 51696239-3ed3-484b-874a-64979a5cd91b
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

# ╔═╡ 08370e88-8f77-44ba-a93a-51e90c7818fa
cm"""
$(bth("Projection Using the Dot Product"))
If ``\mathbf{u}`` and ``\mathbf{v}`` are nonzero vectors, then the projection of ``\mathbf{u}`` onto ``\mathbf{v}`` is
```math
\operatorname{proj}_{\mathbf{v}} \mathbf{u}=\left(\frac{\mathbf{u} \cdot \mathbf{v}}{\|\mathbf{v}\|^2}\right) \mathbf{v}
```
"""

# ╔═╡ ba9914cc-7b24-45c8-b9f7-2e7e33ec8132
cm"""
$(ex(6,"Decomposing a Vector into Vector Components"))
Find the projection of ``\mathbf{u}`` onto ``\mathbf{v}`` and the vector component of ``\mathbf{u}`` orthogonal to ``\mathbf{v}`` for ``\mathbf{u}=3 \mathbf{i}-5 \mathbf{j}+2 \mathbf{k}`` and ``\quad \mathbf{v}=7 \mathbf{i}+\mathbf{j}-2 \mathbf{k}``.
"""

# ╔═╡ a37acdbb-34f2-4643-808a-e5afe817088b
cm"""
$(ex(7,"Finding a Force"))
A 600-pound boat sits on a ramp inclined at ``30^{\circ}``, as shown in Figure below. What force is required to keep the boat from rolling down the ramp?
$(post_img("https://www.dropbox.com/scl/fi/9h16n07tc8x569rwdx5j7/fig_11_32.png?rlkey=rv5hgssgbggmveuj0tcj81ovk&dl=1",500))
"""

# ╔═╡ 217bbde3-e3cf-4e4f-94c7-7d139941ed3f
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

# ╔═╡ daea6ac7-a442-4f05-a7bf-192a0a48bfee
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

# ╔═╡ 0f279112-e03e-403e-b131-6f6a934a427a
cm"""
$(ex(1,"Finding the Cross Product"))
For ``\mathbf{u}=\mathbf{i}-2 \mathbf{j}+\mathbf{k}`` and ``\mathbf{v}=3 \mathbf{i}+\mathbf{j}-2 \mathbf{k}``, find each of the following.
- (a.) ``\mathbf{u} \times \mathbf{v}``
- (b.) ``\mathbf{v} \times \mathbf{u}``
- (c.) ``\mathbf{v} \times \mathbf{v}``
"""

# ╔═╡ 68436e91-4c49-4eb9-b744-884b9321feff
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

# ╔═╡ 3794c467-23d0-472f-9d05-7ddf1fc0d5db
cm"""
$(bth("Geometric Properties of the Cross Product"))
Let ``\mathbf{u}`` and ``\mathbf{v}`` be nonzero vectors in space, and let ``\theta`` be the angle between ``\mathbf{u}`` and ``\mathbf{v}``.
1. ``\mathbf{u} \times \mathbf{v}`` is orthogonal to both ``\mathbf{u}`` and ``\mathbf{v}``.
2. ``\|\mathbf{u} \times \mathbf{v}\|=\|\mathbf{u}\|\|\mathbf{v}\| \sin \theta``
3. ``\mathbf{u} \times \mathbf{v}=\mathbf{0}`` if and only if ``\mathbf{u}`` and ``\mathbf{v}`` are scalar multiples of each other.
4. ``\|\mathbf{u} \times \mathbf{v}\|=`` area of parallelogram having ``\mathbf{u}`` and ``\mathbf{v}`` as adjacent sides.
"""

# ╔═╡ 9a1d80e4-8aa8-4216-8f6b-b4eee617d6a8
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

# ╔═╡ 038dd397-a465-401b-8e39-4d1a62010f51
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

# ╔═╡ b8c87b6e-fb0a-4b66-b8a0-4cd426c914f5
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

# ╔═╡ 688203a2-c7c7-45bf-96dc-e31e69e51092
cm"""
$(ex(4,"An Application of the Cross Product"))
A vertical force of 50 pounds is applied to the end of a one-foot lever that is attached to an axle at point ``P``, as shown below. 

$(post_img("https://www.dropbox.com/scl/fi/9sqxf39xyyukd1zbqjv8o/fig_11_40.png?rlkey=szapu3urbrqd9pe9gfl7qfyai&dl=1",300))

Find the moment of this force about the point ``P`` when ``\theta=60^{\circ}``.
"""

# ╔═╡ 055ddf9e-2174-43c2-bbfd-5d6c0ba2e567
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

# ╔═╡ 3cebbc76-7b88-4e3c-981d-6b4bf69ac017
cm"""
$(bth("Geometric Property of the Triple Scalar Product"))
The volume ``V`` of a parallelepiped with vectors ``\mathbf{u}, \mathbf{v}``, and ``\mathbf{w}`` as adjacent edges is
```math
V=|\mathbf{u} \cdot(\mathbf{v} \times \mathbf{w})| .
```
$(ebl())

$(post_img("https://www.dropbox.com/scl/fi/5hf3ibte2ppgtlx0vegr1/fig_11_41.png?rlkey=z0qrbw2p1z30iyhae0mf2xdfo&dl=1",300))
"""

# ╔═╡ 61427306-0a04-420a-bfd0-361742530e81
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

# ╔═╡ a0711cd1-1ce2-4786-8e0b-4b758c227dd2
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

# ╔═╡ a00f7ba8-5f66-4145-ad18-ff69a6d4e535
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

# ╔═╡ bd55e0c7-1bdd-4cfb-89f2-5701a230a3cd
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

# ╔═╡ 63768194-bf80-4a28-8c15-224b4032cc40
cm"""
$(bbl("Remark",""))
```math
a x+b y+c z+d=0 \qquad \color{red}{\text{General form of equation of plane}}
```
"""

# ╔═╡ 65d4fb31-ff0b-4ee1-a721-b2c2428cc81c
cm"""
$(ex(3,"Finding an Equation of a Plane in Three-Space"))
Find an equation (in standard form and in general form) of the plane containing the points ``(2,1,1), \quad(1,4,1), \quad`` and ``\quad(-2,0,4)``.
"""

# ╔═╡ 2ff76dcb-2184-4096-9d88-b645bb3d8edb
cm"""
$(bbl("Angle between two planes",""))
```math
\cos \theta=\frac{\left|\mathbf{n}_1 \cdot \mathbf{n}_2\right|}{\left\|\mathbf{n}_1\right\|\left\|\mathbf{n}_2\right\|}
```


"""

# ╔═╡ 60a656f9-f93b-448c-8dac-8d5c128583a7
cm"""
$(ex(4,"Finding the Line of Intersection of Two Planes"))
Find the angle between the two planes ``x-2 y+z=0`` and ``2 x+3 y-2 z=0``. Then find parametric equations of their line of intersection.
"""

# ╔═╡ 5624db18-ee2e-4133-bd21-5c768821344f
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

# ╔═╡ 4bbdb2a2-2dd6-44a1-96b3-86a702a4a9c7
cm"""
$(bbl("Distance between a point and a plane"))
Let ``Q(x_0,y_0,z_0)`` be any point. The distance between ``Q`` and the plane ``ax+by+cz+d=0`` is given by
```math
D=\frac{\left|a x_0+b y_0+c z_0+d\right|}{\sqrt{a^2+b^2+c^2}}
```
where ``P(x_1.y_1,z_2)`` on the plane.

"""

# ╔═╡ 8e9693d1-3804-4f05-89b8-16d5ed2a5288
cm"""
$(ex(6,"Finding the Distance Between Two Parallel Planes"))
Two parallel planes, ``3 x-y+2 z-6=0`` and ``6 x-2 y+4 z+4=0``, find the distance between them.
"""

# ╔═╡ a97666b0-60ee-4399-8a9e-5f8551b31ae7
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

# ╔═╡ db120bce-efb1-4290-a94b-6cb0c94b61b6
cm"""
$(define("Skew Lines"))
Two lines in space are __skew__ if they are neither parallel nor intersecting.
"""

# ╔═╡ b3fdfb31-a5f9-46ee-84cf-00aa58560960
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

# ╔═╡ 8c5c067c-6516-496d-a171-b9b1bb48544d
cm"""
$(define("Cylinder"))
Let ``C`` be a curve in a plane and let ``L`` be a line not in a parallel plane. The set of all lines parallel to ``L`` and intersecting ``C`` is a __cylinder__. The curve ``C`` is the __generating curve__ (or __directrix__) of the cylinder, and the parallel lines are __rulings__.

$(post_img("https://www.dropbox.com/scl/fi/q0pbnl6g4n9ouhf0kbf4v/fig_11_57.png?rlkey=k0julsbb28j2liez5723p4hz7&dl=1"))
"""

# ╔═╡ d7a436c8-783c-4fe6-88cc-2118d6ca9ae4
cm"""
$(ex(1,"Sketching a Cylinder"))
Sketch the surface represented by each equation.
- (a.) ``z=y^2``
- (b.) ``z=\sin x, \quad 0 \leq x \leq 2 \pi``
"""

# ╔═╡ f17896e2-a696-4eeb-9049-c27302971f1f
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

# ╔═╡ 28789dce-b106-4c6a-aed9-4faa659d9706
cm"""
$(post_img("https://www.dropbox.com/scl/fi/loxxo1654l5ae0czqq0hg/quadratic_surfaces_1.png?rlkey=l7entrslfedfizipo2kae4ja4&dl=1",500))

$(post_img("https://www.dropbox.com/scl/fi/gie6mrs9mrd2do68ukysh/quadratic_surfaces_2.png?rlkey=dqtmhedg3h6078bgbiifm4hey&dl=1",500))
"""

# ╔═╡ 2f2c7b86-cb1d-4796-9717-76653a441b88
cm"""
$(ex(2,"Sketching a Quadric Surface"))
Classify and sketch the surface
```math
4 x^2-3 y^2+12 z^2+12=0
```
"""

# ╔═╡ 2aa9d376-fa6c-4b2b-9a3a-0b307caad4db
cm"""
$(ex(3,"Sketching a Quadric Surface"))
Classify and sketch the surface
```math
x-y^2-4 z^2=0
```
"""

# ╔═╡ a09252fe-4153-4416-8970-e6d7ce980b15
cm"""
$(ex(4,"A Quadric Surface Not Centered at the Origin"))
Classify and sketch the surface
```math
x^2+2 y^2+z^2-4 x+4 y-2 z+3=0
```
"""

# ╔═╡ da9230a6-088d-4735-b206-9514c12dd223
initialize_eqref()

# ╔═╡ 107407c8-5da0-4833-9965-75a82d84a0fb
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
</style>

</style>
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
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
CommonMark = "~0.8.15"
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.3.1"
Latexify = "~0.16.5"
PlotThemes = "~3.2.0"
Plots = "~1.40.8"
PlutoExtras = "~0.7.13"
PlutoUI = "~0.7.60"
PrettyTables = "~2.4.0"
QRCoders = "~1.4.5"
Symbolics = "~6.15.3"
Unitful = "~1.22.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "0a4dba39da0a41b47f84f534c194cf631fed203e"

[[deps.ADTypes]]
git-tree-sha1 = "eea5d80188827b35333801ef97a40c2ed653b081"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.9.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

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
deps = ["CompositionsBase", "ConstructionBase", "InverseFunctions", "LinearAlgebra", "MacroTools", "Markdown"]
git-tree-sha1 = "b392ede862e506d451fc1616e79aa6f4c673dab8"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.38"

    [deps.Accessors.extensions]
    AccessorsAxisKeysExt = "AxisKeys"
    AccessorsDatesExt = "Dates"
    AccessorsIntervalSetsExt = "IntervalSets"
    AccessorsStaticArraysExt = "StaticArrays"
    AccessorsStructArraysExt = "StructArrays"
    AccessorsTestExt = "Test"
    AccessorsUnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    Requires = "ae029012-a4dd-5104-9daa-d747884805df"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "d80af0733c99ea80575f612813fa6aa71022d33a"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.0"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
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
git-tree-sha1 = "3640d077b6dafd64ceb8fd5c1ec76f7ca53bcf76"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.16.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
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
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bijections]]
git-tree-sha1 = "d8b0439d2be438a5f2cd68ec158fe08a7b2595b7"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.1.9"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "3e4b134270b372f2ed4d4d0e936aabaefc1802bc"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

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
deps = ["Crayons", "PrecompileTools"]
git-tree-sha1 = "3faae67b8899797592335832fccf4b3c80bb04fa"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.15"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

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
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
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
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

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
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

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
git-tree-sha1 = "3101c32aab536e7a27b1763c0797dba151b899ad"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.113"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "490392af2c7d63183bfa2c8aaa6ab981c5ba7561"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.7.14"

    [deps.DomainSets.extensions]
    DomainSetsMakieExt = "Makie"

    [deps.DomainSets.weakdeps]
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DynamicPolynomials]]
deps = ["Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Reexport", "Test"]
git-tree-sha1 = "bbf1ace0781d9744cb697fb856bd2c3f6568dadb"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.Expronicon]]
deps = ["MLStyle", "Pkg", "TOML"]
git-tree-sha1 = "fc3951d4d398b5515f91d7fe5d45fc31dccb3c9b"
uuid = "6b7a57c9-7cc1-4fdf-b7f5-e857abae3636"
version = "0.8.5"

[[deps.Extents]]
git-tree-sha1 = "81023caa0021a41712685887db1fc03db26f41f5"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.4"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "82d8afa92ecf4b52d78d869f038ebfb881267322"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
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
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "b5c7fe9cea653443736d264b85466bad8c574f4a"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.9.9"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

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
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "ec632f177c0d990e64d955ccc1b8c04c485a0950"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.6"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "629693584cef594c3f6f99e76e7a7ad17e60e8d5"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a8863b69c2a0859f2c2c87ebdc4c6712e88bdf0d"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.7+0"

[[deps.GeoFormatTypes]]
git-tree-sha1 = "59107c179a586f0fe667024c5eb7033e81333271"
uuid = "68eda718-8dee-11e9-39e7-89f7f65f511f"
version = "0.4.2"

[[deps.GeoInterface]]
deps = ["Extents", "GeoFormatTypes"]
git-tree-sha1 = "2f6fce56cdb8373637a6614e14a5768a88450de2"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.3.7"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "b62f2b2d76cee0d61a2ef2b3118cd2a3215d3134"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.11"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "43ba3d3c82c18d88471cfd2924931658838c9d8f"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+4"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "674ff0db93fffcd11a3573986e550d66cd4fd71f"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.5+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "401e4f3f30f43af2c8478fc008da50096ea5240f"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.3.1+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "7c4195be1649ae622304031ed46a2f4df989f1eb"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.24"

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
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

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
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils", "Libdl", "Pkg", "Random"]
git-tree-sha1 = "5bc1cb62e0c5f1005868358db0692c994c3a13c6"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d65554bad8b16d9562050c67e7223abf91eaba2f"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.13+0"

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
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
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
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "39d64b09147620f5ffbf6b2d3255be3c901bec63"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.8"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "f389674c99bfcde17dc57454011aa44d5a260a40"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "9fd170c4bbfd8b935fdc5f8b7aa33532c991a673"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.11+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fbb1f2bef882392312feb1ede3615ddc1e9b99ed"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.49.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0c4f9c4f1a50d8f35048fa0532dabbadf702f81e"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "fa7fd067dca76cadd880f1ca937b4f387975a9f5"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.16.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

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
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MLStyle]]
git-tree-sha1 = "bc38dff0548128765760c79eb7388a4b37fae2c8"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.17"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.MarchingCubes]]
deps = ["PrecompileTools", "StaticArrays"]
git-tree-sha1 = "27d162f37cc29de047b527dab11a826dd3a650ad"
uuid = "299715c1-40a9-479a-aaf9-4a633d36f717"
version = "0.1.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

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

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "8d39779e29f80aa6c071e7ac17101c6e31f075d7"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.5.7"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "90077f1e79de8c9c7c8a90644494411111f4e07b"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.5.2"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "1a27764e945a152f7ca7efa04de513d473e9542e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.1"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "f4cb457ffac5f5cf695699f82c537073958a6a6c"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.2+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7493f61f55a6cce7325f197443aa80d32554ba10"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
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
git-tree-sha1 = "6e55c6841ce3411ccb3457ee52fc48cb698d6fb0"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.2.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "45470145863035bb124ca51b320ed35d071cc6c2"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.8"

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
git-tree-sha1 = "681f89bdd5c1da76b31a524af798efb5eb332ee9"
uuid = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
version = "0.7.13"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "8f6bc219586aef8baf0ff9a5fe16ee9c70cb65e4"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.2"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.QRCoders]]
deps = ["FileIO", "ImageCore", "ImageIO", "ImageMagick", "StatsBase", "UnicodePlots"]
git-tree-sha1 = "b3e5fcc7a7ade2d43f0ffd178c299b7a264c268a"
uuid = "f42e9828-16f3-11ed-2883-9126170b272d"
version = "1.4.5"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "492601870742dcd38f233b23c3ec629628c1d724"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.7.1+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "e5dd466bf2569fe08c91a2cc29c1003f4797ac3b"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.7.1+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "1a180aeced866700d4bebc3120ea1451201f16bc"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.7.1+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "729927532d48cf79f49070341e1d918a65aba6b0"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.7.1+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

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
git-tree-sha1 = "b034171b93aebc81b3e1890a036d13a9c4a9e3e0"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "3.27.0"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsFastBroadcastExt = "FastBroadcast"
    RecursiveArrayToolsForwardDiffExt = "ForwardDiff"
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsReverseDiffExt = ["ReverseDiff", "Zygote"]
    RecursiveArrayToolsSparseArraysExt = ["SparseArrays"]
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    FastBroadcast = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "04c968137612c4a5629fa531334bb81ad5680f00"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.13"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "98ca7c29edd6fc79cd74c61accb7010a4e7aee33"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.6.0"

[[deps.SciMLBase]]
deps = ["ADTypes", "Accessors", "ArrayInterface", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "Expronicon", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "PrecompileTools", "Preferences", "Printf", "RecipesBase", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLOperators", "SciMLStructures", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface"]
git-tree-sha1 = "26fea1911818cd480400f1a2b7f6b32c3cc3836a"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "2.56.4"

    [deps.SciMLBase.extensions]
    SciMLBaseChainRulesCoreExt = "ChainRulesCore"
    SciMLBaseMakieExt = "Makie"
    SciMLBasePartialFunctionsExt = "PartialFunctions"
    SciMLBasePyCallExt = "PyCall"
    SciMLBasePythonCallExt = "PythonCall"
    SciMLBaseRCallExt = "RCall"
    SciMLBaseZygoteExt = "Zygote"

    [deps.SciMLBase.weakdeps]
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    PartialFunctions = "570af359-4316-4cb7-8c74-252c00c2016b"
    PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
    PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
    RCall = "6f49c342-dc21-5d91-9882-a32aef131414"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.SciMLOperators]]
deps = ["Accessors", "ArrayInterface", "DocStringExtensions", "LinearAlgebra", "MacroTools"]
git-tree-sha1 = "ef388ca9e4921ec5614ce714f8aa59a5cd33d867"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "0.3.11"
weakdeps = ["SparseArrays", "StaticArraysCore"]

    [deps.SciMLOperators.extensions]
    SciMLOperatorsSparseArraysExt = "SparseArrays"
    SciMLOperatorsStaticArraysCoreExt = "StaticArraysCore"

[[deps.SciMLStructures]]
deps = ["ArrayInterface"]
git-tree-sha1 = "25514a6f200219cd1073e4ff23a6324e4a7efe64"
uuid = "53ae85a6-f571-4167-b2af-e1d143709226"
version = "1.5.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

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
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "eeafab08ae20c62c44c8399ccb9354a04b80db50"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.7"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"
weakdeps = ["ChainRulesCore", "InverseFunctions"]

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "f4dc295e983502292c4c3f951dbb4e985e35b3be"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.18"
weakdeps = ["Adapt", "GPUArraysCore", "SparseArrays", "StaticArrays"]

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = "GPUArraysCore"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.SymbolicIndexingInterface]]
deps = ["Accessors", "ArrayInterface", "RuntimeGeneratedFunctions", "StaticArraysCore"]
git-tree-sha1 = "4bc96df5d71515b1cb86dd626915f06f4c0d46f5"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.3.33"

[[deps.SymbolicLimits]]
deps = ["SymbolicUtils"]
git-tree-sha1 = "fabf4650afe966a2ba646cabd924c3fd43577fc3"
uuid = "19f23fe9-fdab-4a78-91af-e7b7767979c3"
version = "0.2.2"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "ArrayInterface", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "IfElse", "LinearAlgebra", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "TermInterface", "TimerOutputs", "Unityper"]
git-tree-sha1 = "04e9157537ba51dad58336976f8d04b9ab7122f0"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "3.7.2"

    [deps.SymbolicUtils.extensions]
    SymbolicUtilsLabelledArraysExt = "LabelledArrays"
    SymbolicUtilsReverseDiffExt = "ReverseDiff"

    [deps.SymbolicUtils.weakdeps]
    LabelledArrays = "2ee39098-c373-598a-b85f-a56591580800"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.Symbolics]]
deps = ["ADTypes", "ArrayInterface", "Bijections", "CommonWorldInvalidations", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "DynamicPolynomials", "IfElse", "LaTeXStrings", "Latexify", "Libdl", "LinearAlgebra", "LogExpFunctions", "MacroTools", "Markdown", "NaNMath", "PrecompileTools", "Primes", "RecipesBase", "Reexport", "RuntimeGeneratedFunctions", "SciMLBase", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArraysCore", "SymbolicIndexingInterface", "SymbolicLimits", "SymbolicUtils", "TermInterface"]
git-tree-sha1 = "a083b653dc5ebf810e7cf5688679c26d0b62ffbb"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "6.15.3"

    [deps.Symbolics.extensions]
    SymbolicsForwardDiffExt = "ForwardDiff"
    SymbolicsGroebnerExt = "Groebner"
    SymbolicsLuxExt = "Lux"
    SymbolicsNemoExt = "Nemo"
    SymbolicsPreallocationToolsExt = ["PreallocationTools", "ForwardDiff"]
    SymbolicsSymPyExt = "SymPy"

    [deps.Symbolics.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Groebner = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
    Lux = "b2108857-7c20-44ae-9111-449ecde12c47"
    Nemo = "2edaba10-b0f1-5616-af89-8c11ac63239a"
    PreallocationTools = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

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
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

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
git-tree-sha1 = "657f0a3fdc8ff4a1802b984872468ae1649aebb3"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.1"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "3a6f063d690135f5c1ba351412c82bae4d1402bf"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.25"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
git-tree-sha1 = "c0667a8e676c53d390a09dc6870b3d8d6650e2bf"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.22.0"
weakdeps = ["ConstructionBase", "InverseFunctions"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unityper]]
deps = ["ConstructionBase"]
git-tree-sha1 = "25008b734a03736c41e2a7dc314ecb95bd6bbdb0"
uuid = "a7c27f48-0311-42f6-a7f8-2c11e75eb415"
version = "0.1.6"

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
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "1165b0443d0eca63ac1e32b8c0eb69ed2f4f8127"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "a54ee957f4c86b526460a720dbc882fa5edcbefc"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.41+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ac88fb95ae6447c8dda6a5503f3bafd496ae8632"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.6+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "bcd466676fef0878338c61e655629fa7bbc69d8e"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "936081b536ae4aa65415d869287d43ef3cb576b2"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.53.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "7dfa0fd9c783d3d0cc43ea1af53d69ba45c447df"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─71bc54d5-d0ed-42d3-9bc1-48aa86e91d1d
# ╟─e414122f-b93a-4510-b8ae-026c303e0df9
# ╟─8408e369-40eb-4f9b-a7d7-26cde3e34a74
# ╟─cd269caf-ef81-43d7-a1a8-6668932b6363
# ╟─109ff314-76c9-474f-b516-6bb17f1e0b62
# ╟─ee1e2234-cd28-4013-aef6-4af835af9465
# ╟─73107910-a89d-4f4a-8aeb-567aeca3e717
# ╟─277ad9ab-687c-4034-8a01-65e5cadb9a61
# ╟─58eb74fd-b5e5-4e41-bd2f-99d29dbdece8
# ╟─4026f2d0-ec69-4491-b4b7-313c501d7f50
# ╟─62611550-7596-412e-b492-1cfcab69d942
# ╟─356e2c2e-b9dd-4988-81a0-c87036998ec6
# ╟─b2f647d7-9fe4-4ab7-b251-8ba27485ae35
# ╟─b4eff26d-d34b-49b4-be8a-64cffaf2f431
# ╟─8a4f89a9-d0ee-4a4f-9f2e-ed2620247d50
# ╟─56158e41-0621-413d-958b-afb9939493d2
# ╟─cb90c129-362b-41c9-aadb-90b89ac1c3c1
# ╟─ed6f28c3-5edc-48a5-9ab6-99fdb660067a
# ╟─061935b4-9e9b-42ff-926f-e183cbf2de74
# ╟─109e181f-e208-4e42-8169-16582873f069
# ╟─586c9e7e-18d2-49ab-b12e-db30611f726b
# ╟─ec386f03-b425-4e7d-9539-06060d3b9057
# ╟─be94da4b-60cb-41c2-8dbd-05e96104e6c1
# ╟─e9c17c2a-342a-4de2-a6d7-7464bca2d166
# ╟─46c20239-40b8-4336-a575-13b120f42de9
# ╟─1c946ad8-f21c-4030-b4b3-b51ef163c8c0
# ╟─0c0b4d35-5c61-4a3c-b534-6e7437844706
# ╟─99e98559-8b42-4b3e-8667-bfabbcc07c6d
# ╟─161c8ffd-748e-407a-8948-13a9d7481766
# ╟─7e0aaff0-9f10-4f26-a204-4f5ccc0b7ed0
# ╟─1701aff4-76d8-4cbe-a477-8bd10987dd2f
# ╟─d580f679-2677-4bc1-957f-fa3db84403ad
# ╟─e0cb37ff-82c1-4ffc-90ef-7ec4b056da85
# ╟─84ee076f-c8f3-406e-8ef9-fb81e54130d0
# ╟─110286ce-3cec-4d66-88f2-311972ff9285
# ╟─cf66301b-be6e-4507-b471-b9b38481ef0e
# ╟─c0efef5c-a5cb-4b5f-89a1-557d62cecf3b
# ╟─83eaa558-cf7e-46de-9143-0085b12c2702
# ╟─80cd32aa-7156-4896-b76e-78869f8e5000
# ╟─0726ebd1-a83e-42ee-82f5-74dd930266f0
# ╟─2bef46e1-44b2-4dd3-92b1-d50b1a395b97
# ╟─3a115647-a0a9-4a0b-a939-729799a528a4
# ╟─5af5e402-69d2-4a09-8dd1-5ba91d482fe2
# ╟─aeef6042-2182-4068-8fb0-0fedc2badaec
# ╟─c1fe9952-c638-479a-a166-e95956f879ca
# ╠═7ebe5d0a-e565-4e2a-9fc2-8f2a852bf9c6
# ╟─3f565a27-fdc0-4209-9105-dc3f3ae3dfc2
# ╟─056b4af6-c433-497e-81e0-70bb3096bc3c
# ╟─ca784670-8225-4c3e-a4ee-8f7ab59adc85
# ╟─f8dcab6d-2926-43d3-ba9f-b4a50316038e
# ╟─ff6c91b7-d111-4b5b-88c0-a01e42fa3cf8
# ╟─c602fc93-2bdc-444f-9b2d-d20caf751a8f
# ╟─78b5718d-6c40-413d-b990-b8bbf6b323ba
# ╟─519d7317-a639-4d2d-9cb5-8647d6992eb2
# ╟─390823d7-4567-4782-823b-d7de116c4374
# ╟─dd8e4284-9ddc-43ba-93cb-00024faff337
# ╟─a671c82c-084b-4520-a82b-b66a41b4e5f8
# ╟─b69a0131-c8cd-4ba2-a124-548baa1bc52d
# ╟─5c4a9aa7-9223-46d7-91f9-f958e3be6eeb
# ╟─c3b508e4-913c-4e33-b759-7d15d31de0b4
# ╟─0fe1255e-5df0-477e-8999-4b93750b2a6f
# ╟─784aad5e-9618-4ab5-ac7a-0d0394abe25d
# ╟─35220a5b-a101-495e-b617-361510394818
# ╠═fee76b84-3a2d-487c-b034-84ba199a1b90
# ╟─11bbb488-8f5a-47ae-b8a6-c05d7cd01f45
# ╟─bceaaa97-8e13-45a4-ac8c-90d9e9280a75
# ╠═b76eefd7-10a2-4f8c-8a6d-57c0506e7df3
# ╠═1f2859ea-80c9-4918-a4fb-d9db5123cacb
# ╟─0abd3e51-8fe7-4d35-9d0b-23e03e01ab34
# ╟─cd2a10a5-9166-4754-b277-02efd8747eb3
# ╟─ad06e95d-2879-4039-84bc-07b7856e2d89
# ╟─352c4204-c676-47a6-887d-a3bdd5cc7d66
# ╟─f886e4c9-1fa1-45fa-b1b8-ffbca56c522a
# ╟─362222c0-5e65-4d84-8766-7d2fd678dd7b
# ╟─b6e05c6d-5124-4d6e-8160-c2b36cbee1d6
# ╟─96397bdb-4add-4b15-af28-076a0057e88b
# ╟─b294b1df-4b78-4aeb-bbb3-f943adcf4c13
# ╟─0e42e5fb-6a5b-4636-b8b6-309617e14256
# ╟─709ebbe9-c14a-4461-9367-adc512422e9e
# ╟─d38a523d-ac85-4a47-b099-80a0d2273233
# ╟─11a883eb-56a3-49ac-89d2-e7c9ffb2c043
# ╟─603bd8f0-a602-453a-9caf-a73303b78559
# ╟─f7c6fc51-4c31-4eca-a79b-766068558894
# ╟─a22ae8b2-7d44-40cf-ae4f-bebe3b5da083
# ╟─d8085786-1e5e-4c8a-9847-9948a23643fc
# ╟─c0475c93-9b5b-4f13-a045-114b824c1af2
# ╠═40cb2c1d-7387-4d02-a8f2-83d84ddf207f
# ╟─1d54944c-ef82-4237-ad76-62ed4e201577
# ╠═6f0edbab-49c3-4da1-a099-9ec899060383
# ╟─26e3fb79-48b1-4d69-a1b2-5364168e7a36
# ╟─4b6ded9a-929d-48d9-9649-6cd0a2dc38f7
# ╟─16395162-789a-4822-aaff-8a34b4e246f3
# ╟─8ba6d7b2-5a2b-4874-b31c-ef56dd617097
# ╟─fe2376f2-8de3-4163-94f1-b77c3c0e092e
# ╟─136624c5-6f20-4cc5-82f5-079b8f9c9618
# ╟─81101ecd-e335-4cc1-a503-4a62bd964118
# ╟─1135fb0d-4ef3-4d84-a487-940b1be56887
# ╟─ee6a4043-a6e8-466f-a262-f6ec04372c7d
# ╟─c448ff49-ac48-4019-9520-0d6ead2c5bd9
# ╟─1c3a4171-ffc3-46f9-8618-e74abeaef721
# ╟─6e84190d-302e-401c-91b8-775451b4dc37
# ╟─c68d34a8-bdf0-4516-a72c-cb047ebd4c7c
# ╟─2ec1ab72-fec7-43fe-9c5e-f4415bcb9f6a
# ╟─3d3598a8-5e3e-478a-ae71-c99772908426
# ╟─ced54357-381f-4ecd-a1f1-c3b397ac8185
# ╟─a17a0d9d-ebeb-4893-aba7-f0618e045511
# ╟─adad65b4-1106-41a3-a0ac-413e4072b0a1
# ╟─f75a4200-8ab9-421d-8b10-1ad5f6d279ce
# ╟─7dfefa60-23cf-4d9d-b768-c26c2fba8bf6
# ╟─8629cb44-2eda-40c1-afe1-e2a80f207ff0
# ╟─15b84eda-16bc-4255-9e0b-8eb04abdf931
# ╟─f01c3fb1-6331-4a1f-acab-9243b577c0b7
# ╟─b638364c-6b12-44e5-b70b-a1260bd20423
# ╟─638a3b2e-23ff-45c5-9d4c-da3ea28dc123
# ╟─e409714e-9620-4699-86db-3371f34a3286
# ╟─dfa813df-1e71-4004-8327-d333a326648b
# ╟─67eaf1f0-d71d-4fb1-b782-d7b0e73e21fc
# ╟─9ffd817f-3680-4fdc-a369-f3f55e62c4a0
# ╟─e982617c-8230-4818-bd2f-223d31638735
# ╟─4a8731dd-a218-41eb-83ee-18afe812b53d
# ╟─8dea5ec4-8f71-42bb-bb4d-178db354a8de
# ╟─641296c7-72ca-4d28-b55a-c6495edcfdd4
# ╟─7752454b-924b-4290-846e-83680faa1807
# ╟─6a4c706b-ee37-4a33-82b0-99e8e8db6fa9
# ╟─1e816ba7-2ec6-46bd-b349-bea20140111c
# ╟─073611bb-04e2-40a5-8a28-31ea5a435da4
# ╟─a97991f4-dab7-473a-b5a5-d9002384cafc
# ╟─0c5db57b-b294-4d8c-9984-0b289e1d1495
# ╟─da6a09ec-523d-4612-979d-3c55b28288ce
# ╟─869abdcb-84b5-4d96-a101-0293a2d4c1e2
# ╟─dd53c61c-fa51-4788-ba6a-4599c67b9313
# ╟─0859018b-198b-467a-8a64-5f399ccb4c30
# ╟─7253a177-0997-4620-84cd-4c362412b723
# ╟─9c11772f-dc9b-48f4-8bf5-966cdadc2363
# ╟─c139972c-24bd-445f-b95e-ded16e2eba64
# ╟─effc20dc-3097-46bd-a7d6-afe882033a05
# ╟─c3980348-6644-48e6-97f4-8d6ed91547bc
# ╟─51696239-3ed3-484b-874a-64979a5cd91b
# ╟─08370e88-8f77-44ba-a93a-51e90c7818fa
# ╟─ba9914cc-7b24-45c8-b9f7-2e7e33ec8132
# ╟─a37acdbb-34f2-4643-808a-e5afe817088b
# ╟─efabadf1-c3c5-4c9c-9bae-4eadd3d5a033
# ╟─217bbde3-e3cf-4e4f-94c7-7d139941ed3f
# ╟─4487bfe5-df36-41d6-93dd-97e1242f2ae3
# ╟─a75f9328-3c26-4e09-9688-4da4b11aefc5
# ╟─3235aa71-3bb9-4b19-92c5-3026e5dbd1c5
# ╟─daea6ac7-a442-4f05-a7bf-192a0a48bfee
# ╟─0f279112-e03e-403e-b131-6f6a934a427a
# ╟─68436e91-4c49-4eb9-b744-884b9321feff
# ╟─3794c467-23d0-472f-9d05-7ddf1fc0d5db
# ╟─9a1d80e4-8aa8-4216-8f6b-b4eee617d6a8
# ╠═4d568a88-31ee-415d-9b7a-dd68277e76cc
# ╟─038dd397-a465-401b-8e39-4d1a62010f51
# ╠═97cee0f8-4a2e-4cc1-b289-dfde9ee144c9
# ╟─b678c8fd-5f4d-4be0-8b89-2b5fd21a109a
# ╟─06908953-c831-4351-92f4-926d645eccd1
# ╟─b8c87b6e-fb0a-4b66-b8a0-4cd426c914f5
# ╟─688203a2-c7c7-45bf-96dc-e31e69e51092
# ╟─6a30bce0-3f06-4676-bd97-53d406f199ee
# ╟─055ddf9e-2174-43c2-bbfd-5d6c0ba2e567
# ╟─3cebbc76-7b88-4e3c-981d-6b4bf69ac017
# ╟─61427306-0a04-420a-bfd0-361742530e81
# ╠═4a8340ee-1c51-4be2-a703-2e8c5caf37b1
# ╟─e81a3b57-1139-40a7-8966-fb3b31e5cd05
# ╟─a0711cd1-1ce2-4786-8e0b-4b758c227dd2
# ╟─8f2713c1-e74c-4e84-b4c6-b4ab421d919b
# ╟─10e7b1ee-ccdd-49da-9e6e-8b26cd704f5f
# ╟─ceffc602-fad0-4310-b3c8-f0909e886879
# ╟─a00f7ba8-5f66-4145-ad18-ff69a6d4e535
# ╟─da52c005-f146-4fcc-95f5-627519d0c45e
# ╟─58d43afd-4045-44cb-a5c0-3883dc886ece
# ╟─bd55e0c7-1bdd-4cfb-89f2-5701a230a3cd
# ╟─63768194-bf80-4a28-8c15-224b4032cc40
# ╟─65d4fb31-ff0b-4ee1-a721-b2c2428cc81c
# ╟─85d082f1-bcc4-4858-b7d1-de721f9ab501
# ╟─2ff76dcb-2184-4096-9d88-b645bb3d8edb
# ╟─60a656f9-f93b-448c-8dac-8d5c128583a7
# ╟─c015b262-4b35-4c7c-8533-61402e5703e2
# ╠═63bddd53-9326-468a-89ac-6a8fd49dd32f
# ╟─660ac7bd-7537-4042-9400-5a0dd4532508
# ╟─8acf5369-439b-4294-bd1c-dd18095e8480
# ╟─18ef6c08-1ded-45cd-a0bb-106acb2552f2
# ╟─5624db18-ee2e-4133-bd21-5c768821344f
# ╠═2f7931f0-c907-425e-a582-8014e4e0ca11
# ╟─4bbdb2a2-2dd6-44a1-96b3-86a702a4a9c7
# ╟─8e9693d1-3804-4f05-89b8-16d5ed2a5288
# ╠═dd677f71-05e6-4e44-807b-42520c7924f5
# ╠═2be1d63d-2371-4d2b-b93d-fddeb49c451d
# ╟─a97666b0-60ee-4399-8a9e-5f8551b31ae7
# ╠═d553ce36-0b68-4b9d-a261-992162b0bf58
# ╟─32b036c0-92e1-40f7-8162-a2d8b4b43d90
# ╟─db120bce-efb1-4290-a94b-6cb0c94b61b6
# ╟─b3fdfb31-a5f9-46ee-84cf-00aa58560960
# ╟─f317bb32-dd20-45c1-8449-06b7f32672cd
# ╠═eac26ad2-d636-4b93-a562-d13b155f3609
# ╠═f803e12d-617e-478f-8593-5e5849384e1a
# ╟─5141e6da-d53b-4cb8-ad27-0a2666aac859
# ╟─b73636ec-e481-4c1b-acc9-5e77127c6c17
# ╟─8c5c067c-6516-496d-a171-b9b1bb48544d
# ╟─a001c05b-f12f-4dfb-a193-783a082fd0b8
# ╟─439bb6f7-3809-4fc6-83b1-d12ba556583d
# ╟─d7a436c8-783c-4fe6-88cc-2118d6ca9ae4
# ╟─0346f7e4-c32f-498a-80a3-12fb91431fd5
# ╟─d7ea9082-e9cb-4386-ba49-6b7812608587
# ╟─f17896e2-a696-4eeb-9049-c27302971f1f
# ╟─28789dce-b106-4c6a-aed9-4faa659d9706
# ╟─2f2c7b86-cb1d-4796-9717-76653a441b88
# ╟─2aa9d376-fa6c-4b2b-9a3a-0b307caad4db
# ╟─a09252fe-4153-4416-8970-e6d7ce980b15
# ╠═f2d4c2a5-f486-407b-b31b-d2efcc7476b3
# ╟─ef081dfa-b610-4c7a-a039-7258f4f6e80e
# ╟─da9230a6-088d-4735-b206-9514c12dd223
# ╟─107407c8-5da0-4833-9965-75a82d84a0fb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
