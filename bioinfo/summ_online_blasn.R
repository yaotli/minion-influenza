# This is a R script depending on package: rjson, stringr
# Run the script in command line: 
# Rscript blasn.R folder_with_json_files
# folder_with_json_files derive from NCBI online Blastn -- download multiple json file

require(rjson)
require(stringr)

args = commandArgs( trailingOnly = TRUE )

if (length(args)==0) { stop( "one folder with Blastn results", call. = FALSE) } 

out = 
sapply( as.list( list.files( args[1], full.names = TRUE)[- 1 ] ), 
        function(x)
        {
          j.i = fromJSON( file = x )
          
          if ( is.null(j.i$BlastOutput2$report$results$search$message) )
          {
            h1  = j.i$BlastOutput2$report$results$search$hits[[1]][2]$description[[1]]$title
            h1 = gsub(" ", "_", h1)
            
            no  = str_match( x, "([0-9]+).json$")[,2]
            st  = paste( no, h1, sep = " | " )
          }else
          {
            no  = str_match( x, "([0-9]+).json$")[,2]
            st  = paste( no )
          }
          
          return(st)
        })

out.sort = out[ sort( as.numeric( str_match( out, "^[0-9]+" ) ), index.return = TRUE )$ix ]

print(out.sort)


write.table( out.sort, 
             file      = paste0( strsplit( args, "\\/" )[[1]][ length(strsplit( args, "\\/" )[[1]]) ], ".txt" ), 
             row.names = FALSE, col.names = FALSE, quote = FALSE )
