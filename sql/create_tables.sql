-- ============================================
-- CPEN 208 SOFTWARE ENGINEERING PROJECT
-- Student Management System
-- ============================================

-- Create Schema
CREATE SCHEMA IF NOT EXISTS university;

-- ============================================
-- STUDENT TABLE
-- ============================================

CREATE TABLE university.student (
    student_id VARCHAR(15) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    level INT,
    programme VARCHAR(100),
    total_fees DECIMAL(10,2) NOT NULL
);

-- ============================================
-- COURSE TABLE
-- ============================================

CREATE TABLE university.course (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    semester INT NOT NULL
);

-- ============================================
-- LECTURER TABLE
-- ============================================

CREATE TABLE university.lecturer (
    lecturer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    office VARCHAR(50)
);

-- ============================================
-- TEACHING ASSISTANT TABLE
-- ============================================

CREATE TABLE university.teaching_assistant (
    ta_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- ============================================
-- ENROLLMENT TABLE
-- ============================================

CREATE TABLE university.enrollment (
    enrollment_id SERIAL PRIMARY KEY,

    student_id VARCHAR(15),

    course_id INT,

    semester INT,

    academic_year VARCHAR(20),

    CONSTRAINT fk_student
        FOREIGN KEY(student_id)
        REFERENCES university.student(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_course
        FOREIGN KEY(course_id)
        REFERENCES university.course(course_id)
        ON DELETE CASCADE
);

-- ============================================
-- FEE PAYMENT TABLE
-- ============================================

CREATE TABLE university.fee_payment (

    payment_id SERIAL PRIMARY KEY,

    student_id VARCHAR(15),

    amount_paid DECIMAL(10,2) NOT NULL,

    payment_date DATE,

    semester INT,

    academic_year VARCHAR(20),

    CONSTRAINT fk_payment_student
        FOREIGN KEY(student_id)
        REFERENCES university.student(student_id)
        ON DELETE CASCADE
);

-- ============================================
-- LECTURER COURSE ASSIGNMENT
-- ============================================

CREATE TABLE university.lecturer_course (

    assignment_id SERIAL PRIMARY KEY,

    lecturer_id INT,

    course_id INT,

    CONSTRAINT fk_assignment_lecturer
        FOREIGN KEY(lecturer_id)
        REFERENCES university.lecturer(lecturer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_assignment_course
        FOREIGN KEY(course_id)
        REFERENCES university.course(course_id)
        ON DELETE CASCADE
);

-- ============================================
-- LECTURER TA ASSIGNMENT
-- ============================================

CREATE TABLE university.lecturer_ta (

    assignment_id SERIAL PRIMARY KEY,

    lecturer_id INT,

    ta_id INT,

    CONSTRAINT fk_lt_lecturer
        FOREIGN KEY(lecturer_id)
        REFERENCES university.lecturer(lecturer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_lt_ta
        FOREIGN KEY(ta_id)
        REFERENCES university.teaching_assistant(ta_id)
        ON DELETE CASCADE
);