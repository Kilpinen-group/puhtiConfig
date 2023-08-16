args <- commandArgs(trailingOnly = TRUE)
options(stringsAsFactors = FALSE)

require(data.table)

#############
# FUNCTIONS #
#############
fastRead <- function(fileName, sep = '\t',row.names = 1,as.matrix=FALSE,stringsAsFactors=FALSE,...){
	require(data.table)
	dat <- as.data.frame(data.table::fread(fileName,stringsAsFactors=stringsAsFactors, sep = sep,...))
	if(!is.null(row.names)){
	  rownames(dat) <- dat[,row.names]
	  dat <- dat[,-row.names,drop=FALSE]
	}
	if(as.matrix) dat<-as.matrix(dat)
	return(dat)
}

fastWrite <- function(x, fileName = "default.tsv", headRow="Name",row.names=TRUE,col.names=TRUE, dec=".",sep="\t",...) {
	require(data.table)
	if(row.names){
		x=cbind(rownames(x),x)
		colnames(x)[1]<-headRow
	}
	fwrite(x=x,file=fileName,sep="\t", row.names = FALSE, col.names = col.names, quote = FALSE, dec=dec,...)
}


########
# MAIN #
########
# Construit la matrice de comptage des samples (en colonne) pour chaque gène (en ligne)

if (length(args)==0) stop("The fastq path argument is missing .n", call.=FALSE)

fastq_path <- args[1]
files<-list.files(paste0(fastq_path,"/counts"))
samplesName<- substr(files,1,nchar(files)-7)
countsList<-list()
statList<-list()
for(i in 1:length(samplesName)){
	counts<-fastRead(paste0(fastq_path,"/counts/",files[i]),header=FALSE)
	countsList[[samplesName[i]]]<-counts[1:(nrow(counts)-5),,drop=FALSE]
	aligned<-colSums(countsList[[samplesName[i]]])
	stat<-rbind(aligned,counts[(nrow(counts)-4):nrow(counts),,drop=FALSE])
	rownames(stat)<-c("aligned","no_feature","ambiguous","too_low_aQual","not_aligned",
		"alignment_not_unique")
	statList[[samplesName[i]]]<-stat
}
countsTable<-do.call(cbind,countsList)
colnames(countsTable)<-samplesName

statTable<-data.frame(t(do.call(cbind,statList)))
rownames(statTable)<-samplesName
statTable$total_read<-rowSums(statTable)

fastWrite(countsTable,paste0(fastq_path,"/results/rawCountsTable.tsv"))
fastWrite(statTable,paste0(fastq_path,"/results/alignStatTable.tsv"))