## CREATE DATABASE db1;


## How many entries are not from Washington?

SELECT count(*) AS Non_WA_Vehicles FROM db1.ev_data WHERE State != 'WA';


## Number of vehicles per make

SELECT make, count(*) AS total 
FROM db1.ev_data 
GROUP BY make ORDER BY total DESC;


## Number of models per make

SELECT make, COUNT(DISTINCT model) AS model_count 
FROM db1.ev_data 
GROUP BY make 
ORDER BY model_count DESC;


## Number of vehicles for each year

SELECT `model year`, COUNT(*) AS vehicles_registered 
FROM db1.ev_data 
GROUP BY `model year` 
ORDER BY vehicles_registered DESC;


#Top 10 most popular make/model/model year combination

SELECT make, model, `model year`, COUNT(*) AS common_vehicles 
FROM db1.ev_data 
GROUP BY make, model, `model year` 
ORDER BY common_vehicles DESC
LIMIT 10;


# Top 10 most popular make/model combinations
SELECT make, model, COUNT(*) AS common_vehicles 
FROM db1.ev_data 
GROUP BY make, model
ORDER BY common_vehicles DESC
LIMIT 10;

# Vehicles with unknown CAFV due to lack of research

SELECT make, model, `model year` as year, count(*) as total_unknown_CAFV
FROM db1.ev_data
WHERE `Clean Alternative Fuel Vehicle (CAFV) Eligibility` = 
"Eligibility unknown as battery range has not been researched"
GROUP BY make, model, year
ORDER BY total_unknown_CAFV DESC;

#
WITH cte AS ( 
SELECT make, model, `model year`, count(*) as total_unknown_CAFV
FROM db1.ev_data
WHERE `Clean Alternative Fuel Vehicle (CAFV) Eligibility` = 
"Eligibility unknown as battery range has not been researched"
GROUP BY make, model, `model year`
ORDER BY total_unknown_CAFV DESC)

# How many models for each make have an unknown CAFV?
SELECT make, count(*) AS unknown_CAFVs  FROM cte 
GROUP BY make
ORDER BY unknown_CAFVs DESC;


# Which make/model combinations have the highest electric range average?
SELECT make, model, ROUND(AVG(`electric range`), 2) AS avg_range
FROM db1.ev_data
WHERE `electric range` != 0
Group BY make, model
ORDER BY avg_range DESC;


# How does the average electric range vary over the years?
SELECT `model year` as year, ROUND(AVG(`electric range`), 2) AS avg_range
FROM db1.ev_data
WHERE `electric range` != 0
Group BY year
ORDER BY avg_range DESC;

# How has the average base MSRP changed over the years?
SELECT `model year` as year, ROUND(AVG(`base MSRP`), 2) AS avg_base_msrp
FROM db1.ev_data
WHERE `base MSRP` != 0
Group BY year
ORDER BY avg_base_msrp DESC;

# What are the average base MSRPs for different make/model combinations?
SELECT make, model, ROUND(AVG(`base MSRP`), 2) AS avg_base_msrp
FROM db1.ev_data
WHERE `base MSRP` != 0
Group BY make, model
ORDER BY avg_base_msrp DESC;

# Which makes have the lowest base msrp?
SELECT make, ROUND(AVG(`base MSRP`), 2) AS avg_base_msrp
FROM db1.ev_data
WHERE `base MSRP` != 0
Group BY make
ORDER BY avg_base_msrp ASC
LIMIT 3;


# Which makes have the highest base msrp?
SELECT make, ROUND(AVG(`base MSRP`), 2) AS avg_base_msrp
FROM db1.ev_data
WHERE `base MSRP` != 0
Group BY make
ORDER BY avg_base_msrp DESC
LIMIT 3;

# Total vehicles for each electric vehicle type
SELECT `electric vehicle type`, count(*) AS total 
FROM db1.ev_data 
GROUP BY `electric vehicle type`;

# Total vehicles for each electric vehicle type over the years
SELECT `model year`, `electric vehicle type`, count(*) AS total 
FROM db1.ev_data 
GROUP BY `model year`, `electric vehicle type`
ORDER BY `model year`;

