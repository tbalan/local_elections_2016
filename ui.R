library(shiny)
library(plotly)
library(tidyr)

#load("p_cj_cl.Rdata")
load("finaldat.Rdata")
finaldat$CodPart <- as.factor(finaldat$CodPart)
# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Vizualizare date alegeri locale 2016"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  

  sidebarPanel(
    selectInput("ox_poz", "OX: alege o pozitie:", 
                choices = levels(finaldat$Alegeri),
                selected = "consilieri_locali"),
    
    selectInput("ox_part", "OX: alege un partid:", 
                choices = levels(finaldat$CodPart),
                selected = "psd"),
    
    selectInput("oy_poz", "OY: alege o pozitie:", 
                choices = levels(finaldat$Alegeri),
                selected = "primari"),
    
    selectInput("oy_part", "OY: alege un partid:", 
                choices = levels(finaldat$CodPart),
                selected = "psd"),
    
    # selectInput("oy", "alege o variabila (OY):", 
    #             choices = c("pnl_p", "pnl_cj", "pnl_cl",
    #                          "psd_p", "psd_cj", "psd_cl",
    #                          "nule_p", "nule_cj", "nule_cl")),
    # selectInput("judet", "alege un judet (sau nu):",
    #             choices = c("none", levels(p_cj_cl$NumeJudet))),
    
    checkboxInput(inputId = "smoother",
                  label = strong("linie smoother"),
                  value = TRUE),
    
    checkboxInput(inputId = "straightline",
                  label = strong("linie de egalitate"),
                  value = FALSE),
    
    # checkboxInput(inputId = "medii",
    #               label = strong("linii de medie"),
    #               value = FALSE),
    
    sliderInput("nrOrase", "Numar de orase:", min = 3, max = 200, value = 50),
    
    selectInput("sort_how", label = "ordonate dupa... ",
                  choices = c("populatie", "proc_voturi_ox", "proc_voturi_oy")),
    
    
    checkboxGroupInput("judet", label = "selecteaza judete (sau nu):", choices = levels(finaldat$NumeJudet),
                       selected = NULL, inline = FALSE, width = NULL)

    

  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    plotlyOutput("sctplt")
  )
))