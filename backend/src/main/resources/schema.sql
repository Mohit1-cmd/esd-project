-- Student Specialization System Database Schema
-- Database: esd_db
-- IMPORTANT: Table names match JPA Entity names (singular)

-- 1. Domain Table
CREATE TABLE IF NOT EXISTS domain (
    domain_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Specialization Table
CREATE TABLE IF NOT EXISTS specialization (
    specialization_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    domain_id BIGINT NOT NULL,
    specialization_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (domain_id) REFERENCES domain(domain_id) ON DELETE CASCADE,
    UNIQUE KEY unique_spec_per_domain (domain_id, specialization_name)
);

-- 3. Student Table
CREATE TABLE IF NOT EXISTS student (
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

-- 4. Course Table
CREATE TABLE IF NOT EXISTS course (
    course_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 5. Course Specialization Mapping Table
CREATE TABLE IF NOT EXISTS course_specialization (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_id BIGINT NOT NULL,
    specialization_id BIGINT NOT NULL,
    credits_toward_specialization INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id) ON DELETE CASCADE,
    UNIQUE KEY unique_course_spec (course_id, specialization_id)
);

-- 6. Student Course Enrollment Table
CREATE TABLE IF NOT EXISTS student_course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    academic_year VARCHAR(10) NOT NULL,
    semester VARCHAR(10),
    grade VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_course (student_id, course_id, academic_year)
);

-- 7. Employee Table (for admin access)
CREATE TABLE IF NOT EXISTS employee (
    employee_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL,
    employee_role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 8. User Table (for OAuth authentication)
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    picture_url VARCHAR(255),
    provider VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Indexes for better query performance
CREATE INDEX idx_student_roll ON student(roll_number);
CREATE INDEX idx_student_email ON student(email);
CREATE INDEX idx_course_code ON course(course_code);
CREATE INDEX idx_student_course_student ON student_course(student_id);
CREATE INDEX idx_student_course_course ON student_course(course_id);
CREATE INDEX idx_course_spec_course ON course_specialization(course_id);
CREATE INDEX idx_course_spec_spec ON course_specialization(specialization_id);
CREATE INDEX idx_spec_domain ON specialization(domain_id);
