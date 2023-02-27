#!/bin/bash

shopt -s globstar

i=1

# Loop through each file in each subdirectory of the current directory
for file in **/*; do
  # Check if the file is a regular file (i.e., not a directory)
  if [ -f "$file" ]; then
    # Get the parent directory name
    parentdir=$(basename "$(dirname "$file")")
    # Get the file extension
    extension="${file##*.}"
    # Rename the file
    mv "$file" "$(dirname "$file")/${parentdir}_${i}.${extension}"
    # Increment the counter
    i=$((i+1))
  fi
done
