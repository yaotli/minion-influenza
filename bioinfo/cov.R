# This is a R script aims to report depth of a alignment 
# require bedtools2
# requiring packages - ggplot, seqinr
# ex, Rscript cov.R ref.fa sample.bam

require( ggplot2 )
require( seqinr )

args = commandArgs( trailingOnly = TRUE )
if (length(args)==0) { stop( "one folder with Blastn results", call. = FALSE) } 

seqfile = read.fasta(file = args[1])
seq.lth = sapply( getSequence( seqfile ), 
                  function(x)
                    {
                      max( which( x != "-" ) )
                    } )
seq.id  = attributes( seqfile )$names 
seq.seg = paste0( seq(1,8), "_", gsub( "^.*_", "", attributes( seqfile )$names ) )

outtb = data.frame( seq.id, start = 0, seq.lth, seq.seg )

write.table( outtb, "cov.bed", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)


st = paste0( "~/bedtools2/bin/bedtools coverage -a cov.bed -b ", args[2], " -bed -d > cov_report" )

system( st )

df = read.table( "./cov_report", stringsAsFactors = FALSE )

lth = 
sapply( as.list(  unique(df$V1) ),
        function(x)
        {
          min( df$V6[ which( df$V1 == x ) ] )
        })

note = data.frame( V4 = seq.seg, lab = paste0( "min = ", lth ), stringsAsFactors = FALSE )

out = 
ggplot( df ) +
  facet_wrap(. ~ V4, ncol = 2, scales = "free") + 
  geom_line( aes( x = V5, y = V6 ), size = 2, col = "#1f77b4" ) + 
  geom_text( data = note, 
             mapping = aes( x     = -Inf, y = -Inf, label = lab,
                            hjust = -1,
                            vjust = -4 ) ) + 
  theme_bw() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1), 
    strip.background = element_rect(fill = "white", color = "white"),
    strip.text = element_text(size = 12, face = "bold")
  ) +
  xlab("") + ylab("Coverage")

ggsave( out, filename = "cov.pdf", width = 5, height = 5, units = "in" )

