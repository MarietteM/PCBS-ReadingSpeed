from psychopy import core, visual, event
import csv
import random

# Script: Analysis of Reading Speed by Eye
#
# This script runs an experiment to measure the 
# reading speed of a subject's eyes. There are 
# two version to this experiment, one for each 
# subject group.
#
# The Experiment runs as follows:
#   1. Researcher obtains from subject
#       a. Initials
#       b. Age
#       c. Gender
#       d. Handedness
#       e. Eye Dominance
#
#   2. Five texts will be presented to the subject.
#   After each text, the subject will mark the 
#   completion by a keystroke, measuring reaction time.
#   They will then be asked to answer a simple "Yes/No"
#   question. This is to ensure they pay attention and
#   and read each prompt.
#
#    +------------+-------------+-------------+
#    |            |           Group           |
#    +    Text    +---------------------------+
#    |            |   Group A   |   Group B   |
#    +------------+-------------+-------------+
#    |  Text 1    |  Both Eyes  |  Both Eyes  |
#    +------------+-------------+-------------+
#    |  Text 2    |  Right Eye  |  Right Eye  |
#    +------------+-------------+-------------+
#    |  Text 3    |  Right Eye  |  Left Eye   |
#    +------------+-------------+-------------+
#    |  Text 4    |  Left Eye   |  Right Eye  |
#    +------------+-------------+-------------+
#    |  Text 5    |  Left Eye   |  Left Eye   |
#    +------------+-------------+-------------+
#
#    3. All data is then saved to the "/Data" folder
#       titled by initials, age, and sex.
#
#!/usr/bin/env python
# -*- coding: utf-8 -*-


# Functions are defined here

## Function that runs the text
def run_text(group, text):
    
    
    
    init_msg = visual.TextStim(win, text="This the first reading test to set-up the experiment")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip
    
    #Collect Start Time
    start = core.getTime()
    print(start)

    #Get Response
    c = event.waitKeys(keyList='space
    
    #Collect End Time
    end = core.getTime()
    print(end)

    #Show Response
    message = visual.TextStim(win, text=c, height = 0.06)
    message.pos = (0, 0)
    message.draw()
    win.flip()

    #Wait
    core.wait(1)
    
    
    
## Function that allows user to rest eyes
#def take_a_break(break_number):
    
## Function that runs experiment
def Experimenter_cs(group, output_file):
    
    if group == "A":
        for i in 1:5
            run_text("A", i)
            #take_a_break(i)
    else:
        for i in 1:5
            #run_text("B", i)
            #take_a_break(i)
            


# Main Code Starts Here

## Setup section, read experiment variable from file
win = visual.Window([1000,700], monitor="testMonitor", fullscr = False)

#Provide instructions to subject
init_msg = visual.TextStim(win, text="In this experiment you will be reading \
multiple texts and answering simple questions about them. Before a text is \
presented, you will be told if you will read the text with both eyes, only your right \
eye, or only your left eye. If you understand, press the space bar to continue.")
init_msg.pos = (0,0)
init_msg.draw()
win.flip()

#Get Response
c = event.waitKeys(keyList='space')

#Provide more instructions to subject
init_msg = visual.TextStim(win, text="For single eye tasks, close the \
requested eye if possible, and cover it with your hand so you can not see out \
of it. If you understand, press the space bar to continue.")
init_msg.pos = (0,0)
init_msg.draw()
win.flip()

#Get Response
c = event.waitKeys(keyList='space')

#Provide more instructions to subject
init_msg = visual.TextStim(win, text="When you are done with reading the given \
text, hit the space bar to continue, as you have been doing. All questions will \
be 'Yes' or 'No' questions, and will be answered with the 'Y' or 'N' keys \
respectively. If you understand, hit the 'Y' key for 'Yes'.")
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
init_msg = visual.TextStim(win, text="To start the experiment please press the space bar")
init_msg.pos = (0,0)
init_msg.draw()
win.flip()

#Get Response
c = event.waitKeys(keyList='space')

core.wait(2)


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
Experimenter_cs("A", "JG_26_M_R_R");



win.close()
core.quit()