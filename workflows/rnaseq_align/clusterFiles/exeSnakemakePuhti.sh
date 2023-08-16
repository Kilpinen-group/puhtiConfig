source activate rnaseq_align
module load snakemake

snakemake -rp -j 30 --latency-wait 10 --max-jobs-per-second 1 --cluster 'sbatch' --jobscript clusterFiles/jobscriptPuhti.sh --configfile /.../config.json
