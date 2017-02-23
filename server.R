library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(lazyeval)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  # datasetInput <- reactive({
  #   switch(input$ox,
  #          "pnl_p" = pnl_p,
  #          "pnl_cj" = pnl_cj,
  #          "pnl_cl" = pnl_cl)
  # })
  
  # Generate a summary of the dataset
  
  # output$sctplt <- renderPlot({
  #   load("p_cj_cl.Rdata")
  # 
  #   plt <- p_cj_cl %>% arrange(desc(tot_aleg_p)) %>%
  #     slice(1:100L) %>%
  #     mutate(n_alegatori = tot_aleg_p) %>%
  #     #ggplot(aes(x = input$ox, y = nule_p)) +
  #     ggplot(aes(x = pnl_p, y = nule_p)) +
  #     #geom_text(aes(label = oras_id, size = tot_alegatori)) +
  #     geom_point(aes(text = Localitate, size = n_alegatori, colour = NumeJudet)) +
  #     theme(legend.position="none") +
  #     #geom_abline(slope = 1, intercept = 0, colour = "darkblue", alpha = 0.5)
  #     geom_smooth()
  #   # plot(runif(100), runif(100))
  #   
  #   plotly(plt)
  # })
  
  output$sctplt <- renderPlotly({
    load("finaldat.Rdata")
    
    if(!is.null(input$judet)) {
      finaldat <- finaldat %>% filter(NumeJudet == input$judet)
    }
    

    # create the relevant data set
    pl0 <- finaldat %>% 
      filter((Alegeri == input$ox_poz & CodPart == input$ox_part ) |  (Alegeri == input$oy_poz & CodPart ==input$oy_part)) %>% 
      select(-nr_voturi) %>% 
      unite(identif, Alegeri, CodPart) %>% 
      spread(identif, pr_voturi) %>% 
      na.omit() %>% 
      mutate_(same = names(.)[6]) %>% 
      arrange(desc(tot_alegatori)) 
    
    var_names <- names(pl0)[c(6,7)]
    if(input$sort_how == "proc_voturi_ox") pl0 <- pl0 %>% arrange_(interp(~desc(var), var = as.name(var_names[1])))
    if(input$sort_how == "proc_voturi_oy") pl0 <- pl0 %>% arrange_(interp(~desc(var), var = as.name(var_names[2])))
    
    pl0 <- pl0 %>% slice(1:input$nrOrase) %>% 
      ggplot(aes_string(x = var_names[1], y = var_names[2])) +      
      geom_point(aes(text = Localitate, size = tot_alegatori, colour = NumeJudet)) +
      theme(legend.position="none")
    
    if(input$smoother) {
        pl0 <- pl0 + geom_smooth()
      }
    
    if(input$straightline) {
      pl0 <- pl0 + geom_abline(slope = 1, intercept = 0, colour = "darkblue", alpha = 0.5)
    }
    
    plt <- pl0
  
    
    ggplotly(plt)
  }
    
  )
  
})