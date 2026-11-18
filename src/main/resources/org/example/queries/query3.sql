COPY (
    WITH profOneCourse AS (
        SELECT p.firstName, p.lastName, COUNT(*) AS numCourses
        FROM professor p
        JOIN teaches t ON t.profId = p.profId
        GROUP BY p.profId, p.firstName, p.lastName
    )

    SELECT CONCAT(firstName, ' ',lastName) AS fullName
    FROM profOneCourse
    WHERE numCourses = 1
) TO 'src/main/resources/data/output/query3.csv'; 