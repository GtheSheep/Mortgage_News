library(rvest)
library(XML)
source("article_parser.R")
source("web_util.R")

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

getMwDate <- function(rawHtml){
  html_nodes(rawHtml, xpath = "//*[@id='container']/div[2]/div[2]/div[1]/div[1]/text()") %>%
    html_text() %>%
    as.Date("%d.%m.%Y")
}

getMwContent <- function(rawHtml){
  html_nodes(rawHtml, xpath = "//div[@class='news_container']/p") %>% 
    html_text()
}

parseMwUrl <- function(url){
  rawHtml <- read_html(url)
  parsedArticle <- Article$new(title = getMwTitle(rawHtml = rawHtml),
                               content = getMwContent(rawHtml = rawHtml),
                               date = getMwDate(rawHtml = rawHtml),
                               source = url
                               )
  return(parsedArticle)
}