#!/bin/bash

# Create html page containing qr codes that contain vcards(contacts) for scanning by mobile phone

error() {
  tput setaf 1
  echo -n "Error: "
  tput sgr0
  echo $*
  exit 1
}


warning() {
  tput setaf 3
  echo -n "Warning: "
  tput sgr0
  echo $*
}


# Check dependencies are met
for cmd in qrencode base64; do
  command -v $cmd > /dev/null 2>&1 || error "Required command $cmd not found"
done

today="$(date +%Y-%m-%d)"
html="qrs.html"

echo -e "<h1 style=\"padding: 1em 0; margin-bottom: 2em; border-bottom: solid 3px #ccc;\">Lions QR codes for benches</h1>\n" > "$html"

for n in {1..100}; do
  url="https://krakeroylions.no/benker/$n.html"

  # Generate qr code png as base64 string for embedding in html
  qr_base64="$(echo "$url" | qrencode -o /dev/stdout | base64)"

  echo "<div style=\"width: 450px; clear: both;$top_margin\">
<h2>$url</h2>
<img style=\"float: right;\" src=\"data:image/png;base64,$qr_base64\" />
</div>
" >> "$html"

  top_margin=" margin-top: 10em;"
done

