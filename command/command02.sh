# command02.sh
# Suppose you are studying HIV-1. 
# You collected protein sequences of 'gag' from different HIV-1 strains.
# To investigate the evolutionary relationship among the sequences, you want to visualize it by constructing a tree.
# To do so, you need MSA of them fisrt.

# 1. gag protein sequences of different HIV-1 strain is stored in hiv1_gag.faa in the data directory.
# Using Clustal Omega, construct MSA and save the ouput as hiv1_gag_msa.faa in result directory. (Result file: hiv1_gag_msa.faa)
# INPUT: 'hiv1_gag.faa'
# OUNPUT: 'hiv1_gag_msa.faa'
# Use only two parameters: -i, -o
clustalo -i data/hiv1_gag.faa -o result/hiv1_gag_msa.faa

# 2. You have a MSA result now, so let's build a tree using it. (Result file:hiv1_gag_tree.nwk)
# INPUT: 'hiv1_gag_msa.faa'
# OUTPUT: 'hiv1_gag_tree.nwk'
# Use the default setting of fasttree. Just give fastree input path and output path.
# Just type 'fasttree', then you can see a simplified manual.
fasttree result/hiv1_gag_msa.faa > result/hiv1_gag_tree.nwk