#!/bin/bash

# Ensure the file is executable: chmod +x foo_R.sh

# specify the directory where the job's logs should be stored. If the directory doesn't exist, it would create one
output_dir="/storage/home/mms7976/work/roartemplate/job_logs_foo"
mkdir -p "$output_dir"

# Iterate through each line in params_foo.txt file. Each line in that file represents one combination/set of parameters you want to run the experiment for
while IFS= read -r line
do
  # Format current date and time as YYYYMMDD_HHMMSS
  timestamp=$(date +%Y%m%d_%H%M%S)
  # Create a job name using line contents and the current timestamp
  job_name=$(echo "$line" | sed 's/ /_/g')_${timestamp}
  # Submit a job for each line of parameters. There are many other flags that can be used. You can reference: https://slurm.schedmd.com/sbatch.html
  sbatch <<EOT
#!/bin/bash
#SBATCH -J job_${job_name}                                    # Name of the job submitted to roar
#SBATCH --output=${output_dir}/job_${job_name}.out            # Specifies where the output files (.out) would be stored
#SBATCH --error=${output_dir}/job_${job_name}.err             # Specifies where the error files (.err) would be stored
#SBATCH --time=01:00:00                                       # Time limit
#SBATCH --nodes=1                                             # Number of nodes
#SBATCH --cpus-per-task=4                                     # Number of cores 
#SBATCH --mem-per-cpu=8GB                                     # Memory per core

module load r                                                 # Load R module, adjust if using a specific version

cd "/storage/home/mms7976/work/roartemplate/"                 # Directory where the code is stored
Rscript foo.R "$line"                                         # Run the R script with parameters
EOT

done < "params_foo.txt"