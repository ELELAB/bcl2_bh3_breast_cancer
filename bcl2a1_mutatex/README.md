# In silico mutagenesis

Using the in-house Python-based software, MutateX, developed for high-throughput mutagenesis in silico, we evaluated the effects of substituting wild-type residues at the BH3 binding interface of the modelled complexes with the mutant variants found in the cancer patients.

## To reproduce this analysis

### Prerequisites

MutateX and the associated scripts are written in Python, and requires having a working Python 2.x (x >= 7) installation. A number of Python packages needs also to be available. More in details, mutateX requires:
```
BioPython
numpy
matplotlib
``

In addition MutateX works by running the FoldX software. The FoldX binary and the associated rotabase.txt file should be available. FoldX4 is available free of charge to academic affiliates; you will, however, need to register and login to download. See [FOLDX ACADEMIC LICENSE](http://foldxsuite.crg.eu/academic-license-info). The FoldX binary file should be readable and executable by the user who intends to run MutateX, and its location as well as that of the rotabase.txt file should be known.

### Installation

Get the MutateX package from the associated github repository
```
$ git clone https://github.com/ELELAB/mutatex.git 
```

Please refer to the [MutateX manual](https://github.com/ELELAB/mutatex/blob/master/doc/manual.lyx) for installation.

### Running the analysis

For clarification of how MutateX runs, the specified command line options and the outputs please see above mentioned manual.

```
$ cd bcl2a1_mutatex/complexes/computational/hrk_2/
$ chmod +x run_mutatex_OK.sh
$ ./run_mutatex_OK.sh

$ cd figs/
$ run_figs.sh
```

```
$ cd bcl2a1_mutatex/complexes/computational/hrk_3/
$ chmod +x run_mutatex_OK.sh
$ ./run_mutatex_OK.sh

$ cd figs/
$ run_figs.sh
```

```
$ cd bcl2a1_mutatex/complexes/computational/gzmb/
$ chmod +x run_mutatex_OK.sh
$ ./run_mutatex_OK.sh

$ cd figs/
$ run_figs.sh
```

```
$ cd bcl2a1_mutatex/complexes/computational/pcna/
$ chmod +x run_mutatex_OK.sh
$ ./run_mutatex_OK.sh

$ cd figs/
$ run_figs.sh
```

