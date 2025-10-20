#!/bin/bash

# Usage: ./remove-bg.sh BlackMountain-Logo.jpg
# Output: BlackMountain-Logo_no_bg.png

INPUT="$1"
OUTPUT="${INPUT%.*}_no_bg.png"

echo "Removing background from $INPUT..."

# Use 'magick' instead of 'convert' for IMv7
# Get the color of the top-left pixel to use as the background color
BACKGROUND_COLOR="$(magick identify -format '%[pixel:p{0,0}]' "$INPUT")"

magick "$INPUT" -bordercolor "$BACKGROUND_COLOR" -border 1x1 \
  -alpha set -channel RGBA -fuzz 20% -fill none -floodfill +0+0 "$BACKGROUND_COLOR" \
  -shave 1x1 "$OUTPUT"

echo "Saved as $OUTPUT"
