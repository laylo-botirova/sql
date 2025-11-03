create table departments (
    id serial primary key,
    name varchar(50)
);

create table employees (
    id serial primary key,
    name varchar(50),
    position varchar(50),
    salary numeric(10,2),
    department_id int references departments(id)
);

create table customers (
    id serial primary key,
    name varchar(50)
);

create table orders (
    id serial primary key,
    customer_id int references customers(id),
    employee_id int references employees(id),
    order_date date
);

create table products (
    id serial primary key,
    name varchar(50),
    price numeric(10,2)
);

create table order_items (
    id serial primary key,
    order_id int references orders(id),
    product_id int references products(id),
    quantity int
);
insert into departments (name) values
('IT'), ('Sales'), ('HR');

insert into employees (name, position, salary, department_id) values
('Ann', 'developer', 8000, 1),
('Lily', 'manager', 12000, 1),
('Alex', 'salesman', 6000, 2),
('Dan', 'sales manager', 11000, 2),
('Sofia', 'hr specialist', 5500, 3);

insert into customers (name) values
('customer a'), ('customer b'), ('customer c');

insert into orders (customer_id, employee_id, order_date) values
(1, 1, '2025-10-01'),
(1, 2, '2025-10-03'),
(2, 3, '2025-10-04');

insert into products (name, price) values
('laptop', 1200),
('phone', 800),
('mouse', 25),
('keyboard', 45);

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 2, 2),
(3, 3, 1);

--1
select * from employees
where salary > (select avg(salary) from employees);

--2
select * from products
where price>(select avg(price) from products);

--3
select distinct d.* from departments d
join employees e on d.id= e.department_id
where e.salary > 10000;

--4
select p.id, p.name, count(*) as total_orders
from order_items oi
join products p on oi.product_id = p.id
group by p.id, p.name
order by total_orders desc;

--5
select c.id, c.name, count(o.id) as order_count from customers c
left join orders o on c.id = o.customer_id
group by c.id, c.name;

--6
select d.id, d.name, avg(e.salary) as avg_salary from departments d
join employees e on d.id = e.department_id
group by d.id, d.name
order by avg_salary desc
limit 3;

--7
select p.id, p.name, count(*) as total_orders
from order_items oi
join products p on oi.product_id = p.id
group by p.id, p.name;

--8
select e.*
from employees e where e.salary > (select max(salary) from employees where position like '%manager%');

--9
select p.id, p.name, count(*) as total_orders
from order_items oi
join products p on oi.product_id = p.id
group by p.id, p.name
order by total_orders desc;






