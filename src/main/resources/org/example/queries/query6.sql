COPY (
    WITH 
    TakenDataModelling AS ( -- all students taken DM
        SELECT t.studentId
        FROM course c
        JOIN transcript t on c.courseId=t.courseId
        WHERE c.courseName= 'Data Modelling'
    ),
    OtherCoursesAndAbove90 AS ( -- all students that have taken other courses and >= 90 grade
        SELECT t.studentId
        FROM course c
        JOIN transcript t on c.courseId=t.courseId 
        WHERE c.courseName <> 'Data Modelling' and t.grade>=90
    )

    SELECT CONCAT(s.firstName, ' ',s.lastName) AS fullName
    FROM student s
    WHERE EXISTS ( -- check if a row exists for given sId's 
        SELECT *
        FROM TakenDataModelling t
        WHERE s.studentId=t.studentId
    ) 
    AND EXISTS ( -- check if a row exists for given sId's 
        SELECT *
        FROM OtherCoursesAndAbove90 o
        WHERE o.studentId=s.studentId
    )
) TO 'src/main/resources/data/output/query6.csv'; 