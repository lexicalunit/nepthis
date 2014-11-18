#!/bin/bash

set -exu

NAME="$(basename "$(git rev-parse --show-toplevel)")"

# convert journal to pdf
pandoc journal.md -s -o journal.pdf

# build $NAME.pdf from base, book, and journal
pdftk \
    B=base.pdf \
    J=journal.pdf \
    cat B J \
    output "$NAME.pdf"

# cleanup journal build artifacts
rm -f journal.pdf

# convert form fillable $NAME.pdf to flattened image
# pdf2ps "$NAME.pdf" - | ps2pdf - "flat.pdf"
# convert -resize 1100x -density 300 -quality 100 flat.pdf page.png
# convert page-*.png -append all.png
# convert all.png -background white -flatten flat.png
# pngquant --nofs -s 2 --quality=100 flat.png -fo "../art/$NAME.png"
#
# # cleanup image conversion artifacts
# rm page-*.png flat.pdf all.png flat.png
