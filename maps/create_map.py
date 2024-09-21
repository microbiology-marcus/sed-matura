import pandas as pd
import matplotlib.pyplot as plt
from math import cos, sin, pi

# Test data: Replace this later with your actual CSV of electoral districts
points = pd.DataFrame({
    'point': ['district_alpha', 'district_beta', 'district_gamma', 'district_delta', 'district_epsilon'],
    'x': [0, 2, 4, 1, 3],  # x-coordinates for centers of the hexagons
    'y': [0, 0, 0, 1, 1]   # y-coordinates for centers of the hexagons
})

# Radius of the hexagon's circumcircle
radius = 2 / (3 ** 0.5)

# Adjusted y-coordinates for staggering the hexagons using the specified factor
points['y_corrected'] = points['y'] * (3 / 2 * radius)

# Angles for the vertices of the hexagon (start at 30 degrees)
angles = [30, 90, 150, 210, 270, 330]
angles = [angle * pi / 180 for angle in angles]  # Convert to radians

# Function to calculate hexagon vertices for a given center point
def generate_hexagon(center_x, center_y):
    vertices = []
    for angle in angles:
        x = center_x + radius * cos(angle)
        y = center_y + radius * sin(angle)
        vertices.append((x, y))
    return vertices

# Initialize the plot
fig, ax = plt.subplots()
ax.set_aspect('equal')

# Iterate through points and plot hexagons
for index, row in points.iterrows():
    hexagon = generate_hexagon(row['x'], row['y_corrected'])
    hexagon.append(hexagon[0])  # Close the hexagon by adding the first point at the end
    
    # Extract x and y coordinates from the hexagon points
    xs, ys = zip(*hexagon)
    
    # Plot the hexagon as a polygon
    ax.plot(xs, ys, color='blue')
    
    # Plot the center point
    ax.plot(row['x'], row['y_corrected'], 'ro')  # Red dot for the center
    
    # Add labels for each district at the center
    ax.text(row['x'], row['y_corrected'], row['point'], ha='center', va='center', fontsize=8, color='black')

# Set background to white and remove axes
ax.set_facecolor('white')
ax.axis('off')

# Show the plot
plt.show()
