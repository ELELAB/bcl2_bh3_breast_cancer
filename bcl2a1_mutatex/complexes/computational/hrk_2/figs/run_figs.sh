#!/bin/bash
./ddg2matrix -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_hrk_2_model0_checked/bcl2a1_hrk_2_model0_checked_Repair.pdb  -l ../mutation_list.txt -x 5 -s 35 -o hrk2_heatmap
./ddg2distribution -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_hrk_2_model0_checked/bcl2a1_hrk_2_model0_checked_Repair.pdb  -l ../mutation_list.txt -s 50 -o hrk2_stemplot
./ddg2pdb -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_hrk_2_model0_checked/bcl2a1_hrk_2_model0_checked_Repair.pdb  -l ../mutation_list.txt -a 1.6 -b 99999.0 -t between -o hrk2_bfactor.pdb -m hrk2_bfactor.mat
