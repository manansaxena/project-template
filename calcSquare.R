# compute_squares.R
args <- commandArgs(trailingOnly = TRUE)
param_string <- args[1] 
output_dir <- args[2]
param_list <- as.numeric(strsplit(param_string," ")[[1]])

param1 <- param_list[1]
param2 <- param_list[2]

# Function to compute the square of the sum
compute_square <- function(a, b) {
  return((a + b)^2)
}

result <- compute_square(param1, param2)

output_path <- file.path(output_dir, "result.txt")
writeLines(as.character(result), output_path)

cat("Result saved to:", output_path, "\n")  # Confirm saving location