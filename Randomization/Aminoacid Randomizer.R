#AA randomizer

library("writexl")
library(stringi)
library(tm)

#Change sequence in this line and name of xlsx file at the very end (optional: change chunklength if flanking region is shorter or longer than 16 AA)
original_sequence <- "DKSSNSPYSESYYNSL"

my_vector = unlist(strsplit(original_sequence, ""))
my_vector

AA_alphabet <- "ARNDCQEGHILKMFPSTWYV"

my_vector2 = unlist(strsplit(AA_alphabet, ""))
my_vector2

x <- vector()
mutated_seq <- data.frame()

for (i in 1:length(my_vector)) {
  
  for (j in 1:length(my_vector2)) {
    
    mutated_seq <- my_vector
    
    mutated_seq[i] <- my_vector2[j]
    
    final_vector <- c(x, mutated_seq)
    
    x <- final_vector
  }
}

initial_data <- data.frame("Mutated Sequence" = final_vector)
initial_data

data_in_row <- as.data.frame(t(initial_data))
data_in_row

chunklength = 16
split_data <- split(final_vector, ceiling(seq_along(final_vector) / chunklength))

split_data2 <- as.data.frame(t(split_data))

for (k in split_data2) {
  
  final_seqs <- stri_replace_all_regex(split_data2, '[c()," ]', "")
}

final_data <- data.frame("All Mutated Sequences" = final_seqs)
final_data

for (l in final_data) {
  
  no_num_data <- removeNumbers(l)
  no_num_data <- stri_replace_all_regex(no_num_data, "[list'`=]", "")
}

no_num_data

ultimate <- data.frame("All Mutated Sequences" = no_num_data)
ultimate

colnames(ultimate) <- c("All Possible Sequences")

write_xlsx(ultimate,"Colony52b_1Hamming.xlsx")

#Find common element in two different dataframe columns
intersect(variant_data_merge$aa_seq, Merged_1aa_Variants$Sequences)
