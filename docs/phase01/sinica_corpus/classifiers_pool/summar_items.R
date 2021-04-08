library(tidyverse)

terms_path <- list.files(path = paste0(here::here(),"/phase01/sinica_corpus/classifiers_pool/"),pattern="_terms.txt$",full.names = TRUE)

## import the terms data 
## Summarize the type frequency and token frequency
terms_summary <- data.frame(TERM  = NULL,
                           TYPE_FREQ = NULL, 
                           TOKEN_FREQ = NULL)
for(i in 1:length(terms_path)){

terms_summary <- bind_rows(terms_summary,
    read_delim(file = terms_path[i], delim = ",", col_names = FALSE, skip_empty_rows = TRUE ) %>%
    summarise(TERM = str_extract(terms_path[i],pattern = "(?<=_)[:alpha:]+(?=_)"),
              TYPE_FREQ = n(), TOKEN_FREQ = sum(X2))
)

}


write_csv(terms_summary, file="terms_summary.csv")
