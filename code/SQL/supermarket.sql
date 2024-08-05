CREATE DATABASE db;

SELECT * FROM db.market;

# How often is each payment type used?
SELECT payment, 
ROUND((COUNT(*)/(SELECT COUNT(*) FROM db.market)) * 100, 2) AS pct_payment 
FROM db.market GROUP BY payment;

#What are the top 10 totals?
SELECT *
FROM db.market ORDER BY total DESC Limit 10;

#How often is each payment type used when over $500 is spent?
SELECT payment, 
ROUND((COUNT(*)/(SELECT COUNT(*) FROM db.market WHERE total > 500)) * 100, 2) AS pct_payment_500 
FROM db.market WHERE total > 500 GROUP BY payment;

# does one gender tend to be a member more than another?
SELECT gender, `customer type`, 
ROUND((COUNT(*)/(SELECT COUNT(*) FROM db.market)) * 100, 2) AS customer_type_percent 
FROM db.market GROUP BY gender, `customer type`;

# How does the total expenditure vary for gender and customer types?
SELECT gender, `customer type`, ROUND(SUM(total), 2) as total 
FROM db.market GROUP BY gender, `customer type`;

# Do certain cities have more member customers?
SELECT city, `customer type`, COUNT(*) FROM db.market
GROUP BY city, `customer type` ORDER BY city;

# How do product lines compare in terms of revenue?
SELECT `product line`, ROUND(SUM(total),2) AS total FROM db.market
GROUP BY `product line` ORDER BY total DESC;

# How do cities compare in terms of revenue?
SELECT city, ROUND(SUM(total),2) AS total FROM db.market
GROUP BY city ORDER BY total DESC;

# How do branches compare in terms of revenue?
SELECT branch, ROUND(SUM(total),2) AS total FROM db.market
GROUP BY branch ORDER BY total DESC;

# How does the average rating compare in each city? Are the ratings different by gender?
SELECT city, gender, ROUND(AVG(rating),2) AS avg_rating FROM db.market
GROUP BY city, gender ORDER BY avg_rating DESC;

# Checking overall rating for each gender?
SELECT gender, ROUND(AVG(rating),2) AS avg_rating FROM db.market
GROUP BY gender ORDER BY avg_rating DESC;

#Checking overall rating for each branch?
SELECT branch, ROUND(AVG(rating),2) AS avg_rating FROM db.market
GROUP BY branch ORDER BY avg_rating DESC;

#How many items on average are purchased in a single transaction for each product line?
SELECT `product line`, ROUND(AVG(quantity),2) AS avg_quantity FROM db.market
GROUP BY `product line`;

#Does the average quantity vary for different genders?
SELECT `product line`, gender, ROUND(AVG(quantity),2) AS avg_quantity FROM db.market
GROUP BY `product line`, gender ORDER BY avg_quantity DESC;

#Average quantity for shoppers who spent over $500
SELECT AVG(quantity) as avg_quantity, gender
FROM db.market WHERE (total > 500) GROUP BY gender


