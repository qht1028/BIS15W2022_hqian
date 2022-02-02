---
title: "Lab 8 Homework"
author: "Please Add Your Name Here"
date: "2022-02-02"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(skimr)
```

## Install `here`
The package `here` is a nice option for keeping directories clear when loading files. I will demonstrate below and let you decide if it is something you want to use.  

```r
#install.packages("here")
```

## Data
For this homework, we will use a data set compiled by the Office of Environment and Heritage in New South Whales, Australia. It contains the enterococci counts in water samples obtained from Sydney beaches as part of the Beachwatch Water Quality Program. Enterococci are bacteria common in the intestines of mammals; they are rarely present in clean water. So, enterococci values are a measurement of pollution. `cfu` stands for colony forming units and measures the number of viable bacteria in a sample [cfu](https://en.wikipedia.org/wiki/Colony-forming_unit).   

This homework loosely follows the tutorial of [R Ladies Sydney](https://rladiessydney.org/). If you get stuck, check it out!  

1. Start by loading the data `sydneybeaches`. Do some exploratory analysis to get an idea of the data structure.

```r
sydneybeaches <- readr::read_csv("data/sydneybeaches.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   BeachId = col_double(),
##   Region = col_character(),
##   Council = col_character(),
##   Site = col_character(),
##   Longitude = col_double(),
##   Latitude = col_double(),
##   Date = col_character(),
##   `Enterococci (cfu/100ml)` = col_double()
## )
```

```r
sydneybeaches
```

```
## # A tibble: 3,690 x 8
##    BeachId Region        Council Site  Longitude Latitude Date  `Enterococci (~`
##      <dbl> <chr>         <chr>   <chr>     <dbl>    <dbl> <chr>            <dbl>
##  1      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 02/0~               19
##  2      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 06/0~                3
##  3      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 12/0~                2
##  4      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 18/0~               13
##  5      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 30/0~                8
##  6      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 05/0~                7
##  7      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 11/0~               11
##  8      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 23/0~               97
##  9      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 07/0~                3
## 10      25 Sydney City ~ Randwi~ Clov~      151.    -33.9 25/0~                0
## # ... with 3,680 more rows
```

If you want to try `here`, first notice the output when you load the `here` library. It gives you information on the current working directory. You can then use it to easily and intuitively load files.

```r
library(here)
```

The quotes show the folder structure from the root directory.

```r
sydneybeaches <-read_csv(here("lab8", "data", "sydneybeaches.csv")) %>% janitor::clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   BeachId = col_double(),
##   Region = col_character(),
##   Council = col_character(),
##   Site = col_character(),
##   Longitude = col_double(),
##   Latitude = col_double(),
##   Date = col_character(),
##   `Enterococci (cfu/100ml)` = col_double()
## )
```

```
## Warning in FUN(X[[i]], ...): strings not representable in native encoding will
## be translated to UTF-8
```

```r
names(sydneybeaches)
```

```
## [1] "beach_id"              "region"                "council"              
## [4] "site"                  "longitude"             "latitude"             
## [7] "date"                  "enterococci_cfu_100ml"
```

2. Are these data "tidy" per the definitions of the tidyverse? How do you know? Are they in wide or long format?

#### I think this data frame is too wide because the information of region just repeatedly occur to cater to the existence of one column to store the information *date*. I think, different dates can be put into different columns to make the frame wider and more readable. 

3. We are only interested in the variables site, date, and enterococci_cfu_100ml. Make a new object focused on these variables only. Name the object `sydneybeaches_long`

```r
sydneybeaches_long <- sydneybeaches%>%
  select(site, date, enterococci_cfu_100ml)
sydneybeaches_long
```

```
## # A tibble: 3,690 x 3
##    site           date       enterococci_cfu_100ml
##    <chr>          <chr>                      <dbl>
##  1 Clovelly Beach 02/01/2013                    19
##  2 Clovelly Beach 06/01/2013                     3
##  3 Clovelly Beach 12/01/2013                     2
##  4 Clovelly Beach 18/01/2013                    13
##  5 Clovelly Beach 30/01/2013                     8
##  6 Clovelly Beach 05/02/2013                     7
##  7 Clovelly Beach 11/02/2013                    11
##  8 Clovelly Beach 23/02/2013                    97
##  9 Clovelly Beach 07/03/2013                     3
## 10 Clovelly Beach 25/03/2013                     0
## # ... with 3,680 more rows
```


4. Pivot the data such that the dates are column names and each beach only appears once. Name the object `sydneybeaches_wide`

```r
sydneybeaches_long <- sydneybeaches_long%>%
  pivot_wider(names_from = "date", 
              values_from = "enterococci_cfu_100ml")
head(sydneybeaches_long, n=5)
```

```
## # A tibble: 5 x 345
##   site          `02/01/2013` `06/01/2013` `12/01/2013` `18/01/2013` `30/01/2013`
##   <chr>                <dbl>        <dbl>        <dbl>        <dbl>        <dbl>
## 1 Clovelly Bea~           19            3            2           13            8
## 2 Coogee Beach            15            4           17           18           22
## 3 Gordons Bay ~           NA           NA           NA           NA           NA
## 4 Little Bay B~            9            3           72            1           44
## 5 Malabar Beach            2            4          390           15           13
## # ... with 339 more variables: `05/02/2013` <dbl>, `11/02/2013` <dbl>,
## #   `23/02/2013` <dbl>, `07/03/2013` <dbl>, `25/03/2013` <dbl>,
## #   `02/04/2013` <dbl>, `12/04/2013` <dbl>, `18/04/2013` <dbl>,
## #   `24/04/2013` <dbl>, `01/05/2013` <dbl>, `20/05/2013` <dbl>,
## #   `31/05/2013` <dbl>, `06/06/2013` <dbl>, `12/06/2013` <dbl>,
## #   `24/06/2013` <dbl>, `06/07/2013` <dbl>, `18/07/2013` <dbl>,
## #   `24/07/2013` <dbl>, `08/08/2013` <dbl>, `22/08/2013` <dbl>, ...
```


5. Pivot the data back so that the dates are data and not column names.

```r
sydneybeaches_ori <- sydneybeaches_long%>%
  pivot_longer(cols = c(contains("20")), 
               names_to = "date", 
               values_to = "enterococci_cfu_100ml")
head(sydneybeaches_ori, n=5)
```

```
## # A tibble: 5 x 3
##   site           date       enterococci_cfu_100ml
##   <chr>          <chr>                      <dbl>
## 1 Clovelly Beach 02/01/2013                    19
## 2 Clovelly Beach 06/01/2013                     3
## 3 Clovelly Beach 12/01/2013                     2
## 4 Clovelly Beach 18/01/2013                    13
## 5 Clovelly Beach 30/01/2013                     8
```



6. We haven't dealt much with dates yet, but separate the date into columns day, month, and year. Do this on the `sydneybeaches_long` data.

```r
sydneybeaches_long <- sydneybeaches_ori%>%
  separate(date, into = c("day", "month", "year"))
head(sydneybeaches_long, n=5)
```

```
## # A tibble: 5 x 5
##   site           day   month year  enterococci_cfu_100ml
##   <chr>          <chr> <chr> <chr>                 <dbl>
## 1 Clovelly Beach 02    01    2013                     19
## 2 Clovelly Beach 06    01    2013                      3
## 3 Clovelly Beach 12    01    2013                      2
## 4 Clovelly Beach 18    01    2013                     13
## 5 Clovelly Beach 30    01    2013                      8
```


7. What is the average `enterococci_cfu_100ml` by year for each beach. Think about which data you will use- long or wide.

```r
sydneybeaches_long %>%
  select(site, year, enterococci_cfu_100ml)%>%
  unite("category", c("site", "year"), sep="_")%>%
  group_by(category)%>%
  filter(!is.na(enterococci_cfu_100ml))%>%
  summarise(annual_mean=mean(enterococci_cfu_100ml, na.rm = TRUE))%>%
  separate(category, into = c("site", "year"), sep = "_")
```

```
## # A tibble: 66 x 3
##    site         year  annual_mean
##    <chr>        <chr>       <dbl>
##  1 Bondi Beach  2013         32.2
##  2 Bondi Beach  2014         11.1
##  3 Bondi Beach  2015         14.3
##  4 Bondi Beach  2016         19.4
##  5 Bondi Beach  2017         13.2
##  6 Bondi Beach  2018         22.9
##  7 Bronte Beach 2013         26.8
##  8 Bronte Beach 2014         17.5
##  9 Bronte Beach 2015         23.6
## 10 Bronte Beach 2016         61.3
## # ... with 56 more rows
```


8. Make the output from question 7 easier to read by pivoting it to wide format.

```r
sydneybeaches_long %>%
  select(site, year, enterococci_cfu_100ml)%>%
  unite("category", c("site", "year"), sep="_")%>%
  group_by(category)%>%
  filter(!is.na(enterococci_cfu_100ml))%>%
  summarise(annual_mean=mean(enterococci_cfu_100ml, na.rm = TRUE))%>%
  separate(category, into = c("site", "year"), sep = "_")%>%
  pivot_wider(names_from = "year", 
              values_from = "annual_mean")
```

```
## # A tibble: 11 x 7
##    site                    `2013` `2014` `2015` `2016` `2017` `2018`
##    <chr>                    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
##  1 Bondi Beach              32.2   11.1   14.3    19.4  13.2   22.9 
##  2 Bronte Beach             26.8   17.5   23.6    61.3  16.8   43.4 
##  3 Clovelly Beach            9.28  13.8    8.82   11.3   7.93  10.6 
##  4 Coogee Beach             39.7   52.6   40.3    59.5  20.7   21.6 
##  5 Gordons Bay (East)       24.8   16.7   36.2    39.0  13.7   17.6 
##  6 Little Bay Beach        122.    19.5   25.5    31.2  18.2   59.1 
##  7 Malabar Beach           101.    54.5   66.9    91.0  49.8   38.0 
##  8 Maroubra Beach           47.1    9.23  14.5    26.6  11.6    9.21
##  9 South Maroubra Beach     39.3   14.9    8.25   10.7   8.26  12.5 
## 10 South Maroubra Rockpool  96.4   40.6   47.3    59.3  46.9  112.  
## 11 Tamarama Beach           29.7   39.6   57.0    50.3  20.4   15.5
```


9. What was the most polluted beach in 2018?

```r
sydneybeaches_long %>%
  select(site, year, enterococci_cfu_100ml)%>%
  unite(category, c(site, year), sep="_")%>%
  group_by(category)%>%
  filter(!is.na(enterococci_cfu_100ml))%>%
  summarise(annual_mean=mean(enterococci_cfu_100ml, na.rm = TRUE))%>%
  separate(category, into = c("site", "year"), sep = "_")%>%
  pivot_wider(names_from = "year", 
              values_from = "annual_mean")%>%
  select(site, `2018`)%>%
  arrange(desc(`2018`))
```

```
## # A tibble: 11 x 2
##    site                    `2018`
##    <chr>                    <dbl>
##  1 South Maroubra Rockpool 112.  
##  2 Little Bay Beach         59.1 
##  3 Bronte Beach             43.4 
##  4 Malabar Beach            38.0 
##  5 Bondi Beach              22.9 
##  6 Coogee Beach             21.6 
##  7 Gordons Bay (East)       17.6 
##  8 Tamarama Beach           15.5 
##  9 South Maroubra Beach     12.5 
## 10 Clovelly Beach           10.6 
## 11 Maroubra Beach            9.21
```

#### It looks like South Maroubra Rockpool experienced the most serious overall water pollution in 2018. 

10. Please complete the class project survey at: [BIS 15L Group Project](https://forms.gle/H2j69Z3ZtbLH3efW6)


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
