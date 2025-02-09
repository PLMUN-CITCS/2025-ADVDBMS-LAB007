# **2025-ADVDBMS-LAB007**
Week 02 - Review on Database Concepts

Laboratory # 07 - Guided Coding Exercise: Querying Data with SELECT, FROM, and WHERE Clauses

## **Instructions**

### **Step 1.1: Accept the Assignment**

   1. Click on the assignment link provided by your instructor.
   2. GitHub Classroom will create a **private repository** under your GitHub account.
   3. After the repository is created, click **"Go to Repository"** to view your assignment.

---

### **Step 1.2: Setup your Git Environment**
Only perform this if this is the first time you will setup your Git Environment

   1. Create a GitHub Account:
   ```bash
   https://github.com/signup?source=login
   ```
      
   2. Download and Install Git on your Laptop/Desktop:
   ```bash
   https://git-scm.com/downloads
   ```
   
   3. Create a Folder in your Laptop/Desktop
   4. Right-click anywhere in the created folder and select "Open Git Bash Here".
   5. In the Git Bash Terminal, set your git name, perform command:
   ```bash
   git config --global user.name "Your Name"
   ```
   
   6. In the Git Bash Terminal, set your git email, perform command:
   ```bash
   git config --global user.email "your.email@example.com"
   ```
   
   7. Create your SSH Key, just follow the instructions, no need to provide filename and passphrase. In the Git Bash Terminal, perform command:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   
   8. Copy your SSH Keys into clipboard. In the Git Bash Terminal, perform command:
   ```bash
   clip < ~/.ssh/id_rsa.pub
   ```
   
   9. Log in to your GitHub account.
   10. In the upper-right corner of GitHub, click your profile picture and select Settings.
   11. In the left sidebar, click on SSH and GPG keys.
   12. Click the New SSH key button.
   13. In the Title field, give the key a recognizable name (e.g., "My Windows Laptop").
   14. In the Key field, CTRL + V or paste the keys copied into your clipboard. Save the key.
   15. Go Back to terminal, use command:
   ```bash
   ssh -T git@github.com
   ```

### **Step 2: Clone the Repository to Your Local Machine**

   1. On your repository page, click the green **"Code"** button.
   2. Copy the repository URL (choose HTTPS for simplicity).
   3. Open your terminal (or Git Bash, Command Prompt, or PowerShell) and run:
   
   ```bash
   git clone <git_repo_url>
   ```
   
   4. Navigate into the cloned folder:
   
   ```bash
   cd <git_cloned_folder>
   ```

### **Step 3: Complete the Assignment**

**Laboratory # 07 - Guided Coding Exercise: Querying Data with SELECT, FROM, and WHERE Clauses**

   **Objective:**
   Learn to retrieve data from one or more tables using `SELECT`, `FROM`, and `WHERE` clauses. This exercise focuses on basic queries, conditional queries, and joins.

   **Folder Structure:**
   ```
   university_db/
   ├── insert_courses.sql
   ├── insert_enrollments.sql
   ├── select_all_students.sql
   ├── select_students_by_enrollment_date.sql
   └── join_students_and_enrollments.sql
   ```

   **File Naming Convention:**
   - `insert_courses.sql`: Inserts sample course data into the Courses table for join query testing.
   - `insert_enrollments.sql`: Inserts sample enrollment data into the Enrollments table, linking students to courses with enrollment dates.  Requires existing Students and Courses records.
   - `select_all_students.sql`: Contains the query to select all columns from the `Students` table.
   - `select_students_by_enroll_date.sql`: Contains the query to select students based on their enrollment date.
   - `join_students_and_enrollments.sql`: Contains the query to join `Students` and `Enrollments` tables.

   **Notable Observations (to be discussed after completing the exercise):**
   - SELECT is Your Palette: It dictates which columns you retrieve. * is a quick way for everything, but often you'll want to be specific for performance and clarity.
   - FROM is Your Canvas: It specifies the table(s) you're drawing data from. It's the foundation of your query.
   - WHERE is Your Filter: It refines your results based on conditions. Think of it as a magnifying glass, focusing on the data you need.
   - Joins: Connecting the Dots: Joins are crucial for combining data from related tables. Master the different join types (INNER, LEFT, RIGHT, FULL) to get the most out of your database.
   - Aliases: Your Shorthand: Aliases make your queries easier to read and write, especially when dealing with multiple tables or complex joins. They're like nicknames for your tables.

   **SQL Script Best Practices**
   - Data Exploration First: Use SELECT statements to familiarize yourself with your data. Knowing your data is the first step to querying it effectively.
   - Filtering and Sorting Mastery: Become proficient with the WHERE clause and its various conditions (LIKE, BETWEEN, IN, NOT IN, etc.). Learn how to sort your results using ORDER BY. These are essential for data analysis.
   - Explicit Joins: The Professional Way: Always use the explicit join syntax (INNER JOIN, LEFT JOIN, etc.). It's clearer, more maintainable, and the industry standard. Avoid the older, implicit join syntax whenever possible.
   - Populate Before Querying: Remember to insert data into your tables before you try to query it. The insert_courses.sql and insert_enrollments.sql scripts are essential for setting up the data for your join_students_and_enrollments.sql query. This is a crucial step that's easy to overlook.

   **Step-by-Step Instructions:**

   1. Setting up the Environment
   - Ensure you have a SQL database management system installed, connected to the `UniversityDB` database, and that the `Students` and `Enrollments` tables (and potentially `Courses` table if you want to include course information in the join) have been created and populated with data from the previous exercises.
   - Create the three SQL files as shown in the folder structure above within the `university_db` directory.
   
   2. `insert_courses.sql` (Insert Courses Data)
      - Open `insert_courses.sql` in a text editor.
      - Select data into the courses table:
      ```SQL
      USE `UniversityDB`;

      -- Step 1: Insert data into courses table
      INSERT INTO `Courses` (`CourseName`)
      VALUES
         ('Introduction to Computer Science'),
         ('Calculus I'),
         ('Modern World History'),
         ('English Literature'),
         ('Data Structures');

      ```
      - Save the `insert_courses.sql` file.

   3. `insert_enrollments.sql` (Insert Enrollments Data)
      - Open `insert_enrollments.sql` in a text editor.
      - Select data into the enrollments table:
      ```SQL
      USE `UniversityDB`;

      -- Step 2: Insert data into enrollments table
      INSERT INTO `Enrollments` (`StudentID`, `CourseID`, `EnrollmentDate`)
      VALUES
         (1, 1, '2023-09-01'),
         (2, 2, '2023-09-01'),
         (1, 3, '2023-09-01'),
         (2, 4, '2023-09-02'),
         (2, 5, '2023-09-03');


      ```
      - Save the `insert_enrollments.sql` file.

   4. `select_all_students.sql` (Select All Students):
      - Open `select_all_students.sql` in a text editor.
      - Select all columns from Students:
      ```SQL
      USE `UniversityDB`;
      
      -- Step 3: Select all columns from Students
      SELECT * FROM `Students`;
      
      ```
      
      - Save the `select_all_students.sql` file.
      
   5. `select_students_by_enrollment_date.sql` (Select Students by Enrollment Date):
      - Open `select_students_by_enrollment_date.sql` in a text editor.
      - Select `FirstName` and `LastName` for students enrolled on '2023-09-01':
      ```SQL
      USE `UniversityDB`;
      
      -- Step 4: Select FirstName and LastName for students enrolled on '2023-09-01'
      SELECT `FirstName`, `LastName`
      FROM `Students`
      WHERE `EnrollmentDate` = '2023-09-01';
      
      ```
      
      - Save the `select_students_by_enrollment_date.sql` file.
      
   6. `join_students_and_enrollments.sql` (Join Students and Enrollments):
      - Open `join_students_and_enrollments.sql` in a text editor.
      - Join Students and Enrollments to list student enrollments:
      ```SQL
      USE `UniversityDB`;
      
      -- Step 5: Join Students and Enrollments to list student enrollments
      SELECT `s`.`FirstName`, `s`.`LastName`, `e`.`EnrollmentDate`, `c`.`CourseName`  -- Include CourseName
      FROM `Students` AS `s`
      INNER JOIN `Enrollments` AS `e` ON `s`.`StudentID` = `e`.`StudentID`
      INNER JOIN `Courses` AS `c` ON `e`.`CourseID` = `c`.`CourseID`; -- Join with Courses table
      
      -- Alternative (older, implicit join syntax - less preferred):
      -- SELECT s.FirstName, s.LastName, e.EnrollmentDate, c.CourseName
      -- FROM Students s, Enrollments e, Courses c
      -- WHERE s.StudentID = e.StudentID AND e.CourseID = c.CourseID;
      
      ```
         - Important Note: The preferred way to write joins is using the `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, etc., keywords (explicit join syntax). The older comma-separated `FROM` clause with the join condition in the `WHERE` clause (implicit join syntax) is still supported but is considered less readable and maintainable, especially for complex joins.
         - Aliases (`s`, `e`, `c`) are used to make the query more concise and readable.
         - This example joins with the `Courses` table as well to show the `CourseName`. If you haven't created and populated the `Courses` table, you can remove `c.CourseName` from the `SELECT` list and the `INNER JOIN Courses` clause.
      - Save the `join_students_and_enrollments.sql` file.
   
   7. Executing the SQL Scripts:
   - Open your SQL client and connect to the `UniversityDB` database.
   - Select All: Execute the `select_all_students.sql` script.
   - Select by Date: Execute the `select_students_by_enrollment_date.sql` script.
   - Join: Execute the `join_students_and_enrollments.sql` script.

### **Step 4: Push Changes to GitHub**
Once you've completed your changes, follow these steps to upload your work to your GitHub repository.

1. Check the status of your changes:
   Open the terminal and run:
   
   ```bash
   git status
   ```
   This command shows any modified or new files.
   
2. Stage the changes:
   Add all modified files to staging:
   
   ```bash
   git add .
   ```
   
3. Commit your changes:
   Write a meaningful commit message:
   
   ```bash
   git commit -m "Submitting ADVDBMS Week 02 - Session 01 - Exercise 05"
   ```
   
4. Push your changes to GitHub:
   Upload your changes to your remote repository:
   
   ```bash
   git push origin main
   ```
