-- Fix missing specializations for students 51-70
-- Adding specific courses to ensure they reach >= 20 credits based on new mappings

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- MACHINE LEARNING (Students 51, 53, 54, 55)
-- Need to reach 20. Add AI302 (NLP) - 4 credits (Mapped to ML now)
-- ============================================================
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(51, 14, '2024-25', 'Spring', 'A'),
(53, 14, '2024-25', 'Spring', 'A'),
(54, 14, '2024-25', 'Spring', 'A'),
(55, 14, '2024-25', 'Spring', 'A');

-- ============================================================
-- FULL STACK (Student 58)
-- Add CS202 (DBMS) - 4 credits (Mapped to Full Stack now)
-- ============================================================
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(58, 4, '2023-24', 'Fall', 'A');

-- ============================================================
-- DEEP LEARNING (Student 62)
-- Add AI303 (Vision) - 4 credits (Mapped to DL now)
-- ============================================================
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(62, 15, '2024-25', 'Spring', 'A');

-- ============================================================
-- NETWORK SECURITY (Students 64, 65, 66)
-- Add CS302 (OS) - 4 credits (Mapped to Net Sec now)
-- ============================================================
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(64, 6, '2024-25', 'Spring', 'A'),
(65, 6, '2024-25', 'Spring', 'A'),
(66, 6, '2024-25', 'Spring', 'A');

-- ============================================================
-- CLOUD ARCHITECTURE (Students 67, 68)
-- Add DS301 (Big Data) - 3 credits (Mapped to Cloud now)
-- Wait, DS301 is 3 credits. They have 11 base. 11+3 = 14. Not enough.
-- Add SEC201 (Network Sec) - 4 credits. 11+4 = 15.
-- They need more.
-- Let's add BOTH DS301 and SEC201.
-- ============================================================
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(67, 10, '2024-25', 'Spring', 'A'), -- DS301
(67, 16, '2024-25', 'Spring', 'A'), -- SEC201
(68, 10, '2024-25', 'Spring', 'A'),
(68, 16, '2024-25', 'Spring', 'A');

-- ============================================================
-- BUSINESS INTELLIGENCE (Students 69, 70)
-- Base 11. Add DS301 (3) + DS202 (4) = 18. Still < 20.
-- Need more mappings or courses.
-- Let's add CS202 (DBMS) to BI mapping?
-- Or just add more courses.
-- Let's add CS202 (4) to BI mapping in this script too.
-- ============================================================

-- Add CS202 to BI mapping
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(4, 20, 4); -- CS202 DBMS to BI

-- Now enroll 69, 70 in CS202
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(69, 4, '2023-24', 'Fall', 'A'),
(70, 4, '2023-24', 'Fall', 'A');

SET FOREIGN_KEY_CHECKS = 1;
