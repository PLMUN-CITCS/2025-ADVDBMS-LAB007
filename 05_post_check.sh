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
    return 1 # Return non-zero status
  fi
  return 0 # Return zero status (success)
}

# --- Validation ---

# 1. Check Course Count
echo "Checking Course count..."
course_count=$(execute_sql "SELECT COUNT(*) FROM Courses;" | tail -n 1)
if [[ "$course_count" -eq 5 ]]; then
  echo "Course count check: PASSED"
else
  echo "Course count check: FAILED. Expected 5, found $course_count"
  exit 1
fi

# 2. Check Enrollment Count
echo "Checking Enrollment count..."
enrollment_count=$(execute_sql "SELECT COUNT(*) FROM Enrollments;" | tail -n 1)
if [[ "$enrollment_count" -eq 5 ]]; then
  echo "Enrollment count check: PASSED"
else
  echo "Enrollment count check: FAILED. Expected 5, found $enrollment_count"
  exit 1
fi

# 3. Check Bob's updated email
echo "Checking Bob's email..."
bob_email=$(execute_sql "SELECT Email FROM Students WHERE FirstName = 'Bob' AND LastName = 'Johnson';" | tail -n 1)
if [[ "$bob_email" == "bob.j@example.com" ]]; then
  echo "Bob's email check: PASSED"
else
  echo "Bob's email check: FAILED. Expected bob.j@example.com, found $bob_email"
  exit 1
fi

# 4. Check Charlie's deletion (count)
echo "Checking Charlie's deletion..."
charlie_count=$(execute_sql "SELECT COUNT(*) FROM Students WHERE FirstName = 'Charlie' AND LastName = 'Lee';" | tail -n 1)
if [[ "$charlie_count" -eq 0 ]]; then
  echo "Charlie's deletion check: PASSED"
else
  echo "Charlie's deletion check: FAILED. Charlie still exists."
  exit 1
fi


# 5. Check select all students output (count)
echo "Checking select all students count..."
all_students_count=$(execute_sql "SELECT COUNT(*) FROM Students;" | tail -n 1)
if [[ "$all_students_count" -eq 2 ]]; then # After deletion
  echo "Select all students count check: PASSED"
else
  echo "Select all students count check: FAILED. Expected 2, found $all_students_count"
  exit 1
fi

# 6. Check students by enrollment date output (count and content - more complex)
echo "Checking students by enrollment date..."
enrollment_date_count=$(execute_sql "SELECT COUNT(*) FROM Students WHERE EnrollmentDate = '2023-09-01';" | tail -n 1)
if [[ "$enrollment_date_count" -eq 2 ]]; then
    echo "Students by enrollment date count check: PASSED"

    #More thorough check (order may vary, so just checking presence)
    alice_exists=$(execute_sql "SELECT 1 FROM Students WHERE FirstName = 'Alice' AND EnrollmentDate = '2023-09-01';" | tail -n 1)
    bob_exists=$(execute_sql "SELECT 1 FROM Students WHERE FirstName = 'Bob' AND EnrollmentDate = '2023-09-01';" | tail -n 1)

    if [[ "$alice_exists" == 1 && "$bob_exists" == 1 ]]; then
       echo "Students by enrollment date content check: PASSED"
    else
        echo "Students by enrollment date content check: FAILED"
        exit 1
    fi


else
  echo "Students by enrollment date check: FAILED. Expected 2, found $enrollment_date_count"
  exit 1
fi


# 7. Check the join output (count and content - more complex)
echo "Checking join output..."
join_count=$(execute_sql "SELECT COUNT(*) FROM Students AS s INNER JOIN Enrollments AS e ON s.StudentID = e.StudentID INNER JOIN Courses AS c ON e.CourseID = c.CourseID;" | tail -n 1)
if [[ "$join_count" -eq 5 ]]; then
  echo "Join output count check: PASSED"

  #More thorough check (order may vary, so just checking presence of a few records)
  alice_course1_exists=$(execute_sql "SELECT 1 FROM Students AS s INNER JOIN Enrollments AS e ON s.StudentID = e.StudentID INNER JOIN Courses AS c ON e.CourseID = c.CourseID WHERE s.FirstName = 'Alice' AND c.CourseName = 'Introduction to Computer Science';" | tail -n 1)
  bob_course2_exists=$(execute_sql "SELECT 1 FROM Students AS s INNER JOIN Enrollments AS e ON s.StudentID = e.StudentID INNER JOIN Courses AS c ON e.CourseID = c.CourseID WHERE s.FirstName = 'Bob' AND c.CourseName = 'Calculus I';" | tail -n 1)

    if [[ "$alice_course1_exists" == 1 && "$bob_course2_exists" == 1 ]]; then
       echo "Join output content check: PASSED"
    else
        echo "Join output content check: FAILED"
        exit 1
    fi


else
  echo "Join output check: FAILED. Expected 5, found $join_count"
  exit 1
fi


echo "All script validations passed!"

exit 0