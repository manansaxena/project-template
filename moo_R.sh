#!/bin/bash

# Ensure the file is executable: chmod +x this_script.sh

output_dir="/storage/home/mms7976/work/roartemplate/job_logs_moo"
mkdir -p "$output_dir"

# Iterate through each line in params.txt
while IFS= read -r line
do
  # Format current date and time as YYYYMMDD_HHMMSS
  timestamp=$(date +%Y%m%d_%H%M%S)
  # Create a job name using line contents and the current timestamp
  job_name=$(echo "$line" | sed 's/ /_/g')_${timestamp}
  # Submit a job for each line of parameters
  sbatch <<EOT
#!/bin/bash
#SBATCH -J job_${job_name}
#SBATCH --output=${output_dir}/job_${job_name}.out
#SBATCH --error=${output_dir}/job_${job_name}.err
#SBATCH --time=01:00:00             # Time limit
#SBATCH --nodes=1                   # Number of nodes
#SBATCH --cpus-per-task=4           # Number of CPUs per task
#SBATCH --mem-per-cpu=8GB           # memory per CPUs

module load r                       # Load R module, adjust if using a specific version

cd "/storage/home/mms7976/work/roartemplate/"
Rscript moo.R "$line"                 # Run the R script with parameters
EOT

done < "params_moo.txt"