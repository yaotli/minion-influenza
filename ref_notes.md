



1. zibra project (https://github.com/zibraproject/zika-pipeline/blob/master/docs/index.md)  
   - basecalling: Albacore  
   - demultiplex: Porechop (https://github.com/rrwick/Porechop)  
   - consensus calling: bwa (http://bio-bwa.sourceforge.net/bwa.shtml)  
   - primer trim: Nanopolish (https://github.com/jts/nanopolish)  
2. Lin et al., J. Clin. Med., 2019 (https://www.mdpi.com/2077-0383/8/3/351  
   - assemble: Canu (https://github.com/marbl/canu)  
   - polish: Racon (https://github.com/isovic/racon) + Nanopolish + Circlator  
   - species identification: MIGA + BLAST  
   - gene annotation: NCBI PGAAP (Prokaryotic Genomes Automatic Annotation Pipeline)  
   - align: Minimap2 (https://github.com/lh3/minimap2)  

3. Wongsurawat et al., frontiers in Microb, 2019 (https://www.frontiersin.org/articles/10.3389/fmicb.2019.00260/full#h5)  
   - basecall: Albacore ( & filter out short reads )  
   - map: Minimap2  
   - number of mapped reads: Samtools (https://github.com/samtools/samtools)  
   - read coverage: genomecov in BEDtools (https://github.com/arq5x/bedtools2)   
   - reference-based assembly: Racon  

4. Depledge et al., nat comm, 2019 (https://www.nature.com/articles/s41467-019-08734-9)  
   - basecall: Albacore  
   - polish (error correction): proovread (https://github.com/BioInf-Wuerzburg/proovread)  
   - map: MiniMap2  
   - SAM to BAM: SAMtools  
   - parse BAM: BEDtools  

5. Peserico et al., sci. rep., 2019 (https://www.nature.com/articles/s41598-018-37497-4)  
   - basecall: Albacore  
   - demultiplex, trim: Porechop  
   - map: Blastn  
   - consensus calling: GraphMap (https://github.com/isovic/graphmap)  
   - refine consensus: Pilon (https://github.com/broadinstitute/pilon/wiki)  
   - qc: nanoplot (new: https://github.com/wdecoster/nanopack)  

6. Spatz et al., Avian Patho., 2019 (https://www.tandfonline.com/doi/full/10.1080/03079457.2019.1579298)  
   - basecall: Albacore  
   - qc: MinIONQC  
   - demiltiplex, trim adaptor: Porechop  
   - all-against-all alignment-based cluster: LAclust  
   - consensus building: Ampligner  
   - map: BWA-MEM  
   - polish: Nanopolish  

7. Badial et al.,  Plant Disease, 2018 (https://apsjournals.apsnet.org/doi/abs/10.1094/PDIS-04-17-0488-RE)  
   - basecall: Metrichor  
   - 'fasta' extraction: poRe (https://github.com/mw55309/poRe_docs)  
   - align: GraphMap  
   - BAM to SAM: SAMtools  
   - analysis BAM: Rsamtools (http://bioconductor.org/packages/release/bioc/html/Rsamtools.html), Bamstats (https://github.com/guigolab/bamstats), BEDtools  

8. Grubaugh et al., Genome Biology, 2019 (https://genomebiology.biomedcentral.com/articles/10.1186/s13059-018-1618-7)  
   - basecall: Albacore  
   - demultiplex: Porechop  
   - align: BWA-MEM  
   - others: https://github.com/nickloman/zika-isnv  

9. Kafetzopoulou et al., Eurosurveillance, 2018 (https://www.eurosurveillance.org/content/10.2807/1560-7917.ES.2018.23.50.1800228)  
   - basecall: Metrichor + Metrichor, Albacore  
   - align: BWA-MEM (-x ont2d)  
   - % reads mapped, coverage depth: Samtools, Bedtools  
   - map: Samtools? (pileup)  
   - polish: Nanopolish  
   - taxonomic: Kraken (https://ccb.jhu.edu/software/kraken/)  
   - de novo assemble: Spades (http://cab.spbu.ru/software/spades/) + Canu  
  
10. Boldogkői et al., Sci. Data., 2018 (https://www.nature.com/articles/sdata2018276)  
   - basecall: Albacore  
   - align: GMAP ( r counterpart: gmapR )  
   - demultiplex: Porechop  

11. Filloux et al., Sci. Report, 2018 (https://www.nature.com/articles/s41598-018-36042-7)  
   - basecall: Metrichor  
   - map to GenBank: DIAMOND (https://github.com/bbuchfink/diamond)  
   - de novo assemble: Canu  
   - map: Bowtie2 (https://github.com/BenLangmead/bowtie2)  
   - make 'mpileup' file: samtools ( further parse by R/Python )  
 
12. Ima et al., frontiers in Microb., 2018 (https://www.frontiersin.org/articles/10.3389/fmicb.2018.02748/full)  
   - basecall: Albacore  
   - qc: SeqKit (https://github.com/shenwei356/seqkit)( remove < 500 or > 3000 )
   - demultiplex: Porechop  
   - map: Minimap2  
   - SNV call: Samtools + BCFtools ( via mpileup )  
   - map data analysis: IGV, Samtools, Qualimap (http://qualimap.bioinfo.cipf.es)  

13. Tan et al., AMB Expr, 2019 (https://amb-express.springeropen.com/articles/10.1186/s13568-019-0772-y)  
   - basecall, trim: Poreplex (https://github.com/hyeshik/poreplex)  
   - plot, matrix: NanoPlot (https://github.com/wdecoster/NanoPlot)  
   - map: Graphmap  
   - qc for aligned file: Qualimap  

14. Naito et al., Arch. of Virology, 2019 (https://link.springer.com/article/10.1007%2Fs00705-019-04254-5)  
   - basecall: Metrichor  
   - assemble: Canu  
   - polish: Nanopolish  
   - contig to RefSeq: Blastx in Geneious  

15. Butt et al., Virology J, 2018 (https://virologyj.biomedcentral.com/articles/10.1186/s12985-018-1077-5)  
   - basecall: Albacore  
   - qc: NanoporeQC ( in Galaxy )  
   - demultiplex: Porechop  
   - in-house cluster method: LAclust  
   - consensus: Amplicon aligner  
   - 2nd map: BWA-MEM  
   - refine consensus: Nanopolish  


