library(tidyverse)
library(reshape2)
library(RColorBrewer)

df <- read.table("playoff_teams_per_year.txt", header = T)

long_df <- melt(df, id.vars = "year") %>%
  filter(variable != "pct")

long_df$variable <- factor(long_df$variable,
                           ordered = T,
                           levels = (c("teams", "playoffs")))

long_df %>%
  ggplot(aes(x = year, y = value, col = variable)) +
  geom_line(size=1.1) +
  theme_bw() +
  scale_color_brewer(palette = "Dark2",
                     labels = c("\n\nregualar\nseason\nteams", "\nplayoffs\nteams")) +
  labs(y = "") +
  theme(legend.title=element_blank(),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 12))

ggsave(file = "plt.svg", width = 6, height = 4)

melt(df, id.vars = "year") %>%
  filter(variable == "pct") %>%
  ggplot(aes(x = year, y = value, col = variable)) +
  geom_line(size=1.1) +
  theme_bw() + 
  scale_color_brewer(palette = "Dark2",
                     labels = c("\nplayoff\nspots (%)")) +
  #coord_cartesian(ylim = c(0,1)) +
  theme_bw() +
  labs(y = "") +
  theme(legend.title=element_blank(),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 12))

ggsave(file = "plt2.svg", width = 6, height = 4)
