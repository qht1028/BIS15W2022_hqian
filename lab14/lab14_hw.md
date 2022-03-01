---
title: "Lab 14 HW"
output: 
  html_document: 
    keep_md: yes
author: "your name here"
date: '2022-02-28'
---


### Load the Libraries

```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.8
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## 载入程辑包：'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

```r
library("palmerpenguins")
library(skimr)

#install.packages("ggVennDiagram")
library(ggVennDiagram)
library(RColorBrewer)

#install.packages("ggworldcloud")
library(ggwordcloud)

options(warn = -1)

options(scipen=999) #cancels the use of scientific notation for the session
```


### Data

```r
superhero_info <- readr::read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- readr::read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
beachbugs_long <- readr::read_csv("data/beachbugs_long.csv")
```

```
## Rows: 66 Columns: 3
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (1): site
## dbl (2): year, buglevels
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

### 1. 
Clean up the column names (no capitals, not spaces) of `superhero_info`, then use 2 functions to remind yourself of structure of the `superhero_info` data set.


```r
superhero_info <- superhero_info %>%
  clean_names()
skim(superhero_info)
```


Table: Data summary

|                         |               |
|:------------------------|:--------------|
|Name                     |superhero_info |
|Number of rows           |734            |
|Number of columns        |10             |
|_______________________  |               |
|Column type frequency:   |               |
|character                |8              |
|numeric                  |2              |
|________________________ |               |
|Group variables          |None           |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|name          |         0|          1.00|   1|  25|     0|      715|          0|
|gender        |        29|          0.96|   4|   6|     0|        2|          0|
|eye_color     |       172|          0.77|   3|  23|     0|       22|          0|
|race          |       304|          0.59|   5|  18|     0|       61|          0|
|hair_color    |       172|          0.77|   3|  16|     0|       29|          0|
|publisher     |        15|          0.98|   4|  17|     0|       24|          0|
|skin_color    |       662|          0.10|   3|  14|     0|       16|          0|
|alignment     |         7|          0.99|   3|   7|     0|        3|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|   mean|     sd|   p0| p25| p50| p75| p100|hist  |
|:-------------|---------:|-------------:|------:|------:|----:|---:|---:|---:|----:|:-----|
|height        |       217|          0.70| 186.73|  59.25| 15.2| 173| 183| 191|  975|▇▁▁▁▁ |
|weight        |       239|          0.67| 112.25| 104.15|  2.0|  61|  81| 108|  900|▇▁▁▁▁ |

```r
head(superhero_info, n=10)
```

```
## # A tibble: 10 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo~ Male   yellow    Human No Hair       203 Marvel C~ <NA>       good     
##  2 Abe ~ Male   blue      Icth~ No Hair       191 Dark Hor~ blue       good     
##  3 Abin~ Male   blue      Unga~ No Hair       185 DC Comics red        good     
##  4 Abom~ Male   green     Huma~ No Hair       203 Marvel C~ <NA>       bad      
##  5 Abra~ Male   blue      Cosm~ Black          NA Marvel C~ <NA>       bad      
##  6 Abso~ Male   blue      Human No Hair       193 Marvel C~ <NA>       bad      
##  7 Adam~ Male   blue      <NA>  Blond          NA NBC - He~ <NA>       good     
##  8 Adam~ Male   blue      Human Blond         185 DC Comics <NA>       good     
##  9 Agen~ Female blue      <NA>  Blond         173 Marvel C~ <NA>       good     
## 10 Agen~ Male   brown     Human Brown         178 Marvel C~ <NA>       good     
## # ... with 1 more variable: weight <dbl>
```

### 2.
Are bad guys bigger? Make box-plots of weight by `alignment` (alignment on the x-axis).

```r
superhero_info %>%
  ggplot(mapping = aes(x=alignment, y=weight, fill=alignment))+
  geom_boxplot()+
  labs(title = "Superhero Weight", 
       x="Alignment", 
       y="Weight")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

### 3. 
Now, make a violin plot of weight by `alignment` (alignment on the x-axis). Add some color!
  What information can you observe in the violin plot that was not visible in the boxplot?

```r
superhero_info %>%
  filter(!is.na(weight))%>%
  ggplot(mapping = aes(x=alignment, y=weight, fill=alignment))+
  geom_violin()+
  coord_flip()+
  labs(title = "Superhero Weight", 
       x="Alignment", 
       y="Weight")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

#### The violin plots all extend toaward the big value of weight, so extreme values occur for all alignment. The group _alignment == good_ does not give a standard violin plot. The group _alignment == NA_ has a really abnormal plot and I do not know what happened. 

### 4. 
Use `alpha = .5` in `geom_boxplot()` and `geom_violin()` to layer both plots on top of one another. What does this tell you about the distribution of weight in "`bad`" guys?

```r
superhero_info %>%
  filter(!is.na(weight))%>%
  ggplot(mapping = aes(x=alignment, y=weight, fill=alignment))+
  geom_boxplot(alpha = .2)+
  geom_violin(alpha = .6)+
  coord_flip()+
  labs(title = "Superhero Weight", 
       x="Alignment", 
       y="Weight")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

#### Both boxplot and violin indicate that the weight of guys of bad alignment is mainly around 80. This distributioin is highly concentrated around 80. 

### 5. 
Box plots are great for showing how the distribution of a numeric variable (e.g. weight) varies among a categorical variable (e.g. alignment).
  Make your own violin plot with the superhero data. 
  What is your numeric data? 
  What is your categorical variable?


```r
superhero_info%>%
  filter(!is.na(height))%>%
  ggplot(mapping = aes(x=gender, y=height, fill=gender))+
  geom_boxplot(alpha = .2)+
  geom_violin(alpha = .6)+
  coord_flip()+
  labs(title = "Superhero Height", 
       x="Gender", 
       y="Height")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

#### The numeric data is height and the categorical data is sex. 

### 6. 
Remind yourself what `beachbugs` looks like. Then generate a heatmap of buglevels by site and year. 
color it with `scale_fill_gradient(low="yellow", high="red")` or colors of your choice. you may find it looks best with one color!
(dont forget, `coord_flip()` is a quick way to improve the look of your plot if you dont like the default orientation)


```r
beachbugs_long <- beachbugs_long %>%
  clean_names()
skim(beachbugs_long)
```


Table: Data summary

|                         |               |
|:------------------------|:--------------|
|Name                     |beachbugs_long |
|Number of rows           |66             |
|Number of columns        |3              |
|_______________________  |               |
|Column type frequency:   |               |
|character                |1              |
|numeric                  |2              |
|________________________ |               |
|Group variables          |None           |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|site          |         0|             1|  11|  23|     0|       11|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|   mean|    sd|      p0|     p25|     p50|     p75|    p100|hist  |
|:-------------|---------:|-------------:|------:|-----:|-------:|-------:|-------:|-------:|-------:|:-----|
|year          |         0|             1| 2015.5|  1.72| 2013.00| 2014.00| 2015.50| 2017.00| 2018.00|▇▃▃▃▃ |
|buglevels     |         0|             1|   34.1| 26.31|    7.93|   14.38|   25.13|   47.08|  121.53|▇▃▂▁▁ |


```r
beachbugs_long%>%
  ggplot(aes(site, year, fill=buglevels))+
  geom_tile()+
  scale_fill_gradient(low="yellow", high="red")+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Bug level", 
       x="Site", 
       y="Year")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

### 7.  
Use the provided code to normalize the beachbug data set. 
Then make a heatmap with the `beachbugs_normalized` data, and use the same color chois as above. Which heatmap do you think is more informative? why?


```r
#makes a new column of the highest buglevel observed at each site
beachbugs_w_max <- beachbugs_long %>% 
  group_by(site) %>% 
  mutate(max_buglevel = max(buglevels, na.rm=T)) %>% 
  arrange(site)
beachbugs_w_max
```

```
## # A tibble: 66 x 4
## # Groups:   site [11]
##     year site         buglevels max_buglevel
##    <dbl> <chr>            <dbl>        <dbl>
##  1  2013 Bondi Beach       32.2         32.2
##  2  2014 Bondi Beach       11.1         32.2
##  3  2015 Bondi Beach       14.3         32.2
##  4  2016 Bondi Beach       19.4         32.2
##  5  2017 Bondi Beach       13.2         32.2
##  6  2018 Bondi Beach       22.9         32.2
##  7  2013 Bronte Beach      26.8         61.3
##  8  2014 Bronte Beach      17.5         61.3
##  9  2015 Bronte Beach      23.6         61.3
## 10  2016 Bronte Beach      61.3         61.3
## # ... with 56 more rows
```

```r
#makes a new table where the buglevels are normalized to the max_buglevel
beachbugs_normalized <- beachbugs_w_max %>% 
  group_by(site) %>% 
  mutate(norm_buglevel = buglevels/max_buglevel) %>% 
  arrange(site,year) %>%
  select(site, year, norm_buglevel)   # you dont have to select(), but I think its a clearer looking table
beachbugs_normalized
```

```
## # A tibble: 66 x 3
## # Groups:   site [11]
##    site          year norm_buglevel
##    <chr>        <dbl>         <dbl>
##  1 Bondi Beach   2013         1    
##  2 Bondi Beach   2014         0.344
##  3 Bondi Beach   2015         0.445
##  4 Bondi Beach   2016         0.601
##  5 Bondi Beach   2017         0.409
##  6 Bondi Beach   2018         0.710
##  7 Bronte Beach  2013         0.436
##  8 Bronte Beach  2014         0.285
##  9 Bronte Beach  2015         0.385
## 10 Bronte Beach  2016         1    
## # ... with 56 more rows
```
 

```r
beachbugs_normalized%>%
  ggplot(aes(site, year, fill=norm_buglevel))+
  geom_tile()+
  scale_fill_gradient(low="yellow", high="red")+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(title = "Bug level", 
       x="Site", 
       y="Year")+
  theme(plot.title=element_text(hjust=.5))
```

![](lab14_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

#### The later one is more informative because the later one makes a horizontal comparison among different regions to indicate the relative bug level instead of a absolute one. 

### 8.
Let's make a venn diagram of `superhero_info`, from 4 questions:
Is their alignment evil? 
Are their eyes red?
Are they male?
Are they bald?

Start by making the 4 vectors, then the list of vectors. The vector for alignment is provided:
### super heros venn

```r
# evil

evil_vec <- superhero_info %>%
  filter(alignment == "bad")%>%
  pull(name)

# red eyes

red_vec <- superhero_info %>%
  filter(eye_color == "red")%>%
  pull(name)

# male

male_vec <- superhero_info %>%
  filter(gender == "Male")%>%
  pull(name)

# bald

bald_vec <- superhero_info %>%
  filter(hair_color == "No Hair")%>%
  pull(name)
```

Your list of vectors will look something like this:

```r
questions_list <- list(evil_vec, red_vec, male_vec, bald_vec)
```

### 9. 
Let's make the venn diagram! use the code from lab as a reference. 

```r
ggVennDiagram(questions_list , category.names = c("Evil", "Red eye", "Male", "Bald"))
```

![](lab14_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


### 10. Choose one intersection of the venn diagram that is interesting to you. Use dplyr to find the names of the superheros in that intersection. 


```r
superhero_info%>%
  filter(hair_color == "No Hair")%>%
  filter(gender == "Male")%>%
  filter(eye_color == "red")%>%
  filter(alignment != "bad")
```

```
## # A tibble: 7 x 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Drax ~ Male   red       Huma~ No Hair       193 Marvel C~ green      good     
## 2 Etrig~ Male   red       Demon No Hair       193 DC Comics yellow     neutral  
## 3 Fin F~ Male   red       Kaka~ No Hair       975 Marvel C~ green      good     
## 4 Ghost~ Male   red       Demon No Hair       188 Marvel C~ <NA>       good     
## 5 Kilow~ Male   red       Bolo~ No Hair       234 DC Comics pink       good     
## 6 Man-T~ Male   red       <NA>  No Hair       213 Marvel C~ green      good     
## 7 Marti~ Male   red       Mart~ No Hair       201 DC Comics green      good     
## # ... with 1 more variable: weight <dbl>
```

#### EMMMMM, Why there is no Joel Ledford????? Is he an evil guy :p

### 11. Make another venn diagram with the `superhero_info` data. What are your questions? ( At least 2!) 

```r
# Evil

evil_vec <- superhero_info %>%
  filter(alignment == "bad")%>%
  pull(name)

# female

female_vec <- superhero_info %>%
  filter(gender == "Female")%>%
  pull(name)

# blond

blond_vec <- superhero_info %>%
  filter(hair_color == "Blond")%>%
  pull(name)

interest_list <- list(evil_vec, female_vec, blond_vec)
ggVennDiagram(interest_list , category.names = c("Evil", "Female", "Blond"))
```

![](lab14_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

#### This is for attractive evil lady. 

### 12.
What are some very common super powers? Lets make a word cloud with the `superhero_powers` data.

Use the provided code to make the frequency table, then make a word cloud with it. 
Remember, you can change `scale_size_area(max_size = 20)` to a different number if the words wont fit!


```r
head(superhero_powers)
```

```
## # A tibble: 6 x 168
##   hero_names  Agility `Accelerated Healing` `Lantern Power Ri~` `Dimensional A~`
##   <chr>       <lgl>   <lgl>                 <lgl>               <lgl>           
## 1 3-D Man     TRUE    FALSE                 FALSE               FALSE           
## 2 A-Bomb      FALSE   TRUE                  FALSE               FALSE           
## 3 Abe Sapien  TRUE    TRUE                  FALSE               FALSE           
## 4 Abin Sur    FALSE   FALSE                 TRUE                FALSE           
## 5 Abomination FALSE   TRUE                  FALSE               FALSE           
## 6 Abraxas     FALSE   FALSE                 FALSE               TRUE            
## # ... with 163 more variables: `Cold Resistance` <lgl>, Durability <lgl>,
## #   Stealth <lgl>, `Energy Absorption` <lgl>, Flight <lgl>,
## #   `Danger Sense` <lgl>, `Underwater breathing` <lgl>, Marksmanship <lgl>,
## #   `Weapons Master` <lgl>, `Power Augmentation` <lgl>,
## #   `Animal Attributes` <lgl>, Longevity <lgl>, Intelligence <lgl>,
## #   `Super Strength` <lgl>, Cryokinesis <lgl>, Telepathy <lgl>,
## #   `Energy Armor` <lgl>, `Energy Blasts` <lgl>, Duplication <lgl>, ...
```

```r
power_frequency <- superhero_powers %>% 
  select(-hero_names) %>%
  summarise_all(~(sum(.))) %>%
  pivot_longer(everything(), names_to = "power", values_to = "freq")
power_frequency
```

```
## # A tibble: 167 x 2
##    power                  freq
##    <chr>                 <int>
##  1 Agility                 242
##  2 Accelerated Healing     178
##  3 Lantern Power Ring       11
##  4 Dimensional Awareness    25
##  5 Cold Resistance          47
##  6 Durability              257
##  7 Stealth                 126
##  8 Energy Absorption        77
##  9 Flight                  212
## 10 Danger Sense             30
## # ... with 157 more rows
```



```r
power_frequency%>%
  arrange(desc(freq))%>%
  head(n=120)%>%
  ggplot(aes(
  label = power, 
  size = freq,
  color = power
  )) +
  geom_text_wordcloud() +
  scale_size_area(max_size=10) +
  theme_minimal()
```

![](lab14_hw_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

### 13.  
Who are some very powerful supers? 
 Lets make a different word cloud with the `superhero_powers` data. 
Use the provided code to make the frequency table, then make a word cloud with it.
You can use `hero_names` for the labels, and `sum_powers` for size. 


```r
power_quantity <- superhero_powers %>% 
  pivot_longer(-hero_names, names_to = "power", values_to = "yes_or_no") %>% 
  group_by(hero_names) %>% 
  mutate(sum_powers = sum(yes_or_no, na.rm=T)) %>%
  arrange(desc(sum_powers), hero_names, desc(yes_or_no))
power_quantity
```

```
## # A tibble: 111,389 x 4
## # Groups:   hero_names [667]
##    hero_names power                 yes_or_no sum_powers
##    <chr>      <chr>                 <lgl>          <int>
##  1 Spectre    Agility               TRUE              49
##  2 Spectre    Accelerated Healing   TRUE              49
##  3 Spectre    Dimensional Awareness TRUE              49
##  4 Spectre    Stealth               TRUE              49
##  5 Spectre    Energy Absorption     TRUE              49
##  6 Spectre    Flight                TRUE              49
##  7 Spectre    Marksmanship          TRUE              49
##  8 Spectre    Longevity             TRUE              49
##  9 Spectre    Intelligence          TRUE              49
## 10 Spectre    Super Strength        TRUE              49
## # ... with 111,379 more rows
```

```r
#we have to trim down to only the top 50, or it will crowd the image!
power_quantity <- power_quantity %>% 
  ungroup %>%
  distinct(hero_names, sum_powers) %>%
  slice_max(sum_powers, n = 50)
power_quantity
```

```
## # A tibble: 51 x 2
##    hero_names        sum_powers
##    <chr>                  <int>
##  1 Spectre                   49
##  2 Amazo                     44
##  3 Living Tribunal           35
##  4 Martian Manhunter         35
##  5 Man of Miracles           34
##  6 Captain Marvel            33
##  7 T-X                       33
##  8 Galactus                  32
##  9 T-1000                    32
## 10 Mister Mxyzptlk           31
## # ... with 41 more rows
```




```r
power_quantity%>%
  ggplot(aes(
  label = hero_names, 
  size = sum_powers,
  color = hero_names
  )) +
  geom_text_wordcloud() +
  scale_size_area() +
  theme_minimal()
```

![](lab14_hw_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

## That's it! 🎉
Thanks for coding with us all winter! 
Now go finish your group project :) 

