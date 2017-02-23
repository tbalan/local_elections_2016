
Local elections 2016
--------------------

This is a [Shiny](https://shiny.rstudio.com) app for visualizing the results of the [Romanian local elections, 2016](https://en.wikipedia.org/wiki/Romanian_local_elections,_2016).

The purpose of this was to analyze the way that the "cancelled" votes relate to votes of different parties or candidates. To run this app, you should fork the project, open it in RStudio and type the following in the console:

``` r
install.packages("tidyverse")
install.packages("shiny")
install.pacakges("plotly")

shiny::runApp()
```

A live version can be found [here](https://teddybalan.shinyapps.io/vizualizare_alegeri_2016/).
