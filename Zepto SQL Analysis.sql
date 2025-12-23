-- DATA EXPLORATION
-- COUNT OF ROWS
USE zeptodataset;
SELECT COUNT(*) FROM zepto;

DESCRIBE zepto;

-- SAMPLE DATA
SELECT * FROM zepto
LIMIT 10; 

-- Q1 FINDING NULL VALUES
SELECT * FROM zepto
WHERE name IS NULL
or
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- Q2 DIFFERENT PRODUCT CATEGORIES
SELECT DISTINCT category
FROM zepto
ORDER BY category; 

ALTER TABLE zepto
ADD COLUMN sku_id SERIAL first ;

SELECT * FROM zepto;

-- Q3 PRODUCTS IN STOCK VS OUT OF STOCK
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

-- Q4 PRODUCT NAMES PRESENT MULTIPLE TIMES 
SELECT name , COUNT(sku_id) AS "No of SKU_IDS"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

-- Q5 DATA CLEANING
SELECT * FROM zepto;
DELETE FROM zepto
WHERE mrp = 0 
  AND discountedSellingPrice = 0;
  
SELECT COUNT(*) AS remaining_rows
FROM zepto
WHERE mrp = 0 
  AND discountedSellingPrice = 0;



-- Q6 CONVERTING MRP FROM PAISE TO RUPEES
SELECT ROUND(mrp / 100.0, 2) AS mrp_in_rupees
FROM zepto;


-- Q7 Find the Top 10 Best-value Products based on the discount Percentage,
SELECT DISTINCT name,discountPercent 
FROM zepto
ORDER BY name DESC
LIMIT 10;




-- Q8 CALCULATE ESTIMATED REVENUE FOR EACH CATEGORY

SELECT category,SUM(discountedSellingPrice * availableQuantity) AS revenue_as_per_Category
FROM zepto
GROUP BY category
ORDER BY revenue_as_per_Category
LIMIT 10;

-- Q9 FIND ALL PRODUCTS WHERE MRP IS GREATER THAN 500 AND DISCOUNT IS LESS THAN 10%.

SELECT DISTINCT name , mrp , discountPercent FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q10 IDENTIFY THE TOP 5 CATEGORIES OFFERING THE HUGHEST AVERAGE DISCOUNT PERCENTAGE.
 SELECT category,AVG(discountPercent) AS AVG_DISCOUNT
 FROM zepto
 GROUP BY category
 ORDER BY AVG_DISCOUNT DESC 
 LIMIT 5;
 
 -- Q11 FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100G AND SORT BY BEST VALUE.
 SELECT
    name,
    weightInGms,
    mrp,
    quantity,
    availableQuantity,
    (mrp / weightInGms) AS price_per_gram
FROM
    zepto
WHERE
    weightingms > 100
ORDER BY
    price_per_gram ASC;
 
 -- Q12 GROUP THE PRODUCTS INTO CATEGORIES LIKE LOW,MEDIUM,BULK.
SELECT DISTINCT name, quantity,
CASE 
	WHEN quantity < 20 THEN 'Low'
	WHEN quantity BETWEEN 50 AND 100 THEN 'Medium'
	ELSE 'Bulk'
END AS categoriesss
FROM zepto;
 
 
 
 -- Q13 WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY
 SELECT category , SUM(weightInGms * availableQuantity) AS Total_Inventory 
 FROM zepto
 GROUP BY category
 ORDER BY Total_Inventory;
 
 
 
 
 
 