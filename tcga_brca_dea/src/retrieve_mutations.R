# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### RETRIEVE MUTATION FROM CBIOPORTAL FOR THE ANTI-APOPTOTIC BCL2 MEMBERS ####
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

setwd(getwd())

query_genes <- c('BCL2','BCL2L1', 'BCL2L2','MCL1','BCL2L10', 'BCL2A1')


# Create CGDS object
mycgds = CGDS('http://www.cbioportal.org/')

getCancerStudies(mycgds)

# Study: brca_tcga - Breast Invasive Carcinoma (TCGA, Provisional)
my_study <- getCancerStudies(mycgds)[25,1]
case_list <- getCaseLists(mycgds,my_study)[2,1] # brca_tcga_all
genetic_profile <- getGeneticProfiles(mycgds,my_study)[12,1] # brca_tcga_mutations
mutation_data_brca_tcga <- getMutationData(mycgds, caseList = case_list, geneticProfile = genetic_profile,  genes = query_genes)

# Study: brca_tcga_pub2015 - Breast Invasive Carcinoma (TCGA, Cell 2015)
my_study <- getCancerStudies(mycgds)[23,1]
case_list <- getCaseLists(mycgds,my_study)[2,1] # brca_tcga_pub2015_all
genetic_profile <- getGeneticProfiles(mycgds,my_study)[11,1] # brca_tcga_pub2015_mutations
mutation_data_brca_tcga_pub2015 <- getMutationData(mycgds, caseList = case_list, geneticProfile = genetic_profile,  genes = query_genes)


# Study: brca_sanger - Breast Invasive Carcinoma (Sanger, Nature 2012)
my_study <- getCancerStudies(mycgds)[22,1]
case_list <- getCaseLists(mycgds,my_study)[1,1]
genetic_profile <- getGeneticProfiles(mycgds,my_study)[1,1]
mutation_data_brca_sanger <- getMutationData(mycgds, caseList = case_list, geneticProfile = genetic_profile,  genes = query_genes)


# Study: brca_mbcproject_wagle_2017 - The Metastatic Breast Cancer Project (Provisional, October 2017)

my_study <- getCancerStudies(mycgds)[159,1]
case_list <- getCaseLists(mycgds,my_study)[1,1]
genetic_profile <- getGeneticProfiles(mycgds,my_study)[2,1]
mutation_data_brca_mbcproject_wagle_2017 <- getMutationData(mycgds, caseList = case_list, geneticProfile = genetic_profile,  genes = query_genes)


# Study: brca_igr_2015 - Mutational profiles of metastatic breast cancer (France, 2016)

my_study <- getCancerStudies(mycgds)[102,1]
case_list <- getCaseLists(mycgds,my_study)[1,1]
genetic_profile <- getGeneticProfiles(mycgds,my_study)[2,1]
mutation_data_brca_igr_2015 <- getMutationData(mycgds, caseList = case_list, geneticProfile = genetic_profile,  genes = query_genes)




all_mutations <- rbind(mutation_data_brca_tcga, mutation_data_brca_tcga_pub2015, mutation_data_brca_sanger, mutation_data_brca_mbcproject_wagle_2017, mutation_data_brca_igr_2015)

write.table(all_mutations, file = 'output/mutations.antiapop.txt', sep = '\t', row.names = FALSE)
#write.xlsx(all_mutations, file = paste0('output/known.mutations.',args[1],'.xlsx'))



