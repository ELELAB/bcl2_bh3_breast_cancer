#!/bin/bash
./ddg2matrix -d ../results/mutation_ddgs/final_averages/ -p ../repair/repair_5uul_wo_peptide_model0_checked/5uul_wo_peptide_model0_checked_Repair.pdb -l ../mutation_list.txt -x 5 -s 50 -o bcl2a1_heatmap -i Bcl2a1
./ddg2topmuts_26_10-2016_modified -d ../results/mutation_ddgs/final_averages/ -p ../repair/repair_5uul_wo_peptide_model0_checked/5uul_wo_peptide_model0_checked_Repair.pdb -l ../mutation_list.txt -k 20
./ddg2xlsx -d ../results/mutation_ddgs/final_averages/ -p ../repair/repair_5uul_wo_peptide_model0_checked/5uul_wo_peptide_model0_checked_Repair.pdb -l ../mutation_list.txt 
