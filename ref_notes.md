# References for minION data analyses

This is a collection of literature relevent to [minION](http://nanoporetech.com/products/minion) sequencing, with a particular focus on viral genes. 

## Summary 

* __basecalling__: Guppy, Albacore
* __demultiplexing__: Guppy, [Porechop](https://github.com/rrwick/Porechop)
* __read trim__: [Seqtk](https://github.com/lh3/seqtk), Porechop
* __map/align__: [Minimap2](https://github.com/lh3/minimap2), [bwa](http://bio-bwa.sourceforge.net/bwa.shtml) (BWA-MEM), [GraphMap](https://github.com/isovic/graphmap), Blastn, [DIAMOND](https://github.com/bbuchfink/diamond), [Bowtie2](https://github.com/BenLangmead/bowtie2)
* __consensus calling__: [zika-pipeline](https://github.com/zibraproject/zika-pipeline) (margin_cons.py), [bwa](http://bio-bwa.sourceforge.net/bwa.shtml)?
* __de novo assemble__: [Canu](https://github.com/marbl/canu), [Spades](http://cab.spbu.ru/software/spades/), [Shasta](https://github.com/chanzuckerberg/shasta)
* __variant calling__: [Nanopolish](https://github.com/jts/nanopolish)
* __qc__: [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), nanoplot/[nanopack](https://github.com/wdecoster/nanopack), [minion_qc](https://github.com/roblanf/minion_qc), Seqtk, [Qualimap](http://qualimap.bioinfo.cipf.es)
* __polish__: [Nanopolish](https://github.com/jts/nanopolish), [Racon](https://github.com/isovic/racon)
* __general data handling__: [Samtools](https://github.com/samtools/samtools), [BEDtools](https://github.com/arq5x/bedtools2), [Rsamtools](http://bioconductor.org/packages/release/bioc/html/Rsamtools.html), [Bamstats](https://github.com/guigolab/bamstats)
* __others__: [Centrifuge](https://github.com/infphilo/centrifuge) (taxonomic classification), [Kraken](https://ccb.jhu.edu/software/kraken/) (taxonomic)

## Other topics

* Basecalling tools: [Performance of neural network basecalling tools for Oxford Nanopore sequencing](https://github.com/rrwick/Basecalling-comparison) 
* [_How to generate consensus sequences using nanopolish_](http://lab.loman.net/2018/12/21/how-to-generate-consensus-sequences-on-nanopore/) by Nicholas Loman

## Well-established Pipelines 

* ZiBRA Project [[link](https://github.com/zibraproject/zika-pipeline/blob/master/docs/index.md)]
* ARTIC Project [[link](http://artic.network/ebov/ebov-bioinformatics-sop.html)]
* [IRMA](https://wonder.cdc.gov/amd/flu/irma/): assembly, variant calling, and phasing of highly variable RNA viruses (CDC)


### Other reference 

<hr>



1. Badial et al., Plant Disease, 2018 [[link](https://apsjournals.apsnet.org/doi/abs/10.1094/PDIS-04-17-0488-RE)]
    - fasta extraction: [poRe](https://github.com/mw55309/poRe_docs)
2. Boldogkői et al., Sci. Data., 2018 [[link](https://www.nature.com/articles/sdata2018276)]
    - align: GMAP ( r counterpart: gmapR )
12. Ima et al., frontiers in Microb., 2018 [[link](https://www.frontiersin.org/articles/10.3389/fmicb.2018.02748/full)]
    - SNV call: Samtools ( via mpileup )
15. Butt et al., Virology J, 2018 [[link](https://virologyj.biomedcentral.com/articles/10.1186/s12985-018-1077-5)]
9. Filloux et al., Sci. Report, 2018 [[link](https://www.nature.com/articles/s41598-018-36042-7)]
12. Kafetzopoulou et al., Eurosurveillance, 2018 [[link](https://www.eurosurveillance.org/content/10.2807/1560-7917.ES.2018.23.50.1800228)]
1. Depledge et al., nat comm, 2019 [[link](https://www.nature.com/articles/s41467-019-08734-9)]
   - polish: [proovread](https://github.com/BioInf-Wuerzburg/proovread)
2. Peserico et al., sci. rep., 2019 [[link](https://www.nature.com/articles/s41598-018-37497-4)]
   - refine consensus: [Pilon](https://github.com/broadinstitute/pilon/wiki)
4. Tan et al., AMB Expr, 2019 [[link](https://amb-express.springeropen.com/articles/10.1186/s13568-019-0772-y)]
    - adaptor trim: [Poreplex](https://github.com/hyeshik/poreplex)
5. Spatz et al., Avian Patho., 2019 [[link](https://www.tandfonline.com/doi/full/10.1080/03079457.2019.1579298)]
   - all-against-all alignment-based cluster: LAclust
   - consensus building: Ampligner
6. __Kafetzopoulou et al., Science, 2019__ [[link](http://science.sciencemag.org/content/363/6422/74)]
8. __Lin et al., J. Clin. Med., 2019__ [[link](https://www.mdpi.com/2077-0383/8/3/351)]
   - species identification: MIGA + BLAST
   - gene annotation: NCBI PGAAP (Prokaryotic Genomes Automatic Annotation Pipeline)
6. Wongsurawat et al., frontiers in Microb, 2019 [[link](https://www.frontiersin.org/articles/10.3389/fmicb.2019.00260/full#h5)]
11. __Grubaugh et al., Genome Biology, 2019__ [[link](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-018-1618-7)]
14. Naito et al., Arch. of Virology, 2019 [[link](https://link.springer.com/article/10.1007%2Fs00705-019-04254-5)]
16. Warwick-Dugdale et al., PeerJ, 2019 [[link](https://peerj.com/articles/6800/)] 
    - align: [MUmmer](https://github.com/mummer4/mummer/blob/master/MANUAL.md)
17. Krehenwinkel et al., GigaScience, 2019 [[link](https://academic.oup.com/gigascience/article/8/5/giz006/5368330#134713520)]
    - demultiplex: MiniBar
    - qc: [Nanofilt](https://github.com/wdecoster/nanofilt)  
    - error correction(polish): RACON


