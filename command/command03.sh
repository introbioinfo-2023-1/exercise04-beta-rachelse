# command03.sh
# Scenario: You are studying plant physiology using foward genetics. 
# You have isolated a mutant with increased crossover rate, and you found that the causal muatation occured on BZIP49 gene. 
# But the gene is poorly annotated, providing no meaningful information. 
# And you come up with an idea. 
# "If I can find some homologous genes, I can get more clue about my gene based on the annotations of the homologs." 
# So you started a homology search using MMseqs2

# 1. Build a MMseqs2 database using Swiss-Prot reference proteins. (No resulf file)
#    HINT: Read the 'Search' part of MMseqs2 README.
mmseqs databases UniProtKB/Swiss-Prot DB/swissprot tmp

# 2. Perform a homology search. You have the sequence of BZIP49 in data directory. 
#    Save the result as bzip49_homologs.m8 in result directory. (Result file: bzip49_homologs.m8)
#    INPUT: 'bzip49.faa'
#    OUTPUT: 'bzip49_homologs.m8'
#    HINT: Read the README of "https://github.com/soedinglab/mmseqs2"
#    Don't use extra options. Just give input path, database, output path, and tmp path.
mmseqs easy-search data/bzip49.faa DB/swissprot result/bzip49_homologs.m8 tmp

# 3. See the README
mmseqs easy-search data/bzip49.faa DB/swissprot result/bzip49_homologs_iter.m8 tmp --num-iterations 3

# 4. See the README
mmseqs easy-search data/bzip49.faa DB/swissprot intermediate/bzip49_feature.m8 tmp --format-output target,taxid
mmseqs easy-search data/bzip49.faa DB/swissprot intermediate/bzip49_iter_feature.m8 tmp --num-iterations 3 --format-output target,taxid

data=(bzip49_feature.m8 bzip49_iter_feature.m8)
for i in "${data[@]}"
do
    awk 'NR==1 {paralog=0;gene=$2;next} NR>1 && $2==gene {paralog+=1} END {print paralog}' ./intermediate/$i >> ./result/paralogs_cnt.txt
done
