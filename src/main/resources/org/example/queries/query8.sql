COPY (
    WITH 
    CourseInfo AS (
        SELECT 
            t.studentId, 
            c.courseId, UPPER(regexp_extract(c.courseId, '^[A-Za-z]+')) AS department, 
            t.grade,
            -- order by undergrad course level second
            CAST(regexp_extract(c.courseId, '[0-9]+') AS INTEGER) AS courseNumber,
            -- order by grad course first
            CASE WHEN c.gradCourse = 1 THEN 1 ELSE 0 END AS isGraduate
        FROM transcript t
        JOIN course c on t.courseId=c.courseId
    ),
    RankedCourses AS ( -- num associated with course is for ordering 
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY studentId, department 
            -- restart numbering for each student-dept combination
            -- 1. put undergrad and 500-level before grad
            -- 2. put lower courseNumbers first 
            -- 3. same course # --> choose higher grade
            ORDER BY isGraduate ASC, courseNumber ASC, grade DESC, courseId
        ) AS lowestRank,
        ROW_NUMBER () OVER (
            PARTITION BY studentId, department 
            ORDER BY isGraduate DESC, courseNumber DESC, grade DESC, courseId
        ) AS highestRank,
        COUNT(DISTINCT courseNumber) OVER (
            -- student must take >= 2 courses with differing course #
            PARTITION BY studentId, department
        ) AS differentNumber
    FROM CourseInfo
    ) 

    SELECT 
        CONCAT(s.firstName, ' ', s.lastName) AS fullName,
        lo.department,
        CONCAT('(', lo.courseId, ', ', hi.courseId, ')') AS coursePair,
        CONCAT('(', lo.grade, ', ', hi.grade, ')') AS gradePair
    FROM RankedCourses lo
        JOIN RankedCourses hi -- low, high pairs
            ON lo.studentId = hi.studentId AND lo.department = hi.department
        JOIN student s -- names
            ON s.studentId = lo.studentId 
        WHERE -- filter with specific conditions
        -- from each student-dept combination
        -- extract row with highest grade for lowest level course 
        -- extract row with highest grade for highest level course  
        lo.lowestRank = 1 AND hi.highestRank = 1 AND lo.differentNumber >= 2 
        -- must take at least 2 different course numbers
        ORDER BY s.studentId, lo.department -- ascending studentId-dept ordering
) TO 'src/main/resources/data/output/query8.csv'; 

