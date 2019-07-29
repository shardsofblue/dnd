### Scatterplot graph with trendline, axes reversed
# CSAs to call out
callout_ls <- c("Canton", "Clifton-Berea", "Greater Roland Park/Poplar Hill", "Greenmount East")

## Revised graph
csa_tree_temp_demographics %>%
  # Start ggplot and set x and y for entire plot
  ggplot(aes(
    x = percent_of_family_households_living_below_the_poverty_line/100, 
    y = `09-63_mean`
    )) +
  # This section for the basic scatterplot
  geom_point(aes(color = `09-63_mean`),
             size=4) +
  # This section shows the trend line
  geom_smooth(se = FALSE, # Removes gray banding
              #method = loess, method.args = list(family = "symmetric"), # Reduces outlier effect
              color = "black"
  ) +
  # This section for circling all sample neighborhood points
  geom_point(data = csa_tree_temp_demographics %>%
               filter(csa2010 %in% callout_ls),
             aes(color = `09-63_mean`),
             size=6, shape = 1) +
  # This section for labeling Canton, etc.
  ggrepel::geom_label_repel(data = csa_tree_temp_demographics %>%
                              filter(csa2010 %in% callout_ls) %>%
                              mutate(csa2010 = case_when(
                                csa2010 == "Greenmount East" ~ "Greenmount East \n(includes part of Broadway East)", 
                                csa2010 == "Clifton-Berea" ~ "Clifton-Berea \n(includes part of Broadway East)",
                                T ~ csa2010)),
            aes(label = csa2010),
            min.segment.length = .1,
            segment.alpha = .5,
            alpha = .85,
            nudge_x = .05,
            nudge_y = .05) +
  # This section for labeling Patterson Park (so it can be nudged)
  ggrepel::geom_label_repel(data = csa_tree_temp_demographics %>%
                              filter(csa2010 == "Patterson Park North & East") %>%
                              mutate(csa2010 = case_when(
                                csa2010 == "Patterson Park North & East" ~ "Patterson Park North & East \n(includes most of McElderry Park)",
                                T ~ csa2010)),
                            aes(label = csa2010),
                            min.segment.length = .1,
                            segment.alpha = .5,
                            alpha = .85,
                            nudge_x = -.05,
                            nudge_y = -.05) +
  # Colors and label formatting follow
  #coord_flip() +
  scale_colour_gradient(low = "#E0FEA9", high = "#144A11") +
  labs(title = "Poverty to Tree Canopy",
       subtitle = "Percent of households living below the poverty line \ncompared to the percent of tree cover",
       x = "Percent of households living below the poverty line",
       y = "") +
  scale_x_continuous(label = scales::percent_format(accuracy = 1.0),
                     breaks = seq(0, 1, .1)) + 
  scale_y_continuous(label = scales::percent_format(accuracy = 1.0),
                     breaks = seq(0, 1, .1)) + 
  theme_bw() +
  theme(legend.position = "none",
        plot.title = element_text(size = 20),
        plot.subtitle = element_text(size = 12))

# Save to file
ggsave(filename = "poverty-to-mean-tree-cover2.png",
       device = "png", path = here("data", "output-data", "income-to-treecover"),
       width = 6, height = 6, units = "in")
