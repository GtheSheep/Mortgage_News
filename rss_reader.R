library(rvest)
library(XML)

mwProductPage <- read_html('http://www.themortgageworks.co.uk/feed/products')
mwNewsPage <- read_html('http://www.themortgageworks.co.uk/feed/news')

removePdf <- function(urlList){
  urlList[-grep(".pdf", urlList)]
}

mwRssLinks <- function(rssUrl){
  links <- read_html(rssUrl) %>%
    html_nodes(xpath = '//item/guid') %>%
    html_text()
  links <- removePdf(links)
  return(links)
}

getMwTitle <- function(rawHtml){
  html_nodes(rawHtml, xpath = "//div[@class='news_container']/h1") %>%
    html_text()
}

parseMwUrl <- function(url){
  rawHtml <- read_html(url)
}