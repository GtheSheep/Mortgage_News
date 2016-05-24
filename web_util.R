removePdf <- function(urlList){
  urlList[-grep(".pdf", urlList)]
}