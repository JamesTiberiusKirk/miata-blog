#!/bin/bash

# List of directories to ignore
ignore_dirs=("public/")

# Function to check if a file is in an ignored directory
is_ignored() {
    local file="$1"
    for dir in "${ignore_dirs[@]}"; do
        if [[ "$file" == "$dir"* ]]; then
            return 0
        fi
    done
    return 1
}

# Function to convert HEIC to JPEG
convert_heic_to_jpeg() {
    local heic_file="$1"
    local jpeg_file="${heic_file%.heic}.jpeg"
    echo "Converting $heic_file to $jpeg_file"
    sips -s format jpeg "$heic_file" --out "$jpeg_file"
}

# Export the functions and variables for subshells
export -f convert_heic_to_jpeg
export -f is_ignored
export ignore_dirs

# Find and process all HEIC files recursively, ignoring specified directories
find . -type f -iname "*.heic" | while read -r file; do
    if ! is_ignored "$file"; then
        convert_heic_to_jpeg "$file"
    else
        echo "Skipping $file"
    fi
done

echo "Conversion complete."
