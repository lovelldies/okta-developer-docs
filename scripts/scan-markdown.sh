#!/bin/bash

# Check if a filename is provided
if [ -z "$1" ]; then
    echo "Usage: $0 filename.md"
    exit 1
fi

# Assign the first argument to a variable
file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

# Check if the file is empty
if [ ! -s "$file" ]; then
    echo "File is empty!"
    exit 1
fi

# Debugging: Display hidden characters in the file (optional)
# Uncomment the following line to debug hidden characters
# cat -A "$file"

# Search for the words and display line numbers
matches=$(grep -inE '\b(would|could|should)\b' "$file")

if [ -n "$matches" ]; then
    # Count the number of instances found
    count=$(echo "$matches" | wc -l)
    echo "Found $count instances:"
    echo "$matches"
else
    echo "No instances of 'would', 'could', or 'should' found in $file."
fi