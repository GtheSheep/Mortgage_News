
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
source("rss_reader.R")

shinyServer(function(input, output, session){
  mwLinks <- c('http://www.themortgageworks.co.uk/feed/products', 'http://www.themortgageworks.co.uk/feed/news')
  articles <- list()
  for (source in mwLinks){
    for (link in mwRssLinks(source)){
      article = parseMwUrl(link)
      articles <- c(articles, link = article)
    }
  }

})
