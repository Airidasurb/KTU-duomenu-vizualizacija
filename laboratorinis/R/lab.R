library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
data <- read_csv("../data/lab_sodra.csv")

data %>%
  filter(ecoActCode == 452000) %>%
  ggplot(aes(x = avgWage)) +
  geom_histogram(bins = 100)

filtered2 <- data %>%
  filter(ecoActCode == 452000) %>% group_by(code) %>% 
  summarise(suma = sum(avgWage)) %>% 
  arrange(desc(suma)) %>% head(5)
merged <- merge(filtered2, data, by = "code")

merged %>% 
  ggplot(aes(x = month, y = avgWage, group = name)) + theme_minimal()+
  geom_line(aes(colour = name)) + geom_point(aes(color = name)) +
  theme(axis.text.x=element_blank())


merged %>% group_by(name) %>% 
  summarise(maxNumInsured = max(numInsured)) %>% 
  ggplot(aes(x = reorder(name, -maxNumInsured), y = maxNumInsured, fill = name)) 
 + geom_col(aes(fill = name)) + 
  theme(axis.text.x=element_blank()) + xlab('name')
