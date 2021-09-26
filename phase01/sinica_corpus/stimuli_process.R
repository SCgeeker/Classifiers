library(tidyverse)
library(stringr)


## locate working directory at the top 
here::here()


## Set of common classifiers; Origin: (賴宛君, 2011; 陳羿如 & 何萬順, 2020)
classifiers_set01 <- c("瓣","家","名","葉","枚","把","架","匹","員","管","本","間","篇","則","面","柄","件","片","盞","尾","齣","節","起","張","位","點","介","曲","幀","頂","具","首","支","錠","卷","艘","只","棟","棵","所","枝","朵","顆","台","隻","發","口","題","宗","封","塊","條","尊","幅","粒","頭","座","根","輛","丸","個")

## Set of common classifiers; Origin: (田意民等, 2002)
classifiers_set02 <- c("條","根","面","個","粒","枝","張","片","顆")


## Set of object nouns; Origin: (田意民等, 2002)
nouns_set01 <- c("香","羽毛","帆布","樹葉","長尺","掃把","書法","繩子","病床","吸管","卡片","眉毛","梅花","竹筍","石柱","果實","地圖","嗩吶","幻燈片","扁擔","木瓜","面孔","門板","文憑","心","神經","工筆畫","鰻魚","拂塵","手指","巨石","甘蔗","火柴","支票","白雲","枴杖","土地","鋼管","地毯","牙籤","炸彈","水田","打火機","手槍","版畫","紅豆","銅絲","文旦","玉石","竹筷","球棒","花蕊","白米","冰棒","絲瓜","玻璃","花生","香蕉","子彈","箭","表格","名片","西瓜","銀釵","琴弦","烏雲","書桌","木樁","屋瓦","竹竿","氣球","毛蟲","車牌","針","毒蛇","魚刺","肋骨","車票","香煙","犀牛角","木杖","流星","蠟燭","象牙","油漬","蘿蔔","玫瑰","牙齒","鋼筆","電線","果實","鰻魚","西瓜","冰棒","手指","神經","車票","名片","書桌","白雲","魚刺","火柴","玻璃","屋瓦","版畫","氣球","地圖","蠟燭","子彈","絲瓜","汗水","文旦","樹葉","象牙","竹竿","面孔","白米","病床","鋼筆","毒蛇","繩子","香蕉","手槍","吸管","毛巾","釘子","椅子","手掌","盾牌","地毯","骨頭","旗子","竹筍","面具","褲子","樹幹","床","煙囪","磁片","錶帶","蠟燭","門","流星","藥丸","繃帶","木板","書桌","胡瓜","鐵軌","底片","骨牌","蘿蔔","柱子","紙條","獎牌","貝殼","香蕉","廁紙","鏡子","披薩")

label_set01 <- c(rep("study01",90),rep("study03",34),rep("study04",36))


THT_sti <- data.frame(
    WORD = unique(nouns_set01),
    STUDY01 = unique(nouns_set01) %in% nouns_set01[label_set01 == "study01"],
    STUDY03 = unique(nouns_set01) %in% nouns_set01[label_set01 == "study03"],
    STUDY04 = unique(nouns_set01) %in% nouns_set01[label_set01 == "study04"]
)

write.table(classifiers_set01, file=paste0("phase01/sinica_corpus/","LCH_classifiers.txt"),row.names=F,col.names=FALSE,quote=F,sep=",",fileEncoding="UTF-8")

write.table(classifiers_set02, file=paste0("phase01/sinica_corpus/","THT_classifiers.txt"),row.names=F,col.names=FALSE,quote=F,sep=",",fileEncoding="UTF-8")

write.table(THT_sti, 
            file=paste0("phase01/sinica_corpus/","THT_sti.csv"),row.names=F,quote=F,sep=",",fileEncoding="UTF-8")

## Isolate the locations of csv files
csv_path <- list.files(pattern = "sinica_sti_candidates.csv",recursive = TRUE,include.dirs = TRUE)

## import target items
target_items <- read_csv(csv_path) 

## import the words in the past studies
classifiers_set01 <- tibble(WORD = read_csv(paste0(getwd(),"/",list.files(pattern = "LCH_classifiers.txt",recursive = TRUE,include.dirs = TRUE)[1]), col_names = FALSE)$X1, SOURCE = "LCH")

classifiers_set02 <- tibble(WORD = read_csv(paste0(getwd(),"/",list.files(pattern = "THT_classifiers.txt",recursive = TRUE,include.dirs = TRUE)[1]), col_names = FALSE)$X1, SOURCE = "THT")

nouns_set01 <- tibble(WORD = read_csv(paste0(getwd(),"/",list.files(pattern = "THT_nouns.txt",recursive = TRUE,include.dirs = TRUE)[1]), col_names = FALSE)$X1,SOURCE = "THT")

## Select the classifiers for the survey
classifiers_sti <- read_csv(paste0(getwd(),"/",list.files(pattern = "LCH_classifiers.txt",recursive = TRUE,include.dirs = TRUE)[1]), col_names = TRUE)

classifiers_sti %>% subset(CATEGORY == "shape")

## Merge corpus data and study materials
(classifier_set01_property <- target_items %>% right_join(classifiers_set01, by="WORD") %>% arrange(WORD)) %>% write.table(file=paste0("Corpus/sinica_corpus/","LCH_classifiers.txt"),row.names=F,col.names=TRUE,quote=F,sep=",",fileEncoding="UTF-8")

(classifier_set02_property <- target_items %>% right_join(classifiers_set02, by="WORD") %>% arrange(WORD)) %>% write.table(file=paste0("Corpus/sinica_corpus/","THT_classifiers.txt"),row.names=F,col.names=TRUE,quote=F,sep=",",fileEncoding="UTF-8")


(nouns_set01_property <- target_items %>% right_join(nouns_set01, by="WORD") %>% arrange(WORD)) %>% write.table(file=paste0("Corpus/sinica_corpus/","THT_nouns.txt"),row.names=F,col.names=TRUE,quote=F,sep=",",fileEncoding="UTF-8")

## Which classifiers are nouns?
classifier_set01_property %>% subset(POS == "Na")
classifier_set02_property %>% subset(POS == "Na")
## Which nouns are classifiers?
nouns_set01_property %>% subset(POS == "Nf")

## Overview the stimuli property
target_items %>% filter(WORD %in% classifiers_set01) %>%
    filter(POS != "Na") %>%
    summarise(N = n(), Mean = mean(FREQ), SD = sd(FREQ), minimun = min(FREQ), maximal = max(FREQ))

target_items %>% filter(WORD %in% classifiers_set02) %>%
    filter(POS != "Na") %>%
    summarise(N = n(), Mean = mean(FREQ), SD = sd(FREQ), minimun = min(FREQ), maximal = max(FREQ))


target_items %>% filter(WORD %in% nouns_set) %>%
    filter(POS != "Nf") %>%
    summarise(N = n(), Mean = mean(FREQ), SD = sd(FREQ), minimun = min(FREQ), maximal = max(FREQ))


target_items %>% filter(WORD %in% classifiers_set01) %>%
    filter(POS != "Na") %>%
    write.table(file=paste0("Corpus/sinica_corpus/","LCH_calssifiers_property.csv"),row.names=F,col.names=TRUE,quote=F,sep=",",fileEncoding="UTF-8")