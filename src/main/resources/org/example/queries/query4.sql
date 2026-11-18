-- Professor, Student, Teaches, Transcript

COPY (
    WITH 
    RebeccaWardInfo AS ( -- courses rebecca ward took
        SELECT *
        FROM student s
        JOIN transcript t ON s.studentId = t.studentId
        WHERE s.firstName = 'Rebecca' and s.lastName = 'Ward' -- Rebecca Ward's exact name
    ),
    ProfessorTeaches AS ( -- courses taught by profs
        SELECT *
        FROM professor p 
        JOIN teaches t ON p.profId = t.profId
    )

    SELECT CONCAT(p.firstName, ' ',p.lastName) AS fullName
    FROM RebeccaWardInfo r
    JOIN ProfessorTeaches p ON r.courseId = p.courseId
    GROUP BY p.profId, p.firstName, p.lastName
    -- ensures the same professor do not appear multiple times
    -- if they have taught multiple courses that Rebecca Ward took
) TO 'src/main/resources/data/output/query4.csv'; 