# Rscript blasn.R folder_with_csv_output
# .csv generated from blastn script

require( stringr )

args = commandArgs( trailingOnly = TRUE )

if (length(args)==0) { stop( "one folder with Blastn results", call. = FALSE) } 


csvfiles = list.files( args[1], full.names = TRUE, pattern = ".csv" )

for( i in 1: length( csvfiles ) )
{
  
  csv = tryCatch( read.csv( csvfiles[i], header = FALSE, stringsAsFactors = FALSE ),
                  error = function(x) NULL )
  
  if( is.null(csv) ){ next }
  
  if( length( grep( "tig", csv$V1, ignore.case = TRUE, invert = TRUE )) >0 )
  {
    csv = csv[ -grep( "tig", csv$V1, ignore.case = TRUE, invert = TRUE ), ]
  }
  
  out = c()
  for( j in  1: length( unique(csv$V1) ) )
  {
    lth = csv$V2[ which( csv$V1 == unique(csv$V1)[j] ) ][1]
    
    des = unique( csv$V3[ which( csv$V1 == unique(csv$V1)[j] ) ] )
    s1  = str_match( des, "\\w+\\|\\w+\\|\\w+\\|\\w+\\|(.+)" )[,2]
    s2  = gsub( "Influenza A virus ", "", s1 )[1]
    id  = gsub("^\\(|\\)$", "", str_split( s2, "\\)\\)",n = 2)[[1]][1] )
    seg = str_extract( str_split( s2, " ",n = 2)[[1]][2], "PB2|PB1|PA|HA|NP|NA|M1|M2|NS|NEP")
    
    seg.1 = str_extract( s1[2], "PB2|PB1|PA|HA|NP|NA|M1|M2|NS|NEP")
    seg.2 = str_extract( s1[3], "PB2|PB1|PA|HA|NP|NA|M1|M2|NS|NEP")
    seg.3 = str_extract( s1[4], "PB2|PB1|PA|HA|NP|NA|M1|M2|NS|NEP")
    
    if( is.na(seg) )
      { 
        v     =  c(seg.1, seg.2, seg.3) 
        uniqv = unique(v)
        
        if( length(uniqv) == 1 & is.na(uniqv[1]) )
        {
          seg = "Unknown"
        }else
        {
          seg0  = uniqv[ which( !is.na(uniqv) ) ]
          seg   = seg0[1]    
        }
      }
    
    out = c( out, paste(j, lth, seg, id, sep = " | ") )
  }
  
  write.table( out, 
               file      = gsub( ".csv", ".txt", csvfiles[i] ), 
               row.names = FALSE, col.names = FALSE, quote = FALSE )
}

