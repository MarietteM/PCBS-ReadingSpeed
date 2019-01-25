### Load Packages ###
library(ggplot2)
library(dplyr)

### Read in Data ###
data_clean = read.table("data/data.txt", header = T, sep='\t')


reading_data = subset(data_clean, select = c("reading_time_BE", "reading_time_DE", "reading_time_WE", "reading_time_PE"))
head(reading_data)

reading_data_t = t(reading_data)
