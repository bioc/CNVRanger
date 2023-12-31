% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pheno_assoc.R
\name{generateGDS}
\alias{generateGDS}
\title{Produce CNV-GDS for the phenotyped samples}
\usage{
generateGDS(
  phen.info,
  freq.cn = 0.01,
  snp.matrix = FALSE,
  lo.phe = 1,
  chr.code.name = NULL,
  genotype.nodes = c("CNVGenotype", "CNVgenotypeSNPlike"),
  coding.translate = NULL,
  n.cor = 1
)
}
\arguments{
\item{phen.info}{Returned by \code{setupCnvGWAS}}

\item{freq.cn}{Minimum frequency. Default is 0.01 (i.e. 1\%)}

\item{snp.matrix}{Only FALSE implemented. If TRUE, B allele frequencies (BAF) 
and SNP genotypes would be used to reconstruct CNV-SNP genotypes - under development}

\item{lo.phe}{The phenotype to be analyzed in the PhenInfo$phenotypesSam dataframe}

\item{chr.code.name}{A data-frame with the integer name in the first column 
and the original name in the second for each chromosome previously converted to numeric}

\item{genotype.nodes}{Nodes with CNV genotypes to be produced in the gds file. 
Use 'CNVGenotype' for dosage-like genotypes (i.e. from 0 to Inf). 
Use 'CNVgenotypeSNPlike' alongside for SNP-like CNV genotype in a separated 
node (i.e.  '0, 1, 2, 3, 4' as '0/0, 0/1, 1/1, 1/2, 2/2').}

\item{coding.translate}{For 'CNVgenotypeSNPlike'. If NULL or unrecognized 
string use only biallelic CNVs. If 'all' code multiallelic CNVs as 0 for loss; 
1 for 2n and 2 for gain.}

\item{n.cor}{Number of cores}
}
\value{
probes.cnv.gr Object with information about all probes to be used in 
the downstream CNV-GWAS. Only numeric chromosomes
}
\description{
Function to produce the GDS file in a probe-wise fashion for CNV genotypes. 
The GDS file which is produced also incorporates one phenotype to be analyzed. 
If several phenotypes are enclosed in the \sQuote{phen.info} object, the user 
may specify the phenotype to be analyzed with the \sQuote{lo.phe} parameter. 
Only diploid chromosomes should be included.
}
\examples{

# Load phenotype-CNV information
data.dir <- system.file("extdata", package="CNVRanger")

phen.loc <- file.path(data.dir, "Pheno.txt")
cnv.out.loc <- file.path(data.dir, "CNVOut.txt")
map.loc <- file.path(data.dir, "MapPenn.txt")

phen.info <- setupCnvGWAS('Example', phen.loc, cnv.out.loc, map.loc)

# Construct the data-frame with integer and original chromosome names 
 
# Define chr correspondence to numeric, if necessary
df <- '16 1A
25 4A
29 25LG1
30 25LG2
31 LGE22'

chr.code.name <- read.table(text=df, header=FALSE)
probes.cnv.gr <- generateGDS(phen.info, chr.code.name=chr.code.name)

}
\author{
Vinicius Henrique da Silva
}
