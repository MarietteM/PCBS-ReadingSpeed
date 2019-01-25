### Load Packages ###
library(lme4)
library(dplyr)

### Read in Data ###
data_stats = read.table("data/data.txt", header = T, sep='\t') %>%
  filter(eye == "dominant_eye" | eye == "weak_eye")
  

# Things left to do
# Check for linearity
# Absence of Collinearity
# Check for homoskedasticity
# QQPlot
# Influential Data Points



### Start Data Analysis ###

## Create our initial model
minutes.model = lmer(minutes ~ eye + language + (1|subject_id) + (1|text_id),
                     data = data_stats, REML = FALSE)
summary(minutes.model)


# Create our first null model, assume chosen eye has no effect
minutes_null_eye.model = lmer(minutes ~ language + (1|subject_id) + (1|text_id), 
                              data = data_stats, REML = FALSE)
summary(minutes_null_eye.model)

# Using ANOVA, find importance of eye-dominance in the model

anova(minutes.model, minutes_null_eye.model)

# Here we find a p value of 2.22e-16, is this right?


#Create our second null model, assume native language has no effect
minutes_null_language.model = lmer(minutes ~ eye + (1|subject_id) + (1|text_id), 
                              data = data_stats, REML = FALSE)
summary(minutes_null_language.model)

#Using ANOVA, find important of language in model
anova(minutes.model, minutes_null_language.model)


## Because we created the model, we know there are no interactions between language
## and eye dominancy

# Check coefficients of minutes.model
coef(minutes.model)

#Check a model with random slopes
minutes.model = lmer(minutes ~ eye + language + (1+eye|subject_id) + (1+eye|text_id), 
                       data = data_stats, REML = FALSE)

coef(minutes.model)
