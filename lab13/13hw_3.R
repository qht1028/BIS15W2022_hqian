library(tidyverse)
library(shiny)
library(shinydashboard)

admission <- read.csv("data/uc_data/UC_admit.csv")%>%
  filter(Ethnicity != "All")
admission$Academic_Yr <- as.factor(admission$Academic_Yr)

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