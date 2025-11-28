-- Student Specialization System Database Schema
-- Database: esd_db

-- 1. Domains Table
CREATE TABLE IF NOT EXISTS domains (
    domain_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Specializations Table
CREATE TABLE IF NOT EXISTS specializations (
    specialization_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_id BIGINT NOT NULL,
    specialization_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id) ON DELETE CASCADE,
    UNIQUE KEY unique_spec_per_domain (domain_id, specialization_name)
);

-- 3. Students Table
CREATE TABLE IF NOT EXISTS students (
    student_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    roll_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cgpa DECIMAL(3, 2),
    total_credits INT DEFAULT 0,
    graduation_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Courses Table
CREATE TABLE IF NOT EXISTS courses (
    course_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 5. Course Specializations Mapping Table
CREATE TABLE IF NOT EXISTS course_specializations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_id BIGINT NOT NULL,
    specialization_id BIGINT NOT NULL,
    credits_toward_specialization INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE CASCADE,
    UNIQUE KEY unique_course_spec (course_id, specialization_id)
);

-- 6. Student Courses Enrollment Table
CREATE TABLE IF NOT EXISTS student_courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    academic_year VARCHAR(10) NOT NULL,
    semester VARCHAR(10),
    grade VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_course (student_id, course_id, academic_year)
);

-- 7. Employees Table (for admin access)
CREATE TABLE IF NOT EXISTS employees (
    employee_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Indexes for better query performance
CREATE INDEX idx_student_roll ON students(roll_number);
CREATE INDEX idx_student_email ON students(email);
CREATE INDEX idx_course_code ON courses(course_code);
CREATE INDEX idx_student_courses_student ON student_courses(student_id);
CREATE INDEX idx_student_courses_course ON student_courses(course_id);
CREATE INDEX idx_course_spec_course ON course_specializations(course_id);
CREATE INDEX idx_course_spec_spec ON course_specializations(specialization_id);
CREATE INDEX idx_spec_domain ON specializations(domain_id);
