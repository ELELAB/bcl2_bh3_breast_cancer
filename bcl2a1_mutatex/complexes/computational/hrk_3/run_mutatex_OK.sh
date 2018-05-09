#!/bin/bash
module load profile/advanced
module load autoload python/2.7.8
module load numpy/1.9.0--gnu--4.8.3
module load biopython/1.65
python2.7 mutatex.py bcl2a1_hrk_3.pdb --binding-interface --mutlist mutation_list.txt --foldx-log --foldx-version suite4 --np 10
