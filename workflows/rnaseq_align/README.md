# Description
This pipeline aims to provide a simple alignment tool for  RNAseq data (without UMI). The fastq files are aligned on a reference genome with STAR and counted with HTSeq-Count. 

# Prerequisites
- Git
- Conda


# Input
The *fastq.gz* files need to be gathered in a directory. The pathway to this directory will be specified in the config.json. **One fastq** file per sample (or two if data are sequenced in paired end).


# Installation
~~~
git clone https://github.com/DimitriMeistermann/rnaseq_align.git
cd rnaseq_align
conda env create -f virtualEnvs/rnaseq_align.yml
~~~

# Configuration

- **IS_PAIRED_END**: *true* or *false*, is the data in paired end (forward and reverse reads ) ?
- **PRELOAD_GENOME**: *true* or *false* (experimental). STAR can preload the genome in the RAM, so the next job can use it. Currently it does not work on bird2cluster. 
- **STAR_ALIGN_MULTIPLE_FILE**: *true* or *false*, align fastqs by batches, then resulting BAM is split. This is an alternative way to minimize the number of loading of reference genome if PRELOAD_GENOME is not possible.
- **MAX_SIZE_PER_MULTIPLE_ALIGN**: Size of alignment batches (if *STAR_ALIGN_MULTIPLE_FILE=true*). Example for *50* (means 50 gigabytes): if we have 10 samples of 10GB, the alignment will be performed in two batches, from two different STAR_ALIGN jobs. Alignment is also split every 1000 samples, even if *MAX_SIZE_PER_MULTIPLE_ALIGN* has not been reached. 
- **READ_LENGTH**: String. Number of nucleotid in each reads, automatically picked if empty string by opening the first read of the first fastq. **Warning:** if cutadapt was already used on fastqs, you have to enter manually the read length before its use.
- **STAR_GENOME_THREADS**: Number of cores used by genome indexing, preload and align if STAR_ALIGN_MULTIPLE_FILE.
- **THREAD_PER_SAMPLE**: Number of cores used by most of the workflow jobs.
- **FASTA_REFERENCE**: Path of fasta file of the  reference genome
- **GTF_REFERENCE**: Path of the GTF file (feature of the reference genome)
- **FASTQ_PATH**: Directory that contains the input fastqs.
- **OUTPUT_PATH**: Path where the results will be written.
- **PAIR_END_FILE_PATTERN**: characters between sample name and 1 or 2 for paired end data. Example: if forward reads are in *sample_1.fastq.gz* and reverse in *sample_2.fastq.gz*, then *PAIR_END_FILE_PATTERN = "_"*
- **FORWARD_ADAPTATOR**: Forward sequencing adaptator for cutadapt (adaptator trimming). If this argument is set to an empty string, cutadapt will not be used.
- **REVERSE_ADAPTATOR**: Reverse sequencing adaptator for cutadapt. This argument is not used for single end data.
- **GENOME_INDEX_RAM**: RAM allowed to be used by genome indexing.
- **CUTADAPT_MIN_READ_LEN**: Minimum read length after trimming. If the read is to short it will be removed from the fastq.
- **DEDUP_UMI**: *true* or *false*, deduplicate reads based on their UMI. UMI must be stored in read names. The UMI must be at the end of the read name, separated by an underscore, e.g. `@[readname]_[UMI]`. Please see the documentation of *umi_tools extract* to see more details on how to add UMI to read names if the sequencing method uses UMI.
- **FEATURE_TYPE**: Feature of the GTF (second column) were aligned reads are counted (example: Exon, Gene,...).
- **FEATURE_ID**: ID that will be the rows of the count table (gene_name for gene symbols).

# Execution of the pipeline
## Normal launch (with 8 cores), with default config.json
~~~
conda activate rnaseq_align
snakemake -rp -j 8
~~~

## With specific config file
~~~
conda activate rnaseq_align
snakemake -rp -j 8 --configfile configFileSave/[yourConfig.json]
~~~

## On SGE grid engine (example: *bird2cluster*). 
You can find this code in *clusterFiles/exeSnakemakeBird.sh*. You can modify the parameter of jobs by editing *jobscriptBird.sh*.
~~~
conda activate rnaseq_align
snakemake -rp -j 20 --cluster 'qsub'  --jobscript clusterFiles/jobscriptBird.sh --latency-wait 10 --max-jobs-per-second 1 --configfile configFileSave/configTest.json
~~~

Test files can be found at https://gitlab.univ-nantes.fr/E114424Z/rnaseq_align/-/tree/master/testFolder/fastq

# Output data
- **log**: log files from executed jobs, in the form of *RULE_NAME[_sampleName].(err|out)*. Additional logs are maybe saved depending the tool that was used.
- **FASTQ_CUTADAPT**: optional, if cutadapt is used, trimmed fastqs are stored in this folder.
- **fastQC**: Zip and HTML results from the execution of FASTQC.
- **BAM**: this directory contains the results of alignment in the form of BAM files.
- **DEDUP_BAM**: if applicable, this directory contains the BAM deduplicated (based on their UMI)
- **counts**: this directory contains the resulting counts files obtained from htseqcount.
- **results**: this directory contains the raw counts table, a table of alignment stats, and the multiqc reports that present different quality scores from the data.