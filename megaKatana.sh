#!/bin/bash

# Check if the input file exists
INPUT_FILE="PATH_TO_INPUT_FILE"
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Input file '$INPUT_FILE' not found!"
  exit 1
fi

# Remove SCAN_RESULTS.txt if it exists
OUTPUT_FILE="PATH_TO_OUTPUT_FILE"
if [[ -f "$OUTPUT_FILE" ]]; then
  rm "$OUTPUT_FILE"
  echo "'$OUTPUT_FILE' was removed!"
fi

# Read URLs from the input file into an array
mapfile -t url_list < "$INPUT_FILE"

# Get the total number of URLs
total_urls=${#url_list[@]}

# Initialize counter
count=0

# Loop over each URL and perform the scan
for url in "${url_list[@]}"; do
  # Increment the counter
  count=$((count + 1))
  
  echo "Scanning $url..."
  /home/goat/go/bin/./katana -u "$url" >> "$OUTPUT_FILE"
  
  # Calculate percentage complete
  percent=$((count * 100 / total_urls))
  echo "Completed: $percent% ($count out of $total_urls)"
done

echo "All scans completed. Results saved in $OUTPUT_FILE."

