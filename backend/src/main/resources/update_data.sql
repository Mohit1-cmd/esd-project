-- Add more course-specialization mappings to ensure students exceed 20 credits

-- Software Engineering Specialization - add more courses
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(1, 1, 3),  -- Intro to Programming → Software Engineering
(6, 1, 2);  -- Web Technologies → Software Engineering

-- Machine Learning - add more courses  
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(16, 5, 4),  -- NLP → Machine Learning
(17, 5, 3);  -- Computer Vision → Machine Learning

-- Big Data Analytics - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(10, 6, 4),  -- ML → Big Data
(15, 6, 3);  -- AI → Big Data

-- Database Systems - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(3, 2, 3),  -- Algorithms → Database Systems
(4, 2, 2);  -- Software Engineering → Database Systems

-- Computer Vision - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(10, 10, 3);  -- ML → Computer Vision

-- Web Development - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(4, 3, 3),  -- Software Engineering → Web Development
(7, 3, 2);  -- Cloud → Web Development

-- Statistical Analysis - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(10, 7, 3),  -- ML → Statistical
(11, 7, 3),  -- Deep Learning → Statistical
(19, 7, 2);  -- Linear Algebra → Statistical

-- Deep Learning - add more coverage
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(16, 8, 3),  -- NLP → Deep Learning
(17, 8, 4);  -- Computer Vision → Deep Learning

-- Cloud Computing - add more
INSERT IGNORE INTO course_specializations (course_id, specialization_id, credits_toward_specialization) VALUES
(8, 4, 3),  -- Advanced DB → Cloud
(5, 4, 2);  -- DB Management → Cloud
