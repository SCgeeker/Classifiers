library(tidyverse)

term_process <- function(filename){
  
## Locate the path of raw text file
item_path <- paste0(here::here(),"/phase01/sinica_corpus/classifiers_pool/")
## import the raw text file
raw_text <- read_lines(file = paste0(item_path,filename), skip_empty_rows = TRUE ) %>% gsub(pattern = "\t", replacement = "")
## export the tidy text 
## each line begins with the classifier
write_lines(tidy_raw_text <- raw_text[seq(2,length(raw_text),by=2)],file = paste0(item_path,paste0("tidy_",filename)))

print(filename)

## evaluate and access the targeted items
text_line <- c() ## store the line number for further checking
term_slot <- c() ## store the Na after the classifier

for(i in 1:length(tidy_raw_text)){
## Extract POS and punctuation from the raw text
    parsed_pos <- tidy_raw_text[i] %>% str_extract_all(pattern = "(?<=\\()[:graph:]+(?=\\))|[。，？！「、；．（『]") %>%
        unlist()

## Check 2nd element is POS or punctuation
if(!(parsed_pos[2] %in% c("。","，","？","！","「","、","；","．","（","『"))) {
print(i)
## When a line has more than one POS, check 2nd POS is Na
   if(parsed_pos[2] == "Na" & length(parsed_pos) > 1){
       text_line <- c(text_line, i)
       ## Extract Na after this classifier
       term_slot <- c(term_slot,(tidy_raw_text[i] %>% str_split(pattern = " ") %>% unlist())[2] %>% gsub(pattern = "\\(Na\\)", replacement = ""))
   }
  }
}
 

## export the tidy text to be decided
write_lines(tidy_raw_text[text_line],file = paste0(item_path,paste0("selecting_",gsub(filename,pattern = ".txt",replacement = ""),"_texts.txt")))

write_lines(paste(table(term_slot) %>% names(),table(term_slot) %>% as.vector(), sep = ","),
            file = paste0(item_path,paste0("selecting_",gsub(filename,pattern = ".txt",replacement = ""),"_terms.txt")))

}


## Define the file name
filenames <- list.files(path = paste0(here::here(),"/phase01/sinica_corpus/classifiers_pool/"),pattern=".txt$")

for(filename in filenames){
  term_process(filename)
}
