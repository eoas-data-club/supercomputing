#!/bin/bash

#SBATCH --job-name=test.script ## Replace with your jobname 
#SBATCH --partition=main # Partition (job queue) 
#SBATCH -N 1 # Number of nodes 
#SBATCH -n 1 # Numer of tasks
#SBATCH -c 1 # Number of cores per task
#SBATCH --mem=1000 # Real memory (RAM) per node required (MB) 
#SBATCH --time=1:00:00 # Total run time limit (HH:MM:SS) 
#SBATCH -o %N-%j.out
#SBATCH -e %N-%j.err


# This clears the decks of any 'leftovers' 
module purge
# this activates the environment in which we installed R and our packages
source activate renv

# You don't have to change anything from here to 'srun'. It's just specifying which information
# will come out in aaa.out 
### Pre-run preparation
# Print the name of the node on which this script has started and the time.
echo "====================================================================="
echo "Starting on `hostname` at `date`"
STARTDATE=`date`
HN=`hostname`
echo "HERE WILL BE NODELIST $SLURM_JOB_NODELIST" >> aaa.out
echo "Current JOB_ID is $SLURM_JOB_ID"   >> aaa.out

# Display this job's working directory
echo Working directory is $SLURM_SUBMIT_DIR  >> aaa.out

# This line is really important! It tells Amarel that you are running an R script, and it links this
# job file to the script that you want to run. Make sure that this file path matches the path to the
# script in your home directory. 
srun --mpi=pmi2 Rscript /home/at995/data.club/test.script.R IFN:output.file.csv

