#!/bin/bash

# Create webp directory if it doesn't exist
mkdir -p webp

# Find all images in the current directory and its subdirectories
find . -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | while read file; do

  # Get the base name of the file without the extension
  filename=$(basename -- "$file")
  basename="${filename%.*}"

  # Create a directory in webp folder to match the source file location
  directory=$(dirname -- "$file")
  webp_directory="webp/$directory"
  mkdir -p "$webp_directory"

  # Check the dimensions of the image and resize if necessary
  dimensions=$(identify -format '%wx%h' "$file")
  if [[ "$dimensions" > "1920x1080" ]]; then
    convert "$file" -resize 1920x1080\> -quality 80 "$webp_directory/$basename.webp"
  else
    cwebp -q 80 -preset picture -m 6 "$file" -o "$webp_directory/$basename.webp"
  fi

done
