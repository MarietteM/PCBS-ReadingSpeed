### Load Packages ###
library(dplyr)
library(purrr)
library(ggplot2)
library(reshape2)

### Create Model Parameters ###
# Create Fixed Subject Variables
N_NATIVE_SUBJECTS = N_FOREIGN_SUBJECTS = as.integer(30) #Create number of native/non-native subjects
N_SUBJECTS = N_NATIVE_SUBJECTS + N_FOREIGN_SUBJECTS #Find total number of subjects
AVG_WPM_NATIVE = as.integer(250) #Assign average reading speed for native subjects
STD_WPM_NATIVE = as.integer(12) #Assign standard deviation for native subjects
AVG_WPM_FOREIGN = as.integer(230) #Assign average reading speed for non-native subjects
STD_WPM_FOREIGN = as.integer(16) #Assign standard deviation for non-native subjects
EYE_EFFECT_COUNT = seq(1, 4,length.out = 4)

#Create Fixed Text Variables
N_TEXT = as.integer(15) #Number of simmulation texts
AVG_Text_Difficulty = as.integer(0) #Assign average text difficulty effect to be 0 WPM
STD_Text_Difficulty = as.integer(5) #Assign standard deviation of difficulty effect to be 5 WPM
#ORDER_OF_SUB = seq(1, 5, length.out = 5)


# Creat Non-Fixed Subject Effects
sub_effect_native = rnorm(N_NATIVE_SUBJECTS, AVG_WPM_NATIVE, STD_WPM_NATIVE) #Average Reading Speed of Native Subject, Normal Distribution
sub_effect_foreign = rnorm(N_FOREIGN_SUBJECTS, AVG_WPM_FOREIGN, STD_WPM_FOREIGN) #Average Reading Speed of Foreign Subject, Normal Distribution
eye_effect_dominant = rnorm(N_SUBJECTS, -3, 0.75) #Effect of using only dominant eye, -3 WPM AVG, 0.75 as STD
eye_effect_weak = rnorm(N_SUBJECTS, -5, 1) #Effect of using only weak eye, -5 WPM AVG, 1 as STD
eye_effect_both = rep(0, N_SUBJECTS)#Effect of subject using both eye (ie no effect)
eye_effect_prost = sample(-7:5, N_SUBJECTS, replace = TRUE) #Effect of "enhancement" retinal prosthetic


#Attach Native Identification to Native Reading Times
data_subject_native = cbind(sub_effect_native, "native")
colnames(data_subject_native) = c("subject_speed", "language")

#Attach Foreign Identification to Foreigner Reading Times
data_subject_foreign = cbind(sub_effect_foreign, "foreign")
colnames(data_subject_foreign) = c("subject_speed", "language")

#Combine Reading Time, Eye Dominancy Data from both subject groups
data_subject = rbind(data_subject_native, data_subject_foreign) %>%
  cbind(eye_effect_dominant, eye_effect_weak, eye_effect_both, eye_effect_prost) %>%
  data.frame()
  
#Add subject IDs
data_subject = cbind(data_subject, "subject_id" = 1:nrow(data_subject))

# Create Non-Fixed Text Effects
text_effects = rnorm(N_TEXT, AVG_Text_Difficulty, STD_Text_Difficulty) #Text difficult effect
text_length = sample(45:90, N_TEXT, replace = TRUE) #Creates 45-90 "word" sample texts, this is taken from original experiment design

#Combine Text Information, Difficulty and Length
data_text = cbind(text_effects, text_length) %>%
  data.frame()

#Change Column names, add text ID
colnames(data_text) = c("difficulty_penalty", "text_length")
data_text = cbind(data_text, "text_id" = 1:nrow(data_text)) 

### Mixing Subject Data with Text Data ###

#Create eye factor
eye = c("BE", "DE", "WE", "PE")

#Find all combinations of text and subjects
data_combined = expand.grid(data_text$text_id, data_subject$subject_id)

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
data_combined$text_id = as.numeric(data_combined$text_id)
data_combined$subject_id = as.numeric(data_combined$subject_id)
data_combined$difficulty_penalty = as.numeric(data_combined$difficulty_penalty)
data_combined$text_length = as.numeric(data_combined$text_length)
data_combined$subject_speed = as.numeric(as.character(data_combined$subject_speed))
data_combined$eye_effect_dominant = as.numeric(as.character(data_combined$eye_effect_dominant))
data_combined$eye_effect_weak = as.numeric(as.character(data_combined$eye_effect_weak))
data_combined$eye_effect_both = as.numeric(as.character(data_combined$eye_effect_both))
data_combined$eye_effect_prost = as.numeric(as.character(data_combined$eye_effect_prost))

### Create Simulated Reading Times ###

data_simulated_raw = data_combined %>%
  mutate(reading_time_BE = text_length/(difficulty_penalty + subject_speed + eye_effect_both)) %>% #Calculate Reading time with Both Eyes
  mutate(reading_time_DE = text_length/(difficulty_penalty + subject_speed + eye_effect_dominant)) %>% #Calculate Reading time with Dominant Eye
  mutate(reading_time_WE = text_length/(difficulty_penalty + subject_speed + eye_effect_weak)) %>% #Calculate Reading Time with Weak Eye
  mutate(reading_time_PE = text_length/(difficulty_penalty + subject_speed + eye_effect_prost)) #Calculate Reading time with prosthetic eye
  
#mutate(data_simulated_raw, case_id = seq(1, dim(data_simulated_raw)[1],length.out = dim(data_simulated_raw)[1])) #Add an identify factor for melt function below

### Save Simulated Data ###

# Saving Raw Data to see all values
write.table(data_simulated_raw,"data/data_raw.txt",sep="\t",row.names=TRUE) #Save ALL simulated data


# Saving Data a "researcher" would have
data_simulated_available = subset(data_simulated_raw, select = c(-difficulty_penalty, -subject_speed, #Remove categories of information not avaialbe to a researchers / outside of a simulation
  -eye_effect_both, -eye_effect_dominant, -eye_effect_prost, -eye_effect_weak)) %>%
  data.frame()

#Change column names to suitable variable names
colnames(data_simulated_available)[5] = "both_eyes"
colnames(data_simulated_available)[6] = "dominant_eye"
colnames(data_simulated_available)[7] = "weak_eye"
colnames(data_simulated_available)[8] = "prosthetic_eye"

#Reformatting from wide to long format, thank you Christophe Pallier for teachming me about "melt"!
data_simulated_available_long = melt(data_simulated_available, id.vars=c("text_id","subject_id", "text_length", "language"))
head(data_simulated_available_long)

#Change column names
colnames(data_simulated_available_long)[5] = "eye"
colnames(data_simulated_available_long)[6] = "minutes"

#Save data
write.table(data_simulated_available_long,"data/data.txt",sep="\t",row.names=TRUE) #Save data for analysis







