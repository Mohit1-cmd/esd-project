-- Sample Data for Student Specialization System

-- Insert Domains
INSERT INTO domains (domain_name, description) VALUES
('Computer Science', 'Core computer science and software engineering'),
('Data Science', 'Data analytics, statistics, and machine learning'),
('Artificial Intelligence', 'AI, machine learning, and intelligent systems');

-- Insert Specializations
INSERT INTO specializations (domain_id, specialization_name, description) VALUES
-- CS Specializations
(1, 'Software Engineering', 'Software design, development, and testing'),
(1, 'Database Systems', 'Database design, implementation, and management'),
(1, 'Web Development', 'Modern web technologies and frameworks'),
(1, 'Cloud Computing', 'Cloud platforms and distributed systems'),
-- DS Specializations
(2, 'Machine Learning', 'ML algorithms and applications'),
(2, 'Big Data Analytics', 'Large-scale data processing and analysis'),
(2, 'Statistical Analysis', 'Statistical methods and data interpretation'),
-- AI Specializations
(3, 'Deep Learning', 'Neural networks and deep learning'),
(3, 'Natural Language Processing', 'Text processing and understanding'),
(3, 'Computer Vision', 'Image and video analysis');

-- Insert Courses
INSERT INTO courses (course_code, course_name, description, credits) VALUES
-- CS Courses
('CS101', 'Introduction to Programming', 'Basic programming concepts', 4),
('CS201', 'Data Structures', 'Advanced data structures and algorithms', 4),
('CS301', 'Algorithm Design', 'Design and analysis of algorithms', 4),
('CS302', 'Software Engineering', 'Software development lifecycle', 4),
('CS303', 'Database Management Systems', 'Relational databases and SQL', 4),
('CS304', 'Web Technologies', 'HTML, CSS, JavaScript, and frameworks', 3),
('CS305', 'Cloud Computing Fundamentals', 'Cloud platforms and services', 3),
('CS306', 'Advanced Database Systems', 'NoSQL, distributed databases', 3),
-- DS Courses
('DS201', 'Introduction to Data Science', 'Data science fundamentals', 4),
('DS301', 'Machine Learning', 'ML algorithms and techniques', 4),
('DS302', 'Deep Learning', 'Neural networks and DL', 4),
('DS303', 'Big Data Technologies', 'Hadoop, Spark, and big data tools', 4),
('DS304', 'Statistical Methods', 'Probability and statistics', 3),
('DS305', 'Data Visualization', 'Visual analytics and dashboards', 3),
-- AI Courses
('AI301', 'Artificial Intelligence', 'AI fundamentals and search', 4),
('AI302', 'Natural Language Processing', 'Text mining and NLP', 4),
('AI303', 'Computer Vision', 'Image processing and recognition', 4),
('AI304', 'Reinforcement Learning', 'RL algorithms and applications', 3),
-- General Courses
('MATH201', 'Linear Algebra', 'Matrices and vector spaces', 3),
('MATH202', 'Calculus', 'Differential and integral calculus', 3);

-- Map Courses to Specializations
INSERT INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
-- Software Engineering Specialization
(2, 1, 4),   -- Data Structures
(3, 1, 4),   -- Algorithm Design
(4, 1, 4),   -- Software Engineering
-- Database Systems Specialization
(5, 2, 4),   -- Database Management Systems
(8, 2, 3),   -- Advanced Database Systems
(13, 2, 4),  -- Big Data Technologies
-- Web Development Specialization
(6, 3, 3),   -- Web Technologies
(15, 3, 3),  -- Data Visualization
(5, 3, 2),   -- Database Management Systems (partial credits)
-- Cloud Computing Specialization
(7, 4, 3),   -- Cloud Computing Fundamentals
(13, 4, 4),  -- Big Data Technologies
-- Machine Learning Specialization
(10, 5, 4),  -- Machine Learning
(11, 5, 4),  -- Deep Learning
(19, 5, 3),  -- Linear Algebra
-- Big Data Analytics Specialization
(13, 6, 4),  -- Big Data Technologies
(9, 6, 4),   -- Introduction to Data Science
(14, 6, 3),  -- Statistical Methods
-- Statistical Analysis Specialization
(14, 7, 3),  -- Statistical Methods
(20, 7, 3),  -- Calculus
(9, 7, 4),   -- Introduction to Data Science
-- Deep Learning Specialization
(11, 8, 4),  -- Deep Learning
(10, 8, 4),  -- Machine Learning
(19, 8, 3),  -- Linear Algebra
-- NLP Specialization
(16, 9, 4),  -- Natural Language Processing
(15, 9, 4),  -- Artificial Intelligence
(10, 9, 3),  -- Machine Learning
-- Computer Vision Specialization
(17, 10, 4), -- Computer Vision
(11, 10, 4), -- Deep Learning
(15, 10, 4); -- Artificial Intelligence

-- Insert Students
INSERT INTO students (roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year) VALUES
('MT2023001', 'Rahul', 'Sharma', 'rahul.sharma@example.com', 3.75, 48, 2025),
('MT2023002', 'Priya', 'Patel', 'priya.patel@example.com', 3.85, 52, 2025),
('MT2023003', 'Amit', 'Kumar', 'amit.kumar@example.com', 3.60, 44, 2025),
('MT2023004', 'Sneha', 'Reddy', 'sneha.reddy@example.com', 3.90, 56, 2025),
('MT2023005', 'Vikram', 'Singh', 'vikram.singh@example.com', 3.70, 48, 2025),
('MT2023006', 'Anjali', 'Desai', 'anjali.desai@example.com', 3.65, 40, 2025),
('MT2023007', 'Karan', 'Verma', 'karan.verma@example.com', 3.80, 52, 2025),
('MT2023008', 'Neha', 'Gupta', 'neha.gupta@example.com', 3.55, 36, 2025),
('MT2023009', 'Rohan', 'Mehta', 'rohan.mehta@example.com', 3.95, 60, 2025),
('MT2023010', 'Divya', 'Joshi', 'divya.joshi@example.com', 3.72, 48, 2025);

-- Enroll Students in Courses (ensuring some students exceed 20 credits in specializations)

-- Student 1 (Rahul) - Software Engineering Specialization (28 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(1, 1, '2023-24', 'Fall', 'A'),
(1, 2, '2023-24', 'Fall', 'A'),   -- 4 credits to Software Eng
(1, 3, '2023-24', 'Spring', 'A-'), -- 4 credits to Software Eng
(1, 4, '2024-25', 'Fall', 'A'),    -- 4 credits to Software Eng
(1, 5, '2023-24', 'Spring', 'B+'),
(1, 19, '2023-24', 'Fall', 'B+'),
(1, 20, '2023-24', 'Fall', 'A-'),
(1, 6, '2024-25', 'Fall', 'A'),
(1, 7, '2024-25', 'Spring', 'B+'),
(1, 10, '2024-25', 'Spring', 'A'),
(1, 11, '2024-25', 'Spring', 'A-'),
(1, 13, '2024-25', 'Fall', 'B+');

-- Student 2 (Priya) - Machine Learning + Deep Learning Specializations
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(2, 1, '2023-24', 'Fall', 'A'),
(2, 9, '2023-24', 'Fall', 'A'),
(2, 10, '2023-24', 'Spring', 'A+'),  -- 4 credits to ML
(2, 11, '2024-25', 'Fall', 'A'),     -- 4 credits to both ML and DL
(2, 19, '2023-24', 'Fall', 'A'),     -- 3 credits to both ML and DL
(2, 20, '2023-24', 'Spring', 'A-'),
(2, 14, '2023-24', 'Spring', 'B+'),
(2, 15, '2024-25', 'Fall', 'A-'),
(2, 17, '2024-25', 'Spring', 'A'),
(2, 2, '2023-24', 'Spring', 'A'),
(2, 13, '2024-25', 'Fall', 'B+'),
(2, 6, '2024-25', 'Spring', 'A-'),
(2, 18, '2024-25', 'Spring', 'A-');

-- Student 3 (Amit) - Database Systems Specialization (11 credits - below threshold)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(3, 1, '2023-24', 'Fall', 'B+'),
(3, 2, '2023-24', 'Fall', 'B'),
(3, 5, '2023-24', 'Spring', 'B+'),   -- 4 credits to DB Systems
(3, 8, '2024-25', 'Fall', 'B'),      -- 3 credits to DB Systems
(3, 6, '2023-24', 'Spring', 'A-'),
(3, 19, '2023-24', 'Fall', 'B'),
(3, 20, '2023-24', 'Spring', 'B+'),
(3, 10, '2024-25', 'Fall', 'B+'),
(3, 14, '2024-25', 'Spring', 'B'),
(3, 15, '2024-25', 'Fall', 'A-'),
(3, 4, '2024-25', 'Spring', 'B+');

-- Student 4 (Sneha) - Big Data Analytics Specialization (24 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(4, 1, '2023-24', 'Fall', 'A+'),
(4, 9, '2023-24', 'Fall', 'A'),      -- 4 credits to Big Data
(4, 13, '2023-24', 'Spring', 'A'),   -- 4 credits to Big Data
(4, 14, '2023-24', 'Spring', 'A-'),  -- 3 credits to Big Data
(4, 10, '2024-25', 'Fall', 'A+'),
(4, 11, '2024-25', 'Fall', 'A'),
(4, 19, '2023-24', 'Fall', 'A'),
(4, 20, '2023-24', 'Spring', 'A-'),
(4, 15, '2024-25', 'Spring', 'A'),
(4, 2, '2023-24', 'Spring', 'A-'),
(4, 5, '2024-25', 'Fall', 'A'),
(4, 6, '2024-25', 'Spring', 'A-'),
(4, 17, '2024-25', 'Spring', 'A-'),
(4, 18, '2024-25', 'Fall', 'A');

-- Student 5 (Vikram) - Computer Vision Specialization (24 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(5, 1, '2023-24', 'Fall', 'A-'),
(5, 15, '2023-24', 'Fall', 'A'),     -- 4 credits to CV
(5, 17, '2023-24', 'Spring', 'A'),   -- 4 credits to CV
(5, 11, '2024-25', 'Fall', 'A-'),    -- 4 credits to CV
(5, 10, '2024-25', 'Spring', 'A'),
(5, 19, '2023-24', 'Fall', 'B+'),
(5, 20, '2023-24', 'Spring', 'A-'),
(5, 2, '2023-24', 'Spring', 'A'),
(5, 9, '2024-25', 'Fall', 'B+'),
(5, 13, '2024-25', 'Spring', 'B+'),
(5, 6, '2024-25', 'Fall', 'A-'),
(5, 14, '2024-25', 'Spring', 'A-');

-- Student 6 (Anjali) - No specialization (scattered courses)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(6, 1, '2023-24', 'Fall', 'B+'),
(6, 2, '2023-24', 'Fall', 'B'),
(6, 5, '2023-24', 'Spring', 'B+'),
(6, 10, '2024-25', 'Fall', 'A-'),
(6, 19, '2023-24', 'Fall', 'B'),
(6, 20, '2023-24', 'Spring', 'B+'),
(6, 6, '2024-25', 'Spring', 'A-'),
(6, 14, '2024-25', 'Fall', 'B'),
(6, 15, '2024-25', 'Spring', 'A'),
(6, 4, '2023-24', 'Spring', 'B+');

-- Student 7 (Karan) - Web Development Specialization (21 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(7, 1, '2023-24', 'Fall', 'A'),
(7, 6, '2023-24', 'Fall', 'A+'),     -- 3 credits to Web Dev
(7, 15, '2023-24', 'Spring', 'A'),   -- 3 credits to Web Dev
(7, 5, '2024-25', 'Fall', 'A'),      -- 2 credits to Web Dev (partial)
(7, 2, '2023-24', 'Spring', 'A-'),
(7, 3, '2024-25', 'Spring', 'A'),
(7, 4, '2024-25', 'Fall', 'A-'),
(7, 7, '2024-25', 'Spring', 'A'),
(7, 19, '2023-24', 'Fall', 'A-'),
(7, 20, '2023-24', 'Spring', 'B+'),
(7, 10, '2024-25', 'Fall', 'A'),
(7, 11, '2024-25', 'Spring', 'A-'),
(7, 13, '2024-25', 'Fall', 'B+');

-- Student 8 (Neha) - No specialization
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(8, 1, '2023-24', 'Fall', 'B'),
(8, 2, '2023-24', 'Spring', 'B+'),
(8, 5, '2024-25', 'Fall', 'B'),
(8, 19, '2023-24', 'Fall', 'B-'),
(8, 20, '2023-24', 'Spring', 'B'),
(8, 6, '2024-25', 'Spring', 'A-'),
(8, 10, '2024-25', 'Fall', 'B+'),
(8, 14, '2024-25', 'Spring', 'B'),
(8, 9, '2023-24', 'Spring', 'B+');

-- Student 9 (Rohan) - Database + Cloud Computing Specializations (25 and 21 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(9, 1, '2023-24', 'Fall', 'A+'),
(9, 5, '2023-24', 'Fall', 'A+'),     -- 4 credits to DB Systems
(9, 8, '2023-24', 'Spring', 'A'),    -- 3 credits to DB Systems
(9, 13, '2024-25', 'Fall', 'A'),     -- 4 credits to both DB and Cloud
(9, 7, '2024-25', 'Spring', 'A'),    -- 3 credits to Cloud
(9, 2, '2023-24', 'Spring', 'A-'),
(9, 3, '2024-25', 'Fall', 'A'),
(9, 4, '2024-25', 'Spring', 'A-'),
(9, 6, '2024-25', 'Fall', 'A'),
(9, 10, '2024-25', 'Spring', 'A+'),
(9, 11, '2024-25', 'Fall', 'A'),
(9, 19, '2023-24', 'Fall', 'A'),
(9, 20, '2023-24', 'Spring', 'A-'),
(9, 15, '2024-25', 'Spring', 'A'),
(9, 17, '2024-25', 'Fall', 'A-');

-- Student 10 (Divya) - Statistical Analysis Specialization (22 credits)
INSERT INTO student_courses (student_id, course_id, academic_year, semester, grade) VALUES
(10, 1, '2023-24', 'Fall', 'A-'),
(10, 9, '2023-24', 'Fall', 'A'),     -- 4 credits to Statistical Analysis
(10, 14, '2023-24', 'Spring', 'A-'), -- 3 credits to Statistical Analysis
(10, 20, '2023-24', 'Spring', 'A'),  -- 3 credits to Statistical Analysis
(10, 19, '2023-24', 'Fall', 'A-'),
(10, 2, '2023-24', 'Spring', 'A'),
(10, 10, '2024-25', 'Fall', 'A'),
(10, 11, '2024-25', 'Spring', 'A-'),
(10, 5, '2024-25', 'Fall', 'B+'),
(10, 6, '2024-25', 'Spring', 'A'),
(10, 13, '2024-25', 'Fall', 'A-'),
(10, 15, '2024-25', 'Spring', 'A-');

-- Insert Admin Employees
INSERT INTO employees (email, first_name, last_name, department, role) VALUES
('admin@college.edu', 'Admin', 'User', 'Administration', 'Admin'),
('john.doe@college.edu', 'John', 'Doe', 'Administration', 'Manager'),
('jane.smith@college.edu', 'Jane', 'Smith', 'Academics', 'Coordinator');
