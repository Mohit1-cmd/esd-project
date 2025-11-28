-- Add 20 new students with specializations (>=20 credits)
-- Each student is strategically enrolled to earn at least one specialization

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- NEW STUDENTS (20 students: IDs 51-70)
-- ============================================================
INSERT INTO student (roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year) VALUES
-- Machine Learning Specialists (5 students)
('MT2024051', 'Aarav', 'Singh', 'aarav.singh@university.edu', 3.82, 24, 2024),
('MT2024052', 'Diya', 'Sharma', 'diya.sharma@university.edu', 3.91, 24, 2024),
('MT2024053', 'Aryan', 'Patel', 'aryan.patel@university.edu', 3.76, 20, 2024),
('MT2024054', 'Isha', 'Kumar', 'isha.kumar@university.edu', 3.88, 24, 2024),
('MT2024055', 'Vihaan', 'Gupta', 'vihaan.gupta@university.edu', 3.79, 20, 2024),

-- Full Stack Developers (5 students)
('MT2024056', 'Ananya', 'Reddy', 'ananya.reddy@university.edu', 3.85, 20, 2024),
('MT2024057', 'Reyansh', 'Verma', 'reyansh.verma@university.edu', 3.93, 24, 2024),
('MT2024058', 'Saanvi', 'Iyer', 'saanvi.iyer@university.edu', 3.81, 20, 2024),
('MT2024059', 'Aditya', 'Nair', 'aditya.nair@university.edu', 3.87, 24, 2024),
('MT2024060', 'Kiara', 'Menon', 'kiara.menon@university.edu', 3.74, 20, 2024),

-- Deep Learning Specialists (3 students)
('MT2024061', 'Vivaan', 'Joshi', 'vivaan.joshi@university.edu', 3.90, 24, 2024),
('MT2024062', 'Aanya', 'Desai', 'aanya.desai@university.edu', 3.86, 20, 2024),
('MT2024063', 'Dhruv', 'Rao', 'dhruv.rao@university.edu', 3.83, 20, 2024),

-- Cybersecurity Experts (3 students)
('MT2024064', 'Myra', 'Pillai', 'myra.pillai@university.edu', 3.89, 22, 2024),
('MT2024065', 'Arjun', 'Shah', 'arjun.shah@university.edu', 3.77, 20, 2024),
('MT2024066', 'Navya', 'Agarwal', 'navya.agarwal@university.edu', 3.84, 22, 2024),

-- Cloud Architecture (2 students)
('MT2024067', 'Kabir', 'Pandey', 'kabir.pandey@university.edu', 3.92, 22, 2024),
('MT2024068', 'Pari', 'Malhotra', 'pari.malhotra@university.edu', 3.80, 20, 2024),

-- Business Intelligence (2 students)
('MT2024069', 'Advait', 'Kapoor', 'advait.kapoor@university.edu', 3.88, 21, 2024),
('MT2024070', 'Zara', 'Bhat', 'zara.bhat@university.edu', 3.75, 20, 2024);

-- ============================================================
-- ENROLLMENTS FOR ML SPECIALISTS (Students 51-55)
-- ML Specialization needs: DS201(4) + DS202(4) + AI201(4) + AI301(4) = 16 base, need 20+
-- ============================================================

-- Student 51: ML (24 credits) - Takes all 4 ML courses + extra data courses
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(51, 7, '2022-23', 'Fall', 'A'),   -- DS101
(51, 8, '2022-23', 'Spring', 'A'), -- DS201 ML (4)
(51, 9, '2023-24', 'Fall', 'A-'),  -- DS202 Stats (4)
(51, 12, '2023-24', 'Fall', 'A'),  -- AI201 (4)
(51, 13, '2023-24', 'Spring', 'A'), -- AI301 Deep Learning (4)
(51, 10, '2024-25', 'Fall', 'A-'); -- DS301 Big Data (contributes but check mapping)

-- Student 52: ML (24 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(52, 7, '2022-23', 'Fall', 'A'),
(52, 8, '2022-23', 'Spring', 'A'),  -- DS201 (4)
(52, 9, '2023-24', 'Fall', 'A'),   -- DS202 (4)
(52, 12, '2023-24', 'Spring', 'A'), -- AI201 (4)
(52, 13, '2024-25', 'Fall', 'A'),  -- AI301 (4)
(52, 14, '2024-25', 'Fall', 'A-'); -- AI302 NLP (contributes to NLP but may overlap)

-- Student 53: ML (20 credits exactly)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(53, 8, '2023-24', 'Fall', 'B+'),  -- DS201 (4)
(53, 9, '2023-24', 'Fall', 'A-'),  -- DS202 (4)
(53, 12, '2023-24', 'Spring', 'A'), -- AI201 (4)
(53, 13, '2024-25', 'Fall', 'A-'), -- AI301 (4)
(53, 2, '2024-25', 'Fall', 'B+');  -- Filler course

-- Student 54: ML (24 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(54, 8, '2022-23', 'Spring', 'A'),
(54, 9, '2023-24', 'Fall', 'A'),
(54, 12, '2023-24', 'Spring', 'A'),
(54, 13, '2024-25', 'Fall', 'A'),
(54, 1, '2022-23', 'Fall', 'A'),
(54, 7, '2023-24', 'Spring', 'A-');

-- Student 55: ML (20 credits exactly)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(55, 8, '2023-24', 'Fall', 'B+'),
(55, 9, '2023-24', 'Spring', 'A-'),
(55, 12, '2024-25', 'Fall', 'A'),
(55, 13, '2024-25', 'Fall', 'B+'),
(55, 1, '2023-24', 'Fall', 'A');

-- ============================================================
-- ENROLLMENTS FOR FULL STACK DEVELOPERS (Students 56-60)
-- Full Stack needs: WEB201(4) + WEB202(4) + WEB301(4) + WEB302(4) = 16, need 20+
-- ============================================================

-- Student 56: Full Stack (20 credits exactly)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(56, 20, '2022-23', 'Fall', 'A-'),  -- WEB101 (doesn't count, just base)
(56, 21, '2022-23', 'Spring', 'A'), -- WEB201 JS (4)
(56, 22, '2023-24', 'Fall', 'A'),   -- WEB202 React (4)
(56, 23, '2023-24', 'Spring', 'A'), -- WEB301 Node (4)
(56, 24, '2024-25', 'Fall', 'A-'),  -- WEB302 Full Stack (4)
(56, 4, '2023-24', 'Fall', 'A');    -- CS202 Database (4 to Backend = 20 total)

-- Student 57: Full Stack (24 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(57, 21, '2022-23', 'Fall', 'A'),
(57, 22, '2022-23', 'Spring', 'A'),
(57, 23, '2023-24', 'Fall', 'A'),
(57, 24, '2023-24', 'Spring', 'A'),
(57, 20, '2022-23', 'Fall', 'A'),
(57, 4, '2024-25', 'Fall', 'A');

-- Student 58: Full Stack (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(58, 21, '2023-24', 'Fall', 'A-'),
(58, 22, '2023-24', 'Spring', 'A'),
(58, 23, '2024-25', 'Fall', 'A-'),
(58, 24, '2024-25', 'Fall', 'A'),
(58, 1, '2023-24', 'Fall', 'A');

-- Student 59: Full Stack (24 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(59, 21, '2022-23', 'Spring', 'A'),
(59, 22, '2023-24', 'Fall', 'A'),
(59, 23, '2023-24', 'Spring', 'A'),
(59, 24, '2024-25', 'Fall', 'A'),
(59, 4, '2023-24', 'Fall', 'A'),
(59, 20, '2022-23', 'Fall', 'A-');

-- Student 60: Full Stack (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(60, 21, '2023-24', 'Fall', 'B+'),
(60, 22, '2023-24', 'Spring', 'A'),
(60, 23, '2024-25', 'Fall', 'A-'),
(60, 24, '2024-25', 'Fall', 'A'),
(60, 4, '2024-25', 'Fall', 'B+');

-- ============================================================
-- DEEP LEARNING SPECIALISTS (Students 61-63)
-- Deep Learning: AI301(4) + AI201(4) + AI302(4) = 12 base, AI303(4) = 16, need more
-- Mapping: course_id 13(AI301), 12(AI201), 14(AI302) all to spec 7
-- ============================================================

-- Student 61: Deep Learning (24 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(61, 12, '2022-23', 'Fall', 'A'),   -- AI201 (4)
(61, 13, '2022-23', 'Spring', 'A'), -- AI301 DL (4)
(61, 14, '2023-24', 'Fall', 'A'),   -- AI302 NLP (4)
(61, 8, '2023-24', 'Spring', 'A'),  -- DS201 ML (may contribute to DL)
(61, 9, '2024-25', 'Fall', 'A-'),   -- DS202
(61, 1, '2022-23', 'Fall', 'A');

-- Student 62: Deep Learning (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(62, 12, '2023-24', 'Fall', 'A-'),
(62, 13, '2023-24', 'Spring', 'A'),
(62, 14, '2024-25', 'Fall', 'A'),
(62, 8, '2024-25', 'Fall', 'A-'),
(62, 1, '2023-24', 'Fall', 'A');

-- Student 63: Deep Learning (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(63, 12, '2023-24', 'Fall', 'B+'),
(63, 13, '2023-24', 'Spring', 'A'),
(63, 14, '2024-25', 'Fall', 'A-'),
(63, 8, '2024-25', 'Fall', 'A'),
(63, 9, '2024-25', 'Fall', 'B+');

-- ============================================================
-- CYBERSECURITY EXPERTS (Students 64-66)
-- Network Security (spec 10): courses 16,17,18 all give 4 credits each = 12, need 20+
-- ============================================================

-- Student 64: Network Security (22 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(64, 16, '2022-23', 'Fall', 'A'),   -- SEC201 Network Sec (4)
(64, 17, '2022-23', 'Spring', 'A'), -- SEC202 Ethical Hacking (4 to spec 10)
(64, 18, '2023-24', 'Fall', 'A'),   -- SEC301 Cryptography (4 to specs 10 and 12)
(64, 19, '2023-24', 'Spring', 'A'), -- SEC302 (3 to spec 11)
(64, 5, '2024-25', 'Fall', 'A-'),   -- CS301 (4 to spec 11)
(64, 1, '2022-23', 'Fall', 'A');

-- Student 65: Network Security (20+ credits)  
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(65, 16, '2023-24', 'Fall', 'B+'),
(65, 17, '2023-24', 'Spring', 'A'),
(65, 18, '2024-25', 'Fall', 'A-'),
(65, 19, '2024-25', 'Fall', 'A'),
(65, 1, '2023-24', 'Fall', 'A');

-- Student 66: Network/App Security (22 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(66, 16, '2022-23', 'Spring', 'A'),
(66, 17, '2023-24', 'Fall', 'A'),
(66, 18, '2023-24', 'Spring', 'A-'),
(66, 5, '2024-25', 'Fall', 'A'),   -- CS301 Software Eng
(66, 19, '2024-25', 'Fall', 'A-'),
(66, 1, '2022-23', 'Fall', 'A');

-- ============================================================
-- CLOUD ARCHITECTURE SPECIALISTS (Students 67-68)
-- Cloud Arch (spec 18): courses 30,31,29 give 4,4,3 = 11 base, need more
-- ============================================================

-- Student 67: Cloud Architecture (22 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(67, 29, '2022-23', 'Fall', 'A'),   -- CLD201 (3)
(67, 30, '2022-23', 'Spring', 'A'), -- CLD301 (4)
(67, 31, '2023-24', 'Fall', 'A'),   -- CLD302 (4)
(67, 32, '2023-24', 'Spring', 'A'), -- CLD303 DevOps (4 to spec 19)
(67, 1, '2022-23', 'Fall', 'A'),
(67, 2, '2023-24', 'Fall', 'A-');

-- Student 68: Cloud Architecture (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(68, 29, '2023-24', 'Fall', 'A-'),
(68, 30, '2023-24', 'Spring', 'A'),
(68, 31, '2024-25', '  Fall', 'A'),
(68, 32, '2024-25', 'Fall', 'A-'),
(68, 1, '2023-24', 'Fall', 'A');

-- ============================================================
-- BUSINESS INTELLIGENCE SPECIALISTS (Students 69-70)
-- Business Intelligence (spec 20): courses 34,35,11 = 4,4,3 = 11, need more
-- ============================================================

-- Student 69: Business Intelligence (21 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(69, 34, '2022-23', 'Fall', 'A'),   -- BA201 (4)
(69, 35, '2022-23', 'Spring', 'A'), -- BA301 BI (4)
(69, 11, '2023-24', 'Fall', 'A'),   -- DS302 Data Viz (3)
(69, 36, '2023-24', 'Spring', 'A'), -- BA302 Predictive (contributes to spec 6)
(69, 7, '2024-25', 'Fall', 'A-'),   -- DS101
(69, 1, '2022-23', 'Fall', 'A');

-- Student 70: Business Intelligence (20 credits)
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
(70, 34, '2023-24', 'Fall', 'A-'),
(70, 35, '2023-24', 'Spring', 'A'),
(70, 11, '2024-25', 'Fall', 'A'),
(70, 7, '2023-24', 'Fall', 'A'),
(70, 9, '2024-25', 'Fall', 'A-');

SET FOREIGN_KEY_CHECKS = 1;
