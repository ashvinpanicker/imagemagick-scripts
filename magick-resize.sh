#!/bin/bash

INPUT_DIR="./SM"
OUTPUT_DIR="$(pwd)/SM-compressed"
RESIZE_DIMENSIONS="50%"  # You can also use "800x600"

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob
for FILE in "$INPUT_DIR"/*.{jpg,jpeg,png,gif}; do
    if [ -f "$FILE" ]; then
        FILENAME=$(basename "$FILE")
        EXT="${FILENAME##*.}"
        EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
        OUTFILE="$OUTPUT_DIR/$FILENAME"

        case "$EXT_LOWER" in
            jpg|jpeg)
                magick "$FILE" -resize "$RESIZE_DIMENSIONS" -strip -interlace Plane -quality 75 "$OUTFILE"
                ;;
            png)
                magick "$FILE" -resize "$RESIZE_DIMENSIONS" -strip -quality 85 "$OUTFILE"
                ;;
            gif)
                magick "$FILE" -resize "$RESIZE_DIMENSIONS" -strip "$OUTFILE"
                ;;
            *)
                echo "Skipping unsupported file: $FILENAME"
                continue
                ;;
        esac

        echo "Compressed and resized: $FILENAME"
    fi
done

echo "All images processed into $OUTPUT_DIR"
