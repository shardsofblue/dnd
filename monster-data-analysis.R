## Analysis of monsters from the 5th edition of Dungeons and Dragons  ----

####################
## Load workspace ## ----
####################

#install.packages("tidyverse")
#install.packages("rvest")
#install.packages("tidyRSS")
#install.packages("httr")
#install.packages("data.table")
#install.packages("RCurl")
library(tidyverse)
library(data.table)
library(plyr)

# setwd("/Users/shardsofblue/Documents/data-projects/dnd")

# Turn off scientific notation
options(scipen = 999)

# For cleanup
# rm(list=ls())


# SHORTCUTS ----
# cmd-shft-m:     %>% 
# cmd-shft-c:     comment line/block
# cmd-opt-up/dn:  duplicate line
# cmd-rtrn:       run code line/block
# cmd-opt-e:      run code until EoF
# cmd-shft-r:     insert section break

# \

####################
## Notes ## ----
####################

# More data available on github, but must read in each creature from unique .md file: https://github.com/chisaipete/bestiary/tree/master/_creatures

## Do something about splitting allignments out by axes (good-evil, lawful-chaotic)

## Calculating damages based on average die rolls
# avg_die_roll_dmg = ((max + min) / 2) * num_dice
# min is always 1, so avg_die_roll_dmg = ((max + 1) / 2) * num_dice
# A creature's average_static_dmg = avg_die_roll_dmg + modifier
# Use regex to parse around the "d" and the "+"


####################
## Begin analysis ## ----
####################

# Load in basic stats from Endomorphism002 on Reddit/r/DnD
# https://www.reddit.com/r/DnD/comments/3dfose/5e_monster_manual_spreadsheet/
monster_db <- read_csv("5e-monsters_endomorphism002.csv") %>%
  rename_all(tolower) %>%
  drop_na(name) %>%
  mutate(cr = ifelse(cr == "1/2", ".5", cr)) %>%
  mutate(cr = ifelse(cr == "1/4", ".25", cr)) %>%
  mutate(cr = ifelse(cr == "1/8", ".125", cr)) %>%
  mutate_at(vars(matches("cr")), as.double)

# Monsters by region
by_region <- monster_db %>%
  select(name, arctic:urban) %>%
  mutate_all(~str_replace_all(., "NO", "0")) %>%
  mutate_all(~str_replace_all(., "YES", "1")) %>%
  gather(arctic:urban,
         key = region,
         value = value) %>%
  filter(value == "1") %>%
  select(-value) %>%
  mutate_at(vars(matches("region")), as.factor)

# How many monsters in each region?
by_region_summary <- by_region %>%
  group_by(region) %>%
  dplyr::summarize(num = n()) %>%
  arrange(desc(num)) %>%
  mutate(perc_of_total = round(100*(num/sum(num)), 2))

# Plot: regional distribution (BAR, FLIP)
ggplot(by_region, aes(x = region)) +
  geom_bar() +
  coord_flip()

# How many monsters from each book?
monster_db %>% 
  group_by(book) %>%
  dplyr::summarize(num = n())

# How many monsters of each type?
by_type_summary <- monster_db %>%
  group_by(type) %>%
  dplyr::summarize(num = n()) %>%
  arrange(desc(num)) %>%
  mutate(perc_of_total = round(100*(num/sum(num)), 2))

# Plot: monster numbers by type (BAR, FLIP, POSITION, LEGENDS and LABELS)
ggplot(monster_db) +
  geom_bar(aes(x = reorder(type, type, function(x)+length(x)), 
               fill = book),
           position = "dodge") +
  coord_flip() +
  theme(legend.position = "bottom") +
  labs(title = "Number of Monsters by Type",
       x = "",
       y = "",
       fill = "Source Book")

aes(x=reorder(Position,Position,
              function(x)-length(x)))

# Plot: AC distribution (HISTOGRAM, FACET WRAP)
ggplot(monster_db, aes(x = ac)) +
  geom_histogram(binwidth = 2.0) +
  facet_wrap(~ book, nrow = 1)

# Plot: AC distribution only in MM (FILTER WITHIN GGPLOT)
ggplot(data = filter(monster_db, book == "Monster Manual"),
       mapping = aes(x = ac)) +
  geom_histogram(binwidth = 2.0)
  
# How many spellcasting monsters?
monster_db %>% 
  group_by(`spellcasting?`) %>%
  dplyr::summarize(num = n())

  
  


  
  





