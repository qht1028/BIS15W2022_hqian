---
title: "Lab 13 Homework"
author: "Hongtao Qian"
date: "2022-02-24"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Libraries

```r
library(tidyverse)
library(shiny)
library(shinydashboard)
```

## Choose Your Adventure!
For this homework assignment, you have two choices of data. You only need to build an app for one of them. The first dataset is focused on UC Admissions and the second build on the Gabon data that we used for midterm 1.  

## Option 1
The data for this assignment come from the [University of California Information Center](https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus. Admissions are broken down into three categories: applications, admits, and enrollees. The number of individuals in each category are presented by demographic.  

**1. Load the `UC_admit.csv` data and use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine if there are NA's and how they are treated.**  

```r
admission <- read.csv("data/uc_data/UC_admit.csv")%>%
  filter(Ethnicity != "All")
admission$Academic_Yr <- as.factor(admission$Academic_Yr)
unique(admission$Campus)
```

```
## [1] "Davis"         "Berkeley"      "Irvine"        "Los_Angeles"  
## [5] "Merced"        "Riverside"     "San_Diego"     "Santa_Barbara"
## [9] "Santa_Cruz"
```


**2. The president of UC has asked you to build a shiny app that shows admissions by ethnicity across all UC campuses. Your app should allow users to explore year, campus, and admit category as interactive variables. Use shiny dashboard and try to incorporate the aesthetics you have learned in ggplot to make the app neat and clean.**

```r
ui <- dashboardPage(
  dashboardHeader(title = "UC Admission"),
  dashboardSidebar(disable = T),
  dashboardBody(
  fluidRow(
  box(title = "Plot Options", width = 3,
  selectInput("x", "Select Year", choices = c("2010", "2011", "2012","2013", "2014", "2015", "2016", "2017", "2018", "2019"), 
              selected = "2010"),
  selectInput("y", "Select Category", choices = c("Applicants", "Admits"), 
              selected = "Applicants"), 
  selectInput("z", "Select UC", choices = c("Berkeley", "Irvine", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz", "Davis"), 
              selected = "Davis")
  ),
  box(title = "Plot of UC Admission by Ethnicity", width = 7,
  plotOutput("plot", width = "600px", height = "500px")
  )
  )
  ) 
) 
```

```
## Warning in name %in% fa_tbl$v4_name: strings not representable in native
## encoding will be translated to UTF-8
```

```r
server <- function(input, output, session) { 
  output$plot <- renderPlot({admission %>% 
  filter(Academic_Yr == input$x)%>%
  filter(Category == input$y)%>%
  filter(Campus == input$z)%>%
  ggplot(aes_string(x = "Ethnicity", y="FilteredCountFR", fill = "Ethnicity")) +
  geom_col()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x="Campus", 
       y="Number")
  })
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}


**3. Make alternate version of your app above by tracking enrollment at a campus over all of the represented years while allowing users to interact with campus, category, and ethnicity.**  


```r
ui <- dashboardPage(
  dashboardHeader(title = "UC Admission"),
  dashboardSidebar(disable = T),
  dashboardBody(
  fluidRow(
  box(title = "Plot Options", width = 3,
  selectInput("x", "Select Ethnicity", choices = c("International", "Unknown", "White", "Asian", "Chicano/Latino", "American Indian", "African American"), 
              selected = "International"),
  selectInput("y", "Select Category", choices = c("Applicants", "Admits"), 
              selected = "Applicants"), 
  selectInput("z", "Select UC", choices = c("Berkeley", "Irvine", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz", "Davis"), 
              selected = "Davis")
  ),
  box(title = "Plot of UC Admission by Ethnicity", width = 7,
  plotOutput("plot", width = "600px", height = "500px")
  )
  )
  ) 
) 

server <- function(input, output, session) { 
  output$plot <- renderPlot({admission %>% 
  filter(Ethnicity == input$x)%>%
  filter(Category == input$y)%>%
  filter(Campus == input$z)%>%
  ggplot(aes_string(x = "Academic_Yr", y="FilteredCountFR")) +
  geom_col(fill = "tomato", alpha = 0.8)+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x="Academic Year", 
       y="Number")
  })
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
