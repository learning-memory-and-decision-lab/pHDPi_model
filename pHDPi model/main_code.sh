#!/bin/bash

# Job Name
#SBATCH -J arrayjob 

# Walltime requested
#SBATCH -t 24:00:00

#SBATCH --mem-per-cpu=30G

# Provide index values (TASK IDs)
#SBATCH --array=1-20

# Use '%A' for array-job ID, '%J' for job ID and '%a' for task ID
#SBATCH -e sequential_tasks_code-%a.err
#SBATCH -o sequential_tasks_code-%a.out

# single core
#SBATCH -c 1
#SBATCH --account=carney-mnassar-condo 

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job
 
echo "Running job array number: "$SLURM_ARRAY_TASK_ID

module load matlab/R2025a

matlab-threaded -nodisplay -nojvm -r "sequential_tasks_code($SLURM_ARRAY_TASK_ID,5,25,0.1,0.1), exit"
