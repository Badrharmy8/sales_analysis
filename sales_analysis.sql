-- show all data
select * 
from facts; 

select distinct(DATEDIFF(day , shipping_date , due_date))
from facts; -- difference for delivery for all orders is 5 days

select distinct(DATEDIFF(day , order_date , shipping_date))
from facts; -- difference for shipping all orders is 7 days

-- clean null order dates
update facts
set order_date =DATEADD(day , -7 , shipping_date)
where order_date is null;

-- sales for each month
select year(order_date) as year , 
	month(order_date) as month,
	count(distinct(order_number)) as total_orders,
	sum(quantity) as total_quantity,
case 
	when sum(quantity) - count(distinct(order_number))  > 0 then 'Profit from order count'
	when sum(quantity) - count(distinct(order_number))  < 0 then 'Profit from quantity count'
	when sum(quantity) - count(distinct(order_number))  = 0 then 'Profit from both order and quantity count'
end as profit_driver,
	sum(sales_amount) as total_sales,
	lag(sum(sales_amount)) over(partition by year(order_date) order by year(order_date)) as previos_sales,
	sum(sales_amount) + 
		isnull(lag(sum(sales_amount)) over(partition by year(order_date) order by year(order_date)), 0) as running_sales
from facts
group by year(order_date) , month(order_date) 
order by year(order_date) , month(order_date);

-- Customer Performance
select customer_key, 
	count(distinct(order_number)) as customer_orders,
	sum(sales_amount) as customer_sales
from facts
group by customer_key
order by customer_sales desc , customer_orders desc;

-- all data from facts and products
select * 
from facts f join products p
on f.product_key = p.product_key;

-- products progress
select p.product_name as product,
	datetrunc(month ,f.order_date) as date,
	count(distinct(order_number)) product_orders,
	sum(f.sales_amount) as product_sales ,
	avg(f.sales_amount) as sales_average,
case
	when sum(f.sales_amount) > avg(f.sales_amount) then 'Above Average'
	when sum(f.sales_amount) < avg(f.sales_amount) then 'Below Average'
	else 'In Average'
end as avg_progress
from facts f join products p
on f.product_key = p.product_key
group by p.product_name, datetrunc(month ,f.order_date)
order by product;

