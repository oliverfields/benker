#!/bin/bash

i=0

while read b; do
  let "i+=1"
  lat=${b%,*}
  long=${b#*,}

  file_path="content/benker/$i.html"

  if [ -e "$file_path" ]; then
    echo $file_path exists, skipping
    continue
  fi

  echo "Template: benk.mako
Latitude: $lat
Longitude: $long
Title: Benk #$i
Hero caption:
Hero img alt text:

" > "$file_path"

done < benker_koordinater
