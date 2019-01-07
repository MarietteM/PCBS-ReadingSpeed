from psychopy import core, visual, event
import csv
import random

# Script: Analysis of Reading Speed by Eye
#
# This script runs an experiment to measure the 
# reading speed of a subject's eyes. There are 
# two versions to this experiment, one for each 
# subject group.
#
# The experiment runs as follows:
#   1. Researcher obtains from subject
#       a. Initials
#       b. Age
#       c. Gender
#       d. Handedness
#       e. Eye Dominance
#
#   2. Ten texts will be presented to the subject.
#   After each text, the subject will mark the 
#   completion by a keystroke, measuring reaction time.
#   They will then be asked to answer a simple "Yes/No"
#   question. This is to ensure they pay attention and
#   and read each prompt.
#
#    +--------------+-------------+-------------+
#    |              |           Group           |
#    +    Text      +---------------------------+
#    |              |   Group A   |   Group B   |
#    +--------------+-------------+-------------+
#    |  Text 1,2    |  Both Eyes  |  Both Eyes  |
#    +--------------+-------------+-------------+
#    |  Text 3,4    |  Right Eye  |  Right Eye  |
#    +--------------+-------------+-------------+
#    |  Text 5,6    |  Right Eye  |  Left Eye   |
#    +--------------+-------------+-------------+
#    |  Text 7,8    |  Left Eye   |  Left Eye   |
#    +--------------+-------------+-------------+
#    |  Text 9,10   |  Left Eye   |  Right Eye  |
#    +--------------+-------------+-------------+
#
#    3. All data is then saved to the "/Data" folder
#       titled by initials, age, and sex.
#
# 1.Rivers by Nigel Holmes & Paul Raven, pg 51
# 2.The Invention of Nature, Andrea Wulf pg 1
# 3.Rivers, Pg 83
# 4.The Book of Dust by Phillip Pullman, pg 4
# 5.The Butterflies of Britain and Ireland by Jeremy Thomas pg 29
# 6. The Book of Dust, pg 25
# 7.The Butterflies of Britain and Ireland, pg 63 
# 8.Dragon Teeth by Michael Crichton, pg 12
# 9.Psychology by ,Roisberg pg 21
# 10.Dragon Teeth, pg 6
#
#
#!/usr/bin/env python
# -*- coding: utf-8 -*-


# Functions are defined here

## Function that runs experiment
def Experimenter_cs(subject_id, group, handedness, eye_dominancy, age, gender, output_file):
    
    ##Open Data file for recording subject's answers
    datafile = open("Data/" + output_file + ".txt", "wb")
    writer = csv.writer(datafile, delimiter="\t")
    writer.writerow(['Subject', 'Group', 'Text', 'Text_Type', 'Reading_Eye', 'Handedness','Eye_Dominancy', 'Age', 'Gender' 'Response_Time', 'Graded_Answer'])
    
    
    
    ## Present instructions
    Instructions()
    
    ## Run through texts, take measurement, record data
    for i in range(10):
        time_measurement, graded_answer, reading_eye = run_text(group, i)
        
        ##Check if text is story or factual
        if (i+1) % 2 == 0:
            text_type = "Fiction"
        else:
            text_type = "Nonfiction"
        
        writer.writerow([subject_id, group, i+1, text_type, reading_eye, handedness, eye_dominancy, age, gender, time_measurement, graded_answer ])

    
    ## Present end
    Finish()
    


## Function that runs instructions
def Instructions():
    #Provide instructions to subject
    init_msg = visual.TextStim(win, text="In this experiment you will be reading multiple texts and answering simple questions about them. Base your answers on the text. Before a text is presented, you will be told if you will read the text with both eyes, your right eye, or your left eye. If you understand, press the space bar to continue.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')
    
    #Provide more instructions to subject
    init_msg = visual.TextStim(win, text="For single eye tasks, close the requested eye if possible, and cover it with your hand so you can not see out of it. If you understand, press the space bar to continue.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')
    
    #Provide more instructions to subject
    init_msg = visual.TextStim(win, text="When you are done with reading the given text, hit the space bar to continue. All questions will be 'Yes' or 'No' questions, and will be answered with the 'Y' or 'N' keys respectively. If you understand, hit the 'Y' key for 'Yes'.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='y')
    
    #Provide more instructions to subject
    init_msg = visual.TextStim(win, text="Now hit the 'N' key for 'No'.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='n')
    
    #Initiate Experiment
    init_msg = visual.TextStim(win, text="To start the experiment please press the space bar.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')
    
    init_msg = visual.TextStim(win, text="")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #core.wait(1)

## Function that runs the text
def run_text(group, text):
    
    texts = [
    "1. Sewage and farmyard slurry cause serious river pollution, because faecal bacteria multiply rapidly and consume all the water's oxygen. Untreated sewage, often combined with industrial pollution, created a major health hazard in towns and cities and created hundreds of kilometers of fishless rivers in the 1950s.", 
    "2. They were crawling on hands and knees along a high narrow ridge that was in places only two inches wide. The path, if you could call it that, was layered with sand and loose stones that shifted whenever touched. Down to the left was a steep cliff encrusted with ice that glinted when the sun broke through the thick clouds.",
    "3. Water on the move is a powerful force (one cubic metre weighs a ton) and its ability to erode and carry sediment downstream is enhanced dramatically as current velocity increases. This is best seen in flashy rivers. Clear water during dry-weather conditions indicates that very little sediment is being moved.",
    "4. Like every child of an innkeeper, Malcom had to work around the tavern, washing dishes and glasses, carrying plates of food or tankards of beer, retrieving them when they were empty. He took the work for granted. The only annoyance in his life was a girl called Alice, who helped with washing the dishes. She was fifteen years old, tall and skinny, with lank dark hair that she scraped back into an unflattering ponytail.",
    "5. The Large Skipper is a common butterfly in England and Wales, and can be found in almost any sheltered patch of grassland that contains tall clumps of native coarse grasses. But it becomes a rarity as one travels further north, extending no further than the Scottish border in the north-east and Ayrshire in the north-west. It had never reliably been recorded in Ireland.",
    "6. That afternoon Malcom went to the lean-to-shed beside the house and hauled the tarpaulin off this canoe. He inspected it from stem to stem, scraping off the green slime that had accumulated during the winter, examining every inch. Norman the peacock came along to see if there was anything to eat, and shook his feathers with a rattle of displeasure when he found there wasn't.",
    "7. Large White Butterfly: This is the larger and more pernicious of the two cabbage white butterflies that infest kitchen gardens and farms, from the Channel Isles to Shetland. Its caterpillars are vastly destructive. They roam over Brassica crops in bands, reducing each plant to a skeleton of ribs and leaving it enveloped in the acrid smell of mustard oil.",
    "8. Marsh led him back into the interior of the museum. The air was chalky and shafts of sunlight pierced it like a cathedral. In a vast cavernous space, Johnson saw men in white lab coats bent over great slabs of rock, chipping bones free with small chisels. The worked carefully, he saw, and used small brushes to clean their work. In the far corner, a gigantic skeleton was being assembled, the framework of bones rising to the ceiling.",
    "9. For at least 10,000 years, humans have been manipulating their own brains by drinking alcohol. And for at least the last few decades, researches have wondered whether alcohol had a positive effect on physical health. Study after study seemed to suggest that people who imbibed one alcoholic beverage per day had healthier hearts than did people who abstained from drinking altogether.",
    "10. A later photograph, marked Cheyenne, Wyoming, 1876, shows Johnson quite differently. His mouth is framed by a full mustache; his body is harder and enlarged by use; his jaw is set; he stands confidently with shoulders squared and feet wide - and ankle-deep in mud. Clearly visible is a peculiar scar on his upper lip, which in later years he claimed was the result of an Indian attack."
    ]
    
    text = text + 1
    
    if group == "A":
        if text == 1 or text == 2:
            eyes = "Read the following text with both eyes open."
            reading_eye = "Both"
        elif text == 3 or  text == 4 or text == 5 or text == 6:
            eyes = "Read the following with only the RIGHT EYE. Cover your LEFT EYE."
            reading_eye = "Right"
        else:
            eyes = "Read the following with only the LEFT EYE. Cover your RIGHT EYE."
            reading_eye = "Left"
    else:
        if text == 1 or text == 2:
            eyes = "Read the following text with both eyes open."
            reading_eye = "Both"
        elif text == 3 or text == 4 or text == 9 or text == 10:
            eyes = "Read the following with only the RIGHT EYE. Cover your LEFT EYE."
            reading_eye = "Right"
        else:
            eyes = "Read the following with only the LEFT EYE. Cover your RIGHT EYE."
            reading_eye = "Left"
            
        
    init_msg = visual.TextStim(win, text=eyes)
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')
    
    text = text - 1
    init_msg = visual.TextStim(win, text=texts[text])
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Collect Start Time
    start = core.getTime()
    
    #Get Response
    c = event.waitKeys(keyList='space')
    
    #Collect End Time
    end = core.getTime()
    
    measurement = end-start
    
    #Check reading comprehension
    
    questions =[
    "1. Yes or No: Sewage can cause serious river pollution.", 
    "2. Yes or No: The ridge was two inches wide in some places.", 
    "3. Yes or No: Clear water means there is much sediment being moved.", 
    "4. Yes or No: Malcom had to work around the tavern.", 
    "5. Yes or No: The Large Skipper is a common butterfly in Mongolia.", 
    "6. Yes or No: Malcom scraped off the green slime that had accumulated during the winter.", 
    "7. Yes or No: Large White Butterfly caterpillars are destructive.", 
    "8. Yes or No: Johnson saw men in tie-dye lab coats.", 
    "9. Yes or No: Humans have been drinking alcohol for at most 1,000 years.", 
    "10. Yes or No: Johnson claimed the scar on his upper lip was the result of an Eskimo attack." 
    ]
    
    answers = ['y','y','n','y','n','y','y','n','n','n']
    
    init_msg = visual.TextStim(win, text=questions[text])
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList=['y','n'])
    
    if c[0] == answers[text]:
        grade = "Correct"
    else:
        grade = "Wrong"
    
    #Wait
    core.wait(1)
    
    return (measurement, grade, reading_eye)
    

## Function that runs instructions
def Finish():
    #Provide instructions to subject
    init_msg = visual.TextStim(win, text="The experiment is over. Thank you for your participation.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')


# Main Code Starts Here

## Setup section, read experiment variable from file
win = visual.Window(monitor="testMonitor", fullscr = True)

## Possible Experiment combinations and examples:
## If you want to run a subject in Group A, Initials JG, Age 26, Male,
## right handed, right eye dominance, you run:
## Experimenter_cs("A", "JG_26_M_R_R")
## If you want to run a subject in Group B, Intials AG, Age 32, Female
## left handed, left eye dominance, you run:
## Experimenter_CS("B", "AG_32_F_L_L")
## The Formula is:
## INITIALS_AGE_SEX_HANDEDNESS_EYEDOMINANCY


# Runs Experiments

##Enter subject information
subject_id = 04
group = "B"
handedness = "R"
eye_dominancy = "R"
age = 25
gender = "M"
output_file = "04_JY"


Experimenter_cs(subject_id, group, handedness, eye_dominancy, age, gender,  output_file);



win.close()
core.quit()