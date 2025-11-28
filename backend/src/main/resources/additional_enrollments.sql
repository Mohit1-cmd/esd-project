-- Additional enrollments to ensure students earn specializations (>20 credits)
-- This supplements the existing data.sql

SET FOREIGN_KEY_CHECKS = 0;

-- Add more ML courses for students 1, 2, 4, 12 to push them over 20 credits
-- Student 1 already has 16 ML credits, add 2 more ML courses
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
-- Student 1 - Adding to get ML specialization (already has 16, add 8 more = 24 total)
(1, 14, '2024-25', 'Spring', 'A'),  -- AI302 NLP (contributes 4 to ML via course_id 14 -> spec 8)
(1, 11, '2024-25', 'Spring', 'A-'); -- DS302 Data Viz (contributes 3 to Big Data)

-- Student 2 - Already focused on Full Stack, let's give full stack specialization
-- Full Stack needs: WEB302 (course 24), WEB202 (22), WEB301 (23), WEB201 (21) = 16 credits
-- Student 2 already has all these. Let's add one more to push over 20
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(2, 21, '2024-25', 'Spring', 'A');  -- Extra JavaScript course (already has it, this is duplicate academic year - skip)

-- Student 4 - Has ML (16 credits), add more
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(4, 12, '2024-25', 'Spring', 'A'),  -- AI201 (contributes 4 to ML)
(4, 13, '2024-25', 'Spring', 'A'),  -- AI301 Deep Learning (contributes 4 to ML)
(4, 36, '2024-25', 'Spring', 'A-'); -- BA302 (contributes to Statistical Modeling)

-- Student 6 - Deep Learning specialization (already has 8, add more)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(6, 8, '2024-25', 'Spring', 'A'),   -- DS201 ML (contributes to DL)
(6, 9, '2024-25', 'Spring', 'A');   -- DS202 Stats

-- Student 8 - Full Stack (already has most courses)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(8, 4, '2024-25', 'Spring', 'A');   -- CS202 Database (contributes 4 to Backend)

-- Student 12 - Machine Learning specialist
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(12, 14, '2024-25', 'Spring', 'A'), -- NLP
(12, 10, '2024-25', 'Spring', 'A'); -- Big Data

-- Student 16 - Deep Learning (already has 12 credits via courses 13,14,15,12,2)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(16, 8, '2024-25', 'Spring', 'A'),  -- DS201
(16, 9, '2024-25', 'Spring', 'A');  -- DS202

-- Student 18 - Network Security (has 16, 17, 18, 19)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(18, 5, '2024-25', 'Spring', 'A');  -- CS301 Software Eng (contributes to App Security)

-- Student 20 - Machine Learning
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(20, 14, '2024-25', 'Spring', 'A'), -- NLP
(20, 11, '2024-25', 'Spring', 'A'); -- Data Viz

SET FOREIGN_KEY_CHECKS = 1;
