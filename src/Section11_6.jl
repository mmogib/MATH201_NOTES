##############################################################
#  Animated Visualization of x² - y² - z² = 1
#  (Hyperboloid of Two Sheets)
#  Author: MATH201 TA (KFUPM)
#  Dependencies: GLMakie.jl
##############################################################

using GLMakie
using GeometryBasics  # For Vec3f

# Define the implicit function
f(x, y, z) = x^2 - y^2 - z^2 - 1

# Common grid for all plots
x = range(-3, 3, length=150)
y = range(-3, 3, length=150)
z = range(-3, 3, length=150)

#################################################################
# 1️⃣  Animation 1: "Building the Hyperboloid"
#################################################################

println("Rendering Animation 1: Building the Hyperboloid...")

fig1 = Figure(size=(900, 700))
ax1 = Axis3(fig1[1, 1],
    title="Hyperboloid of Two Sheets: x² - y² - z² = 1",
    aspect=(1, 1, 1),
    xlabel="x", ylabel="y", zlabel="z"
)

# Initial contour
data = [f(xi, yi, zi) for xi in x, yi in y, zi in z]
contour!(
    ax1,
    (-3, 3),   # Use tuple notation
    (-3, 3),
    (-3, 3),
    data;
    levels=[0],
    colormap=:viridis,
    alpha=0.5
)

record(fig1, "hyperboloid_growth.mp4", 1:90; framerate=30) do i
    xmax = 1 + i * 0.02
    xcut = range(-xmax, xmax, length=150)
    d = [f(xi, yi, zi) for xi in xcut, yi in y, zi in z]
    contour!(ax1, (-xmax, xmax), (-3, 3), (-3, 3), d;
        levels=[0], colormap=:viridis, alpha=0.5)
    xlims!(ax1, -3, 3)
    ylims!(ax1, -3, 3)
    zlims!(ax1, -3, 3)

    # Rotate camera using azimuth
    ax1.azimuth[] = ax1.azimuth[] + 0.02
end

println("✅ Animation 1 saved as hyperboloid_growth.mp4")

#################################################################
# 2️⃣  Animation 2: "Cross-Sections"
#################################################################

println("Rendering Animation 2: Cross-Sections...")

fig2 = Figure(size=(900, 700))
ax2 = Axis3(fig2[1, 1],
    title="Circular Cross-sections of x² - y² - z² = 1",
    aspect=(1, 1, 1),
    xlabel="x", ylabel="y", zlabel="z"
)

# Create observables for the lines
line1 = Observable(Point3f[])
line2 = Observable(Point3f[])

lines!(ax2, line1, color=:orange, linewidth=3)
lines!(ax2, line2, color=:blue, linewidth=3)

xlims!(ax2, -3, 3)
ylims!(ax2, -3, 3)
zlims!(ax2, -3, 3)

record(fig2, "hyperboloid_sections.mp4", range(1.0, 3.0, length=100); framerate=30) do xval
    # Only draw when x^2 > 1
    if xval > 1
        r = sqrt(xval^2 - 1)
        θ = range(0, 2π, length=200)
        yvals = r * cos.(θ)
        zvals = r * sin.(θ)

        # Two sheets: x = ±xval
        line1[] = [Point3f(xval, yvals[i], zvals[i]) for i in 1:length(yvals)]
        line2[] = [Point3f(-xval, yvals[i], zvals[i]) for i in 1:length(yvals)]
    else
        line1[] = Point3f[]
        line2[] = Point3f[]
    end

    # Rotate camera using azimuth and elevation
    ax2.azimuth[] = ax2.azimuth[] + 0.03
    ax2.elevation[] = ax2.elevation[] + 0.01
end

println("✅ Animation 2 saved as hyperboloid_sections.mp4")
println("🎉 Done! Both animations saved in current directory.")