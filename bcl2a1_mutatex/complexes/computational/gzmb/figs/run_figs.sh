#!/bin/bash
./ddg2matrix -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_gzmb_model0_checked/bcl2a1_gzmb_model0_checked_Repair.pdb  -l ../mutation_list.txt -x 5 -s 50 -o gzmb_heatmap
./ddg2pdb -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_gzmb_model0_checked/bcl2a1_gzmb_model0_checked_Repair.pdb  -l ../mutation_list.txt -a 1.6 -b 99999.0 -t between -o gzmb_bfactor.pdb -m gzmb_bfactor.mat
./ddg2distribution -d ../results/interface_ddgs/final_averages/A-B/ -p ../repair/repair_bcl2a1_gzmb_model0_checked/bcl2a1_gzmb_model0_checked_Repair.pdb  -l ../mutation_list.txt -s 50 -o gzmb_stemplot -T stem
