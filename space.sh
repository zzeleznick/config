#!/bin/bash
#
function show_space {
    output=$(diskutil info / | grep -i -B 1 free | awk 'FNR == 1 {print "Total: "$3" GB"} FNR == 2 {print "Free: "$4" GB"}'); echo "$output"
}
 if [ "$#" -eq  "0" ]
    then
        show_space
 else
    cd $1 && bash -c '{ tree -hF ; du -csh ./* ;}'
 fi

