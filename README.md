# Reading Speed
Atelier Expérimentation Project for 2018/2019

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Reading Speed Experiment](#reading-speed-experiment)
    - [Repository Layout](#repository-layout)
    - [Tools](#tools)
    - [Experimental Program](#experimental-program)
        - [Text](#text)
        - [Main](#pseudowords)
        - [Functions](#functions)
    - [Experiment Run](#experiment-run)
    - [R Simulation](#r-simulation)
    - [R Analysis](#r-analysis)
    - [CONCLUSION](#conclusion)
        - [Final Remarks](#final-remarks)
        - [Extra Material](#extra-material)

<!-- markdown-toc end -->

## Repository Layout

In this Github repository would will find the programs and documentation necessary to carry out the Reading Speed Experiment, Reading Speed Simulator, and Reading Speed Analysis.

[Analysis](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Anlysis) Contains the Reading Speed Simulator and Analysis of the simulation

[Data](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Data) Contains the data recorded while running the Reading Speed Experiment using PsychoPy

[Images](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/images) Contains an image used for instructing subjects

[Experiment_0_0_2.py](https://github.com/jvgiordano/PCBS-ReadingSpeed/blob/master/Experiment_0_0_2.py) is the experimental program that is run in PsychoPy

## Tools

The tools used for this project are:

PscyhoPy Version 1.85.6 (the newest version should work)

R Version

R Toolboxs: "dplyr", "purrr", "ggplot2", and "reshape2"

## Experimental Program

### Text

### Main

### Functions

## Experiment Run

## R Simulation

Because of the troubles running the experiment, a Reading Speed Simulation was created in R. This model took into account effects discovered while running the experiment and so was a more evolved form of it in some ways. Because of time constraints, it was simplified. For instance, the model has no variables to account for "Nonfiction" and "Fiction"  task, but it does have a parameter to account for text difficulty.

The R code for the simulation can be found here:

## R Analysis

The full R analysis can be found in the R markdown document here:


## Conclusion

I learned a lot from this project, both programming and experience wise. I had only ever used R from data analysis, but never for creating a simulation or for Linear Mixed Models with my own data. I didn't know about pandas in Python either, but quickly realized how strong R is with matrix and table maniupulations. I also got to use Github for a project, and not just a one time thing for a homework.

Carrying out the experiment I programmed in PsychoPy was also enlightening. There were many factors I had failed to account for, and it made me appreaciate how difficult it is to conduct a good experiment. This is something I will think about for future experiments I might have to design as well as papers I will read.

### Final Remarks

Programming Level - Intermediate

Programming related learning - How to create a simulation, How to run a Linear Mixed Model in R, About Pages in Github, about Pandas in Python, About the "Reshape2" package and "melt" function for R, Using Github for a real project and not just a one time homework assignment

Non-Programming related learning - Zipf's Law, Benford's law, How difficult it is to conduct an experiment (unaccounted for factors, unwanted subject behavior, lost data, etc.), The importance of backing up data (learned the hard-way, multiple times)

Regarding the course: I was not a typical student, having taken Atelier d'Experimentation last year. One thing that hampered me was the difficulty in having internet, so often I could not access the Github in class, or access online materials to help me. Also, there were not enough outlets in the room for computers, and my PC could never last the entire class. It sounds silly but these are really important for a computer class.

Sometimes when I followed the material it was a little fast for me. I had already done many of the things before, but actually typing and getting it to run and solving it on your own takes time and I felt like I was in a race at times. When you (Professor Pallier) wrote on the chalkboard it was nice because I had the time to program but also pay attention.

Compared with AE, and especially the "mois de rentrée" this class was far better for improving programming skills. I learned far more during the project this semester, than the project for AE I completed last year. Besides the outlets and plugs, I think this course should have 2 projects. A midterm and a final. And I think the midterm should be a small experiment students try to run, something very simple, to give them gratification for having done something physical but also to show how difficult running and experiment can be.

I'm pleasantly surprised with how much I learned from this class.

## Extra Material

There is extra material contained within the github respository. 

(1) "/Images/Instructions.jpg" - This contains an image used to teach subjects how to determine their dominant eye. It was used in the experiment.

(2) "/Data/Texts.docx" - A document with all texts used in the experimnet with corresponding position and group labels.

(3) "/Data/Example_subject.txt" - Contains an examplary data file from a subject

(4) "/Data/DataStructure.xlsx" - Excel sheet for the planned data structure for subject data
