library(tidyverse)
## Locate working dir
data_path <- paste0(here::here(),"/phase01/sinica_corpus/")

## Import THT stimulus
THT_nouns <- read_csv(file = paste0(data_path,"THT_nouns.txt"))

## Locate selected noun sets
selecting_files_path <- list.files(paste0(data_path,"classifiers_pool/"),pattern = "_terms.txt$",full.names = TRUE)

## prepare the empty data frame for the checks
checks <- NULL

i = 1
while(i < length(selecting_files_path) ){
    
    ## Import selected noun sets
    checks <- bind_cols(checks, THT_nouns$WORD %in% (read_csv(selecting_files_path[i], col_names = FALSE) %>%
        pull(X1)) )
    i = i + 1
}

colnames(checks) <- selecting_files_path %>% gsub(pattern = paste0(data_path,"classifiers_pool/selecting_"), replacement="") %>% gsub(pattern = "_terms.txt",replacement = "")

## Export the checks to csv file
THT_nouns <- bind_cols(THT_nouns, checks)
write_csv(THT_nouns, file = paste0(data_path,"THT_nouns_check.csv"))

## Import THT checks from the csv file
THT_nouns <- read_csv(file=paste0(data_path,"THT_nouns_check.csv"))

## Summarize the numbers
THT_nouns[,-(1:5)] %>% colSums()

Nf_SUM = THT_nouns[,-(1:5)] %>% rowSums()

write_csv(bind_cols(THT_nouns, Nf_SUM), file = paste0(data_path,"THT_nouns_check.csv"))
