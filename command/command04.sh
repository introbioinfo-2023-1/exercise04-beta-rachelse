# command04.sh

# Paralogs go through different evolutionary paths, and some of them can lose or gain domains. 
# To investigate what domains the paralogs have, you can search your paralogs against Pfam database which stores protein domain sequences.
# Now, you want to find out what domains the paralogs of BZIP49 have.

# 1. See the README
mmseqs databases Pfam-A.seed DB/pfam tmp

# 2. See the README
mmseqs easy-search data/bzip49.faa DB/swissprot intermediate/bzip49_remote.m8 tmp --num-iterations 3 --format-output target,tseq 
tail -1 intermediate/bzip49_remote.m8 | awk 'BEGIN {OFS="\n"} {id=$1;seq=$2} END {print ">"id,seq}' > intermediate/remote-protein.faa
mmseqs easy-search result/remote-protein.faa DB/pfam result/remote-protein-pfam.m8 tmp

# 3. See the README
mmseqs easy-search data/bzip23.faa DB/pfam result/bzip23-pfam.m8 tmp

# 4. See the README

awk -v common=$(awk 'NR==FNR{same[$2]=$2;next}$2 in same {print $2}' result/bzip23-pfam.m8 result/remote-protein-pfam.m8) \
    'BEGIN {OFS=","} $2!=common {print $2}' result/bzip23-pfam.m8 result/remote-protein-pfam.m8 | sort > result/unique_domain.txt