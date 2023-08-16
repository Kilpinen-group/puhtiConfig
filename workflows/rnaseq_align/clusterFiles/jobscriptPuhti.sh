#!/bin/bash
#SBATCH --partition=small
#SBATCH --mem=128g
#SBATCH --account=project_2003986
#SBATCH --cpus-per-task=16
#SBATCH -o ./log/untrackedOut.txt
#SBATCH -e ./log/untrackedErr.txt
#SBATCH --time=24:00:00

{exec_job}
