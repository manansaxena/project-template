library(foreach)
library(doParallel)

# Function to run multiple simulations for same set of parameters
# param_string: All the parameters on a specific line specified in the params text file
# num_times: Number of times simulation is ran
# num_cores: Number of cores used when parallely running the same simulation num_times
# file_name: Name of the R file that contains the code needed to be run
# result_dir_path: base path where the results of the simulation is stored
# safe_param_string: param_string converted to a valid directory name

run_multi_sim_per_param <- function(param_string, num_times, num_cores, file_name, result_dir_path, safe_param_string) {
  # define a cluster of available cores leaving one out. Good Practice
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
res_dir_name <- "res_foo"
result_dir_path <- paste0(base_dir_path, res_dir_name, "/")
dir.create(result_dir_path,recursive=TRUE,showWarnings=TRUE)


file_name <- 'calcSquare.R'
num_cores <- 4
run_multiple_times <- FALSE

if(run_multiple_times){
  num_times <- 3
  result <- run_multi_sim_per_param(param_string, num_times, num_cores, file_name, result_dir_path, safe_param_string)
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