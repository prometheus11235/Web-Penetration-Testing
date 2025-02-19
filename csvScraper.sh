#!/bin/bash

orginalCSV="/home/goat/Downloads/scopes_for_indrive_at_2024-12-25_22_02_07_UTC.csv"

#https://miller.readthedocs.io/en/latest/10min/

# Check if the file exists
if [[ -f "$orginalCSV" ]]; then

	echo "CSV FILE FOUND!"

	mlr --csv filter '$eligible_for_bounty == "true"' "$orginalCSV" > filter_csv.csv

	current_dir=$(pwd)

	full_path="$current_dir/filter_csv.csv"

	mlr --icsv --opprint cut -o -f identifier "$full_path" > hackableDomains.txt

	rm filter_csv.csv

	echo "ELIGIBLE DOMAINS EXTRACTED. HAPPY HUNTING!" 

else
	echo "CSV FILE NOT FOUND, PLEASE TRY AGAIN!"
fi 
