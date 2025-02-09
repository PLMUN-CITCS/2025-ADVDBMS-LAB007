#!/bin/bash

declare -a files
directory="university_db"
SQL_FILES=("setup.sql" "select_all_students.sql" "select_students_by_enrollment_date.sql" "join_students_and_enrollments.sql") # Array of filenames

for file in "${files[@]}"; do  # Important: Quote "${files[@]}"
filepath="$directory/$file" # Construct the full path
if [ -f "$filepath" ]; then
    echo "$filepath exists"
else
    echo "$filepath does not exist"
fi
done