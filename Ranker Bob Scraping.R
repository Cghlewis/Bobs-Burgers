install.packages('xml2')
install.packages('rvest')
install.packages('stringr')

library(xml2)
library(rvest)
library(stringr)

#Bring in data

webpage<-read_html('https://www.ranker.com/list/all-bob_s-burgers-characters/reference')

list(webpage)

#Remove html

text<-html_text(webpage)

writeLines(text)

#Drop portions of the text

text2 <- str_split_fixed(text, "Region", n = 2)[2]

writeLines(text2)

text3 <- str_split_fixed(text2, "LOAD", n = 2)[1]

writeLines(text3)


##Remove comments

bobs_text_data_taff1 <- str_split_fixed(text3, pattern=fixed( "Taffy, nicknamed"), n = 2)[1]

bobs_text_data_taff2 <- str_split_fixed(text3, "of Taff!!", n = 2)[2]

bob<-paste(bobs_text_data_taff1, bobs_text_data_taff2, sep=" ")

bob<-str_replace(bob, "Michelle Collins added", "")

bob<-str_replace(bob, "rachel-blanton added", "")

bob<-str_replace(bob, "bobburgersbinge added", "")


## Clean up some whitespace

bobfinal <- gsub("\\s+", " ", str_trim(bob))

#OR

bob2<-str_squish(bob)

#Turn our data into a list

bob3<-strsplit(bob2, split=" ")

list(bob3)

write.table(bob3, "bob.txt" , sep = " ", dec = ".",
            row.names = F, col.names = F)

