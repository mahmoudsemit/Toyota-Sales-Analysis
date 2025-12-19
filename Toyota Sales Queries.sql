use toyota;

# Data Understanding & Quality

select * from toyota;

#Total listings
SELECT COUNT(*) AS total_listings FROM toyota;

#Unique Toyota models
SELECT COUNT(DISTINCT model) AS unique_models FROM toyota;

# Missing values percentage
SELECT
SUM(price IS NULL)/COUNT(*)*100 AS price_missing_pct,
SUM(mileage IS NULL)/COUNT(*)*100 AS mileage_missing_pct,
SUM(engineSize IS NULL)/COUNT(*)*100 AS engine_missing_pct
FROM toyota;

# Duplicate listings
SELECT model, year, mileage, price, COUNT(*) AS duplicates
FROM toyota
GROUP BY model, year, mileage, price
HAVING COUNT(*) > 1;

# Price range
SELECT MIN(price) AS min_price, MAX(price) AS max_price FROM toyota;

# Invalid values
SELECT * FROM toyota
WHERE price <= 0 OR mileage < 0 OR engineSize <= 0;

# Pricing & Value Analysis
# Avg, min, max price
SELECT
AVG(price) AS avg_price,
MIN(price) AS min_price,
MAX(price) AS max_price
from toyota;

# Average price by model
SELECT model, AVG(price) AS avg_price
FROM toyota
GROUP BY model
ORDER BY avg_price DESC;

# Average price by year
SELECT year, AVG(price) AS avg_price
FROM toyota
GROUP BY year
ORDER BY year;

# Price buckets
SELECT
CASE
WHEN price < 10000 THEN 'Cheap'
WHEN price < 20000 THEN 'Mid'
ELSE 'Premium'
END AS price_bucket,
COUNT(*) AS listings
FROM toyota
GROUP BY price_bucket;

# Overpriced cars
SELECT * FROM toyota t
WHERE price > (
SELECT AVG(price) FROM toyota
WHERE model = t.model AND year = t.year
);

# Underpriced cars
SELECT * FROM toyota t
WHERE price < (
SELECT AVG(price) FROM toyota
WHERE model = t.model AND year = t.year
);

# Best value models
SELECT model, AVG(price/engineSize) AS avg_price_per_litre
FROM toyota
GROUP BY model
ORDER BY avg_price_per_litre ASC;

# Mileage & Depreciation

# Price vs mileage buckets
SELECT
CASE
WHEN mileage < 20000 THEN '<20k'
WHEN mileage < 60000 THEN '20k-60k'
ELSE '60k+'
END AS mileage_bucket,
AVG(price) AS avg_price
FROM toyota
GROUP BY mileage_bucket;

# Average mileage by model
SELECT model, AVG(mileage) AS avg_mileage
FROM toyota
GROUP BY model;

# Sharpest price drop mileage range
SELECT mileage DIV 10000 AS band, AVG(price) AS avg_price
FROM toyota
GROUP BY band
ORDER BY band;

# Value retention at high mileage
SELECT model, AVG(price) AS avg_price
FROM toyota
WHERE mileage > 80000
GROUP BY model;

# Year / Age Analysis

# Price vs age
SELECT (YEAR(CURDATE()) - year) AS age, AVG(price) AS avg_price
FROM toyota
GROUP BY age
ORDER BY age;

# Listings by year
SELECT year, COUNT(*) AS listings
FROM toyota
GROUP BY year
ORDER BY year DESC;

# Best resale by aging
SELECT model, AVG(price) AS avg_price
FROM toyota
WHERE year <= YEAR(CURDATE()) - 5
GROUP BY model;

# Engine & Performance

# Engine size vs price
SELECT engineSize, AVG(price) AS avg_price
FROM toyota
GROUP BY engineSize;

# Common engine sizes
SELECT engineSize, COUNT(*) AS count
FROM toyota
GROUP BY engineSize
ORDER BY count DESC;

# MPG vs price
SELECT mpg, AVG(price) AS avg_price
FROM toyota
GROUP BY mpg;

# Fuel Type Analysis

# Fuel type counts
SELECT fuelType, COUNT(*) AS count
FROM toyota
GROUP BY fuelType;

# Fuel type pricing
SELECT fuelType, AVG(price) AS avg_price
FROM toyota
GROUP BY fuelType;

# Hybrid trend by year
SELECT year, COUNT(*) AS hybrid_count
FROM toyota
WHERE fuelType = 'hybrid'
GROUP BY year;

# Transmission Analysis
# Transmission counts
SELECT transmission, COUNT(*) AS count
FROM toyota
GROUP BY transmission;

# Transmission pricing
SELECT transmission, AVG(price) AS avg_price
FROM toyota
GROUP BY transmission;

