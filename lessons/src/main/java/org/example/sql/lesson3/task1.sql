
CREATE TABLE sales (
   id SERIAL PRIMARY KEY,
   region VARCHAR(20),
   amount BIGINT,
   sale_date DATE
);

INSERT INTO sales (region, amount, sale_date) VALUES
('North', 1000, '2024-01-01'),
('South', 700, '2024-01-02'),
('North', 500, '2024-01-03'),
('West', NULL, '2024-01-04'),
('South', 900, '2024-01-05'),
('North', 1500, '2024-01-06');


--sum of sales by region
select region, sum(amount) as total
from sales
group by region;

--avg by region
select region , AVG(amount) as avg_s
from sales
group by region having count(*)>1;

--max sales region
select region , sum(amount) as total_s
from sales
group by region
order by total_s desc
limit 1;

--total sales count with not null amount
select
count(*) as totalCount,
count(*) filter (where amount is not null) as nonNullCount
from sales;

-- regions  with above the average sales
select region, sum(amount) as total_s
from sales
 group by region
having sum(amount)>(
select avg(amount) from sales
);

