create database onln_shopping;
use onln_shopping;
show tables;

create table categories(cat_id int primary key, cat_name varchar(50), cat_type varchar(50)); 
create table customers(cust_id int primary key, cust_name varchar(30), contact bigint, address varchar(30)); 
create table products(prod_id int primary key, cat_id int, prod_name varchar(50),
foreign key(cat_id) references categories(cat_id));       
create table sh_order(ord_id varchar(30) primary key, cust_id int, ord_date date,
foreign key(cust_id) references customers(cust_id));                                            
create table deliveries(del_id varchar(30) primary key, cust_id int, del_date date, 
foreign key(cust_id) references customers(cust_id));                                         
create table seller (sel_id int primary key, prod_id int, sel_name varchar(50), 
foreign key(prod_id) references products(prod_id));                                                
create table payment(pay_id varchar(30) primary key, cat_id int, pay_date date, 
foreign key(cat_id) references categories(cat_id));          
create table transactions(report_id int primary key, cust_id int, ord_id varchar(30), prod_id int, pay_id varchar(30),
foreign key(cust_id) references customers(cust_id), foreign key(ord_id) references sh_order(ord_id), 
foreign key(pay_id) references payment(pay_id), foreign key(prod_id) references products(prod_id));
                                            

insert into categories values
(101, 'mobiles', 'electronics'),
(102, 'kitchen', 'home_appliances'),
(103, 'womens', 'Beauty_Products'),
(104, 'sofaset', 'furniture'),
(105, 'toy', 'kids'),
(106, 'kitchen', 'groceries'),
(107, 'TV', 'electronics'),
(108, 'bed', 'furniture'),
(109, 'mens', 'Beauty_Products'),
(110, 'clothes', 'kids');
select * from categories;

insert into products values 
(1,101, 'vivo_Y17s'),
(2,102,'bajaj_rex_500W'),
(3,103,'lakme_lipstic'),
(4,104,'furney_arvon_sofa'),
(5,105,'teddy_bear'),
(6,106,'vim_liquid_gel'),
(7,107,'MI_80_32inch'),
(8,108,'wakefit_bed'),
(9,109,'dove_shampoo'),
(10,110,'satin_frock');
select * from products;

insert into customers values
(1125, 'john', 5687456859, 'mumbai'),
(1023, 'ajay', 9586425789, 'punjab'),
(1205, 'rishi', 9856247523, 'kerla'),
(1056, 'rahul', 9856427518, 'mumbai'),
(1435, 'sidhi', 9875214586, 'pune'),
(1047, 'ritu', 8952416357, 'pune'),
(1235, 'sneha', 8563154795, 'mumbai'),
(1582, 'atul', 9856321456, 'pune');
select * from customers;

insert into sh_order values
('o10001', 1056, '2023-08-15'),
('o10002', 1125, '2023-02-25'),
('o10003', 1205, '2023-05-06'),
('o10004', 1435, '2023-10-07'),
('o10005', 1235, '2023-08-10'),
('o10006', 1023, '2023-06-06'),
('o10007', 1582, '2023-08-25');
select * from sh_order;


insert into deliveries values
('D10001', 1056, '2023-08-20'),
('D10002', 1125, '2023-02-28'),
('D10003', 1205, '2023-05-10'),
('D10004', 1435, '2023-10-12'),
('D10005', 1235, '2023-08-15'),
('D10006', 1023, '2023-06-11'),
('D10007', 1582, '2023-08-30');
select *  from deliveries;

insert into payment values
('P10001', 105, '2023-08-20'),
('P10002', 104, '2023-02-28'),
('P10003', 102, '2023-05-10'),
('P10004', 103, '2023-10-12'),
('P10005', 106, '2023-08-15'),
('P10006', 101, '2023-06-11'),
('P10007', 109, '2023-08-30');
select * from payment;

insert into seller values
(11, 1, 'vivo'),
(12, 2, 'bajaj'),
(13, 3, 'lakme'),
(14, 4, 'retailez'),
(15, 5, 'store'),
(16, 6, 'vim'),
(17, 7, 'MI'),
(18, 8, 'innov'),
(19, 9, 'dove'),
(20, 10, 'buy_try');
select * from products;

insert into transactions values
(1001, 1125, 'o10002', 4, 'P10002'),
(1002, 1023, 'o10006', 1, 'P10006'),
(1003, 1205, 'o10003', 2, 'P10003'),
(1004, 1056, 'o10001', 5, 'P10001'),
(1005, 1435, 'o10004', 3, 'P10004'),
(1006, 1235, 'o10005', 6, 'P10005'),
(1007, 1582, 'o10007', 9, 'P10007');
select * from transactions;


# find custome who placed order for teddy bear;
select cust_name from customers where cust_id = 
(select cust_id from transactions where prod_id=
(select prod_id from products where prod_name= 'teddy_bear'));

# find customers who placed order for teddy bear;
select cust_name from customers where cust_id = 
(select cust_id from transactions where prod_id=
(select prod_id from products where prod_name= 'lakme_lipstic'));

select cust_name from customers where cust_name like 's%';

# find total orders placed for all categories till date
select t.ord_id, t.prod_id, p.prod_name, c.cat_name, o.ord_date, count(o.ord_id) as count
from transactions t inner join sh_order o
on  t.ord_id = o.ord_id inner join products p 
on t.prod_id= p.prod_id inner join categories c
on p.cat_id = c.cat_id
where ord_date <= date(now())
group by prod_name;
# group by cat_name;






