#!/bin/bash

source=$1

dest=$2

extension=$3

BACKUP_COUNT=0

total_size=0


# checking all required arguments received or not

echo ""

if [[ -z "$source" ]] || [[ -z "$dest" ]] || [[ -z "$extension" ]]; then

	echo "All three required command line arguments not received " >&2

	exit 1

fi

# checking source directory and its files and subdirectories if exist

if [[ -d "$source" ]]; then

	echo "Source Directory exists. Proceeding to check whether files and/or subdirectories exist or not"

	echo ""

	if ! [[ -z "$(ls -A "$source")" ]]; then

		echo "Files or subdirectories exist"

		echo ""

	else

		echo "No files exist in the given source directory" >&2

		exit 1

	fi

else

	echo "Source directory does not exist." >&2

fi

# checking backup directory

if ! [[ -d "$dest" ]]; then

	mkdir -p "$dest" || echo "Attempt to create backup directory provided failed...." >&2

else

	echo "Backup directory is ready"

	echo ""

fi


# extracting the files with given extension from source into myarr array 

mapfile -t myarr < <(ls -n "$source" | awk -v  ext="$extension" 'NR>1 && $NF ~ ext"$" {print $NF}')

echo "Files going to backed up from given source to given destination directory"


# printing the files with sizes before backup

for file in "${myarr[@]}"; do

	ls -lh "$source/$file" | awk -v var="$9" '{print $5 "\t" "'"$file"'"}'

done

echo ""

# checking whether extracted files already present in destination directory or not and processing accordingly as per given question

for file in "${myarr[@]}"; do

	if [[ -f "$dest/$file" ]]; then

		echo "File $file exists already in destination folder"

		if [[ "$source/$file" -nt "$dest/$file" ]]; then

			echo "File $file in destination folder is older than that of source directory"

			cat "$source/$file" > "$dest/$file"

		fi

	else

		echo "File $file does not exist in destination folder so creating copy of it in destination folder"

		cat "$source/$file" > "$dest/$file"

	fi

done

export BACKUP_COUNT="${#myarr[@]}"

# Generating backup report

backup="${dest}/backup_report.log"

echo "Files that are backed up from ${source} are as follows : " > "$backup"

size=0

for file in "${myarr[@]}"; do

	size=$(stat -c %s "$source/$file")

	total_size=$((total_size+size))

	echo "$file" >> "$backup"

done

echo "Total files backed up is ${#myarr[@]}" >> "${dest}/backup_report.log"

echo "Total Size got backed up is ${total_size}" >> "${dest}/backup_report.log"

echo "Path to the backup directory is : ${dest}" >> "${dest}/backup_report.log"


