 ---FIRST OF ALL CREATE TABLE  COMSUMER TABLE , SALEDATA TABLE , MARKETING CAMPAIGNS TABLE 

 --CREATE CUSTOMER TABLE 

CREATE TABLE consumer_data (
    consumer_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    income FLOAT,
    preferred_brand VARCHAR(50),
    loyalty_score INT
);

---INSERT VALUE INTO CUSTOMER TABLE 
INSERT INTO consumer_data VALUES
(1, 'John Doe', 25, 'Male', 3000, 'Brand A', 8),
(2, 'Jane Smith', 32, 'Female', 4500, 'Brand B', 7),
(3, 'Mike Johnson', 28, 'Male', 3500, 'Brand A', 9),
(4, 'Emily Davis', 40, 'Female', 7000, 'Brand C', 6),
(5, 'Chris Lee', 22, 'Male', 2500, 'Brand B', 5);

---CREATE SALEDATA TABLE

CREATE TABLE saledata (
    sales_id INT PRIMARY KEY,
    brand_name VARCHAR(50),
    product_category VARCHAR(50),
    units_sold INT,
    revenue FLOAT,
    sale_date DATE
);

--- INSERT VALUE INTO SALE TABLE 

INSERT INTO saledata VALUES
(1, 'Brand A', 'Electronics', 120, 6000, '2024-06-01'),
(2, 'Brand B', 'Apparel', 80, 3200, '2024-06-01'),
(3, 'Brand A', 'Electronics', 150, 7500, '2024-07-01'),
(4, 'Brand C', 'Home', 90, 4500, '2024-07-01'),
(5, 'Brand B', 'Apparel', 100, 4000, '2024-08-01');

----CREATE MARKETING CAMPAIGNS TABLE 

CREATE TABLE marketing_campaigns (
    campaign_id INT PRIMARY KEY,
    brand_name VARCHAR(50),
    campaign_channel VARCHAR(50),
    spend FLOAT,
    impressions INT,
    conversions INT
);

---INSERT VALUE INTO MARKETING CAMPAIGNS TABLE 

INSERT INTO marketing_campaigns VALUES
(1, 'Brand A', 'Social Media', 2000, 15000, 300),
(2, 'Brand B', 'TV', 3000, 20000, 400),
(3, 'Brand C', 'Email', 1000, 10000, 150),
(4, 'Brand A', 'TV', 2500, 18000, 350),
(5, 'Brand B', 'Social Media', 1500, 12000, 280);

--- TOP PERFORMING BRANDS BY REVENUE

SELECT brand_name, SUM(revenue) AS total_revenue
FROM saledata
GROUP BY brand_name
ORDER BY total_revenue DESC;

---Consumer Segmentation Based on Loyalty Score

SELECT preferred_brand, AVG(loyalty_score) AS avg_loyalty_score, COUNT(*) AS consumer_count
FROM consumer_data
GROUP BY preferred_brand
ORDER BY avg_loyalty_score DESC;

---Campaign Performance Metrics

SELECT brand_name, campaign_channel, SUM(spend) AS total_spend, 
       SUM(impressions) AS total_impressions, SUM(conversions) AS total_conversions
FROM marketing_campaigns
GROUP BY brand_name, campaign_channel
ORDER BY total_conversions DESC;

---Monthly Sales Trend

SELECT brand_name, 
       FORMAT(sale_date, 'yyyy-MM') AS sale_month, 
       SUM(revenue) AS total_revenue
FROM saledata
GROUP BY brand_name, FORMAT(sale_date, 'yyyy-MM')
ORDER BY sale_month;

---Consumer Demographics for Top Brands

 SELECT preferred_brand, gender, COUNT(*) AS consumer_count
FROM consumer_data
GROUP BY preferred_brand, gender
ORDER BY preferred_brand;

---Highest Revenue-Generating Product Categories by Brand

SELECT brand_name, product_category, SUM(revenue) AS total_revenue
FROM saledata
GROUP BY brand_name, product_category
ORDER BY total_revenue DESC;

---Return on Investment (ROI) for Marketing Campaigns

SELECT mc.brand_name, mc.campaign_channel, mc.spend, 
       SUM(sd.revenue) AS total_revenue,
       (SUM(sd.revenue) - mc.spend) / mc.spend AS ROI
FROM marketing_campaigns mc
JOIN saledata sd ON mc.brand_name = sd.brand_name
GROUP BY mc.brand_name, mc.campaign_channel, mc.spend
ORDER BY ROI DESC;

---Age Group Analysis for Brand Preference

SELECT preferred_brand,
       CASE 
           WHEN age BETWEEN 18 AND 25 THEN '18-25'
           WHEN age BETWEEN 26 AND 35 THEN '26-35'
           WHEN age BETWEEN 36 AND 45 THEN '36-45'
           ELSE '46+'
       END AS age_group,
       COUNT(*) AS consumer_count
FROM consumer_data
GROUP BY preferred_brand, age
ORDER BY preferred_brand, age;



---Revenue Per Unit Sold by Brand
SELECT brand_name, 
       SUM(revenue) / SUM(units_sold) AS revenue_per_unit
FROM saledata
GROUP BY brand_name
ORDER BY revenue_per_unit DESC;

---Campaign Conversion Rates

SELECT brand_name, campaign_channel, 
       SUM(impressions) AS total_impressions, 
       SUM(conversions) AS total_conversions,
       (SUM(conversions) * 100.0) / SUM(impressions) AS conversion_rate
FROM marketing_campaigns
GROUP BY brand_name, campaign_channel
ORDER BY conversion_rate DESC;

---Sales Trends by Quarter


SELECT brand_name, 
       CONCAT('Q', (MONTH(sale_date) - 1) / 3 + 1, ' ', YEAR(sale_date)) AS quarter,
       SUM(revenue) AS total_revenue
FROM saledata
GROUP BY brand_name, 
         YEAR(sale_date), 
         (MONTH(sale_date) - 1) / 3 + 1
ORDER BY YEAR(sale_date), 
         (MONTH(sale_date) - 1) / 3 + 1, 
         brand_name;

---High-Value Consumers

SELECT name, preferred_brand, income, loyalty_score
FROM consumer_data
WHERE loyalty_score >= 8 AND income >= 4000
ORDER BY income DESC, loyalty_score DESC;

---Underperforming Brands or Product Categories

SELECT brand_name, product_category, SUM(units_sold) AS total_units_sold
FROM saledata
GROUP BY brand_name, product_category
HAVING SUM(units_sold) < 100
ORDER BY total_units_sold ASC;


---Gender-Based Analysis of Brand Preference

SELECT preferred_brand, gender, COUNT(*) AS consumer_count
FROM consumer_data
GROUP BY preferred_brand, gender
ORDER BY preferred_brand, gender;

