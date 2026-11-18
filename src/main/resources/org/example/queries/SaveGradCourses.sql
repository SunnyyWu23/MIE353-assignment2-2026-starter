COPY 
    (SELECT courseId, courseName 
    FROM course 
    WHERE gradCourse = 1 or gradCourse = 2)
TO "src/main/resources/data/output/gradCourses.csv"; 
-- exclude gradCourse column
