library(tidyverse)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

df <- read.table("teams_per_year.txt", header = T)

melt(df, id.vars = "year") %>%
  filter(variable != "pct") %>%
  ggplot(aes(x = year, y = value, col = variable)) +
  geom_line(size=1.1) +
  theme_minimal() +
  scale_color_brewer(palette = "Dark2",labels = c("regualar season", "playoffs")) +
  labs(y = "number of teams") +
  theme(legend.title=element_blank(),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 12))

ggsave(file = "plt.svg", width = 7, height = 5)

melt(df, id.vars = "year") %>%
  filter(variable == "pct") %>%
  ggplot(aes(x = year, y = value)) +
  geom_line(size=1.1) +
  theme_bw() + 
  #coord_cartesian(ylim = c(0,1)) +
  theme_minimal() +
  labs(y = "percentage of teams making the playoffs")
