import pyvista as pv
import numpy as np


# Define the implicit function
def f(x, y, z):
    return x**2 - y**2 - z**2 - 1


# Create a grid
x = np.linspace(-3, 3, 100)
y = np.linspace(-3, 3, 100)
z = np.linspace(-3, 3, 100)

X, Y, Z = np.meshgrid(x, y, z, indexing="ij")
values = f(X, Y, Z)

# Create PyVista grid
grid = pv.ImageData()
grid.dimensions = (100, 100, 100)
grid.origin = (-3, -3, -3)
grid.spacing = (6 / 99, 6 / 99, 6 / 99)
grid.point_data["values"] = values.flatten(order="F")

# Extract isosurface
surface = grid.contour([0], scalars="values")

# Plot interactively
plotter = pv.Plotter()
plotter.add_mesh(surface, color="cyan", opacity=0.7, smooth_shading=True)
plotter.add_text("Hyperboloid: x² - y² - z² = 1", font_size=12)
plotter.show()
