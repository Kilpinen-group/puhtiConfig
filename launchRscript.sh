#!/bin/bash
#SBATCH --job-name=rscript
#SBATCH --account=project_2003986
#SBATCH --ntasks=1
#SBATCH --nodes=1  
#SBATCH --cpus-per-task=16
#SBATCH --mem=96g
#SBATCH --time=04:00:00
#SBATCH --partition=small

source activate renv

Rscript $1