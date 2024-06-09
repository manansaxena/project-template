#!/bin/bash

# create a pipeline of different steps in your project. After the first job, every subsequent job can be made dependent on previous being completed successfully
# For example, the first step could be data preprocessing, next running the model, etc.

foojid=$(sbatch foo_R.sh)

moojid=$(sbatch --dependency=afterok:${foojid##* } moo_R.sh)