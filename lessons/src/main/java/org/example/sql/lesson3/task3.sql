CREATE TABLE students (
   student_id INT PRIMARY KEY,
   full_name VARCHAR(100),
   age INT,
   group_id INT
);

CREATE TABLE groups (
   group_id INT PRIMARY KEY,
   group_name VARCHAR(50)
);

CREATE TABLE subjects (
   subject_id INT PRIMARY KEY,
   subject_name VARCHAR(50)
);

CREATE TABLE grades (
   grade_id INT PRIMARY KEY,
   student_id INT,
   subject_id INT,
   grade INT,
   FOREIGN KEY (student_id) REFERENCES students(student_id),
   FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

INSERT INTO groups VALUES
(1, 'Group A'),
(2, 'Group B'),
(3, 'Group C');

INSERT INTO students VALUES
(1, 'John Smith', 20, 1),
(2, 'Anna Brown', 22, 1),
(3, 'Tom Clark', 21, 2),
(4, 'Jane Doe', 23, 2),
(5, 'Lily Adams', 19, 3);

INSERT INTO subjects VALUES
(1, 'Math'),
(2, 'Physics'),
(3, 'History');

INSERT INTO grades VALUES
(1, 1, 1, 9),
(2, 1, 2, 8),
(3, 1, 3, 10),
(4, 2, 1, 7),
(5, 2, 2, 8),
(6, 3, 1, 9),
(7, 3, 3, 9),
(8, 4, 2, 10),
(9, 4, 3, 9),
(10, 5, 1, 8),
(11, 5, 2, 9);


--1
select count(*) as total_students from students;

--2
select avg(age) as avg_age from students;

--3
select min(age) as min_age,
max(age) as max_age from students;

--4
select count(*) as total_grades
from grades;

--5
select g.group_name, count(s.student_id) as student_count from groups g
left join students s on g.group_id = s.group_id
group by g.group_name;

--6
select g.group_name, avg(s.age) as avg_age
 from groups g
 left join students s on g.group_id = s.group_id
 group by g.group_name;

 --7
 select sub.subject_name, avg(g.grade) as avg_grade
 from subjects sub
 right join grades g on sub.subject_id = g.subject_id
 group by sub.subject_name;

 --8
 select count(distinct s.student_id) as student_subj
 from students s
 where not exists(
 select subject_id
 from subjects sub
 where sub.subject_id not in(
select g.subject_id
from grades g
where g.student_id = s.student_id
 )
 );


 --9
 select g.group_name, count(s.student_id) as st_count
 from groups g
 left join students s  on g.group_id = s.group_id
 group by group_name
 having count(s.student_id)>1;

 --10
 select sub.subject_name, avg(g.grade) as avg_grade
 from subjects sub
 join grades g on sub.subject_id = g.subject_id
 group by sub.subject_name
 having avg(g.grade)>8;

 --11
 select s.full_name, avg(g.grade) as avg_grade
  from students s
  join grades g on s.student_id = g.student_id
  group by s.full_name
  having avg(g.grade)>8.5;
