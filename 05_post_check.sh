#!/bin/bash

# Database credentials (environment variables are recommended)
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-4000}"
DB_USER="${DB_USER:-root}"
DB_NAME="${DB_NAME:-UniversityDB}"

execute_sql() {
  mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -D "$DB_NAME" -e "$1"
  if [[ $? -ne 0 ]]; then
    echo "Error executing SQL: $1"
    return 1  # Return non-zero status
  fi
  return 0 # Return zero status
}

# Function to check the number of rows returned by a query
check_row_count() {
  query="$1"
  expected_count="$2"
  actual_count=$(execute_sql "$query" | wc -l) # Count lines (rows)
  actual_count=$((actual_count - 1)) # Subtract header row

  if [[ $? -eq 0 && "$actual_count" -eq "$expected_count" ]]; then
    echo "$query check: PASSED (Expected $expected_count rows, found $actual_count)"
    return 0
  else
    echo "$query check: FAILED (Expected $expected_count rows, found $actual_count)"
    return 1
  fi
}

# Function to check if a specific value exists in the result of a query
check_value_exists() {
  query="$1"
  expected_value="$2"

  result=$(execute_sql "$query" | grep "$expected_value")

  if [[ $? -eq 0 && ! -z "$result" ]]; then
    echo "$query check: PASSED (Found value: $expected_value)"
    return 0
  else
    echo "$query check: FAILED (Value '$expected_value' not found)"
    return 1
  fi
}


# --- Validation ---

# 1. Check select_all_students.sql (after DELETE)
# Should have 2 rows (Alice and Bob)
if ! check_row_count "SELECT * FROM Students;" 2; then
    exit 1
fi


# 2. Check select_students_by_enrollment_date.sql
# Should have 2 rows (Alice and Bob)
if ! check_row_count "SELECT FirstName, LastName FROM Students WHERE EnrollmentDate = '2023-09-01';" 2; then
  exit 1
fi

# 3. Check join_students_and_enrollments.sql
# You'll need to know how many enrollments you inserted to check this accurately.
# Let's assume you added 2 enrollments (Alice and Bob have 1 each)
# *IMPORTANT* Change this to the actual number of enrollments
NUMBER_OF_ENROLLMENTS=2
if ! check_row_count "SELECT s.FirstName, s.LastName, e.EnrollmentDate, c.CourseName FROM Students s INNER JOIN Enrollments e ON s.StudentID = e.StudentID INNER JOIN Courses c ON e.CourseID = c.CourseID;" "$NUMBER_OF_ENROLLMENTS"; then
  exit 1
fi

# 4. Check if Bob's email was updated
if ! check_value_exists "SELECT Email FROM Students WHERE FirstName = 'Bob';" "bob.j@example.com"; then
  exit 1
fi


echo "All data validation checks passed!"

exit 0