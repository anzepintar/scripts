#!/bin/bash

# Check if the user provided an argument
if [ $# -eq 0 ]; then
	echo "Usage: $0 <acsm_file>"
	exit 1
fi

# Assign the provided argument to the ACSM file variable
acsm_file="$1"

# Check if the ACSM file exists
if [ ! -f "$acsm_file" ]; then
	echo "ACSM file not found!"
	exit 1
fi

# Run the acsmdownloader command to generate the .epub file
acsmdownloader -f "$acsm_file"

# Extract the names of the generated .epub files
epub_files=$(ls -t *.epub 2>/dev/null)

# Check if any .epub files were generated
if [ -z "$epub_files" ]; then
	echo "No .epub files generated."
	exit 1
fi

# Select the newest .epub file
newest_epub=$(echo "$epub_files" | head -n 1)

# Remove the newest .epub file
echo "Removing $newest_epub"
adept_remove "$newest_epub"
