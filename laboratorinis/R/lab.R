library(tidyverse)
library(ggplot2)
data <- read_csv("lab_sodra.csv")
summary(data)

datafiltered <- data %>%
  filter(ecoActCode == 452000)

datafiltered%>%
  ggplot(aes(x = avgWage)) +
  geom_histogram(bins = 100)


data1 <- datafiltered %>%
  group_by(name) %>%
 summarise(avg = mean(avgWage)) %>%
  arrange(desc(avg))

data2 <- merge(datafiltered, data1)


data2%>%
  arrange(desc(avg))%>%
  head(60)%>%
ggplot(aes(x = month, y = avgWage, group = name)) + theme_minimal()+
  geom_line(aes(colour = name)) + geom_point(aes(color = name)) +
  theme(axis.text.x=element_blank())


data2 %>%
  arrange(desc(avg))%>%
  head(60)%>%
  group_by(name)%>%
  slice_max(numInsured, with_ties = FALSE)%>%
  head(5)%>%
ggplot(aes(x = reorder(name,-numInsured), y = numInsured)) + geom_col(aes(fill = name)) + 
  theme(axis.text.x=element_blank()) + xlab('name')


