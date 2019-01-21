### Load Packages ###
library(dplyr)
library(purrr)
library(ggplot2)

### Create Model Parameters ###
# Create Fixed Subject Variables
N_NATIVE_SUBJECTS = N_FOREIGN_SUBJECTS = as.integer(5)
N_SUBJECTS = N_NATIVE_SUBJECTS + N_FOREIGN_SUBJECTS
AVG_WPM_NATIVE = as.integer(250)
STD_WPM_NATIVE = as.integer(25)
AVG_WPM_FOREIGN = as.integer(215)
STD_WPM_FOREIGN = as.integer(40)

#Create Fixed Text Variables
N_TEXT = as.integer(5)
STD_Text_Difficulty = as.integer(5)
ORDER_OF_SUB = seq(1, 5, length.out = 5)


# Creat Non-Fixed Subject Effects
sub_effect_native = rnorm(N_NATIVE_SUBJECTS, AVG_WPM_NATIVE, STD_WPM_NATIVE) #Average Reading Speed of Native Subject
sub_effect_foreign = rnorm(N_FOREIGN_SUBJECTS, AVG_WPM_FOREIGN, STD_WPM_FOREIGN) #Average Reading Speed of Foreign Subject
eye_effect_dominant = rnorm(N_SUBJECTS, -3, 0.75) #Effect of using only dominant eye
eye_effect_weak = rnorm(N_SUBJECTS, -5, 1) #Effect of using only weak eye
eye_effect_both = rep(0, N_SUBJECTS)#Effect of subject using both eye (ie no effect)

#Attach Native Identification to Native Reading Times
data_subject_native = cbind(sub_effect_native, "native")
colnames(data_subject_native) = c("subject_speed", "language")

#Attach Foreign Identification to Foreigner Reading Times
data_subject_foreign = cbind(sub_effect_foreign, "foreign")
colnames(data_subject_foreign) = c("subject_speed", "language")

#Combine Reading Time, Eye Dominancy Data - add subject ID
data_subject = rbind(data_subject_native, data_subject_foreign) %>%
  cbind(eye_effect_dominant, eye_effect_weak, eye_effect_both) %>%
  data.frame()

#Add subject IDs
data_subject = mutate(data_subject, subject_id = rownames(data_subject))

# Create Non-Fixed Text Effects
text_effects = rnorm(N_TEXT, 0, STD_Text_Difficulty) #Text difficult effect
text_length = sample(45:90, N_TEXT) #Creates 45-90 "word" sample texts

#Combine Text Information, Difficulty and Length
data_text = cbind(text_effects, text_length) %>%
 data.frame()

#Change Column names, add text ID
colnames(data_text) = c("difficulty_penalty", "text_length")
data_text = mutate(data_text, text_id = rownames(data_text))

# List of future variabless to add:
#Fiction vs Non-Fiction


### Mixing Subject Data with Text Data ###

#Find all combinations of text and subjects
data_combined = expand.grid(data_text$text_id, data_subject$subject_id) %>%
  data.frame() 

#Reassign text and subject IDs
colnames(data_combined) = c("text_id", "subject_id")

#Combine all tables based on text and subject ID
data_combined = data_combined %>%
  inner_join(data_text) %>%
  inner_join(data_subject)

# Here I encounted a problem with the inner_join() function:
# "Warning Message: joining factor and character vector, coercing into character vector"
# Each of the columns had to be reconverted to numeric
# For some reason, columns from the data_subject first had to be converted
# to characters, otherwise there would be rounding despite the digits option

#Converting from factor to numeric
options(digits = 8)
data_combined$text_id = as.numeric(data_combined$text_id)
data_combined$subject_id = as.numeric(data_combined$subject_id)
data_combined$difficulty_penalty = as.numeric(data_combined$difficulty_penalty)
data_combined$text_length = as.numeric(data_combined$text_length)
data_combined$subject_speed = as.numeric(as.character(data_combined$subject_speed))
data_combined$eye_effect_dominant = as.numeric(as.character(data_combined$eye_effect_dominant))
data_combined$eye_effect_weak = as.numeric(as.character(data_combined$eye_effect_weak))
data_combined$eye_effect_both = as.numeric(as.character(data_combined$eye_effect_both))


### Create Simulated Reading Times ###

data_simulated = data_combined %>%
  mutate(reading_time_BE = text_length/(difficulty_penalty + subject_speed + eye_effect_both)) %>%
  mutate(reading_time_DE = text_length/(difficulty_penalty + subject_speed + eye_effect_dominant)) %>%
  mutate(reading_time_WE = text_length/(difficulty_penalty + subject_speed + eye_effect_weak))
  
### Quick Plot ###

reading_speeds_figs.plot = ggplot(data_simulated, aes(x = language, y = reading_time_BE)) + 
                                    geom_boxplot()


reading_speeds_figs.plot

subject_reading_speeds_figs.plot = ggplot(data_simulated, aes(x = factor(subject_id), y = reading_time_BE)) +
  geom_boxplot()

subject_reading_speeds_figs.plot





