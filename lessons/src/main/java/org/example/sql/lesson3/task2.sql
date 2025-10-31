CREATE TABLE students (
                         student_id SERIAL PRIMARY KEY,
                         first_name VARCHAR(50) NOT NULL,
                         last_name VARCHAR(50) NOT NULL,
                         birth_date DATE NOT NULL,
                         email VARCHAR(100) UNIQUE,
                         group_id INT NOT NULL
);
--insert students
INSERT INTO students (first_name, last_name, birth_date, email, group_id)
VALUES
('John', 'Smith', '1999-02-01', 'john1@gmail.com', 1),
('Anna', 'Brown', '2000-02-01', 'anna.brown@gmail.com', 2),
('Carol', 'Doe', '1999-02-01', 'carol.doe@gmail.com', 2),
('John', 'Smith', '1999-02-01', 'john2@gmail.com', 3),
('Jane', 'Mayer', '2001-06-05', 'jane.mayer@gmail.com', 1),
('Linnet', 'Doe', '2000-08-05', 'linnet.doe@gmail.com', 2);

--find and delete duplicates

select first_name, last_name,
count(*) as dup_count
from students
group by first_name, last_name
having count(*)>1;

delete from students
where student_id NOT IN(
select min(student_id)
from students
group by first_name, last_name);
select * from student order by student_id;


