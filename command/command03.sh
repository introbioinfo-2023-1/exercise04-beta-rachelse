# command03.sh
# Scenario: As you were preparing for exams, a wish to have a superpower to overcome sleepiness crossed your mind.
# Intrigued, you discovered that BHLHE41 is a gene involved in circadian rhythm.
# Now, you are curious to find out how the gene evolved and if modern society's changes in circadian rhythm have affected its evolution.
# And you come up with an idea.
# "If I can find some homologous genes, I can get more clue about the gene's evolution."
# With this in mind, you begin a homology search using MMseqs2.

# 1. Build a MMseqs2 database using Swiss-Prot reference proteins. (No resulf file)
#    HINT: Read the 'Search' part of MMseqs2 README.
mmseqs databases UniProtKB/Swiss-Prot DB/swissprot tmp

# 2. Perform a homology search. You have the sequence of BHLHE1 in data directory. 
#    Save the result as bhlhe41_homologs.m8 in result directory. (Result file: bhlhe41_homologs.m8)
#    INPUT: 'bhlhe41.faa'
#    OUTPUT: 'bhlhe41_homologs.m8'
#    HINT: Read the README of "https://github.com/soedinglab/mmseqs2"
#    Don't use extra options. Just give input path, database, output path, and tmp path.
mmseqs easy-search data/bhlhe41.faa DB/swissprot result/bhlhe41_homologs.m8 tmp

# 3. See the README
mmseqs easy-search data/bhlhe41.faa DB/swissprot result/bhlhe41_homologs_iter.m8 tmp --num-iterations 3

# 4. See the README
mmseqs easy-search data/bhlhe41.faa DB/swissprot intermediate/bhlhe41_feature.m8 tmp --format-output target,taxid
mmseqs easy-search data/bhlhe41.faa DB/swissprot intermediate/bhlhe41_iter_feature.m8 tmp --num-iterations 3 --format-output target,taxid

data=(bhlhe41_feature.m8 bhlhe41_iter_feature.m8)
for i in "${data[@]}"
do
    awk 'NR==1 {paralog=0;gene=$2;next} NR>1 && $2==gene {paralog+=1} END {print paralog}' ./intermediate/$i >> ./result/paralogs_cnt.txt
done
