library(tidyverse)
library(rvest)
## Scrape the results of sinica corpus 3.0
## This case is 片(Nf)
url <- "http://asbc.iis.sinica.edu.tw/page.asp?pagenum=1&poshave=1"

## import raw web page
sinica_read <- readLines(url, encoding = "UTF-8")

## Extract the survey result only
sinica_read = sinica_read[str_which(flat_html, pattern = "<th nowrap>")]

parsed_sinica <- read_html(sinica_read)
