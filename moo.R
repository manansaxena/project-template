library(foreach)
library(doParallel)

# Function to run multiple simulations
run_multi_sim_per_param <- function(param_string, num_times, num_cores, file_name, result_dir_path, safe_param_string) {
  my_cluster <- parallel::makeCluster(num_cores - 1, type = "PSOCK")
  on.exit(parallel::stopCluster(my_cluster))  # Ensure cluster is stopped even if errors occur

  doParallel::registerDoParallel(cl = my_cluster)

  results <- foreach(i = 1:num_times, .packages = "foreach") %dopar% {

    dir_name <- sprintf("%sresults_%s_%d",result_dir_path,safe_param_string,i)
    dir.create(dir_name,recursive=TRUE,showWarnings=TRUE)

    cmd <- sprintf("Rscript %s \"%s\" \"%s\"", file_name, param_string, dir_name)
    tryCatch({
      output <- system(cmd, intern = TRUE)
      list(success = TRUE, output = output)
    }, error = function(e) {
      list(success = FALSE, error = conditionMessage(e))
    })
  }
  return(results)
}

args <- commandArgs(trailingOnly = TRUE)
param_string <- args[1]
safe_param_string <- gsub("[^a-zA-Z0-9]", "_", param_string)
base_dir_path <- "/storage/home/mms7976/work/roartemplate/"
res_dir_name <- "res_moo"
result_dir_path <- paste0(base_dir_path, res_dir_name, "/")
dir.create(result_dir_path,recursive=TRUE,showWarnings=TRUE)


file_name <- 'calcSquare.R'
num_cores <- 4
run_multiple_times <- TRUE

if(run_multiple_times){
  num_times <- 3
  result <- run_multi_sim_per_param(param_string, num_times, num_cores, file_name, result_dir_path, safe_param_string)
  print(result)
} else {
  
  dir_name <- sprintf("%sresults_%s",result_dir_path,safe_param_string)
  dir.create(dir_name,recursive=TRUE,showWarnings=TRUE)

  cmd <- sprintf("Rscript %s \"%s\" \"%s\"", file_name, param_string, dir_name)
  results <- tryCatch({
      output <- system(cmd, intern = TRUE)
      list(success = TRUE, output = output)
    }, error = function(e) {
      list(success = FALSE, error = conditionMessage(e))
    })
}