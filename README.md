# Config files for using CSC Puhti

All files and folder have to be copied in puhti's home (default directory when logging in), except *sshLocal* content which belongs to local home folder (`~/.ssh`)

activate, createEnv, and bash_export have to be modified to point to the right project/folder.

## File Description

📦puhtiConfig

 ┣ 📜20230816_CSCtuto.pptx *slides to introduce Puhti/CSC*  
 ┣ 📂bin  
 ┃ ┣ 📜activate *activate conda env containerized with Tykky, needs to be modified*  
 ┃ ┣ 📜createEnv *activate conda env containerized with Tykky, needs to be modified*  
 ┃ ┣ 📜gzTarSuppr.sh *compress a folder into a .tar.gz, delete the folder*  
 ┃ ┗ 📜mkrdir *create an empty folder for an R project*  
 ┣ 📂envFiles *templates for conda environment files*  
 ┃ ┣ 📜cellProfiler.yml  
 ┃ ┣ 📜crispresso.yml  
 ┃ ┣ 📜leafcutter.yml  
 ┃ ┣ 📜renv.yml  
 ┃ ┗ 📜rnaseq_align.yml  
 ┣ 📂sshLocal  
 ┃ ┗ 📜config *to add to your own config file*  
 ┣ 📜.bashrc *modify your own to source bash_aliases and bash_export*  
 ┣ 📜.bash_aliases *alias for bash command, needs to be modified*  
 ┣ 📜.bash_export *Modify env variable*  
 ┣ 📜launchRscript.sh *send an R script to slurm, needs to be modified*  
 ┣ 📂workflows *example of snakemake workflow*  
 ┃ ┣ 📂rnaseq_align *workflow for aligning rnaseq data*  
 ┃ ┃ ┣ 📂clusterFiles  
 ┃ ┃ ┃ ┣ 📜exeSnakemakePuhti.sh *commands to launch the snakemake workflow*  
 ┃ ┃ ┃ ┗ 📜jobscriptPuhti.sh *file to give to snakemake for launching jobs, need to be modified*  
 ┃ ┃ ┣ 📂log  
 ┃ ┃ ┣ 📂virtualEnvs  
 ┃ ┃ ┃ ┗ 📜rnaseq_align.yml  
 ┃ ┃ ┣ 📜config.json *parameters of the workflow*  
 ┃ ┃ ┣ 📜countsTable.R  
 ┃ ┃ ┣ 📜README.md  
 ┗ ┗ ┗ 📜Snakefile  