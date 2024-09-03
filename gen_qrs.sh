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
for cmd in qrencode; do
  command -v $cmd > /dev/null 2>&1 || error "Required command $cmd not found"
done

today="$(date +%Y-%m-%d)"

rm qrs/*

for n in {1..25}; do
  url="https://krakeroylions.no/benker/$n.html"

  echo $url
  continue

  png="qrs/qr_${n}.png"
  pdf="qrs/qr_${n}.pdf"

  # Generate qr code png as base64 string for embedding in html
  echo "$url" | qrencode -s 21 -m 0 -o "$png"
  convert "$png" "$pdf"
done



