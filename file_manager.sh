#!/bin/bash

#Mini File Manager Script

#  ====== 1.Handle Command Line Argument ===========

## This code makes sure you always give the required input to the script, so it doesn’t run with missing or wrong parameters
if [ $# -lt 1 ]; then
  echo "Usage: $0 <directory> [file_extension]" >&2
  exit 1
fi

TARGET_DIR="$1"
EXT_FILTER="${2:-txt}"  # Default to txt if not provided

# ========== 2. Logging Start ==========
echo "========== File Manager Run ==========" > "$LOG_FILE"
echo "Target Directory: $TARGET_DIR" >> "$LOG_FILE"
echo "File Extension Filter: *.$EXT_FILTER" >> "$LOG_FILE"
echo "Start Time: $(date)" >> "$LOG_FILE"


# ========== 3. Save Current Directory ==========
start_dir=$(pwd)


# ========== 4. Change to Target Directory ==========
cd "$TARGET_DIR" || {
  echo "Directory '$TARGET_DIR' not found!" >> "$ERROR_FILE"
  exit 2
}

# ========== 5. Wildcard & Quoting ==========
echo "Listing all *.$EXT_FILTER files:" >> "$LOG_FILE"
ls *."$EXT_FILTER" >> "$LOG_FILE" 2>>"$ERROR_FILE"

echo "Listing files matching file?.$EXT_FILTER:" >> "$LOG_FILE"
ls file?."$EXT_FILTER" >> "$LOG_FILE" 2>>"$ERROR_FILE"


# ========== 6. Create File With Space ==========
touch file\ with\ space."$EXT_FILTER"
echo "Created file: file with space.$EXT_FILTER" >> "$LOG_FILE"



# ========== 7. Quoting Examples ==========
echo "Current user is \"$USER\"" >> "$LOG_FILE"
echo 'This is how we write $USER literally' >> "$LOG_FILE"
echo "Escaping semicolon \; just for show" >> "$LOG_FILE"


#Other descriptors:
#0 → stdin (standard input)
#1 → stdout (standard output)
#2 → stderr (standard error)


# ========== 8. Redirect Input (Sort Example) ==========
echo "orange
apple
banana" > unsorted.txt


# ========== 9. Count lines in all matching files ==========
echo "Line counts for *.$EXT_FILTER files:" >> "$LOG_FILE"
for f in *."$EXT_FILTER"; do  ## till every file with .."$EXT_FILTER" format
  if [ -f "$f" ]; then   ##if files are there in the directory
    count=$(wc -l < "$f")  ##what ever is there in the file push it to wc -l and it will count it
    echo "$f: $count lines" >> "$LOG_FILE" ##simplayy write the vailue in Log_File
  fi
done


# ========== 10. Return to Original Directory ==========
cd "$start_dir"

echo "Returned to $start_dir" >> "$LOG_FILE"
echo "End Time: $(date)" >> "$LOG_FILE"
echo "✅ Task Completed Successfully" >> "$LOG_FILE"