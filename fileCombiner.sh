#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 /path/to/input_directory /path/to/output_directory"
    exit 1
fi

# Assign input and output directories from arguments
input_dir="$1"
output_dir="$2"

# Verify that the input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' does not exist."
    exit 1
fi

# Verify that the output directory exists; create it if it doesn't
if [ ! -d "$output_dir" ]; then
    echo "Output directory '$output_dir' does not exist. Creating it now."
    mkdir -p "$output_dir"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create output directory."
        exit 1
    fi
fi

# Define the output file path
output_file="$output_dir/combined_output.txt"

# Add a header to the output file
echo "Combined Text Files" > "$output_file"
echo "===================" >> "$output_file"

# Iterate over all text files in the input directory
for file in "$input_dir"/*.txt; do
    # Check if there are no text files in the directory
    if [ ! -e "$file" ]; then
        echo "No text files found in the input directory."
        exit 1
    fi

    # Append the content of each text file to the output file
    cat "$file" >> "$output_file"
    # Add a newline for separation
    echo "" >> "$output_file"
done

echo "All text files from '$input_dir' have been combined into '$output_file'."
