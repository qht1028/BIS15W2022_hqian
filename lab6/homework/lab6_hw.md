---
title: "Lab 6 Homework"
author: "Joel Ledford"
date: "2022-01-20"
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
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv(file = "data/FAO_1950to2012_111914.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## i<U+00A0>Use `spec()` for the full column specifications.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
names(fisheries)
```

```
##  [1] "Country"                 "Common name"            
##  [3] "ISSCAAP group#"          "ISSCAAP taxonomic group"
##  [5] "ASFIS species#"          "ASFIS species name"     
##  [7] "FAO major fishing area"  "Measure"                
##  [9] "1950"                    "1951"                   
## [11] "1952"                    "1953"                   
## [13] "1954"                    "1955"                   
## [15] "1956"                    "1957"                   
## [17] "1958"                    "1959"                   
## [19] "1960"                    "1961"                   
## [21] "1962"                    "1963"                   
## [23] "1964"                    "1965"                   
## [25] "1966"                    "1967"                   
## [27] "1968"                    "1969"                   
## [29] "1970"                    "1971"                   
## [31] "1972"                    "1973"                   
## [33] "1974"                    "1975"                   
## [35] "1976"                    "1977"                   
## [37] "1978"                    "1979"                   
## [39] "1980"                    "1981"                   
## [41] "1982"                    "1983"                   
## [43] "1984"                    "1985"                   
## [45] "1986"                    "1987"                   
## [47] "1988"                    "1989"                   
## [49] "1990"                    "1991"                   
## [51] "1992"                    "1993"                   
## [53] "1994"                    "1995"                   
## [55] "1996"                    "1997"                   
## [57] "1998"                    "1999"                   
## [59] "2000"                    "2001"                   
## [61] "2002"                    "2003"                   
## [63] "2004"                    "2005"                   
## [65] "2006"                    "2007"                   
## [67] "2008"                    "2009"                   
## [69] "2010"                    "2011"                   
## [71] "2012"
```

```r
skim(fisheries)
```


Table: Data summary

                                     
-------------------------  ----------
Name                       fisheries 
Number of rows             17692     
Number of columns          71        
_______________________              
Column type frequency:               
character                  69        
numeric                    2         
________________________             
Group variables            None      
-------------------------  ----------


**Variable type: character**

skim_variable              n_missing   complete_rate   min   max   empty   n_unique   whitespace
------------------------  ----------  --------------  ----  ----  ------  ---------  -----------
Country                            0            1.00     4    25       0        204            0
Common name                        0            1.00     3    30       0       1553            0
ISSCAAP taxonomic group            0            1.00     5    36       0         30            0
ASFIS species#                     0            1.00    10    13       0       1553            0
ASFIS species name                 0            1.00     6    32       0       1548            0
Measure                            0            1.00    17    17       0          1            0
1950                           15561            0.12     1     6       0        513            0
1951                           15550            0.12     1     7       0        536            0
1952                           15501            0.12     1     7       0        553            0
1953                           15439            0.13     1     6       0        570            0
1954                           15417            0.13     1     7       0        588            0
1955                           15382            0.13     1     7       0        589            0
1956                           15331            0.13     1     7       0        633            0
1957                           15253            0.14     1     7       0        627            0
1958                           15138            0.14     1     6       0        643            0
1959                           15110            0.15     1     7       0        641            0
1960                           15016            0.15     1     7       0        673            0
1961                           14922            0.16     1     8       0        713            0
1962                           14801            0.16     1     8       0        729            0
1963                           14707            0.17     1     8       0        760            0
1964                           14349            0.19     1     8       0        759            0
1965                           14241            0.20     1     8       0        798            0
1966                           14187            0.20     1     8       0        801            0
1967                           14047            0.21     1     8       0        815            0
1968                           13963            0.21     1     8       0        829            0
1969                           13920            0.21     1     8       0        853            0
1970                           13113            0.26     1     8       0       1225            0
1971                           12925            0.27     1     8       0       1326            0
1972                           12749            0.28     1     8       0       1372            0
1973                           12673            0.28     1     8       0       1432            0
1974                           12583            0.29     1     8       0       2601            0
1975                           12333            0.30     1     8       0       2767            0
1976                           12177            0.31     1     8       0       2804            0
1977                           12014            0.32     1     8       0       2867            0
1978                           11847            0.33     1     8       0       2901            0
1979                           11820            0.33     1     8       0       2932            0
1980                           11747            0.34     1     8       0       2956            0
1981                           11713            0.34     1     8       0       2996            0
1982                           11558            0.35     1     9       0       3030            0
1983                           11453            0.35     1     8       0       3031            0
1984                           11309            0.36     1     8       0       3076            0
1985                           11212            0.37     1     8       0       3161            0
1986                           11086            0.37     1     8       0       3242            0
1987                           10930            0.38     1     8       0       3255            0
1988                           10493            0.41     1     8       0       3435            0
1989                           10435            0.41     1     8       0       3425            0
1990                           10293            0.42     1     8       0       3446            0
1991                           10364            0.41     1     8       0       3420            0
1992                           10435            0.41     1     8       0       3322            0
1993                           10522            0.41     1     8       0       3313            0
1994                           10400            0.41     1     8       0       3313            0
1995                           10148            0.43     1     8       0       3329            0
1996                            9990            0.44     1     7       0       3358            0
1997                            9773            0.45     1     9       0       3393            0
1998                            9579            0.46     1     9       0       3399            0
1999                            9265            0.48     1     9       0       3428            0
2000                            8899            0.50     1     9       0       3481            0
2001                            8646            0.51     1     9       0       3490            0
2002                            8590            0.51     1     9       0       3507            0
2003                            8383            0.53     1     9       0       3482            0
2004                            7977            0.55     1     9       0       3505            0
2005                            7822            0.56     1     9       0       3532            0
2006                            7699            0.56     1     9       0       3565            0
2007                            7589            0.57     1     8       0       3551            0
2008                            7667            0.57     1     8       0       3537            0
2009                            7573            0.57     1     8       0       3572            0
2010                            7499            0.58     1     8       0       3590            0
2011                            7371            0.58     1     8       0       3618            0
2012                            7336            0.59     1     8       0       3609            0


**Variable type: numeric**

skim_variable             n_missing   complete_rate    mean      sd   p0   p25   p50   p75   p100  hist  
-----------------------  ----------  --------------  ------  ------  ---  ----  ----  ----  -----  ------
ISSCAAP group#                    0               1   37.38    7.88   11    33    36    38     77  ▁▇▂▁▁ 
FAO major fishing area            0               1   45.34   18.33   18    31    37    57     88  ▇▇▆▃▃ 

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <-janitor::clean_names(fisheries)
```

```
## Warning in FUN(X[[i]], ...): strings not representable in native encoding will
## be translated to UTF-8
```

```r
names(fisheries)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "x1950"                   "x1951"                  
## [11] "x1952"                   "x1953"                  
## [13] "x1954"                   "x1955"                  
## [15] "x1956"                   "x1957"                  
## [17] "x1958"                   "x1959"                  
## [19] "x1960"                   "x1961"                  
## [21] "x1962"                   "x1963"                  
## [23] "x1964"                   "x1965"                  
## [25] "x1966"                   "x1967"                  
## [27] "x1968"                   "x1969"                  
## [29] "x1970"                   "x1971"                  
## [31] "x1972"                   "x1973"                  
## [33] "x1974"                   "x1975"                  
## [35] "x1976"                   "x1977"                  
## [37] "x1978"                   "x1979"                  
## [39] "x1980"                   "x1981"                  
## [41] "x1982"                   "x1983"                  
## [43] "x1984"                   "x1985"                  
## [45] "x1986"                   "x1987"                  
## [47] "x1988"                   "x1989"                  
## [49] "x1990"                   "x1991"                  
## [51] "x1992"                   "x1993"                  
## [53] "x1994"                   "x1995"                  
## [55] "x1996"                   "x1997"                  
## [57] "x1998"                   "x1999"                  
## [59] "x2000"                   "x2001"                  
## [61] "x2002"                   "x2003"                  
## [63] "x2004"                   "x2005"                  
## [65] "x2006"                   "x2007"                  
## [67] "x2008"                   "x2009"                  
## [69] "x2010"                   "x2011"                  
## [71] "x2012"
```


```r
fisheries$country<-as.factor(fisheries$country)
fisheries$isscaap_group_number<-as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number<-as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area<-as.factor(fisheries$fao_major_fishing_area)
lapply(fisheries, class)
```

```
## $country
## [1] "factor"
## 
## $common_name
## [1] "character"
## 
## $isscaap_group_number
## [1] "factor"
## 
## $isscaap_taxonomic_group
## [1] "character"
## 
## $asfis_species_number
## [1] "factor"
## 
## $asfis_species_name
## [1] "character"
## 
## $fao_major_fishing_area
## [1] "factor"
## 
## $measure
## [1] "character"
## 
## $x1950
## [1] "character"
## 
## $x1951
## [1] "character"
## 
## $x1952
## [1] "character"
## 
## $x1953
## [1] "character"
## 
## $x1954
## [1] "character"
## 
## $x1955
## [1] "character"
## 
## $x1956
## [1] "character"
## 
## $x1957
## [1] "character"
## 
## $x1958
## [1] "character"
## 
## $x1959
## [1] "character"
## 
## $x1960
## [1] "character"
## 
## $x1961
## [1] "character"
## 
## $x1962
## [1] "character"
## 
## $x1963
## [1] "character"
## 
## $x1964
## [1] "character"
## 
## $x1965
## [1] "character"
## 
## $x1966
## [1] "character"
## 
## $x1967
## [1] "character"
## 
## $x1968
## [1] "character"
## 
## $x1969
## [1] "character"
## 
## $x1970
## [1] "character"
## 
## $x1971
## [1] "character"
## 
## $x1972
## [1] "character"
## 
## $x1973
## [1] "character"
## 
## $x1974
## [1] "character"
## 
## $x1975
## [1] "character"
## 
## $x1976
## [1] "character"
## 
## $x1977
## [1] "character"
## 
## $x1978
## [1] "character"
## 
## $x1979
## [1] "character"
## 
## $x1980
## [1] "character"
## 
## $x1981
## [1] "character"
## 
## $x1982
## [1] "character"
## 
## $x1983
## [1] "character"
## 
## $x1984
## [1] "character"
## 
## $x1985
## [1] "character"
## 
## $x1986
## [1] "character"
## 
## $x1987
## [1] "character"
## 
## $x1988
## [1] "character"
## 
## $x1989
## [1] "character"
## 
## $x1990
## [1] "character"
## 
## $x1991
## [1] "character"
## 
## $x1992
## [1] "character"
## 
## $x1993
## [1] "character"
## 
## $x1994
## [1] "character"
## 
## $x1995
## [1] "character"
## 
## $x1996
## [1] "character"
## 
## $x1997
## [1] "character"
## 
## $x1998
## [1] "character"
## 
## $x1999
## [1] "character"
## 
## $x2000
## [1] "character"
## 
## $x2001
## [1] "character"
## 
## $x2002
## [1] "character"
## 
## $x2003
## [1] "character"
## 
## $x2004
## [1] "character"
## 
## $x2005
## [1] "character"
## 
## $x2006
## [1] "character"
## 
## $x2007
## [1] "character"
## 
## $x2008
## [1] "character"
## 
## $x2009
## [1] "character"
## 
## $x2010
## [1] "character"
## 
## $x2011
## [1] "character"
## 
## $x2012
## [1] "character"
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
fisheries_tidy%>%
  count(country)%>%
  nrow()
```

```
## [1] 203
```

```r
fisheries_tidy%>%
  count(country)
```

```
## # A tibble: 203 x 2
##    country                 n
##    <fct>               <int>
##  1 Albania               934
##  2 Algeria              1561
##  3 American Samoa        556
##  4 Angola               2119
##  5 Anguilla              129
##  6 Antigua and Barbuda   356
##  7 Argentina            3403
##  8 Aruba                 172
##  9 Australia            8183
## 10 Bahamas               423
## # ... with 193 more rows
```
#### 203 countries in total. 

4. Refocus the data only to include country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
fisheries_tidy%>%
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g~ asfis_species_na~ asfis_species_num~  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2004     4
## # ... with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
fisheries_tidy%>%
  count(asfis_species_number)%>%
  nrow()
```

```
## [1] 1551
```
#### 1551 distinct species are caught. 

6. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy%>%
  filter(year=="2000")%>%
  group_by(country)%>%
  summarise(overall_catch=sum(catch, na.rm =TRUE ))%>%
  arrange(desc(overall_catch))%>%
  head(n=5)
```

```
## # A tibble: 5 x 2
##   country                  overall_catch
##   <fct>                            <dbl>
## 1 China                            25899
## 2 Russian Federation               12181
## 3 United States of America         11762
## 4 Japan                             8510
## 5 Indonesia                         8341
```
#### It is China. 

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
fisheries_tidy%>%
  filter(between(year,1990,2000))%>%
  filter(asfis_species_name=="Sardina pilchardus")%>%
  group_by(country)%>%
  summarise(total_catch=sum(catch, na.rm=TRUE))%>%
  arrange(desc(total_catch))
```

```
## # A tibble: 37 x 2
##    country               total_catch
##    <fct>                       <dbl>
##  1 Morocco                      7470
##  2 Spain                        3507
##  3 Russian Federation           1639
##  4 Ukraine                      1030
##  5 France                        966
##  6 Portugal                      818
##  7 Greece                        528
##  8 Italy                         507
##  9 Serbia and Montenegro         478
## 10 Denmark                       477
## # ... with 27 more rows
```
#### Morocco catches the most fishes. 

8. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy%>%
  filter(between(year,2008,2012))%>%
  filter(isscaap_taxonomic_group=="Squids, cuttlefishes, octopuses")%>%
  group_by(country)%>%
  summarise(total_catch=sum(catch, na.rm=TRUE))%>%
  arrange(desc(total_catch))%>%
  head(n=5)
```

```
## # A tibble: 5 x 2
##   country            total_catch
##   <fct>                    <dbl>
## 1 China                     8349
## 2 Korea, Republic of        3480
## 3 Peru                      3422
## 4 Japan                     3248
## 5 Chile                     2775
```
#### The top five cephalopods killers are China, South Korea, Peru, Japan, and Chile. 

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy%>%
  filter(between(year,2008,2012))%>%
  group_by(common_name)%>%
  summarise(total_catch=sum(catch, na.rm=TRUE))%>%
  arrange(desc(total_catch))%>%
  head(n=5)
```

```
## # A tibble: 5 x 2
##   common_name                    total_catch
##   <chr>                                <dbl>
## 1 Marine fishes nei                   105651
## 2 Alaska pollock(=Walleye poll.)       41075
## 3 Anchoveta(=Peruvian anchovy)         35523
## 4 Skipjack tuna                        32153
## 5 Largehead hairtail                   30400
```
#### The most victims of fisheries all over the world is called Alska pollock, except for Marine fishes nei. 

10. Use the data to do at least one analysis of your choice.

```r
annual_catch<-fisheries_tidy%>%
  group_by(country)%>%
  summarise(total_catch=sum(catch, na.rm=TRUE), time=n_distinct(year, na.rm=TRUE))%>%
  mutate(annual_fishing=total_catch/time)%>%
  arrange(desc(annual_fishing))%>%
  print()
```

```
## # A tibble: 203 x 4
##    country                  total_catch  time annual_fishing
##    <fct>                          <dbl> <int>          <dbl>
##  1 Japan                         814843    63         12934.
##  2 China                         735938    63         11682.
##  3 Russian Federation            270219    25         10809.
##  4 United States of America      623994    63          9905.
##  5 Peru                          599508    63          9516 
##  6 Un. Sov. Soc. Rep.            360127    42          8574.
##  7 Chile                         366808    63          5822.
##  8 Norway                        300947    63          4777.
##  9 Korea, Republic of            253734    63          4028.
## 10 Indonesia                     253476    63          4023.
## # ... with 193 more rows
```
#### I just figured out the annual fishing amount for all countries regardless of species. The consequence indicates that Japan has the highest annual catching amount. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
