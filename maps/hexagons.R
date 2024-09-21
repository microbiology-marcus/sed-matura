library(tidyverse)

# Create a dataframe of center points for hexagons
points <- data.frame(
  point = c("alpha", "beta", "gamma", "one", "two", "three", "x", "y", "z"),  # You can add more points here
  x = c(0, 2, 4, 1, 3, 5, 0, 2, 4),  # x-coordinates for centers of the hexagons
  y = c(0, 0, 0, 1, 1, 1, 2, 2, 2)   # y-coordinates for centers of the hexagons
)

# Radius of the hexagon's circumcircle
radius <- 2 / sqrt(3)

# Adjusted angles for the vertices of the hexagon (start at 30 degrees)
angles <- seq(30, 390, by = 60) * (pi / 180)

# Function to calculate hexagon vertices for a given center point
generate_hexagon <- function(center_x, center_y, point_label) {
  data.frame(
    point = point_label,
    x = center_x + radius * cos(angles),
    y = center_y + radius * sin(angles)
  )
}

# Apply corrective factors to the centers based on grid layout:
points_corrected <- points %>%
  mutate(
    # Correct vertical spacing between rows
    y_corrected = y * (3/2 * radius)
  )

# Generate hexagon vertices for each point in the corrected dataframe
hex_points <- points_corrected %>%
  group_by(point) %>%
  do(generate_hexagon(.$x, .$y_corrected, .$point)) %>%
  ungroup()

# Create the scatter plot using ggplot
ggplot(data = hex_points) +
  geom_polygon(aes(x = x, y = y, group = point, color = point), fill = NA) +
  geom_point(data = points_corrected, aes(x = x, y = y_corrected), color = "red", size = 3) +  # Highlight center points
  coord_equal() +  # Ensure aspect ratio is 1:1 for proper shape
  labs(title = "Hexagon Vertices with Corrected Staggering")
