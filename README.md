# Reading Speed

PCBS Project 2018/2019

The aim of this project was to create a Reading Speed experiment in PsychoPy and to run it on twenty subject and analyze the results. Due to issues in experimental implementation, a Reading Speed Simulator was built in R, and an analysis involving visualizations of the simulated data and the creation of a linear mixed model was carried out.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Reading Speed Experiment](#reading-speed-experiment)
    - [Repository Layout](#repository-layout)
    - [Tools](#tools)
    - [Experimental Program](#experimental-program)
        - [Text](#text)
        - [Main](#main)
        - [Experimenter_cs](#experimenter_cs)
        - [Instructions](#instructions)
        - [run_text](#run_text)
        - [Finish](#finish)
    - [Experiment Run](#experiment-run)
    - [R Simulation](#r-simulation)
    - [R Analysis](#r-analysis)
    - [CONCLUSION](#conclusion)
        - [Final Remarks](#final-remarks)
        - [Extra Material](#extra-material)

<!-- markdown-toc end -->

## Repository Layout

In this Github repository would will find the programs and documentation necessary to carry out the Reading Speed Experiment, Reading Speed Simulator, and Reading Speed Analysis.

[Analysis](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Analysis) Contains the Reading Speed Simulator and Analysis of the simulation

[Data](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Data) Contains the data recorded while running the Reading Speed Experiment using PsychoPy

[Images](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Images) Contains an image used for instructing subjects

[Experiment_0_0_2.py](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Experiment_0_0_2.py) is the experimental program that is run in PsychoPy

## Tools

The tools used for this project are:

PscyhoPy Version 1.85.6 (the newest version should work)

R Version 3.2.3

R Toolboxes: "dplyr", "purrr", "ggplot2", and "reshape2"

## Experimental Program

The experimental code can be found [here](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Experiment_0_0_2.py)

The program runs and experiment which attempts to measure the reading speeds of a subject based on three eye conditions. If the subject uses both eyes, their right eye or their left eye. The goal was to determine if there is a significant difference in reading speed between the left and right eye.
 
 Subjects were broken into two groups, A and B. Texts would be shown to them based on the configuration in the chart below:
 
     +--------------+-------------+-------------+
    |              |           Group           |
    +    Text      +---------------------------+
    |              |   Group A   |   Group B   |
    +--------------+-------------+-------------+
    |  Text 1,2    |  Both Eyes  |  Both Eyes  |
    +--------------+-------------+-------------+
    |  Text 3,4    |  Right Eye  |  Right Eye  |
    +--------------+-------------+-------------+
    |  Text 5,6    |  Right Eye  |  Left Eye   |
    +--------------+-------------+-------------+
    |  Text 7,8    |  Left Eye   |  Left Eye   |
    +--------------+-------------+-------------+
    |  Text 9,10   |  Left Eye   |  Right Eye  |
    +--------------+-------------+-------------+
    
This configuration was chosen so that base lines of reading speed could be measured across the two groups. This is the case for texts 1 and 2 where subjects used both eyes, texts 3 and 4, where subjects used their right eye and texts 7 and 8, where subjects used their left eye. Contrasting cases were text 5 and 6 and 9 and 10.
    
The experiment would run as follows:

1. Researcher obtains from subject#       

a. Initials

b. Age

c. Gender

d. Handedness

e. Eye Dominance

and the researcher would give

f. a subject ID

g. a group (A or B)

### Text

The ten exts were taken from the following sources. One may note the alternating fiction and non-fiction sources.

1.Rivers by Nigel Holmes & Paul Raven, pg 51

2.The Invention of Nature, Andrea Wulf pg 1

3.Rivers, Pg 83

4.The Book of Dust by Phillip Pullman, pg 4

5.The Butterflies of Britain and Ireland by Jeremy Thomas pg 29

6. The Book of Dust, pg 25

7.The Butterflies of Britain and Ireland, pg 63 

8.Dragon Teeth by Michael Crichton, pg 12

9.Psychology by ,Roisberg pg 21

10.Dragon Teeth, pg 6


### Main

The main code is shown below. It consists of the opening of a window in PsychoPy, and the entering of all the subjects information, ending with the call of the "Experimenter_cs()" function, which launches the experiment.

It is recommended to not run the experiment in full screen mode. PsychoPy has a tendency to freeze and there is no way to exit full screen mode (at least in Windows, even with task manager).

    # Main Code Starts Here

    ## Create window for experiment
    win = visual.Window([1370,760], monitor="testMonitor", fullscr = False)

    ##Enter subject information
    subject_id = 00
    group = "A"
    handedness = "R"
    eye_dominancy = "R"
    age = 99
    gender = "M"
    output_file = "00_JG"


    ##Call function to run experiment with subject informatio
    Experimenter_cs(subject_id, group, handedness, eye_dominancy, age, gender,  output_file);
    
There are four functions that run the experiment "Experimenter_cs()", "Instructions()", "run_text()", and "Finish()". They are discussed below.

### Experimenter_cs

Experimenter_cs did the bulk of running the experiment. (1) It creates a data file recording all subject information in the /Data/ folder, titled by subjectID and their initials. (2) It runs the function Instructions() presenting instructions to the user (3) It runs through the run_text() function 10 times, once for each text to be presented, and records the reading time and answer corresponding to each text. It also checks if a text was fiction or non-fiction. Odd number texts were all fiction. (4) It runs Finish() which lets the subject know the experiment is over. 

    ##Open Data file for recording subject's answers and reponse times
    datafile = open("Data/" + output_file + ".txt", "wb")
    writer = csv.writer(datafile, delimiter="\t")
    writer.writerow(['Subject', 'Group', 'Text', 'Text_Type', 'Reading_Eye', 'Handedness','Eye_Dominancy', 'Age', 'Gender' 'Response_Time', 'Graded_Answer'])
    
    
    
    ## Present instructions to subject
    Instructions()
    
    ## Run through texts, take measurement, record data
    for i in range(10):
        
        ## Call run text function, gets back measurements for data file
        time_measurement, graded_answer, reading_eye = run_text(group, i)
        
        ##Check if text is story or factual, even texts are fiction, odd texts are non-fiction
        if (i+1) % 2 == 0:
            text_type = "Fiction"
        else:
            text_type = "Nonfiction"
        
        ## Record measurement and answer for text
        writer.writerow([subject_id, group, i+1, text_type, reading_eye, handedness, eye_dominancy, age, gender, time_measurement, graded_answer ])

    
    ## Present end of experiment
    Finish()

### Instructions

Only a portion of the Instructions() function is show below. The function presents the experiment to the subject, explains them the task, and how to proceed. It teaches them to proceed from texts by hitting the space bar, and to answer questions either using 'Y' or 'N' key to answer "yes" or "no" respectively. 

Psychopy works something like a flash card. A message or picture is saved to a variable, in this case init_msg. This can than be positioned and "drawn". Refering to the flash card analogy it would be like placing our message on a certain section of the card, and drawing it on the back. This card equates to the screen. Then we "flip" this card, or "window" and our message that we drew is presented.

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


### run_text

run_text() is the function which (1) presents the specified text to the user, based on the loop iteration, (2) determines based on the assigned group what eye(s) the subject should read with and alerts them, (3) captures the reading time using the core.getTime() function, and finally (4) asks the corresponding text question and receives the answer and grades it. Snapshots of these sections are presented below.

(1) Presents specified text (this is but a small portion due to length)

     texts = [
        "1. Sewage and farmyard slurry cause serious river pollution, because faecal bacteria multiply rapidly and consume all the water's oxygen. Untreated sewage, often combined with industrial pollution, created a major health hazard in towns and cities and created hundreds of kilometers of fishless rivers in the 1950s.", 
        "2. They were ----



(2) Determine assigned group and instructions

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

(3) Captures reading time

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
    

(4) Asks questions and grades response

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

### Finish

Finish() tells the subject the experiment is over.

    #Tells subject experiment is over
    init_msg = visual.TextStim(win, text="The experiment is over. Thank you for your participation.")
    init_msg.pos = (0,0)
    init_msg.draw()
    win.flip()
    
    #Get Response
    c = event.waitKeys(keyList='space')



## Experiment Run

Running the experiment proved to be more difficult than anticipated. Several problems were encountered concering the design and build of the experiment. The first of these were typos found by the subjects during the experiment which had an observable effect on the reading times for those trials. Even after all 8 subjects had completed the experiment, other typos were found, but it is unknown how these errors affected reading speed.  The second issue was that the questions, though designed to be simple and often did not require the reading of the text to answer, still received many wrong responses. This was most notable for non-native speakers. The questions failed here because they did not ensure the subjects read the questions, and at the same time, were too difficult for most subjects to answer completely correctly. One last problem is that perhaps the experiment should have been divided in dominant eye and non-dominant eye as would be done in the simulation, instead of left eye versus right eye. The original goal was to determine if lateralization played an effect, and how eye dominancy affected this, but since most people are right eye dominant, it would be hard to determine dominancy effects from the small left eye dominant population.

Other issues with the experiment are related to subject behavior and conditions. I failed to take into account the effect being a native English speaker would have. Non-native speakers took far longer, and with apparent variability, to read the texts and answer the questions. Due to the initial group A and B design, the non-native speakers would have probably had an over influential role on the data and hidden any effects of eye dominancy. Second, subjects were not informed of the timed readings. They only knew about the questions and some became overly concerned with this aspect of the test. I was told by several subjects that they read the texts "three to four times" to ensure they would remember all the details and to have fully understood it. This of course greatly affects reading time.

Last, there were some technical issues. 2 of the data sets were lost. They still have files associated with the subjects which can be found in the respository under subject initials of "PR" and "JY", but the files are empty. Initially I thought the cause was from shutting down the computer while the text file was still opened after reviewing it after an experiment. Later I determined the cause was by launching the experiment with the same subject initials, even if the experiment wasn't carried out. Just starting the experiment wiped the recorded information.

Because of all of these issues, and time constaints, running the experiment was ended in lieu of creating a reading speed simulator in R.

## R Simulation

Because of the troubles running the experiment, a Reading Speed Simulation was created in R. This model took into account effects discovered while running the experiment and so was a more evolved form of it in some ways. Because of time constraints, it was simplified. For instance, the model has no variables to account for "Nonfiction" and "Fiction"  task, but it does have a parameter to account for text difficulty.

The R code for the simulation can be found in /master/Analysis/scripts as ["Reading_Speed_Simulator.R"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Analysis/scripts/Reading_Speed_Simulator.R) (or you can click the link)

## R Analysis

The full R analysis can be found in the R markdown document can be found in master/Analysis/write_up as ["reading_speed_markdown.html"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Analysis/write_up/reading_speed_markdown.html) (or you can click the link).

There is an alternative PDF version [here](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Analysis/write_up/reading_speed_markdown.pdf)

The data for the analysis can be found in master/Analysis/data [here.](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Analysis/data/data.txt)


## Conclusion

I learned a lot from this project, both programming and experience wise. I had only ever used R from data analysis, but never for creating a simulation or for Linear Mixed Models with my own data. I didn't know about pandas in Python either, but quickly realized how strong R is with matrix and table maniupulations. I also got to use Github for a project, and not just a one time thing for a homework.

Carrying out the experiment I programmed in PsychoPy was also enlightening. There were many factors I had failed to account for, and it made me appreaciate how difficult it is to conduct a good experiment. This is something I will think about for future experiments I might have to design as well as papers I will read.

### Final Remarks

Programming Level - Intermediate

Programming related learning - How to create a simulation, How to run a Linear Mixed Model in R, About Pages in Github, about Pandas in Python, About the "Reshape2" package and "melt" function for R, Using Github for a real project and not just a one time homework assignment

Non-Programming related learning - Zipf's Law, Benford's law, How difficult it is to conduct an experiment (unaccounted for factors, unwanted subject behavior, lost data, etc.), The importance of backing up data (learned the hard-way multiple time, lost my ReadMe after it wall all written because I hadn't pulled locally and forced a push)

Regarding the course: I was not a typical student, having taken Atelier d'Experimentation last year. One thing that hampered me was the difficulty in having internet, so often I could not access the Github in class, or access online materials to help me. Also, there were not enough outlets in the room for computers, and my PC could never last the entire class. It sounds silly but these are really important for a computer class.

Sometimes when I followed the material it was a little fast for me. I had already done many of the things before, but actually typing and getting it to run and solving it on your own takes time and I felt like I was in a race at times. When you (Professor Pallier) wrote on the chalkboard it was nice because I had the time to program but also pay attention.

Compared with AE, and especially the "mois de rentrée" this class was far better for improving programming skills. I learned far more during the project this semester, than the project for AE I completed last year. Besides the outlets and plugs, I think this course should have 2 projects. A midterm and a final. And I think the midterm should be a small experiment students try to run, something very simple, to give them gratification for having done something physical but also to show how difficult running and experiment can be.

I'm pleasantly surprised with how much I learned from this class.

## Extra Material

There is extra material contained within the github respository. 

(1) ["/Images/Instructions.jpg"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Images/Instructions.jpg) - This contains an image used to teach subjects how to determine their dominant eye. It was used in the experiment.

(2) ["/Data/Texts.docx"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Data/Texts.docx) - A document with all texts used in the experimnet with corresponding position and group labels.

(3) ["/Data/Example_subject.txt"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Data/Example_Subject.txt) - Contains an examplary data file from a subject

(4) ["/Data/DataStructure.xlsx"](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Data/DataStructure.xlsx) - Excel sheet for the planned data structure for subject data
