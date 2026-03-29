function krun
    set filename $argv[1]
    set outname (echo $filename | cut -d '.' -f 1)'.jar'
    kotlinc $filename -include-runtime -d $outname &&  
    java -jar $outname
end
