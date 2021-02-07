#!/bin/bash

getTocMdFiles(){
  find . -iname '*.md' \
  | xargs grep -nwlzP -e '<!--ts-->' | xargs grep -nwlzP -e '<!--te-->'
}

echo "Generate TOC begin: ..."
getTocMdFiles | xargs -L 1 -P 50 gh-md-toc --insert --no-backup 
echo "Generate TOC end."
echo "-----------------"

echo "Remove time row in TOC begin: ..."
# remove time content to aviod too many changes
getTocMdFiles | xargs sed -i '/<!-- Added by:/d' 
echo "Remove time row in TOC end."
