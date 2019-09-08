# Rscript blasn.R folder_with_txt_output
# .txt generated from magic-blast script

args = commandArgs( trailingOnly = TRUE )

min_hit = 5
min_lth = 50
n_show  = 5

if (length(args)==0) { stop( "one folder with Blastn results", call. = FALSE) } 

txtfiles = list.files( args[1], full.names = TRUE, pattern = ".txt" )

for( f in 1: length(txtfiles) )
{
  readin = read.table( txtfiles[f], stringsAsFactors = FALSE )
  
  p.read.mapped = paste0( "# % pos. reads: ", length( unique( readin$V1[ which( readin$V2 != "-" ) ] ) ), "/", length( unique( readin$V1 ) ) )
  
  t2 = readin[ -which( readin$V2 == "-" ),  ]
  t2[ ,ncol(t2)+1 ] = abs( t2$V10 - t2$V9 )
  
  df = as.data.frame( table( t2$V2 ), stringsAsFactors = FALSE)

  lth = sapply( as.list(t2$V2), 
                function(x)
                {
                  return( median( t2$V26[ which( t2$V2 == x ) ] ) )
                })
  
  df.l = data.frame( ref = t2$V2[ !duplicated( t2$V2 ) ], lth = lth[ !duplicated( t2$V2 ) ], stringsAsFactors = FALSE )

  #1 order by length
  df.f = df.l[ match( df$Var1[ which( df$Freq >= min_hit ) ], df.l$ref ), ]
  df.f = df.f[ order( df.f$lth, decreasing = TRUE ), ]
  
  out = df.f$ref[ c(1:n_show) ]
  out = out[ !is.na(out) ]
  
  #2 order by hit count
  df.g = df[ match( df.l$ref[ which( df.l$lth >= min_lth ) ], df$Var1 ), ]
  df.g = df.g[ order( df.g$Freq, decreasing = TRUE ), ]
  
  out2 = df.g$Var1[ c(1:n_show) ]
  out2 = out2[ !is.na(out2) ]
  
  if( length( c(out, out2) ) == 0 ){ next() }
  
  system( paste0( "echo '", p.read.mapped, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) ) )
  system( paste0( "echo '", "# ", "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) ) )
  sp = paste0( "echo '", "# ", "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  
  if( length(out) != 0 )
  {
  # 1 
  n.hit.occur = paste0( "# no. of occur. of each hit: ", paste( df$Freq[ match( out, df$Var1 ) ], collapse = "; ") )
  lth.align   = paste0( "# median lth. of each hit: ", paste( df.f$lth[ match( out, df.f$ref ) ], collapse = "; ") )
  
  title1 =  paste0( "echo '", "# --1-- Order by hit lengths, threshold: ", min_hit, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  
  st1  = paste0( "grep '>' ~/ncbi-blast-2.9.0/db/influenza.fna | sed '", out, "!d' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  n1a = paste0( "echo '", n.hit.occur, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  n1b = paste0( "echo '", lth.align, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  
  fin1 = c( title1, sp, st1, sp, n1a, n1b, sp, sp )
  for( s in 1: length(fin1) )
  {
    system( fin1[s] )
  }
  }
  
  if( length(out2) != 0 )
  {
  # 2 
  n.hit.occur2 = paste0( "# no. of occur. of each hit: ", paste( df$Freq[ match( out2, df$Var1 ) ], collapse = "; ") )
  lth.align2   = paste0( "# median lth. of each hit: ", paste( df.l$lth[ match( out2, df.l$ref ) ], collapse = "; ") )
  
  title2 =  paste0( "echo '", "# --2-- Order by occur. of hit, threshold: ", min_lth, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  
  st2 = paste0( "grep '>' ~/ncbi-blast-2.9.0/db/influenza.fna | sed '", out2, "!d' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  n2a = paste0( "echo '", n.hit.occur2, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  n2b = paste0( "echo '", lth.align2, "' >> ", gsub( ".txt", "_summ.txt", txtfiles[f] ) )
  
  fin2 = c( title2, sp, st2, sp, n2a, n2b )
  for( s in 1: length(fin2) )
  {
    system( fin2[s] )
  }
  }
  
}
  
