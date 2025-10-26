-- normalization tasks
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    product_id INT REFERENCES products(id)
);
SELECT * FROM customers;
INSERT INTO customers (name, email)
VALUES ('Abcd', 'abcd@gmail.com'),
       ('john', 'john@gmail.com');

INSERT INTO products (name, price)
VALUES ('Phone', 1200.00),
       ('Apple', 2.50);

INSERT INTO orders (customer_id, product_id)
VALUES (1, 1),
       (2, 2);

SELECT * FROM customers;
SELECT
    o.id AS order_id,
    c.name AS customer_name,
    c.email AS customer_email,
    p.name AS product_name,
    p.price AS product_price
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id;

CREATE TABLE order_items (
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);
ALTER TABLE customers
ADD COLUMN city TEXT,
ADD COLUMN region TEXT;

--1) customers & orders table
CREATE TABLE customers1 (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE orders1 (
    id SERIAL PRIMARY KEY,
    amount NUMERIC(10,2) NOT NULL,
    order_date DATE NOT NULL,
	customer_id INT REFERENCES customers1(id)
);
INSERT INTO customers1 (name, email)
VALUES ('Abcde', 'abcde@gmail.com'),
       ('Xyz', 'xyz@gmail.com');

INSERT INTO orders1 (amount, order_date, customer_id)
VALUES (120.50, '2025-10-01', 1),
(89.99, '2025-10-02', 1),
(45.00, '2025-10-03', 2);


--2) departments & employees
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    position TEXT,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL
);


INSERT INTO departments (name) VALUES ('HR'), ('IT');
INSERT INTO employees (name, position, department_id)
VALUES ('Kate', 'Manager', 1),
       ('Jane', 'Backend Developer', 2),
       ('Alex', 'Designer', NULL);


	  SELECT * FROM departments;
	  SELECT * FROM employees;

--3) category&products

CREATE TABLE categories (
id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

CREATE TABLE productss (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) CHECK (price >= 0),
    category_id INT REFERENCES categories(id)
);


INSERT INTO categories (name) VALUES ('Electronics'), ('Fruits');
INSERT INTO productss (name, price, category_id)
VALUES ('Phone', 1200.00, 1),
       ('Apple', 2.50, 2),
	     ('Banana', 6.50, 2),
		   ('Laptop', 20000.00, 1);

-- 4) customers, orders, order items, products
CREATE TABLE customers2 (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE products2 (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders2 (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers2(id)
);

CREATE TABLE order_items1 (
    order_id INT REFERENCES orders2(id),
    product_id INT REFERENCES products2(id),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO customers2 (name) VALUES ('Tom'), ('Jerry');
INSERT INTO products2 (name, price) VALUES ('Laptop', 1500), ('Mouse', 25);
INSERT INTO orders2 (customer_id) VALUES (1), (2);
INSERT INTO order_items1 (order_id, product_id, quantity)
VALUES (1, 1, 1), (1, 2, 2), (2, 2, 3);

	   
--5 ) facs, groups, teachers,courses, student courses tables
CREATE TABLE faculties (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    faculty_id INT REFERENCES faculties(id)
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    teacher_id INT REFERENCES teachers(id)
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    group_id INT REFERENCES groups(id)
);

CREATE TABLE student_courses (
    student_id INT REFERENCES students(id),
    course_id INT REFERENCES courses(id),
    grade INT CHECK (grade BETWEEN 1 AND 5),
    PRIMARY KEY (student_id, course_id)
);


INSERT INTO faculties (name) VALUES ('CS');
INSERT INTO groups (name, faculty_id) VALUES ('Group 1', 1);
INSERT INTO teachers (name) VALUES ('John');
INSERT INTO courses (name, teacher_id) VALUES ('java', 1);
INSERT INTO students (name, group_id) VALUES ('Kate', 1);
INSERT INTO student_courses (student_id, course_id, grade) VALUES (1, 1, 5);



--6) users, comments, posts, likes
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    created_at timestamp DEFAULT NOW()
);

CREATE TABLE likes (
user_id INT REFERENCES users(id) ON DELETE CASCADE,
post_id INT REFERENCES posts(id) ON DELETE CASCADE,
PRIMARY KEY (user_id, post_id)
);
INSERT INTO users (name, email) VALUES
('Alice', 'alice@mail.com'),
('Bob', 'bob@mail.com');


INSERT INTO posts (user_id, text) VALUES
(1, 'Hello world!'),
(2, 'comments here');


INSERT INTO comments (post_id, user_id, text) VALUES
(1, 2, 'woww!'),
(2, 1, 'Good luck!');


INSERT INTO likes (user_id, post_id) VALUES
(1, 2),
(2, 1);

