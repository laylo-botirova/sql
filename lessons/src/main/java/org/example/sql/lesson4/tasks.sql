create table departments (
    id serial primary key,
    name varchar(100)
);

create table employees (
    id serial primary key,
    name varchar(100),
    surname varchar(100),
    department_id int references departments(id),
    manager_id int references employees(id),
    position varchar(50),
    salary numeric(10,2),
    phone varchar(20),
    created_at timestamp default now()
);

create table customers (
    id serial primary key,
    name varchar(100),
    phone varchar(20),
    email varchar(100)
);

create table orders (
    id serial primary key,
    employee_id int references employees(id),
    customer_id int references customers(id),
    amount numeric(10,2),
    order_date timestamp default now()
);

create table products (
    id serial primary key,
    name varchar(100),
    price numeric(10,2)
);

create table order_items (
    id serial primary key,
    order_id int references orders(id),
    product_id int references products(id),
    quantity int,
    price numeric(10,2)
);
insert into departments (name) values
('Sales'), ('IT'), ('HR');

insert into employees (name, surname, department_id, position, salary, manager_id) values
('Alice', 'Brown', 1, 'Manager', 2000, null),
('Bob', 'Smith', 1, 'Salesperson', 1500, 1),
('Charlie', 'Jones', 2, 'Developer', 1800, null),
('Diana', 'Miller', null, 'Intern', null, 3);

insert into customers (name, phone, email) values
('Emma', '+998901111111', 'emma@gmail.com'),
('Frank', '+998902222222', 'frank@gmail.com');

insert into products (name, price) values
('Laptop', 1000),
('Phone', 500),
('Mouse', 50);

insert into orders (employee_id, customer_id, amount, order_date) values
(2, 1, 1050, now() - interval '5 days'),
(3, 2, 500, now() - interval '20 days'),
(null, 1, 0, now() - interval '2 days');

insert into order_items (order_id, product_id, quantity, price) values
(1, 1, 1, 1000),
(1, 3, 1, 50),
(2, 2, 1, 500);


--1
select
e.id as employee_id,
e.name as emp_name,
coalesce(d.name, 'no department') as department_name
from employees e
left join departments d on e.department id = d.id;

--2
select
 e.name as emp_name,
 m.name as manager_name
 from employees e
 join employees m on e.manager_id = m.id;


 --3
 select
 d.name as department_name
 from departments d
 left join employees on d.id = e.department_id
 where e.id is null;

 --4

 select
 o.id as order_id,
 coalesce (e.name, 'no employee') as employee_name,
 coalesce (c.name, 'no customer') as customer_name

 from orders o
 left join employees e  on o.employee_id = e.id
 left join customers c on o.customer_id = c.id;

 --5
 select
 o.id as order_id,
 p.name as product_name,
 oi.quantity
 from orders o
 left join order_items oi  on o.id = oi.order_id
 left join products p on oi.product_id = p.id;

 --6
  select
 d.name as dep_name,
 o.id as order_id
 from departments d
 left join employees e on d.id = e.department_id
 left join orders o on e.id = o.employee_id;


--7
select
c.name as c_name,
p.name as product_name

from customers c
cross join products p
where not exists(
select 1
from orders o
join order_items oi on o.id = oi.order_id
where o.customer_id = c.id and oi.product_id = p.id
);

--8
select
p.name as product_name from products p
left join order_items oi on p.id = oi.product_id
where oi.id is null;

--9
select
m.name as m_name,
sum(o.amount ) as total_sale
from employees m
join employees e on e.manager_id = m.id
join orders o on o.employee_id = e.id
group by m.name;


--10
select
count * as total_orders,
sum(amount) as total_revenue
from orders;

--11
select
 d.name as department_name,
 avg(e.salary) as avg_salary,
 max(e.salary) as max_salary
from departments d
left join employees e on d.id = e.department_id
group by d.name;


--12
select
o.id as order_id,
sum(oi.quantity) as total_quantity,
count(distinct oi.product_id) as unique_products
from orders o
left join order_items oi on o.id = oi.order_id
group by o.id;

--13
select
p.name as product_name,
sum(oi.price * oi.quantity) as total_revenue
from order_items oi
join products p on oi.product_id = p.id
group by p.name
order by total_revenue desc
limit 3;


--14
select count(distinct customer_id) as active_customers from orders;

--15
select
d.name as department_name,
count(e.id) as employee_count,
avg(e.salary) as avg_salary,
sum(o.amount) as total_sales
from departments d
left join employees e on d.id = e.department_id
left join orders o on e.id = o.employee_id
group by d.name;

--16
select
c.name as customer_name,
avg(o.amount) as avg_customer_order
from customers c
join orders o on c.id = o.customer_id
group by c.name
having avg(o.amount) > (select avg(amount) from orders);

--17

select id,
concat(name, ' ', surname) as full_name
from employees;

--18
select id,
  to_char(order_date, 'DD.MM.YYYY HH24:MI') as formated
from orders;

--19
select * from orders where order_date < now() - interval '30 days';


--20
select id, name,
 coalesce(salary, 0) + coalesce(salary, 0) * 0.1 as bonus
 from employees;