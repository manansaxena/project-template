# compute_squares.R
args <- commandArgs(trailingOnly = TRUE)

# get the string of parameters like "1 2" and the directory where results would be stored
param_string <- args[1] 
output_dir <- args[2]
# split the parameter string and convert it to a list of numeric
param_list <- as.numeric(strsplit(param_string," ")[[1]])

param1 <- param_list[1]
param2 <- param_list[2]

# Function to compute the square of the sum
compute_square <- function(a, b) {
  return((a + b)^2)
}

result <- compute_square(param1, param2)

# save the result
output_path <- file.path(output_dir, "result.txt")
writeLines(as.character(result), output_path)

cat("Result saved to:", output_path, "\n")  # Confirm saving location. This would go in .out file for this simulation