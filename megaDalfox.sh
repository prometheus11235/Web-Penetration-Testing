#!/bin/bash

# Check if the input file exists
INPUT_FILE="PATH_TO_FILE"
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Input file '$INPUT_FILE' not found!"
  exit 1
fi

# Remove OUTPUT_FILE if it exists
OUTPUT_FILE="/home/goat/HackerOne/Websites/HILTON/CODE/BASH/DALFOX_SCAN.txt"
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
  
  # Define TEMP_PATH inside the loop
  TEMP_PATH="/home/goat/HackerOne/Websites/HILTON/CODE/BASH/${count}.txt"
  
  dalfox url "$url" -o "$TEMP_PATH"

  if [[ -s "$TEMP_PATH" ]]; then
    echo "Vulnerability found in $url!"  
    cat "$TEMP_PATH" >> "$OUTPUT_FILE"
    echo "Results appended to '$OUTPUT_FILE'. Temp file removed!"
    # Remove the temporary file
    rm "$TEMP_PATH"
  else
    echo "No vulnerabilities found in $url."
  fi

  # Calculate percentage complete
  percent=$((count * 100 / total_urls))
  echo "Completed: $percent% ($count out of $total_urls)"
done

echo "All scans completed. Results saved in $OUTPUT_FILE."


