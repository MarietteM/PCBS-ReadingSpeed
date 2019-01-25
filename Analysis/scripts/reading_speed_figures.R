### Read in Data ###
source("scripts/Reading_Speed_Simulator.R")

### Load Packages ###
library(ggplot2)
library(dplyr)

### Read in Data ###
data_figs = read.table("data/data.txt", header = T, sep='\t') %>%
  data.frame()

#Examine data
head(data_figs)
summary_native = summary(filter(data_figs, language == "native"))
summary_foreign = summary(filter(data_figs, language == "foreign"))


### Quick Plot ###

#Plot Reading Speed Speed Native vs Non-Native for Both Eyes
language_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = language, y = minutes)) + 
  geom_boxplot(fill = c("pink", "light blue"))
language_box.plot

#Plot minutes ~ eye*language
eye_native_box.plot = ggplot(filter(data_figs, eye == "dominant_eye" | eye == "weak_eye"), 
                            aes(x = factor(language), fill = factor(eye), y = minutes)) + 
                            geom_boxplot(position = position_dodge(width = .8))
eye_native_box.plot

#Plot Reading Speed of all subjects
subjects_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = factor(subject_id), fill = factor(language), y = minutes)) +
  geom_boxplot()
subjects_box.plot

#Plot Reading Speed of all texts
texts_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = factor(text_id), y = minutes)) +
  geom_boxplot()
texts_box.plot

#Plot Reading Speed based on eye conditions dominant vs weak
eyes_box.plot = ggplot(filter(data_figs, eye != "both_eyes" & eye != "prosthetic_eye"), aes(x = factor(eye), y = minutes )) +
  geom_boxplot(fill = c("pink", "light blue"))
eyes_box.plot

#Plot Reading Speed based on all eye conditions
eyes_box.plot = ggplot(data_figs, aes(x = factor(eye), y = minutes )) +
  geom_boxplot()
eyes_box.plot

