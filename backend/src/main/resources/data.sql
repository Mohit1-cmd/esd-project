-- Comprehensive Sample Data for Student Specialization Management System
-- This file contains ~60+ records across all tables

-- Disable foreign key checks to allow TRUNCATE
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data
TRUNCATE TABLE student_course;
TRUNCATE TABLE course_specialization;
TRUNCATE TABLE specialization;
TRUNCATE TABLE domain;
TRUNCATE TABLE course;
TRUNCATE TABLE student;
TRUNCATE TABLE employee;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- DOMAINS (8 domains)
-- ============================================================
INSERT INTO domain (domain_name, description) VALUES
('Computer Science', 'Computing, programming, and software development'),
('Data Science', 'Data analysis, machine learning, and statistics'),
('Artificial Intelligence', 'AI, machine learning, and neural networks'),
('Cybersecurity', 'Information security and network protection'),
('Web Development', 'Frontend and backend web technologies'),
('Mobile Development', 'iOS and Android application development'),
('Cloud Computing', 'Cloud infrastructure and distributed systems'),
('Business Analytics', 'Business intelligence and decision science');

-- ============================================================
-- SPECIALIZATIONS (20 specializations)
-- ============================================================
INSERT INTO specialization (domain_id, specialization_name, description) VALUES
-- Computer Science
(1, 'Software Engineering', 'Software design and development methodologies'),
(1, 'Database Systems', 'Database design, SQL, and NoSQL technologies'),
(1, 'Algorithms & Theory', 'Advanced algorithms and computational theory'),

-- Data Science
(2, 'Machine Learning', 'Supervised and unsupervised learning techniques'),
(2, 'Big Data Analytics', 'Large-scale data processing and analysis'),
(2, 'Statistical Modeling', 'Statistical methods and predictive modeling'),

-- Artificial Intelligence
(3, 'Deep Learning', 'Neural networks and deep learning frameworks'),
(3, 'Natural Language Processing', 'Text processing and language understanding'),
(3, 'Computer Vision', 'Image processing and visual recognition'),

-- Cybersecurity
(4, 'Network Security', 'Securing networks and communications'),
(4, 'Application Security', 'Secure software development practices'),
(4, 'Cryptography', 'Encryption and secure communications'),

-- Web Development
(5, 'Frontend Development', 'React, Angular, Vue.js development'),
(5, 'Backend Development', 'Server-side programming and APIs'),
(5, 'Full Stack Development', 'End-to-end web application development'),

-- Mobile Development
(6, 'iOS Development', 'Swift and iOS app development'),
(6, 'Android Development', 'Kotlin and Android app development'),

-- Cloud Computing
(7, 'Cloud Architecture', 'Designing scalable cloud solutions'),
(7, 'DevOps', 'CI/CD and infrastructure automation'),

-- Business Analytics
(8, 'Business Intelligence', 'BI tools and data visualization');

-- ============================================================
-- COURSES (40 courses)
-- ============================================================
INSERT INTO course (course_code, course_name, description, credits) VALUES
-- Computer Science Courses
('CS101', 'Introduction to Programming', 'Fundamentals of programming using Python', 4),
('CS102', 'Data Structures', 'Arrays, linked lists, trees, and graphs', 4),
('CS201', 'Algorithms', 'Algorithm design and analysis', 4),
('CS202', 'Database Management Systems', 'Relational databases and SQL', 4),
('CS301', 'Software Engineering', 'SDLC, design patterns, and best practices', 4),
('CS302', 'Operating Systems', 'Process management and memory allocation', 4),

-- Data Science Courses
('DS101', 'Introduction to Data Science', 'Data analysis fundamentals', 3),
('DS201', 'Machine Learning Fundamentals', 'Supervised and unsupervised learning', 4),
('DS202', 'Statistical Analysis', 'Probability and statistical methods', 4),
('DS301', 'Big Data Technologies', 'Hadoop, Spark, and distributed computing', 4),
('DS302', 'Data Visualization', 'Tableau, D3.js, and visual analytics', 3),

-- AI Courses
('AI201', 'Artificial Intelligence', 'AI concepts and applications', 4),
('AI301', 'Deep Learning', 'Neural networks and TensorFlow', 4),
('AI302', 'Natural Language Processing', 'Text mining and language models', 4),
('AI303', 'Computer Vision', 'Image processing and CNN', 4),

-- Cybersecurity Courses
('SEC201', 'Network Security', 'Firewalls, VPNs, and network protocols', 4),
('SEC202', 'Ethical Hacking', 'Penetration testing and security auditing', 3),
('SEC301', 'Cryptography', 'Encryption algorithms and protocols', 4),
('SEC302', 'Security Operations', 'SOC operations and incident response', 3),

-- Web Development Courses
('WEB101', 'HTML/CSS Fundamentals', 'Web markup and styling', 3),
('WEB201', 'JavaScript Programming', 'Client-side scripting and ES6', 4),
('WEB202', 'React Development', 'Building UIs with React', 4),
('WEB301', 'Node.js Backend', 'Server-side JavaScript development', 4),
('WEB302', 'Full Stack Project', 'Complete web application development', 4),

-- Mobile Development Courses
('MOB201', 'iOS Development', 'Swift and SwiftUI programming', 4),
('MOB202', 'Android Development', 'Kotlin and Android SDK', 4),
('MOB301', 'Mobile UI/UX', 'Mobile interface design principles', 3),
('MOB302', 'Cross-Platform Development', 'React Native and Flutter', 4),

-- Cloud Computing Courses
('CLD201', 'Cloud Fundamentals', 'AWS, Azure, and GCP basics', 3),
('CLD301', 'Cloud Architecture', 'Designing scalable cloud systems', 4),
('CLD302', 'Containerization', 'Docker and Kubernetes', 4),
('CLD303', 'DevOps Practices', 'CI/CD pipelines and automation', 4),

-- Business Analytics Courses
('BA201', 'Business Analytics', 'Data-driven decision making', 4),
('BA301', 'Business Intelligence', 'BI tools and dashboards', 4),
('BA302', 'Predictive Analytics', 'Forecasting and time series', 4),

-- General/Elective Courses
('GEN101', 'Communication Skills', 'Professional communication', 2),
('GEN102', 'Ethics in Technology', 'Technology ethics and responsibility', 2),
('GEN201', 'Project Management', 'Agile and project planning', 3),
('GEN301', 'Entrepreneurship', 'Startup fundamentals', 3);

-- ============================================================
-- COURSE-SPECIALIZATION MAPPINGS (Multiple per specialization)
-- ============================================================
INSERT INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
-- Software Engineering
(5, 1, 4), (6, 1, 4), (39, 1, 3),

-- Database Systems
(4, 2, 4), (11, 2, 4),

-- Algorithms & Theory
(3, 3, 4), (6, 3, 4),

-- Machine Learning
(8, 4, 4), (9, 4, 4), (12, 4, 4), (13, 4, 4),

-- Big Data Analytics
(10, 5, 4), (7, 5, 3), (11, 5, 3),

-- Statistical Modeling
(9, 6, 4), (35, 6, 4), (36, 6, 4),

-- Deep Learning
(13, 7, 4), (12, 7, 4), (14, 7, 4),

-- NLP
(14, 8, 4), (13, 8, 4), (2, 8, 4),

-- Computer Vision
(15, 9, 4), (13, 9, 4), (14, 9, 3),

-- Network Security
(16, 10, 4), (17, 10, 3), (18, 10, 4),

-- Application Security
(19, 11, 3), (5, 11, 4), (17, 11, 3),

-- Cryptography
(18, 12, 4), (16, 12, 4),

-- Frontend Development
(20, 13, 3), (21, 13, 4), (22, 13, 4),

-- Backend Development
(23, 14, 4), (4, 14, 4), (24, 14, 4),

-- Full Stack Development
(24, 15, 4), (22, 15, 4), (23, 15, 4), (21, 15, 4),

-- iOS Development
(25, 16, 4), (27, 16, 3), (28, 16, 4),

-- Android Development
(26, 17, 4), (27, 17, 3), (28, 17, 4),

-- Cloud Architecture
(30, 18, 4), (31, 18, 4), (29, 18, 3),

-- DevOps
(32, 19, 4), (31, 19, 4), (33, 19, 4),

-- Business Intelligence
(34, 20, 4), (35, 20, 4), (11, 20, 3);

-- ============================================================
-- STUDENTS (50 students)
-- ============================================================
INSERT INTO student (roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year) VALUES
('MT2024001', 'Arjun', 'Sharma', 'arjun.sharma@university.edu', 3.85, 64, 2024),
('MT2024002', 'Priya', 'Patel', 'priya.patel@university.edu', 3.92, 68, 2024),
('MT2024003', 'Rahul', 'Kumar', 'rahul.kumar@university.edu', 3.67, 60, 2024),
('MT2024004', 'Sneha', 'Reddy', 'sneha.reddy@university.edu', 3.78, 72, 2024),
('MT2024005', 'Vikram', 'Singh', 'vikram.singh@university.edu', 3.55, 56, 2024),
('MT2024006', 'Ananya', 'Gupta', 'ananya.gupta@university.edu', 3.95, 76, 2024),
('MT2024007', 'Karthik', 'Menon', 'karthik.menon@university.edu', 3.72, 64, 2024),
('MT2024008', 'Divya', 'Iyer', 'divya.iyer@university.edu', 3.88, 68, 2024),
('MT2024009', 'Rohan', 'Verma', 'rohan.verma@university.edu', 3.61, 60, 2024),
('MT2024010', 'Isha', 'Nair', 'isha.nair@university.edu', 3.83, 72, 2024),
('MT2024011', 'Aditya', 'Joshi', 'aditya.joshi@university.edu', 3.76, 64, 2024),
('MT2024012', 'Meera', 'Desai', 'meera.desai@university.edu', 3.91, 76, 2024),
('MT2024013', 'Siddharth', 'Rao', 'siddharth.rao@university.edu', 3.58, 52, 2024),
('MT2024014', 'Kavya', 'Pillai', 'kavya.pillai@university.edu', 3.87, 68, 2024),
('MT2024015', 'Nikhil', 'Shah', 'nikhil.shah@university.edu', 3.69, 60, 2024),
('MT2024016', 'Ritu', 'Agarwal', 'ritu.agarwal@university.edu', 3.94, 80, 2024),
('MT2024017', 'Akash', 'Pandey', 'akash.pandey@university.edu', 3.52, 48, 2024),
('MT2024018', 'Pooja', 'Malhotra', 'pooja.malhotra@university.edu', 3.81, 72, 2024),
('MT2024019', 'Varun', 'Kapoor', 'varun.kapoor@university.edu', 3.73, 64, 2024),
('MT2024020', 'Tanvi', 'Bhat', 'tanvi.bhat@university.edu', 3.89, 76, 2024),
('MT2025021', 'Amit', 'Thakur', 'amit.thakur@university.edu', 3.65, 48, 2025),
('MT2025022', 'Neha', 'Chopra', 'neha.chopra@university.edu', 3.77, 56, 2025),
('MT2025023', 'Pranav', 'Kulkarni', 'pranav.kulkarni@university.edu', 3.82, 52, 2025),
('MT2025024', 'Simran', 'Bajaj', 'simran.bajaj@university.edu', 3.91, 60, 2025),
('MT2025025', 'Harsh', 'Saxena', 'harsh.saxena@university.edu', 3.59, 44, 2025),
('MT2025026', 'Aisha', 'Khan', 'aisha.khan@university.edu', 3.86, 56, 2025),
('MT2025027', 'Gaurav', 'Mishra', 'gaurav.mishra@university.edu', 3.71, 48, 2025),
('MT2025028', 'Shruti', 'Bansal', 'shruti.bansal@university.edu', 3.93, 60, 2025),
('MT2025029', 'Manish', 'Tiwari', 'manish.tiwari@university.edu', 3.64, 44, 2025),
('MT2025030', 'Radhika', 'Ghosh', 'radhika.ghosh@university.edu', 3.88, 56, 2025),
('MT2025031', 'Yash', 'Sinha', 'yash.sinha@university.edu', 3.75, 52, 2025),
('MT2025032', 'Anjali', 'Yadav', 'anjali.yadav@university.edu', 3.80, 56, 2025),
('MT2025033', 'Vivek', 'Chauhan', 'vivek.chauhan@university.edu', 3.57, 40, 2025),
('MT2025034', 'Nidhi', 'Srivastava', 'nidhi.srivastava@university.edu', 3.84, 52, 2025),
('MT2025035', 'Kunal', 'Ahuja', 'kunal.ahuja@university.edu', 3.68, 48, 2025),
('MT2025036', 'Sakshi', 'Kaur', 'sakshi.kaur@university.edu', 3.92, 60, 2025),
('MT2025037', 'Abhishek', 'Gupta', 'abhishek.gupta@university.edu', 3.53, 36, 2025),
('MT2025038', 'Riya', 'Mehta', 'riya.mehta@university.edu', 3.79, 52, 2025),
('MT2025039', 'Sameer', 'Singhal', 'sameer.singhal@university.edu', 3.66, 44, 2025),
('MT2025040', 'Kriti', 'Arora', 'kriti.arora@university.edu', 3.87, 56, 2025),
('MT2026041', 'Mohit', 'Bhardwaj', 'mohit.bhardwaj@university.edu', 3.70, 32, 2026),
('MT2026042', 'Preeti', 'Jain', 'preeti.jain@university.edu', 3.81, 36, 2026),
('MT2026043', 'Rajat', 'Bose', 'rajat.bose@university.edu', 3.63, 28, 2026),
('MT2026044', 'Tanya', 'Sethi', 'tanya.sethi@university.edu', 3.90, 40, 2026),
('MT2026045', 'Vishal', 'Dutta', 'vishal.dutta@university.edu', 3.56, 24, 2026),
('MT2026046', 'Megha', 'Kapoor', 'megha.kapoor@university.edu', 3.85, 36, 2026),
('MT2026047', 'Naveen', 'Agarwal', 'naveen.agarwal@university.edu', 3.72, 32, 2026),
('MT2026048', 'Pallavi', 'Roy', 'pallavi.roy@university.edu', 3.88, 40, 2026),
('MT2026049', 'Saurabh', 'Sharma', 'saurabh.sharma@university.edu', 3.60, 28, 2026),
('MT2026050', 'Urmila', 'Patel', 'urmila.patel@university.edu', 3.93, 40, 2026);

-- ============================================================
-- STUDENT-COURSE ENROLLMENTS (200+ enrollments)
-- ============================================================
-- Each student enrolled in multiple courses with grades
INSERT INTO student_course (student_id, course_id, academic_year, semester, grade) VALUES
-- Student 1 (MT2024001) - ML specialization
(1, 1, '2022-23', 'Fall', 'A'), (1, 2, '2022-23', 'Fall', 'A-'),
(1, 8, '2022-23', 'Spring', 'A'), (1, 9, '2023-24', 'Fall', 'A-'),
(1, 12, '2023-24', 'Fall', 'B+'), (1, 13, '2023-24', 'Spring', 'A'),
(1, 7, '2023-24', 'Spring', 'A-'), (1, 10, '2024-25', 'Fall', 'A'),

-- Student 2 (MT2024002) - Full Stack Development
(2, 1, '2022-23', 'Fall', 'A'), (2, 20, '2022-23', 'Spring', 'A'),
(2, 21, '2023-24', 'Fall', 'A-'), (2, 22, '2023-24', 'Fall', 'A'),
(2, 23, '2023-24', 'Spring', 'A'), (2, 24, '2023-24', 'Spring', 'A'),
(2, 4, '2024-25', 'Fall', 'A-'), (2, 27, '2024-25', 'Fall', 'B+'),

-- Student 3 (MT2024003) - Cybersecurity
(3, 1, '2022-23', 'Fall', 'B+'), (3, 2, '2022-23', 'Spring', 'A-'),
(3, 16, '2023-24', 'Fall', 'A'), (3, 17, '2023-24', 'Fall', 'A-'),
(3, 18, '2023-24', 'Spring', 'B+'), (3, 19, '2024-25', 'Fall', 'A'),
(3, 5, '2024-25', 'Fall', 'B+'),

-- Student 4 (MT2024004) - Data Science
(4, 1, '2022-23', 'Fall', 'A'), (4, 7, '2022-23', 'Spring', 'A'),
(4, 8, '2023-24', 'Fall', 'A-'), (4, 9, '2023-24', 'Fall', 'A'),
(4, 10, '2023-24', 'Spring', 'A-'), (4, 11, '2023-24', 'Spring', 'A'),
(4, 34, '2024-25', 'Fall', 'A'), (4, 35, '2024-25', 'Fall', 'A-'),

-- Student 5 (MT2024005) - Software Engineering
(5, 1, '2022-23', 'Fall', 'B'), (5, 2, '2022-23', 'Spring', 'B+'),
(5, 3, '2023-24', 'Fall', 'B'), (5, 5, '2023-24', 'Fall', 'B+'),
(5, 6, '2023-24', 'Spring', 'B'), (5, 39, '2024-25', 'Fall', 'B+'),

-- Continuing with more students...
-- Student 6-10
(6, 1, '2022-23', 'Fall', 'A'), (6, 13, '2022-23', 'Spring', 'A'),
(6, 14, '2023-24', 'Fall', 'A-'), (6, 15, '2023-24', 'Fall', 'A'),
(6, 12, '2023-24', 'Spring', 'A'), (6, 2, '2024-25', 'Fall', 'A-'),

(7, 1, '2022-23', 'Fall', 'B+'), (7, 4, '2022-23', 'Spring', 'A-'),
(7, 2, '2023-24', 'Fall', 'B+'), (7, 5, '2023-24', 'Spring', 'A'),
(7, 6, '2024-25', 'Fall', 'B+'), (7, 39, '2024-25', 'Fall', 'A-'),

(8, 1, '2022-23', 'Fall', 'A'), (8, 20, '2022-23', 'Spring', 'A'),
(8, 21, '2023-24', 'Fall', 'A-'), (8, 22, '2023-24', 'Fall', 'A'),
(8, 23, '2023-24', 'Spring', 'A-'), (8, 24, '2024-25', 'Fall', 'A'),

(9, 1, '2022-23', 'Fall', 'B+'), (9, 7, '2022-23', 'Spring', 'B+'),
(9, 8, '2023-24', 'Fall', 'A-'), (9, 9, '2023-24', 'Spring', 'B+'),
(9, 12, '2024-25', 'Fall', 'A-'),

(10, 1, '2022-23', 'Fall', 'A'), (10, 25, '2022-23', 'Spring', 'A-'),
(10, 26, '2023-24', 'Fall', 'A'), (10, 27, '2023-24', 'Spring', 'A'),
(10, 28, '2024-25', 'Fall', 'A-'),

-- Students 11-20
(11, 1, '2022-23', 'Fall', 'A-'), (11, 29, '2022-23', 'Spring', 'A'),
(11, 30, '2023-24', 'Fall', 'A'), (11, 31, '2023-24', 'Spring', 'A-'),
(11, 32, '2024-25', 'Fall', 'A'),

(12, 1, '2022-23', 'Fall', 'A'), (12, 8, '2022-23', 'Spring', 'A'),
(12, 9, '2023-24', 'Fall', 'A'), (12, 12, '2023-24', 'Spring', 'A-'),
(12, 13, '2024-25', 'Fall', 'A'),

(13, 1, '2022-23', 'Fall', 'B'), (13, 2, '2022-23', 'Spring', 'B+'),
(13, 3, '2023-24', 'Fall', 'B'), (13, 20, '2024-25', 'Fall', 'B+'),

(14, 1, '2022-23', 'Fall', 'A'), (14, 7, '2022-23', 'Spring', 'A-'),
(14, 8, '2023-24', 'Fall', 'A'), (14, 9, '2023-24', 'Spring', 'A'),
(14, 11, '2024-25', 'Fall', 'A-'),

(15, 1, '2022-23', 'Fall', 'B+'), (15, 20, '2022-23', 'Spring', 'A-'),
(15, 21, '2023-24', 'Fall', 'A'), (15, 22, '2024-25', 'Fall', 'A-'),

(16, 1, '2022-23', 'Fall', 'A'), (16, 13, '2022-23', 'Spring', 'A'),
(16, 14, '2023-24', 'Fall', 'A'), (16, 15, '2023-24', 'Spring', 'A'),
(16, 12, '2024-25', 'Fall', 'A'), (16, 2, '2024-25', 'Fall', 'A-'),

(17, 1, '2022-23', 'Fall', 'B'), (17, 2, '2022-23', 'Spring', 'B'),
(17, 20, '2023-24', 'Fall', 'B+'), (17, 38, '2024-25', 'Fall', 'B'),

(18, 1, '2022-23', 'Fall', 'A'), (18, 16, '2022-23', 'Spring', 'A-'),
(18, 17, '2023-24', 'Fall', 'A'), (18, 18, '2023-24', 'Spring', 'A'),
(18, 19, '2024-25', 'Fall', 'A-'),

(19, 1, '2022-23', 'Fall', 'B+'), (19, 4, '2022-23', 'Spring', 'A-'),
(19, 2, '2023-24', 'Fall', 'B+'), (19, 5, '2023-24', 'Spring', 'A'),
(19, 6, '2024-25', 'Fall', 'B+'),

(20, 1, '2022-23', 'Fall', 'A'), (20, 8, '2022-23', 'Spring', 'A'),
(20, 9, '2023-24', 'Fall', 'A-'), (20, 12, '2023-24', 'Spring', 'A'),
(20, 13, '2024-25', 'Fall', 'A'), (20, 10, '2024-25', 'Fall', 'A-'),

-- Students 21-30 (2025 batch - fewer courses)
(21, 1, '2023-24', 'Fall', 'B+'), (21, 2, '2023-24', 'Spring', 'A-'),
(21, 7, '2024-25', 'Fall', 'A'), (21, 8, '2024-25', 'Fall', 'B+'),

(22, 1, '2023-24', 'Fall', 'A-'), (22, 20, '2023-24', 'Spring', 'A'),
(22, 21, '2024-25', 'Fall', 'A'), (22, 22, '2024-25', 'Fall', 'A-'),

(23, 1, '2023-24', 'Fall', 'A'), (23, 2, '2023-24', 'Spring', 'A-'),
(23, 16, '2024-25', 'Fall', 'A'), (23, 17, '2024-25', 'Fall', 'B+'),

(24, 1, '2023-24', 'Fall', 'A'), (24, 7, '2023-24', 'Spring', 'A'),
(24, 8, '2024-25', 'Fall', 'A'), (24, 9, '2024-25', 'Fall', 'A-'),

(25, 1, '2023-24', 'Fall', 'B'), (25, 2, '2023-24', 'Spring', 'B+'),
(25, 20, '2024-25', 'Fall', 'B+'),

(26, 1, '2023-24', 'Fall', 'A'), (26, 13, '2023-24', 'Spring', 'A-'),
(26, 14, '2024-25', 'Fall', 'A'), (26, 12, '2024-25', 'Fall', 'A'),

(27, 1, '2023-24', 'Fall', 'B+'), (27, 20, '2023-24', 'Spring', 'A-'),
(27, 21, '2024-25', 'Fall', 'A'),

(28, 1, '2023-24', 'Fall', 'A'), (28, 7, '2023-24', 'Spring', 'A'),
(28, 8, '2024-25', 'Fall', 'A-'), (28, 9, '2024-25', 'Fall', 'A'),

(29, 1, '2023-24', 'Fall', 'B+'), (29, 2, '2023-24', 'Spring', 'B+'),
(29, 3, '2024-25', 'Fall', 'A-'),

(30, 1, '2023-24', 'Fall', 'A'), (30, 25, '2023-24', 'Spring', 'A-'),
(30, 26, '2024-25', 'Fall', 'A'),

-- Students 31-40
(31, 1, '2023-24', 'Fall', 'A-'), (31, 29, '2023-24', 'Spring', 'A'),
(31, 30, '2024-25', 'Fall', 'A'), (31, 31, '2024-25', 'Fall', 'A-'),

(32, 1, '2023-24', 'Fall', 'A'), (32, 8, '2023-24', 'Spring', 'A-'),
(32, 9, '2024-25', 'Fall', 'A'),

(33, 1, '2023-24', 'Fall', 'B'), (33, 2, '2023-24', 'Spring', 'B+'),
(33, 20, '2024-25', 'Fall', 'B'),

(34, 1, '2023-24', 'Fall', 'A'), (34, 7, '2023-24', 'Spring', 'A-'),
(34, 8, '2024-25', 'Fall', 'A'),

(35, 1, '2023-24', 'Fall', 'B+'), (35, 20, '2023-24', 'Spring', 'A-'),
(35, 21, '2024-25', 'Fall', 'A'),

(36, 1, '2023-24', 'Fall', 'A'), (36, 13, '2023-24', 'Spring', 'A'),
(36, 14, '2024-25', 'Fall', 'A-'), (36, 12, '2024-25', 'Fall', 'A'),

(37, 1, '2023-24', 'Fall', 'B'), (37, 2, '2023-24', 'Spring', 'B'),
(37, 38, '2024-25', 'Fall', 'B+'),

(38, 1, '2023-24', 'Fall', 'A-'), (38, 16, '2023-24', 'Spring', 'A'),
(38, 17, '2024-25', 'Fall', 'A-'),

(39, 1, '2023-24', 'Fall', 'B+'), (39, 4, '2023-24', 'Spring', 'A-'),
(39, 2, '2024-25', 'Fall', 'A'),

(40, 1, '2023-24', 'Fall', 'A'), (40, 8, '2023-24', 'Spring', 'A'),
(40, 9, '2024-25', 'Fall', 'A-'),

-- Students 41-50 (2026 batch - very few courses)
(41, 1, '2024-25', 'Fall', 'B+'), (41, 2, '2024-25', 'Fall', 'A-'),
(41, 20, '2024-25', 'Fall', 'A'),

(42, 1, '2024-25', 'Fall', 'A'), (42, 7, '2024-25', 'Fall', 'A-'),
(42, 2, '2024-25', 'Fall', 'A'),

(43, 1, '2024-25', 'Fall', 'B+'), (43, 2, '2024-25', 'Fall', 'B+'),

(44, 1, '2024-25', 'Fall', 'A'), (44, 13, '2024-25', 'Fall', 'A'),
(44, 7, '2024-25', 'Fall', 'A-'),

(45, 1, '2024-25', 'Fall', 'B'), (45, 2, '2024-25', 'Fall', 'B+'),

(46, 1, '2024-25', 'Fall', 'A'), (46, 20, '2024-25', 'Fall', 'A-'),
(46, 8, '2024-25', 'Fall', 'A'),

(47, 1, '2024-25', 'Fall', 'B+'), (47, 2, '2024-25', 'Fall', 'A-'),

(48, 1, '2024-25', 'Fall', 'A'), (48, 7, '2024-25', 'Fall', 'A'),
(48, 29, '2024-25', 'Fall', 'A-'),

(49, 1, '2024-25', 'Fall', 'B+'), (49, 2, '2024-25', 'Fall', 'B+'),

(50, 1, '2024-25', 'Fall', 'A'), (50, 13, '2024-25', 'Fall', 'A'),
(50, 14, '2024-25', 'Fall', 'A-');

-- ============================================================
-- EMPLOYEES (5 employees)
-- ============================================================
INSERT INTO employee (employee_name, email, department, employee_role) VALUES
('Dr. Rajesh Kumar', 'rajesh.kumar@university.edu', 'Computer Science', 'Professor'),
('Dr. Lakshmi Iyer', 'lakshmi.iyer@university.edu', 'Data Science', 'Associate Professor'),
('Dr. Amit Deshmukh', 'amit.deshmukh@university.edu', 'Administration', 'Dean'),
('Suresh Nambiar', 'suresh.nambiar@university.edu', 'IT Support', 'System Administrator'),
('Priya Menon', 'priya.menon@university.edu', 'Admissions', 'Coordinator');
