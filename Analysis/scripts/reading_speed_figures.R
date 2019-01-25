### Load Packages ###
library(ggplot2)

### Read in Data ###
data_figs = read.table("data/data.txt", header = T, sep='\t')

#Examine data
head(data_figs)
summary(data_figs)
which(is.na(data_figs$minutes))


### Quick Plot ###

#Plot Reading Speed Speed Native vs Non-Native for Both Eyes
language_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = language, y = minutes)) + 
  geom_boxplot()
language_box.plot

#Plot Reading Speed of minutes ~ eye*native
boxplot(minutes ~ eye*language, col = c("green", "pink"), filter(data_figs, eye == "dominant_eye" | eye == "prosthetic_eye"))

#Plot Reading Speed of all subjects
subjects_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = factor(subject_id), y = minutes)) +
  geom_boxplot()
subjects_box.plot

#Plot Reading Speed of all texts
texts_box.plot = ggplot(filter(data_figs, eye == "both_eyes"), aes(x = factor(text_id), y = minutes)) +
  geom_boxplot()
texts_box.plot

#Plot Reading Speed based on eye condition
eyes_box.plot = ggplot(filter(data_figs, eye != "prosthetic_eye"), aes(x = factor(eye), y = minutes )) +
  geom_boxplot()
eyes_box.plot

eyes_box.plot = ggplot(data_figs, aes(x = factor(eye), y = minutes )) +
  geom_boxplot()
eyes_box.plot

