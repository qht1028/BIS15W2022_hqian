---
title: "Lab 2 Homework"
author: "Hongtao Qian (Steve"
date: "2022-01-06"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---

```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.1.1     v dplyr   1.0.5
## v tidyr   1.1.3     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(ggplot2)
```

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

1. What is a vector in R?  
* ##### Vector in R is an object with several value in a specific order. 

2. What is a data matrix in R?  
* ##### Data matrix is a collection of data, catagorized with data types and ordered, or stored, in rows and columns. It is similar to "series of stacked vectors". 

3. Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of eight hot springs. Run this code chunk to create the vectors.  

```r
spring_1 <- c(36.25, 35.40, 35.30)
spring_2 <- c(35.15, 35.35, 33.35)
spring_3 <- c(30.70, 29.65, 29.20)
spring_4 <- c(39.70, 40.05, 38.65)
spring_5 <- c(31.85, 31.40, 29.30)
spring_6 <- c(30.20, 30.65, 29.75)
spring_7 <- c(32.90, 32.50, 32.80)
spring_8 <- c(36.80, 36.45, 33.15)
```

4. Build a data matrix that has the springs as rows and the columns as scientists. 


```r
spring_data<-c(spring_1,spring_2,spring_3,spring_4,spring_5,spring_6,spring_7,spring_8)
spring_data<-matrix(spring_data, nrow=8, byrow=T)%>%
print()
```

```
##       [,1]  [,2]  [,3]
## [1,] 36.25 35.40 35.30
## [2,] 35.15 35.35 33.35
## [3,] 30.70 29.65 29.20
## [4,] 39.70 40.05 38.65
## [5,] 31.85 31.40 29.30
## [6,] 30.20 30.65 29.75
## [7,] 32.90 32.50 32.80
## [8,] 36.80 36.45 33.15
```


5. The names of the springs are 1.Bluebell Spring, 2.Opal Spring, 3.Riverside Spring, 4.Too Hot Spring, 5.Mystery Spring, 6.Emerald Spring, 7.Black Spring, 8.Pearl Spring. Name the rows and columns in the data matrix. Start by making two new vectors with the names, then use `colnames()` and `rownames()` to name the columns and rows.


```r
Name<-c("Blubell Spring","Opal Spring","Riverside Spring","Too Hot Spring","Mystery Spring","Emerald Spring","Black Spring","Pearl Spring")
rownames(spring_data)<-Name
Scientists<-c("Jill","Steve","Susan")
colnames(spring_data)<-Scientists
print(spring_data)
```

```
##                   Jill Steve Susan
## Blubell Spring   36.25 35.40 35.30
## Opal Spring      35.15 35.35 33.35
## Riverside Spring 30.70 29.65 29.20
## Too Hot Spring   39.70 40.05 38.65
## Mystery Spring   31.85 31.40 29.30
## Emerald Spring   30.20 30.65 29.75
## Black Spring     32.90 32.50 32.80
## Pearl Spring     36.80 36.45 33.15
```


6. Calculate the mean temperature of all eight springs.

```r
Mean_Temperature<-rowMeans(spring_data)%>%
  print()
```

```
##   Blubell Spring      Opal Spring Riverside Spring   Too Hot Spring 
##         35.65000         34.61667         29.85000         39.46667 
##   Mystery Spring   Emerald Spring     Black Spring     Pearl Spring 
##         30.85000         30.20000         32.73333         35.46667
```


7. Add this as a new column in the data matrix.  

```r
all_spring_data<-cbind(spring_data, Mean_Temperature)%>%
  print()
```

```
##                   Jill Steve Susan Mean_Temperature
## Blubell Spring   36.25 35.40 35.30         35.65000
## Opal Spring      35.15 35.35 33.35         34.61667
## Riverside Spring 30.70 29.65 29.20         29.85000
## Too Hot Spring   39.70 40.05 38.65         39.46667
## Mystery Spring   31.85 31.40 29.30         30.85000
## Emerald Spring   30.20 30.65 29.75         30.20000
## Black Spring     32.90 32.50 32.80         32.73333
## Pearl Spring     36.80 36.45 33.15         35.46667
```


8. Show Susan's value for Opal Spring only.

```r
all_spring_data[2,3]
```

```
## [1] 33.35
```


9. Calculate the mean for Jill's column only.  

```r
Mean<-colMeans(spring_data)
Mean[1]
```

```
##     Jill 
## 34.19375
```


10. Use the data matrix to perform one calculation or operation of your interest.
* ##### I want to calculate the stand deviation for each spring by three scientists. 

```r
stand_deviation<-apply(spring_data, 1, sd)
analyzed_spring_data <-cbind(spring_data, stand_deviation)%>%
  print()
```

```
##                   Jill Steve Susan stand_deviation
## Blubell Spring   36.25 35.40 35.30       0.5220153
## Opal Spring      35.15 35.35 33.35       1.1015141
## Riverside Spring 30.70 29.65 29.20       0.7697402
## Too Hot Spring   39.70 40.05 38.65       0.7285831
## Mystery Spring   31.85 31.40 29.30       1.3610658
## Emerald Spring   30.20 30.65 29.75       0.4500000
## Black Spring     32.90 32.50 32.80       0.2081666
## Pearl Spring     36.80 36.45 33.15       2.0139100
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
