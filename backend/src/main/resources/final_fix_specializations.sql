-- Final Fix for Students 64-70
-- Update mappings to ensure max credits > 20 and add enrollments

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. UPDATE MAPPINGS
-- ============================================================

-- Network Security (10): Add SEC302(19) and CS301(5)
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(19, 10, 4), -- SEC302
(5, 10, 4);  -- CS301

-- Cloud Architecture (18): Add CLD303(32) and CS302(6)
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(32, 18, 4), -- CLD303
(6, 18, 4);  -- CS302 OS

-- ============================================================
-- 2. ADD ENROLLMENTS
-- ============================================================

-- Cloud Students (67, 68) need CS302(6) and CLD303(32)
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(67, 6, '2024-25', 'Spring', 'A'),
(67, 32, '2023-24', 'Spring', 'A'),
(68, 6, '2024-25', 'Spring', 'A'),
(68, 32, '2024-25', 'Fall', 'A');

-- BI Students (69, 70) need DS301(10) and DS202(9)
INSERT IGNORE INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(69, 10, '2024-25', 'Spring', 'A'),
(69, 9, '2024-25', 'Spring', 'A'),
(70, 10, '2024-25', 'Spring', 'A'),
(70, 9, '2024-25', 'Spring', 'A');

SET FOREIGN_KEY_CHECKS = 1;
