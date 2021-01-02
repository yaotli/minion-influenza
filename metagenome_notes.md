## Metagenomic pipline 

#### Metagenomic Nanopore Sequencing of Influenza Virus Direct from Clinical Respiratory Samples

1. taxonomically classification - Centrifuge
2. mapping - minimap2
3. search - BLAST 
4. count mapped reads - SAMtool 
5. polish

#### Assessment of Metagenomic Sequencing and qPCR for Detection of Influenza D Virus in Bovine Respiratory Tract Samples

1. mapping to host (BioProject) - minimap2
2. unmap were subject to de novo assemble: Trinity (https://github.com/trinityrnaseq/trinityrnaseq/wiki)
3. contigs map to virus reference sequence - BLASTn (with RefSeq; mim alig. length 100bp and e value <10e-3)
4. check - BLASTx (Genbank nonredunt protein sequence)
5. count viral reads 
6. WIMP (used centrifuge)

#### Assembly methods for nanopore‐based metagenomic sequencing: a comparative study assemble tool

* best assembler - Flye/metaFlye (https://github.com/fenderglass/Flye)
* viral contig verification tool (https://github.com/ablab/viralVerify)
* assembler - raven (https://github.com/lbcb-sci/raven)

#### Zika Virus Amplification Using Strand Displacement Isothermal Method and Sequencing Using Nanopore Technology

1. download zika complete genome 
2. delete reads < xxx bp, and > xxxx bp
3. remove duplicated reads
4. BLAST

#### Metagenomic sequencing at the epicenter of the Nigeria 2018 Lassa fever outbreak

1. trim reads
2. map to human (bwa mem)
3. extract unmapped (SAMtool)
4. do novo (canu)
5. search (BLAST)
6. map, variant calling, consensus, pileup...


#### Strain-level identification of bacterial tomato pathogens directly from metagenomic

1. taxonomic classification - WIMP, Sourmash (https://sourmash.readthedocs.io/en/latest/), MetaMaps (https://github.com/DiltheyLab/MetaMaps)
2. mapped against each other to find overlaps - minimap2 (-x & ava-ont) 
3. de novo - miniasm (https://github.com/lh3/miniasm)
4. assembly correction - racon (https://github.com/isovic/racon)
5. against custom database - BLASTn (e-value < 10e-2)
6. genome alignment (to published genome) - MUMmer

#### Simultaneous detection and comprehensive analysis of HPV and microbiome status of a cervical liquid-based cytology sample using Nanopore MinION sequencing

1. align to HPV - LAST
2. filter non-HPV reads by length 
3. taxonomies annotation - QIIME [a microbiome tool] with database Greengenes

#### Freshwater monitoring by nanopore sequencing

1. qc - nanostat (https://github.com/wdecoster/nanostat), pistis (https://github.com/mbhall88/pistis)
2. classification method - minimap2 (best in this study), megaBLAST, BLASTn, kraken2, Centrifuge

#### Performance of Metagenomic Next-Generation Sequencing for the Diagnosis of Viral Meningoencephalitis in a Resource-Limited Setting

* Taxonomer (https://www.taxonomer.com)
* (MiSeq) filter out duplicated reads, reads belonging to human and bacterial genomes, 
* trim adaptors and low-quality reads
* de novo assemble
* BLAST search with a customized viral proteome database
* align against a nonredundant nonvirus protein database to remove any false-positive reads - DIAMOND (https://github.com/bbuchfink/diamond)
* manually check by BLASTx
* reference-based mapping

#### Metagenomic sequencing with spiked primer enrichment for viral diagnostics and genomic surveillance

1. trim adapters and low-complexity sequences 
2. partition the first 450 nucleotides of the preprocessed nanopore read into three 150-nucleotide segments
3. viral reads identification - Bowtie 2 (http://bowtie-bio.sourceforge.net/bowtie2/index.shtml), with a min alignment score cut-off (100)
4. filter and taxonomic classification
5. trim 13-nt spiked primers and PCR duplicates
6. map to the most closely matched reference - GraphMap (https://github.com/isovic/graphmap)

#### Nanopore metagenomic sequencing to investigate nosocomial transmission of human metapneumovirus from a unique genetic group among haematology patients in the United Kingdom

1. remove human reads - CRuMPIT workflow (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6161345/)  
	1.1. QC - PRINSEQ (http://prinseq.sourceforge.net)  
	1.2. Centrifuge (https://ccb.jhu.edu/software/centrifuge/manual.shtml)  
	1.3. map sequences with a taxonomic id - minimap 
2. taxonomic classification - centrifuge 
3. map to generate a draft consensus sequence - minimap2 
4. BLAST to identify the closest strain
5. remap, polish...

#### Limited SARS-CoV-2 diversity within hosts and following passage in cell culture

1. deplete host sequences - map against host genome and transcript by ??, save unmapped reads
2. trim by 30 bp & qc
3. map to SARS-CoV2 sequence 
4. identify minor variant > 10% - bbtool (https://jgi.doe.gov/data-and-tools/bbtools/)

#### Cartography of opportunistic pathogens and antibiotic resistance genes in a tertiary hospital environment

1. taxonomic classification - Kraken; against miniKraken database
2. assembly - canu
3. hybrid assembly - OPERA-MS (https://github.com/CSB5/OPERA-MS)
4. map assembled contigs - BLAST
5. polish canu assemblies (Illumina) - Pilon

### Detection of atypical porcine pestivirus genome in newborn piglets affected by congenital tremor and high preweaning mortality1

1. classification - centrifuge (centrifuge-build, centrifuge-class)
2. analysis the metagenomic results - Pavian (https://ccb.jhu.edu/software/pavian/)