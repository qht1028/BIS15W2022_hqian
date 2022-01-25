---
title: "Midterm 1"
author: "Hongtao Qian (Irritating)"
date: "2022-01-25"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 15 total questions, each is worth 2 points.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by 12:00p on Thursday, January 27.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.1.1     v dplyr   1.0.6
## v tidyr   1.1.3     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(skimr)
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Questions  
Wikipedia's definition of [data science](https://en.wikipedia.org/wiki/Data_science): "Data science is an interdisciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from noisy, structured and unstructured data, and apply knowledge and actionable insights from data across a broad range of application domains."  

1. (2 points) Consider the definition of data science above. Although we are only part-way through the quarter, what specific elements of data science do you feel we have practiced? Provide at least one specific example.  

#### So far, we have tried to *extract* the data in interest from *a huge data frame* through select() function and filter() or subset() functions to *extract* the expected value from a column for further *process*. 

2. (2 points) What is the most helpful or interesting thing you have learned so far in BIS 15L? What is something that you think needs more work or practice?  

#### The most helpful part is to extract some data from the frame to do something related to "statistics". However, I still need some work to _tidy up_ the data for easy data procession. 

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.

```r
elephants<-readr::read_csv(file="data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
  skim(elephants)
```


Table: Data summary

                                     
-------------------------  ----------
Name                       elephants 
Number of rows             288       
Number of columns          3         
_______________________              
Column type frequency:               
character                  1         
numeric                    2         
________________________             
Group variables            None      
-------------------------  ----------


**Variable type: character**

skim_variable    n_missing   complete_rate   min   max   empty   n_unique   whitespace
--------------  ----------  --------------  ----  ----  ------  ---------  -----------
Sex                      0               1     1     1       0          2            0


**Variable type: numeric**

skim_variable    n_missing   complete_rate     mean     sd      p0      p25      p50      p75     p100  hist  
--------------  ----------  --------------  -------  -----  ------  -------  -------  -------  -------  ------
Age                      0               1    10.97    8.4    0.01     4.58     9.46    16.50    32.17  ▆▇▂▂▂ 
Height                   0               1   187.68   50.6   75.46   160.75   200.00   221.09   304.06  ▃▃▇▇▁ 

```r
lapply(elephants, class)
```

```
## $Age
## [1] "numeric"
## 
## $Height
## [1] "numeric"
## 
## $Sex
## [1] "character"
```


4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.

```r
elephants <-janitor::clean_names(elephants)
```

```
## Warning in FUN(X[[i]], ...): strings not representable in native encoding will
## be translated to UTF-8
```

```r
elephants$sex<-as.factor(elephants$sex)
lapply(elephants, class)
```

```
## $age
## [1] "numeric"
## 
## $height
## [1] "numeric"
## 
## $sex
## [1] "factor"
```


5. (2 points) How many male and female elephants are represented in the data?

```r
elephants%>%
  group_by(sex)%>%
  summarise(n=n())
```

```
## # A tibble: 2 x 2
##   sex       n
##   <fct> <int>
## 1 F       150
## 2 M       138
```
#### 150 female and 138 male. 


6. (2 points) What is the average age all elephants in the data?

```r
elephants%>%
  summarise(average_age=mean(age))
```

```
## # A tibble: 1 x 1
##   average_age
##         <dbl>
## 1        11.0
```
#### The average age is around 10.97. 


7. (2 points) How does the average age and height of elephants compare by sex?

```r
elephants%>%
  group_by(sex)%>%
  summarise(average_age=mean(age), average_height=mean(height))
```

```
## # A tibble: 2 x 3
##   sex   average_age average_height
##   <fct>       <dbl>          <dbl>
## 1 F           12.8            190.
## 2 M            8.95           185.
```
#### It seems that female has a longer average age and greater average height.


8. (2 points) How does the average height of elephants compare by sex for individuals over 20 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.

```r
elephants%>%
  filter(age > 20)%>%
  group_by(sex)%>%
  summarise(average_height=mean(height),max_height=max(height),min_height=min(height))
```

```
## # A tibble: 2 x 4
##   sex   average_height max_height min_height
##   <fct>          <dbl>      <dbl>      <dbl>
## 1 F               232.       278.       193.
## 2 M               270.       304.       229.
```
#### For individual over 20 years old, male has greater average height, maximum height, and minimum height. It seems like both sex have a similar overall higher growth rate, but male will have a growth boost when male is old enough. 

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.

```r
vertebrate<-readr::read_csv(file="data/IvindoData_DryadVersion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i<U+00A0>Use `spec()` for the full column specifications.
```

```r
vertebrate<-janitor::clean_names(vertebrate)
vertebrate$hunt_cat<-as.factor(vertebrate$hunt_cat)
vertebrate$land_use<-as.factor(vertebrate$land_use)
head(vertebrate, n=5)
```

```
## # A tibble: 5 x 26
##   transect_id distance hunt_cat num_households land_use veg_rich veg_stems
##         <dbl>    <dbl> <fct>             <dbl> <fct>       <dbl>     <dbl>
## 1           1     7.14 Moderate             54 Park         16.7      31.2
## 2           2    17.3  None                 54 Park         15.8      37.4
## 3           2    18.3  None                 29 Park         16.9      32.3
## 4           3    20.8  None                 29 Logging      12.4      29.4
## 5           4    16.0  None                 29 Park         17.1      36  
## # ... with 19 more variables: veg_liana <dbl>, veg_dbh <dbl>, veg_canopy <dbl>,
## #   veg_understory <dbl>, ra_apes <dbl>, ra_birds <dbl>, ra_elephant <dbl>,
## #   ra_monkeys <dbl>, ra_rodent <dbl>, ra_ungulate <dbl>,
## #   rich_all_species <dbl>, evenness_all_species <dbl>,
## #   diversity_all_species <dbl>, rich_bird_species <dbl>,
## #   evenness_bird_species <dbl>, diversity_bird_species <dbl>,
## #   rich_mammal_species <dbl>, evenness_mammal_species <dbl>,
## #   diversity_mammal_species <dbl>
```


10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?

```r
vertebrate%>%
  filter(hunt_cat=="Moderate" | hunt_cat=="High")%>%
  group_by(hunt_cat)%>%
  summarise(average_bird_diversity=mean(diversity_bird_species), average_mammal_diversity=mean(diversity_mammal_species))
```

```
## # A tibble: 2 x 3
##   hunt_cat average_bird_diversity average_mammal_diversity
##   <fct>                     <dbl>                    <dbl>
## 1 High                       1.66                     1.74
## 2 Moderate                   1.62                     1.68
```
#### It seems like higher hunting intensity can improve diversity. 

11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 3km from a village to sites that are greater than 25km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.  

```r
near<-vertebrate%>%
  filter(distance<3)%>%
  summarise(across(contains("ra_"), mean))%>%
  print()
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    0.12     76.6       0.145       17.3      3.90        1.87
```

```r
far<-vertebrate%>%
  filter(distance>25)%>%
  summarise(across(contains("ra_"), mean))%>%
  print()
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    4.91     31.6           0       54.1      1.29        8.12
```
#### It seems like increasing distance can improve the abundance of ape, monkey, and ungulate. 

12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`

```r
vertebrate%>%
  group_by(hunt_cat)%>%
  summarise(bird_evenness=mean(evenness_bird_species), bird_rich=mean(rich_bird_species), bird_diversity=mean(diversity_bird_species))
```

```
## # A tibble: 3 x 4
##   hunt_cat bird_evenness bird_rich bird_diversity
##   <fct>            <dbl>     <dbl>          <dbl>
## 1 High             0.717      10.1           1.66
## 2 Moderate         0.691      10.6           1.62
## 3 None             0.731      10.2           1.70
```
#### I assume there is a food chain between cat and birds, so there should be a relationship betweem cat hunting and bird ecological situation. Surprisingly, the difference for bird evenness, richness, and diversity among transects with distinct hunting rate is not significant. 
