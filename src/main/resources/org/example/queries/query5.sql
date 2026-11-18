COPY (
    -- professor, teaches, transcript
    SELECT CONCAT(firstName, ' ',lastName) AS fullName
    FROM professor p
    WHERE EXISTS ( -- professor teaches at least one course if there is profId associated with the course
        SELECT * -- eliminates profs without profId associated with course
        FROM teaches t 
        WHERE t.profId = p.profId
    )
    AND NOT EXISTS ( -- returns rows for a given prof if they give failing grade
        SELECT *
        FROM teaches t -- links professor to grade and course
        JOIN transcript tr on t.courseId = tr.courseId
        -- find profs that have given failing grade
        WHERE tr.grade < 50 and t.profId = p.profId 
    )
) TO 'src/main/resources/data/output/query5.csv'; 