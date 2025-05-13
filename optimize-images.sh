#!/bin/bash

INPUT_DIR="./input"
OUTPUT_DIR="./output"

mkdir -p "$OUTPUT_DIR"

for file in "$INPUT_DIR"/*.{jpg,jpeg,png}; do
  [ -e "$file" ] || continue

  filename=$(basename "$file")
  name="${filename%.*}"

  echo "Processing $filename..."

  magick "$file" \
    -strip \
    -resize 1600x1600\> \
    -quality 82 \
    -define webp:auto-filter=true \
    -define webp:method=6 \
    -define webp:alpha-quality=85 \
    "$OUTPUT_DIR/$name.webp"
done

echo "✅ Done! Optimized images are in $OUTPUT_DIR"
