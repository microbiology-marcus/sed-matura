import pandas as pd
import plotly.graph_objects as go
from math import cos, sin, pi

# Load points from an external CSV file
points = pd.read_csv('electoral_districts.csv')

# Ensure the CSV contains the necessary columns
if not all(col in points.columns for col in ['point', 'x', 'y']):
    raise ValueError("CSV must contain 'point', 'x', and 'y' columns.")

# Radius of the hexagon's circumcircle
radius = 2 / (3 ** 0.5)

# Adjusted y-coordinates for staggering the hexagons
points['y_corrected'] = points['y'] * (3 / 2 * radius)

# Angles for the vertices of the hexagon (start at 30 degrees)
angles = [30, 90, 150, 210, 270, 330]
angles = [angle * pi / 180 for angle in angles]  # Convert to radians

# Create a list of hexagons
hexagons = []
for index, row in points.iterrows():
    hexagon = [(row['x'] + radius * cos(angle), row['y_corrected'] + radius * sin(angle)) for angle in angles]
    hexagons.append(hexagon)

# Create the Plotly figure
fig = go.Figure()

# Add hexagons to the figure
for hexagon, point_name in zip(hexagons, points['point']):
    x_hex, y_hex = zip(*hexagon)
    fig.add_trace(go.Scatter(x=x_hex, y=y_hex, fill='toself', name=point_name, mode='lines+markers'))

# Add center points
fig.add_trace(go.Scatter(x=points['x'], y=points['y_corrected'], mode='markers+text', 
                         marker=dict(color='red', size=10), text=points['point'], textposition="top center"))

# Update layout
fig.update_layout(title='Electoral Map', showlegend=False)
fig.write_html('electoral_map.html')

# Optionally, show the plot
fig.show()