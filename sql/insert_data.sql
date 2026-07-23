-- ============================================
-- COURSES
-- ============================================

INSERT INTO university.course (course_code, course_name, credit_hours, semester)
VALUES
('CPEN204', 'Data Structures and Algorithms', 3, 1),
('CPEN206', 'Digital Systems II', 3, 1),
('CPEN208', 'Software Engineering', 3, 1),
('CPEN210', 'Database Systems', 3, 1),
('MATH202', 'Engineering Mathematics II', 3, 1);

-- ============================================
-- LECTURERS
-- ============================================

INSERT INTO university.lecturer (first_name,last_name,email,office)
VALUES
('Kwame','Mensah','kwame.mensah@ug.edu.gh','ENG201'),
('Ama','Boateng','ama.boateng@ug.edu.gh','ENG205'),
('Kojo','Asare','kojo.asare@ug.edu.gh','ENG210'),
('Linda','Owusu','linda.owusu@ug.edu.gh','ENG212'),
('Samuel','Addo','samuel.addo@ug.edu.gh','ENG220');

-- ============================================
-- TEACHING ASSISTANTS
-- ============================================

INSERT INTO university.teaching_assistant (first_name,last_name,email)
VALUES
('Alice','Mensah','alice@ug.edu.gh'),
('David','Owusu','david@ug.edu.gh'),
('Michael','Asante','michael@ug.edu.gh'),
('Ruth','Ofori','ruth@ug.edu.gh'),
('Grace','Antwi','grace@ug.edu.gh');

-- ============================================
-- LECTURER → COURSE ASSIGNMENT
-- ============================================

INSERT INTO university.lecturer_course (lecturer_id,course_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- ============================================
-- LECTURER → TA ASSIGNMENT
-- ============================================

INSERT INTO university.lecturer_ta (lecturer_id,ta_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

INSERT INTO university.enrollment
(student_id,course_id,semester,academic_year)

SELECT
student_id,
course_id,
1,
'2025/2026'
FROM university.student
CROSS JOIN university.course;

INSERT INTO university.fee_payment
(student_id,amount_paid,payment_date,semester,academic_year)
SELECT
student_id,
CASE
WHEN RANDOM()<0.25 THEN 5000
WHEN RANDOM()<0.50 THEN 3500
WHEN RANDOM()<0.75 THEN 2000
ELSE 1000
END,
CURRENT_DATE,
1,
'2025/2026'
FROM university.student;