# this R script aims to generate polished consensus seqs
# based on .vcf from nanopolish 
# requiring package - seqinr, ggplot2
# ex, Rscript con.R folder_with_vcf_output ref.fa raw_con.fa

require(seqinr)
require(ggplot2)
require(dplyr)

threshold_qual       = 200
threshold_supFrac    = 0.6
threshold_totalreads = 25


args = commandArgs( trailingOnly = TRUE )

if ( length(args)==0) { stop( "one folder with Blastn results", call. = FALSE) } 

vcffiles = list.files( args[1], full.names = TRUE )

snps =  do.call( rbind, lapply( as.list( vcffiles ), function(x) tryCatch( read.table( file = x, stringsAsFactors = FALSE ),
                                                                           error = function(x) NULL ) ) )
if( !is.null(snps) )
{
  snps = cbind( snps, 
                do.call( rbind, 
                         lapply( strsplit( snps$V8, ";" ), 
                                 function(x)
                                 {
                                   n = as.numeric( gsub( "(.)*=", "", x ) )
                                   return(n)
                                 }) 
                ) 
  )
  
  colnames(snps) = paste0( "v", seq(1, ncol(snps) ) )
  
  snps_polish = 
    snps %>% 
    filter( v6  >= threshold_qual ) %>%
    filter( v11 >= threshold_totalreads ) %>%
    filter( v15 >= threshold_supFrac ) %>%
    select( v1, v2, v5  )
}else( stop( "no detectable snps after polish" ) )


ref.seqfile = read.fasta( file = args[2] )
raw.seqfile = read.fasta( file = args[3] )

ref.seq.id  = attributes( ref.seqfile )$names 
raw.seq.id  = attributes( ref.seqfile )$names 
ref.seq     = getSequence( ref.seqfile )
raw.seq     = getSequence( raw.seqfile )

ref.seq.lth = sapply( getSequence( ref.seqfile ), length )

snps_pile = 
do.call( rbind, 
          lapply( as.list( ref.seq.id ), 
                  function( x )
                  {
                    
                    l.ref = which(  ref.seq.id == x ) 
                    l.raw = which(  raw.seq.id == x ) 
                    
                    ref.seq.i = ref.seq[[ l.ref ]]
                    raw.seq.i = raw.seq[[ l.raw ]]
                    
                    if( length(ref.seq.i) != length(raw.seq.i) ){ stop( "raw seq length is differnet from ref" ) }
                    
                    snp.p = c()
                    for( p in 1: length(ref.seq.i) )
                    {
                      if( ref.seq.i[p] !=  raw.seq.i[p] ){ snp.p = c( snp.p, p ) }
                    }
                    if( is.null(snp.p) ){ return( NULL ) }else{ df = data.frame( v1 = x, v2 = snp.p, stringsAsFactors = FALSE )  }
                    
                  }) )

if( is.null(snps_pile) ){ stop( "no detectable snps in pileup" ) }

df_fig_line = data.frame( h   = rep( seq(1, length(ref.seq.id) ), 2 ), 
                          lth = c( rep(1, length(ref.seq.id) ),  ref.seq.lth ), 
                          seg = rep( ref.seq.id, 2 ) )

snps_polish$v4 = match( snps_polish$v1, ref.seq.id )
snps_pile$v4   = match( snps_pile$v1, ref.seq.id )


outfig = 
ggplot() + 
  geom_line( data  = df_fig_line, aes( x = lth, y = h, group = seg), size = 1 ) + 
  geom_point( data = snps_pile, aes( x = v2, y = v4-0.2 ), color = "#1f77b4", shape = "I", size = 5 ) +
  geom_point( data = snps_polish, aes( x = v2, y = v4+0.2 ), color = "#d62728", shape = "I", size = 5 ) +
  theme_bw() +
  theme( panel.grid.minor = element_blank(),
         panel.grid.major.y = element_blank() ) +
  scale_y_continuous( breaks = seq(1, length(ref.seq.id)), label = ref.seq.id ) +
  annotate( geom = "text", x = 2000, y = 8, label = paste0( "SNV: ", nrow(snps_polish), " in ", sum(ref.seq.lth) ) ) +
  ylab("") + xlab("") 

ggsave( outfig, filename = "variant.pdf", width = 5, height = 5, units = "in" )


# generate seq

new.seq = 
lapply( as.list(ref.seq.id), 
        function(x)
        {
          s0   = ref.seq[[ which( ref.seq.id == x ) ]]
          gene = which( snps_polish$v1 == x )
          
          pos = snps_polish$v2[ gene ]
          alt = snps_polish$v5[ gene ]
          
          s0[ pos ] = tolower( alt )
          return(s0)
        })

write.fasta( sequences = new.seq, 
             names     = ref.seq.id,  
             file.out  = "./polished.fasta")

