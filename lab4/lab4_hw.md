---
title: "Lab 4 Homework"
author: "Hongtao Qian (Steve)"
date: "2022-01-13"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
## i<U+00A0>Use `spec()` for the full column specifications.
```

```r
glimpse(homerange)
```

```
## Rows: 569
## Columns: 24
## $ taxon                      <chr> "lake fishes", "river fishes", "river fishe~
## $ common.name                <chr> "american eel", "blacktail redhorse", "cent~
## $ class                      <chr> "actinopterygii", "actinopterygii", "actino~
## $ order                      <chr> "anguilliformes", "cypriniformes", "cyprini~
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae"~
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cli~
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fundu~
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recapt~
## $ N                          <chr> "16", NA, "20", "26", "17", "5", "2", "2", ~
## $ mean.mass.g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00,~
## $ log10.mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600,~
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
## $ mean.hra.m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, 3~
## $ log10.hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437,~
## $ hra.reference              <chr> "Minns, C. K. 1995. Allometry of home range~
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic",~
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ect~
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimmi~
## $ trophic.guild              <chr> "carnivore", "carnivore", "carnivore", "car~
## $ dimension                  <chr> "3D", "2D", "2D", "2D", "2D", "2D", "2D", "~
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, N~
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA, ~
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, NA~
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 20~
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
str(homerange)
```

```
## spec_tbl_df[,24] [569 x 24] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ taxon                     : chr [1:569] "lake fishes" "river fishes" "river fishes" "river fishes" ...
##  $ common.name               : chr [1:569] "american eel" "blacktail redhorse" "central stoneroller" "rosyside dace" ...
##  $ class                     : chr [1:569] "actinopterygii" "actinopterygii" "actinopterygii" "actinopterygii" ...
##  $ order                     : chr [1:569] "anguilliformes" "cypriniformes" "cypriniformes" "cypriniformes" ...
##  $ family                    : chr [1:569] "anguillidae" "catostomidae" "cyprinidae" "cyprinidae" ...
##  $ genus                     : chr [1:569] "anguilla" "moxostoma" "campostoma" "clinostomus" ...
##  $ species                   : chr [1:569] "rostrata" "poecilura" "anomalum" "funduloides" ...
##  $ primarymethod             : chr [1:569] "telemetry" "mark-recapture" "mark-recapture" "mark-recapture" ...
##  $ N                         : chr [1:569] "16" NA "20" "26" ...
##  $ mean.mass.g               : num [1:569] 887 562 34 4 4 ...
##  $ log10.mass                : num [1:569] 2.948 2.75 1.531 0.602 0.602 ...
##  $ alternative.mass.reference: chr [1:569] NA NA NA NA ...
##  $ mean.hra.m2               : num [1:569] 282750 282.1 116.1 125.5 87.1 ...
##  $ log10.hra                 : num [1:569] 5.45 2.45 2.06 2.1 1.94 ...
##  $ hra.reference             : chr [1:569] "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ ...
##  $ realm                     : chr [1:569] "aquatic" "aquatic" "aquatic" "aquatic" ...
##  $ thermoregulation          : chr [1:569] "ectotherm" "ectotherm" "ectotherm" "ectotherm" ...
##  $ locomotion                : chr [1:569] "swimming" "swimming" "swimming" "swimming" ...
##  $ trophic.guild             : chr [1:569] "carnivore" "carnivore" "carnivore" "carnivore" ...
##  $ dimension                 : chr [1:569] "3D" "2D" "2D" "2D" ...
##  $ preymass                  : num [1:569] NA NA NA NA NA NA 1.39 NA NA NA ...
##  $ log10.preymass            : num [1:569] NA NA NA NA NA ...
##  $ PPMR                      : num [1:569] NA NA NA NA NA NA 530 NA NA NA ...
##  $ prey.size.reference       : chr [1:569] NA NA NA NA ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   taxon = col_character(),
##   ..   common.name = col_character(),
##   ..   class = col_character(),
##   ..   order = col_character(),
##   ..   family = col_character(),
##   ..   genus = col_character(),
##   ..   species = col_character(),
##   ..   primarymethod = col_character(),
##   ..   N = col_character(),
##   ..   mean.mass.g = col_double(),
##   ..   log10.mass = col_double(),
##   ..   alternative.mass.reference = col_character(),
##   ..   mean.hra.m2 = col_double(),
##   ..   log10.hra = col_double(),
##   ..   hra.reference = col_character(),
##   ..   realm = col_character(),
##   ..   thermoregulation = col_character(),
##   ..   locomotion = col_character(),
##   ..   trophic.guild = col_character(),
##   ..   dimension = col_character(),
##   ..   preymass = col_double(),
##   ..   log10.preymass = col_double(),
##   ..   PPMR = col_double(),
##   ..   prey.size.reference = col_character()
##   .. )
```

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
lapply(homerange, class)
```

```
## $taxon
## [1] "character"
## 
## $common.name
## [1] "character"
## 
## $class
## [1] "character"
## 
## $order
## [1] "character"
## 
## $family
## [1] "character"
## 
## $genus
## [1] "character"
## 
## $species
## [1] "character"
## 
## $primarymethod
## [1] "character"
## 
## $N
## [1] "character"
## 
## $mean.mass.g
## [1] "numeric"
## 
## $log10.mass
## [1] "numeric"
## 
## $alternative.mass.reference
## [1] "character"
## 
## $mean.hra.m2
## [1] "numeric"
## 
## $log10.hra
## [1] "numeric"
## 
## $hra.reference
## [1] "character"
## 
## $realm
## [1] "character"
## 
## $thermoregulation
## [1] "character"
## 
## $locomotion
## [1] "character"
## 
## $trophic.guild
## [1] "character"
## 
## $dimension
## [1] "character"
## 
## $preymass
## [1] "numeric"
## 
## $log10.preymass
## [1] "numeric"
## 
## $PPMR
## [1] "numeric"
## 
## $prey.size.reference
## [1] "character"
```

```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
homerange$taxon<-as.factor(homerange$taxon)
class(homerange$taxon)
```

```
## [1] "factor"
```

```r
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```

```r
homerange$order<-as.factor(homerange$order)
class(homerange$order)
```

```
## [1] "factor"
```

```r
levels(homerange$order)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes<U+00A0>" "tinamiformes"
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
taxa <- select(homerange, "common.name", class, order, family, genus, species)%>%
  print()
```

```
## # A tibble: 569 x 6
##    common.name          class        order        family     genus     species  
##    <chr>                <chr>        <fct>        <chr>      <chr>     <chr>    
##  1 american eel         actinoptery~ anguillifor~ anguillid~ anguilla  rostrata 
##  2 blacktail redhorse   actinoptery~ cypriniform~ catostomi~ moxostoma poecilura
##  3 central stoneroller  actinoptery~ cypriniform~ cyprinidae camposto~ anomalum 
##  4 rosyside dace        actinoptery~ cypriniform~ cyprinidae clinosto~ funduloi~
##  5 longnose dace        actinoptery~ cypriniform~ cyprinidae rhinicht~ cataract~
##  6 muskellunge          actinoptery~ esociformes  esocidae   esox      masquino~
##  7 pollack              actinoptery~ gadiformes   gadidae    pollachi~ pollachi~
##  8 saithe               actinoptery~ gadiformes   gadidae    pollachi~ virens   
##  9 lined surgeonfish    actinoptery~ perciformes  acanthuri~ acanthur~ lineatus 
## 10 orangespine unicorn~ actinoptery~ perciformes  acanthuri~ naso      lituratus
## # ... with 559 more rows
```

**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**  

```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```

**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
table(homerange$"trophic.guild")
```

```
## 
## carnivore herbivore 
##       342       227
```
#### 342 kinds of carnivore and 227 kinds of herbivore

**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
herb <- filter(homerange, trophic.guild == "herbivore")%>%
  print()
```

```
## # A tibble: 227 x 24
##    taxon  common.name   class   order  family  genus species primarymethod N    
##    <fct>  <chr>         <chr>   <fct>  <chr>   <chr> <chr>   <chr>         <chr>
##  1 marin~ lined surgeo~ actino~ perci~ acanth~ acan~ lineat~ direct obser~ <NA> 
##  2 marin~ orangespine ~ actino~ perci~ acanth~ naso  litura~ telemetry     8    
##  3 marin~ bluespine un~ actino~ perci~ acanth~ naso  unicor~ telemetry     7    
##  4 marin~ redlip blenny actino~ perci~ blenni~ ophi~ atlant~ direct obser~ 20   
##  5 marin~ bermuda chub  actino~ perci~ kyphos~ kyph~ sectat~ telemetry     11   
##  6 marin~ cherubfish    actino~ perci~ pomaca~ cent~ argi    direct obser~ <NA> 
##  7 marin~ damselfish    actino~ perci~ pomace~ chro~ chromis direct obser~ <NA> 
##  8 marin~ twinspot dam~ actino~ perci~ pomace~ chry~ biocel~ direct obser~ 18   
##  9 marin~ wards damsel  actino~ perci~ pomace~ poma~ wardi   direct obser~ <NA> 
## 10 marin~ australian g~ actino~ perci~ pomace~ steg~ apical~ direct obser~ <NA> 
## # ... with 217 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
carn <- filter(homerange, trophic.guild == "carnivore")%>%
  print()
```

```
## # A tibble: 342 x 24
##    taxon   common.name   class   order  family genus species primarymethod N    
##    <fct>   <chr>         <chr>   <fct>  <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake f~ american eel  actino~ angui~ angui~ angu~ rostra~ telemetry     16   
##  2 river ~ blacktail re~ actino~ cypri~ catos~ moxo~ poecil~ mark-recaptu~ <NA> 
##  3 river ~ central ston~ actino~ cypri~ cypri~ camp~ anomal~ mark-recaptu~ 20   
##  4 river ~ rosyside dace actino~ cypri~ cypri~ clin~ fundul~ mark-recaptu~ 26   
##  5 river ~ longnose dace actino~ cypri~ cypri~ rhin~ catara~ mark-recaptu~ 17   
##  6 river ~ muskellunge   actino~ esoci~ esoci~ esox  masqui~ telemetry     5    
##  7 marine~ pollack       actino~ gadif~ gadid~ poll~ pollac~ telemetry     2    
##  8 marine~ saithe        actino~ gadif~ gadid~ poll~ virens  telemetry     2    
##  9 marine~ giant treval~ actino~ perci~ caran~ cara~ ignobi~ telemetry     4    
## 10 lake f~ rock bass     actino~ perci~ centr~ ambl~ rupest~ mark-recaptu~ 16   
## # ... with 332 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  

```r
herb_average <- herb$mean.hra.m2
is.na(herb_average)
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [37] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [49] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [97] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
mean(herb_average)
```

```
## [1] 34137012
```

```r
carn_average <- carn$mean.hra.m2
is.na(carn_average)
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [37] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [49] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [97] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [337] FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
mean(carn_average)
```

```
## [1] 13039918
```
#### Herbivore has larger 'mean.hra.m2' on average than carnivore. 

**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?**  

```r
deer <- homerange
deer <- filter(homerange, family == "cervidae")
deer <- select(deer, mean.mass.g, log10.mass, family, genus, species)
deer <- arrange(deer, desc(log10.mass))
head(deer, n=10)
```

```
## # A tibble: 10 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus
```
#### the largest deer is _Alces Alces_. Its common name is *moose*. 

**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**    

```r
snakes <- homerange
snakes <- filter(homerange, taxon == "snakes")
snakes <- arrange(snakes, log10.hra)
head(snakes, n=10)
```

```
## # A tibble: 10 x 24
##    taxon  common.name   class  order  family genus  species  primarymethod N    
##    <fct>  <chr>         <chr>  <fct>  <chr>  <chr>  <chr>    <chr>         <chr>
##  1 snakes namaqua dwar~ repti~ squam~ viper~ bitis  schneid~ telemetry     11   
##  2 snakes eastern worm~ repti~ squam~ colub~ carph~ viridis  radiotag      10   
##  3 snakes butlers gart~ repti~ squam~ colub~ thamn~ butleri  mark-recaptu~ 1    
##  4 snakes western worm~ repti~ squam~ colub~ carph~ vermis   radiotag      1    
##  5 snakes snubnosed vi~ repti~ squam~ viper~ vipera latastei telemetry     7    
##  6 snakes chinese pit ~ repti~ squam~ viper~ gloyd~ shedaoe~ telemetry     16   
##  7 snakes ringneck sna~ repti~ squam~ colub~ diado~ punctat~ mark-recaptu~ <NA> 
##  8 snakes cottonmouth   repti~ squam~ viper~ agkis~ piscivo~ telemetry     15   
##  9 snakes redbacked ra~ repti~ squam~ colub~ oocat~ rufodor~ telemetry     21   
## 10 snakes gopher snake  repti~ squam~ colub~ pituo~ catenif~ telemetry     4    
## # ... with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
#### The snake with the smallest homerange is called Bitis Schneideri, or Namaqua dwarf adder. Here is the [Wikipedia for this little snake](https://en.wikipedia.org/wiki/Bitis_schneideri). In short, this snake is the smallest viper all over the world. It is native to a small coastal region from Namibia and South Africa. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
