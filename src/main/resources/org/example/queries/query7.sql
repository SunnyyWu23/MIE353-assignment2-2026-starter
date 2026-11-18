-- student x 2, transcript x 2
COPY (
    WITH 
    Student1 AS (
        SELECT s.studentId, s.firstName, s.lastName, t.courseId, t.grade
        FROM student s 
        JOIN transcript t ON s.studentId = t.studentId
    ),
    Student2 AS (
        SELECT s.studentId, s.firstName, s.lastName, t.courseId, t.grade
        FROM student s 
        JOIN transcript t ON s.studentId = t.studentId
    ),
    Total AS (
        SELECT 
            s1.studentId AS studentId1,
            s2.studentId AS studentId2,
            s1.firstName AS firstName1,
            s2.firstName AS firstName2,
            s1.lastName AS lastName1,
            s2.lastName AS lastName2,
            s1.grade AS grade1,
            s2.grade AS grade2
        FROM Student1 s1
        JOIN Student2 s2 ON s1.courseId = s2.courseId AND s1.studentId < s2.studentId
        -- ensure students don't match with itself
    )
    SELECT 
        CONCAT(firstName1, ' ', lastName1) AS student1,
        CONCAT(firstName2, ' ', lastName2) AS student2,
        COUNT(*) AS numSharedCourses,
        AVG(grade1) AS student1Average,
        AVG(grade2) AS student2Average
    FROM Total
    GROUP BY
        studentId1, firstName1, lastName1,
        studentId2, firstName2, lastName2
    HAVING COUNT(*) >= 3
) TO 'src/main/resources/data/output/query7.csv'; 


