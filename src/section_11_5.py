##############################################################
#  Animated Visualization of x² - y² - z² = 1
#  (Hyperboloid of Two Sheets)
#  Author: MATH201 TA (KFUPM)
#  Dependencies: pyvista, numpy, imageio
##############################################################

import pyvista as pv
import numpy as np


# Define the implicit function
def f(x, y, z):
    return x**2 - y**2 - z**2 - 1


# Create a grid for the implicit function
x = np.linspace(-3, 3, 150)
y = np.linspace(-3, 3, 150)
z = np.linspace(-3, 3, 150)

# Create 3D meshgrid
X, Y, Z = np.meshgrid(x, y, z, indexing="ij")

# Evaluate the function on the grid
values = f(X, Y, Z)

# Create a PyVista uniform grid
grid = pv.ImageData()
grid.dimensions = (150, 150, 150)
grid.origin = (-3, -3, -3)
grid.spacing = (6 / 149, 6 / 149, 6 / 149)
grid.point_data["values"] = values.flatten(order="F")

#################################################################
# 1️⃣  Animation 1: "Building the Hyperboloid"
#################################################################

print("Rendering Animation 1: Building the Hyperboloid...")

# Create plotter
plotter = pv.Plotter(off_screen=True)
plotter.add_text(
    "Hyperboloid of Two Sheets: x² - y² - z² = 1", position="upper_edge", font_size=12
)

# Set camera position
plotter.camera_position = [(8, 8, 8), (0, 0, 0), (0, 0, 1)]

# Open a movie file
plotter.open_movie("hyperboloid_growth.mp4", framerate=30)

# Animate by growing the x-range (start from xmax > 1 to ensure surface exists)
n_frames = 90
for i in range(n_frames):
    plotter.clear()

    # Start from 1.1 instead of 1.0 to ensure surface exists
    xmax = 1.1 + i * 0.02

    # Create subset grid
    x_cut = np.linspace(-xmax, xmax, 150)
    Y_cut, Z_cut = np.meshgrid(y, z, indexing="ij")

    # Create grid for each x slice
    values_cut = np.zeros((150, 150, 150))
    for idx, x_val in enumerate(x_cut):
        values_cut[idx, :, :] = f(x_val, Y_cut, Z_cut)

    grid_cut = pv.ImageData()
    grid_cut.dimensions = (150, 150, 150)
    grid_cut.origin = (-xmax, -3, -3)
    grid_cut.spacing = (2 * xmax / 149, 6 / 149, 6 / 149)
    grid_cut.point_data["values"] = values_cut.flatten(order="F")

    surface_cut = grid_cut.contour([0], scalars="values")

    # Only add mesh if it's not empty
    if surface_cut.n_points > 0:
        plotter.add_mesh(surface_cut, color="cyan", opacity=0.7, smooth_shading=True)

    # Rotate camera slightly
    plotter.camera.azimuth += 0.5

    # Write frame
    plotter.write_frame()

plotter.close()
print("✅ Animation 1 saved as hyperboloid_growth.mp4")

#################################################################
# 2️⃣  Animation 2: "Cross-Sections"
#################################################################

print("Rendering Animation 2: Cross-Sections...")

# Create plotter for second animation
plotter2 = pv.Plotter(off_screen=True)
plotter2.add_text(
    "Circular Cross-sections of x² - y² - z² = 1", position="upper_edge", font_size=12
)

# Set camera position
plotter2.camera_position = [(8, 8, 8), (0, 0, 0), (0, 0, 1)]

# Open movie file
plotter2.open_movie("hyperboloid_sections.mp4", framerate=30)

# Animate cross-sections
xvals = np.linspace(1.1, 3.0, 100)  # Start from 1.1 to ensure r > 0

for xval in xvals:
    plotter2.clear()

    # Calculate radius (will always be > 0 now)
    r = np.sqrt(xval**2 - 1)
    theta = np.linspace(0, 2 * np.pi, 200)
    y_circle = r * np.cos(theta)
    z_circle = r * np.sin(theta)

    # Two sheets: x = +xval and x = -xval
    # Create point arrays
    points_pos = np.column_stack([np.full_like(y_circle, xval), y_circle, z_circle])
    points_neg = np.column_stack([np.full_like(y_circle, -xval), y_circle, z_circle])

    # Create polylines
    circle_pos = pv.lines_from_points(points_pos, close=True)
    circle_neg = pv.lines_from_points(points_neg, close=True)

    plotter2.add_mesh(circle_pos, color="orange", line_width=3)
    plotter2.add_mesh(circle_neg, color="blue", line_width=3)

    # Rotate camera
    plotter2.camera.azimuth += 1.0
    plotter2.camera.elevation += 0.3

    # Write frame
    plotter2.write_frame()

plotter2.close()
print("✅ Animation 2 saved as hyperboloid_sections.mp4")
print("🎉 Done! Both animations saved in current directory.")
