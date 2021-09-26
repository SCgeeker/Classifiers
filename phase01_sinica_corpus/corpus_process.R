library(tidyverse)
library(stringr)

## locate working directory at the top 
here::here()

## Isolate the locations of tex files
paths <- list.files(pattern = ".tex$",recursive = TRUE,include.dirs = TRUE)

# import tex file without head
items <- c(read_lines(paths[1],skip=17), read_lines(paths[2],skip=18) )


# exclude no column items
items <- items[grep(pattern = "&", items)] %>%
    str_split(pattern = " & ")

# Prepare the data frame for the storage of items
items_db <- data.frame(
    word = character(),
    POS = character(),
    FREQ = numeric(),
    RANK = double()
)

# Convert list of vectors to dataframe
for(i in 1:length(items)){
    items_db <- rbind(items_db,items[[i]])
}

# Shape the data type of dataframe
names(items_db) <-c("WORD","POS","FREQ","RANK")
items_db$FREQ <- as.numeric(items_db$FREQ)
items_db$RANK <- gsub(items_db$RANK, pattern = "[^0-9|.]", replacement = "") %>% as.double()

# Select the target items
targeted_items <- items_db %>% filter(POS %in% c("Na","Nf")) %>%
    distinct()

# Export the target items to the single file
write.table(targeted_items, file=paste0("Corpus/sinica_corpus/","sinica_sti_candidates.csv"),row.names=F,col.names=TRUE,quote=F,sep=",",fileEncoding="UTF-8")

