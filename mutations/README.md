# Mutations

We retrieved known mutations in the genes [BCL2A1](http://www.uniprot.org/uniprot/Q16548), [BBC3](http://www.uniprot.org/uniprot/Q9BXH1), [HRK](http://www.uniprot.org/uniprot/O00198) and [GZMB](http://www.uniprot.org/uniprot/P10144), encoding respectively Bfl1 (Bcl-2-related protein A1), Puma (Bcl-2-binding component 3), HRK (Activator of apoptosis harakiri) and Grab (Granzyme B). (change names !!)
The mutations were retrieved from [cBioPortal for Cancer Genomics](http://www.cbioportal.org) and [COSMIC, the Catalogue Of Somatic Mutations In Cancer](http://cancer.sanger.ac.uk/cosmic).

To accomplish this in-house scripts were produced, querying the cBioPortal and Cosmic databases. 

## To reproduce this analysis

### Prerequisites

**To run ```retrieve_mutations_cbio.R```:**

```
R version 3.3.1 or higher
Rstudio version 1.1.383 or higher        
Bioconductor version 3.6 or higher
```
Although R-packages should automatically be installed and errors raised if they cannot be, we here provide the user with the list of required packages for manual installation:

CRAN:
```
openxlsx
cgdsr
```

**To run ```retrieve_mutations_cosmic.py```:**

```
Python version 3.0 or higher
```

The Cosmic database(s) need to be downloaded before running the script. The database(s) are available free of charge to academic affiliates; you will, however, need to register and login to download. See [Data Downloads](http://cancer.sanger.ac.uk/cosmic/download).
We retrieved mutations from COSMIC v84 (released 13-FEB-18) downloading the three database files COSMIC Complete Mutation Data, COSMIC Mutation Data (Genome Screens) and COSMIC Mutation Data.

To download the databases:
```
$ sftp "your_email_address"@sftp-cancer.sanger.ac.uk

$ sftp> get /files/grch38/cosmic/v84/CosmicCompleteTargetedScreensMutantExport.tsv.gz
$ sftp> get /files/grch38/cosmic/v84/CosmicGenomeScreensMutantExport.tsv.gz
$ sftp> get /files/grch38/cosmic/v84/CosmicMutantExport.tsv.gz
```


### Running the analysis

The two scripts, retrieving mutations can be downloaded from Github (add).

```
clone github
```


*```retrieve_mutations_cbio.R``` is executed like:*

```
$ cd mutations/
$ chmod +x retrieve_mutations_cbio.R
$ ./retrieve_mutations_cbio.R genes_of_int.txt

```
The cBioportal mutation data were retrieved 9-APRIL-18 from cBioPortal Version 1.12.1-SNAPSHOT

* genes_of_int.txt is a text file emcompassing the genes (one for each line) for which to retrieve mutations.
* The script is coded to retrieve mutation in breast cancer studies. For other tissue studies the code must be manually altered. 

*```retrieve_mutations_cosmic.py``` is executed like:*

```
usage: retrieve_mutations_cosmic.py [-h] [-v]
                                    database tissue gene_file outfile

This program retrieves mutation from the COSMIC database for a specified
tissue and set of genes

positional arguments:
  database       path to cosmic database
  tissue         tissue to query
  gene_file      file with genes to query
  outfile        file(csv) to print results to

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit
```

```
$ cd mutations/
$ chmod +x retrieve_mutations_cosmic.py
$ ./retrieve_mutations_cosmic.py /data/databases/cosmic-v84/ breast genes_of_int.txt mutations_cosmic.csv
```

## Author(s)

Simon Kønig


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## R session info

```
R version 3.4.3 (2017-11-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.5 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.0
LAPACK: /usr/lib/lapack/liblapack.so.3.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB.UTF-8       
 [4] LC_COLLATE=en_GB.UTF-8     LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
 [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
[10] LC_TELEPHONE=C             LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] cgdsr_1.2.10    openxlsx_4.0.17

loaded via a namespace (and not attached):
[1] compiler_3.4.3    tools_3.4.3       Rcpp_0.12.15      R.methodsS3_1.7.1
[5] R.oo_1.21.0 
```
