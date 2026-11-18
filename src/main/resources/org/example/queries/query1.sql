COPY (
    SELECT COUNT(*) AS totalNumStudents
    FROM transcript t
    WHERE t.grade >= 80 and t.courseId = 'mie301h1f'
) TO 'src/main/resources/data/output/query1.csv'; 