# Define the lists
N <- c(1, 2, 3)
D <- c(4, 5, 6)

# Compute all combinations of N and D
combinations <- expand.grid(N = N, D = D)

# Format the combinations into a single string per line
params_lines <- apply(combinations, 1, function(x) paste(x, collapse = " "))

# Write the combinations to params.txt
writeLines(params_lines, "params.txt")
