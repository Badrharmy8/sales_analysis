📊 Sales Data Analysis Project
This project presents an analysis of sales data using a fact table and related product data.

## 🗂️ Dataset Description
The dataset includes:
- **Fact Table**: Contains sales transactions with columns
   'order_number'
   'product_key'
   'customer_key'
   'order_date'
   'shipping_date'
   'due_date'
   'sales_amount'
   'quantity'
    'price'.
- **Product Table**: Contains product details
  'product_key'
   'product_id'
   'product_number'
   'product_name'
   'category_id'
   'category'
   'subcategory'.

 ## 🛠️ Tools & Technologies
- **Microsoft SQL Server**

 ## 📈 Key Analyses Performed
### 1. 📅 **Monthly Sales Overview** 
Calculates monthly metrics such as:
- Total number of orders
- Total quantity sold
- Total sales
- Profit driver (`order-driven` vs `quantity-driven`)
- Previous month's sales using `LAG()`

  ### 2. 👥 **Customer Performance**
Measures:
- Total number of distinct orders per customer
- Total sales per customer
- Ranks customers by total revenue and order frequency

  ### 3. 📦 **Product Progress Analysis**
Tracks each product's monthly performance:
- Number of orders
- Total sales
- Average sales amount
- Classifies performance as:
  - "Above Average"
  - "Below Average"
  - "In Average"
- Running total sales (month + previous)
