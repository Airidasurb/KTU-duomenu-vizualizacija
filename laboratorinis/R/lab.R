library(tidyverse)
library(ggplot2)
data <- read_csv("lab_sodra.csv")
summary(data)

data%>%
  filter(ecoActCode == 452000)%>%
  ggplot(aes(x = avgWage)) +
  geom_histogram(bins = 100)


data1 <- data %>%
  filter(ecoActCode == 452000) %>%
  group_by(name) %>%
 summarise(avg = mean(avgWage)) %>%
  arrange(desc(avg))

data3 <- merge(data, data1)


data3%>%
  arrange(desc(avg))%>%
  head(60)%>%
ggplot(aes(x = month, y = avgWage, group = name)) + theme_minimal()+
  geom_line(aes(colour = as.factor(name))) + theme(axis.text.x=element_blank())







