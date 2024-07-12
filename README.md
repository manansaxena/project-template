# Roar HPC Project Template

This repository serves as a template for running batch processing jobs on the Roar High-Performance Computing (HPC) system. It includes scripts for job submission, handling dependencies, and organizing output which are tailored for efficient computational research.

## Description

This template simplifies the process of submitting and managing dependent jobs on Roar HPC. It employs SLURM for job scheduling, ensuring that jobs are executed in the correct order and only if previous jobs have completed successfully.

## Features

- **Job Submission Scripts**: Includes scripts for submitting jobs via the SLURM scheduler on Roar HPC.
- **Dependency Management**: Automates the management of job dependencies.
- **Output Management**: Organizes job outputs and error logs into specified directories, facilitating easy analysis.

## Prerequisites

Before using this template, ensure you have:
- An active Roar HPC account.
- Basic understanding of SLURM commands.
- Familiarity with Bash scripting and R programming.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/manansaxena/project-template.git
   cd roar-hpc-template
   ```
2. **Make Scripts Executable**:
   ```bash
   chmod +x *.sh
   ```

## Usage

1. **Prepare your scripts**:
   Use 'foo_R.sh' and 'foo.R' as templates and make the necessary changes using the comments in the file. Create as many pair of similar files to run multiple stages in the project.
2. **Make changes to master_driver.sh**:
   Each stage in the project is assigned a script file to be executed and each stage is executed after the previous one has been completed successfully.
3. **Create parameters file**:
   Use 'generate_params.R' file to create params.txt which would contain all the combinations you want to run your experiment for. Each stage of the project can have a dedicated parameter file.
 
## Execute
After all the changes have been made, just run the following command from your terminal(already connected to Roar):

```bash
sbatch master_driver.sh
```

You can check the status of jobs using the following command

```bash
squeue -u {your_roar_id}
```
