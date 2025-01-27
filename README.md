OBJECTIVE

As a data analyst for Olist Store Analysis, provide insights on key aspects of e-commerce performance and customer behavior to support decision-making.
Weekday vs Weekend Performance: Total number of orders comparison and Average payment value for orders.
High Review Scores and Payment Method: Total number of orders with a review score of 5 and payment type as credit card.
Delivery Performance: Average number of days taken for order delivery (customer's perspective) for pet_shop.
City-Based Insights: Average price and payment values from customers in São Paulo.
Shipping Days vs Review Scores:Analyze the relationship between shipping days (calculated as the difference between order_delivered_customer_date and order_purchase_timestamp) and review scores.

DOMAIN KNOWLEDGE

In the e-commerce domain, revenue generation typically follows several key mechanisms. Here’s a breakdown of how money flows in an e-commerce business:
Sales Revenue: Olist earns a commission on products sold by third-party sellers.
Transaction Fees: A fee for processing payments on each sale.
Advertising: Sellers pay for better visibility (sponsored listings) and third-party ads.
Affiliate Marketing: Influencers earn commissions for driving sales.
Shipping Fees: Olist charges for logistics and shipping.
Subscription Models: Premium seller accounts or buyer memberships.
Returns & Refunds: Olist may charge for processing returns or restocking.

DATA KNOWLEDGE

Customers_Dataset Table(99441 rows)
•	customer_id: Unique identifier for each customer.
•	customer_unique_id: A unique, anonymized ID for the customer.
•	customer_zip_code_prefix: Postal code prefix of the customer's address.
•	customer_city: City where the customer resides.
•	customer_state: State where the customer resides.

Geolocation_Dataset Table(738332 rows)
•	geolocation_zip_code_prefix: Zip code prefix linked to geolocation data.
•	geolocation_lat: Latitude of the location.
•	geolocation_lng: Longitude of the location.
•	geolocation_city: City associated with the location.
•	geolocation_state: State associated with the location.

Order_Items_Dataset Table(112650 rows)
•	order_id: Unique identifier for each order.
•	order_item_id: Unique identifier for each order item.
•	product_id: Unique identifier for each product in the order.
•	seller_id: ID of the seller fulfilling the order.
•	shipping_limit_date: Last date for shipping the order.
•	price: Price of the product.
•	freight_value: Shipping cost for the order.

Order_Payments_Dataset Table(103886 rows)
•	order_id: Unique identifier for the order.
•	payment_sequential: Sequential order of payments for the order.
•	payment_type: Type of payment (e.g., credit card, boleto).
•	payment_installments: Number of installments in the payment.
•	payment_value: Total payment amount.

Order_Review_Dataset Table(99224 rows)
•	review_id: Unique identifier for each review.
•	order_id: Unique identifier for the related order.
•	review_score: Rating given by the customer (1-5).
•	review_comment_title: Title of the review comment.
•	review_comment_message: Detailed review message.
•	review_creation_date: Date when the review was created.
•	review_answer_timestamp: Time when the review was answered by the seller.

Orders_Dataset Table(99441 rows)
•	order_id: Unique identifier for the order.
•	customer_id: Unique identifier for the customer placing the order.
•	order_status: Current status of the order (e.g., delivered, cancelled).
•	order_purchase_timestamp: Timestamp when the order was placed.
•	order_approved_at: Timestamp when the order was approved.
•	order_delivered_carrier_date: Date when the carrier delivered the order.
•	order_delivered_customer_date: Date when the customer received the order.
•	order_estimated_delivery_date: Estimated delivery date.

Product_Category_Name_Translation Table(71)
•	product_category_name: Category name in the original language.
•	product_category_name_english: English translation of the category name.

Products_Dataset Table(32951 rows)
•	product_id: Unique identifier for each product.
•	product_category_name: Category of the product.
•	product_name_length: Length of the product's name.
•	product_description_length: Length of the product description.
•	product_photos_qty: Number of photos associated with the product.
•	product_weight_g: Weight of the product in grams.
•	product_length_cm: Length of the product in centimeters.
•	product_height_cm: Height of the product in centimeters.
•	product_width_cm: Width of the product in centimeters.

Seller_Dataset Table(3095 rows)
•	seller_id: Unique identifier for each seller.
•	seller_zip_code_prefix: Postal code prefix of the seller's address.
•	seller_city: City where the seller is located.
•	seller_state: State where the seller is located.

DATA CLEANING

Customers_Dataset
•	Checked for null values.
•	Capitalized each word in the customer_city column.
•	Removed duplicate rows.
•	Checked and corrected data types.

Geolocation_Dataset
•	Checked for null values.
•	Removed duplicate rows.
•	Checked and corrected data types.
•	Standardized the geolocation_city column by changing all variations of "Sao Paulo" to a single consistent format (e.g., "São Paulo").

Order_Items_Dataset
•	Checked and corrected data types.
•	Removed duplicate rows.
•	Checked for null values.

Order_Payments_Dataset
•	Checked and corrected data types.
•	Removed duplicate rows.
•	Checked for null values.
•	Cleaned the payment_type column by:
o	Replacing underscores ("_") with spaces (" ").
o	Capitalizing each word.

Order_Review_Dataset
•	Checked and corrected data types.
•	Removed duplicate rows.
•	Checked for null values in review_comment_title and review_comment_message columns.
•	Replaced null values with "No Title" and "No Message", respectively.

 Orders_Dataset
•	Capitalized each word in the order_status column.
•	Removed duplicate rows.
•	Checked and corrected data types.
•	Checked for null values in order_delivered_carrier_date and order_delivered_customer_date.
•	Retained null values for potential future analysis.

 Product_Category_Name_Translation
•	Used the first row as headers.
•	Removed duplicate rows.
•	Checked and corrected data types.
•	Checked for null values.
•	Cleaned both columns by replacing underscores ("_") with spaces (" ") and capitalizing each word.

Products_Dataset
•	Removed duplicate rows.
•	Checked and corrected data types.
•	Corrected the header names for name_length and description_length (corrected spelling errors).
•	Replaced null values in product_name_length and product_description_length with 0.
•	Cleaned the product_category_name column by:
o	Replacing underscores ("_") with spaces (" ").
o	Replacing null values with "Unknown".
o	Capitalizing each word.

Seller_Dataset
•	Removed duplicate rows.
•	Checked for null values.
•	Checked and corrected data types.
•	Standardized the seller_city column by replacing the value "04482258" with "Rio De Janeiro" based on zip_code and seller_state information.
•	Capitalized each word in the seller_city column.
•	Standardized the seller_city column by changing all variations of "Sao Paulo" to a single consistent format (e.g., "São Paulo").


RELATIONSHIPS(JOINS)

Step 1 :
Merge Olist_products_dataset (column : product_category_name) & product_category_name_Translation(column:product_category_name)

Step 2:
Remove duplicates from geolocation table with column “geolocation_zip_code_prefix” for establishing a relationship.

Step 3: 
Create Date Table and join it with order_approved_date column in orders_dataset.
 
DO VISIT THE INTERACTIVE DASHBOARD
THANKS 😊


