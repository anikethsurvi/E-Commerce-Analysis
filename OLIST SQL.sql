# DATA IMPORTING

use group1;

-- CREATING Olist_Customers_Dataset TABLE
create table Olist_Customers_Dataset(customer_id varchar(50), customer_unique_id varchar(50), customer_zip_code_prefix varchar(50), customer_city varchar(50), customer_state varchar(50));
select * from Olist_Customers_Dataset;
select count(*) from Olist_Customers_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Customers_Dataset.csv' INTO TABLE Olist_Customers_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- CREATING Olist_Geolocation_Dataset TABLE
create table Olist_Geolocation_Dataset(geolocation_zip_code_prefix varchar(50),geolocation_lat varchar(50), geolocation_lng varchar(50), geolocation_city varchar(50), geolocation_state varchar(50));
select * from Olist_Geolocation_Dataset;
select count(*) from Olist_geolocation_dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Geolocation_Dataset.csv' INTO TABLE Olist_Geolocation_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- CREATING Olist_Order_Items_Dataset TABLE
create table Olist_Order_Items_Dataset(order_id varchar(50), order_item_id varchar(50),	product_id varchar(50),	seller_id varchar(50),	shipping_limit_date varchar(50), price varchar(50),freight_value varchar(50));
select * from Olist_Order_Items_Dataset;
select count(*) from Olist_Order_Items_Dataset;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Order_Items_Dataset.csv' INTO TABLE Olist_Order_Items_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- CREATING Olist_Order_Payments_Dataset TABLE
create table Olist_Order_Payments_Dataset(order_id varchar(50),	payment_sequential varchar(50),	payment_type varchar(50), payment_installments varchar(50),	payment_value varchar(50));
select * from Olist_Order_Payments_Dataset;
select count(*) from Olist_Order_Payments_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Order_Payments_Dataset.csv' INTO TABLE Olist_Order_Payments_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- CREATING Olist_Order_Review_Dataset TABLE
create table Olist_Order_Review_Dataset(review_id varchar(50), order_id varchar(50), review_score varchar(50),	review_comment_title varchar(50), review_comment_message varchar(1000), review_creation_date date, review_answer_timestamp date
);
select * from Olist_Order_Review_Dataset;
select count(*) from Olist_Order_Review_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Order_Review_Dataset.csv' INTO TABLE Olist_Order_Review_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- CREATING Olist_Orders_Dataset TABLE
create table Olist_Orders_Dataset(order_id varchar(50),	customer_id varchar(50), order_status varchar(50), order_purchase_timestamp date, order_approved_at date, order_delivered_carrier_date date default NULL, order_delivered_customer_date date default Null,  order_estimated_delivery_date date
);
select * from Olist_Orders_Dataset;
select count(*) from Olist_Orders_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Orders_Dataset.csv' 
INTO TABLE Olist_Orders_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@order_id, @customer_id, @order_status, @order_purchase_timestamp, @order_approved_at, @order_delivered_carrier_date, @order_delivered_customer_date, @order_estimated_delivery_date)
SET 
    order_id = @order_id,
    customer_id = @customer_id,
    order_status = @order_status,
    order_purchase_timestamp = IF(@order_purchase_timestamp = '', NULL, STR_TO_DATE(@order_purchase_timestamp, '%Y-%m-%d')),
    order_approved_at = IF(@order_approved_at = '', NULL, STR_TO_DATE(@order_approved_at, '%Y-%m-%d')),
    order_delivered_carrier_date = IF(@order_delivered_carrier_date = '', NULL, STR_TO_DATE(@order_delivered_carrier_date, '%Y-%m-%d')),
    order_delivered_customer_date = IF(@order_delivered_customer_date = '', NULL, STR_TO_DATE(@order_delivered_customer_date, '%Y-%m-%d')),
    order_estimated_delivery_date = IF(@order_estimated_delivery_date = '', NULL, STR_TO_DATE(@order_estimated_delivery_date, '%Y-%m-%d'));

-- CREATING Olist_Products_Dataset TABLE
create table Olist_Products_Dataset(product_id varchar(50),	product_category_name varchar(50),	product_name_length varchar(50), product_description_length varchar(50), product_photos_qty varchar(50), product_weight_g varchar(50),	product_length_cm varchar(50),	product_height_cm varchar(50),	product_width_cm varchar(50)
);
select * from Olist_Products_Dataset;
select count(*) from Olist_Products_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Products_Dataset.csv' INTO TABLE Olist_Products_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- CREATING Olist_Sellers_Dataset TABLE
create table Olist_Sellers_Dataset(seller_id varchar(50), seller_zip_code_prefix varchar(50), seller_city varchar(50),	seller_state varchar(50)
);
select * from Olist_Sellers_Dataset;
select count(*) from Olist_Sellers_Dataset;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Olist_Sellers_Dataset.csv' INTO TABLE Olist_Sellers_Dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


select @@secure_file_priv;



-- card Visuals(Metrics)

-- Total unique customers 
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers 
FROM olist_customers_dataset;

-- Total Sellers
Select count(*) from olist_sellers_dataset;

-- TOTAL SALES 
SELECT ROUND(SUM(Payment_value), 2) AS total_payment 
FROM olist_order_payments_dataset;

-- Total Price
SELECT ROUND(SUM(Price), 2) AS total_price 
FROM olist_order_items_dataset;

-- Total Profit (Assumption Total Payment_value - Total Price)
SELECT 
    ROUND(
        (SELECT SUM(Payment_value) FROM olist_order_payments_dataset) - 
        (SELECT SUM(Price) FROM olist_order_items_dataset), 
    2) AS profit;


-- Average Rating 
SELECT ROUND(AVG(review_score), 2) AS average_rating 
FROM olist_order_review_dataset;


-- KPI 1 : Weekday Vs Weekend (order_purchase timestamp) payment statistics
 
 select kpi1.day_end,
	concat(round(kpi1.total_payment/(select SUM(payment_value) from olist_order_payments_dataset) * 100,2)
    , "%") AS percenatge_payment_values
    
FROM
	(select ord.day_end,sum(pmt.payment_value) AS total_payment
    FROM olist_order_payments_dataset AS pmt
    JOIN
(SELECT DISTINCT order_id,
CASE
WHEN weekday(order_purchase_timestamp) IN (5,6) THEN 'Weekend'
else 'weekday'
end as day_end
from olist_orders_dataset) as ord
on ord.order_id = pmt.order_id
group by ord.day_end) as kpi1;



-- KPI 2 : No of orders with review score 5 and payment type as credit card.
Select COUNT(pmt.order_id) as total_orders
from olist_order_payments_dataset pmt
inner join olist_order_review_dataset rev on pmt.order_id = rev.order_id
where rev.review_score = 5
and pmt.payment_type = "credit card";



-- KPI 3: No of days taken for order_delivered_customer_date for pet_shop

select
prod.product_category_name,
round(avg(datediff(ord.order_delivered_customer_date,ord.order_purchase_timestamp)),0) as avg_delivery_days
from olist_orders_dataset ord
join
(select product_id, order_id, product_category_name
from olist_products_dataset
join olist_order_items_dataset using(product_id)) as prod
on ord.order_id = prod.order_id
where prod.product_category_name = "pet shop"
group by prod.product_category_name;



-- KPI 4 : Average Price and payment values from customers of sao paulo city
WITH orderItemsAvg AS(
	SELECT round(AVG(item.price)) AS avg_order_item_price
	from olist_order_items_dataset item
	join olist_orders_dataset ord
	on item.order_id = ord.order_id
	join olist_customers_dataset cust on ord.customer_id = cust.customer_id
	where cust.customer_city = "sao paulo"
)
select
(select avg_order_item_price from orderItemsAvg) as avg_order_item_price,
round(avg(pmt.payment_value)) as avg_payment_value
from olist_order_payments_dataset pmt
join olist_orders_dataset ord on pmt.order_id = ord.order_id
join olist_customers_dataset cust on ord.customer_id = cust.customer_id
where 
cust.customer_city = "sao paulo";




-- KPI 5 : Relation ship between shipping days (delivereddate - purchasedate) Vs review Scores

select
rew.review_score,
round(avg(datediff(ord.order_delivered_customer_date, order_purchase_timestamp)),0) as "Avg Shipping Days"
From olist_orders_dataset as ord
join olist_order_review_dataset as rew on rew.order_id = ord.order_id
group by rew.review_score
order by rew.review_score;




-- THANK YOU 