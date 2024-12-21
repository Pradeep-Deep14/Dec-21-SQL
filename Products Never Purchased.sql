CREATE TABLE products (
         product_id INT, 
         product_name VARCHAR(100), 
         category_id INT, 
         manufacturer VARCHAR(100)
     );
     CREATE TABLE categories (
         category_id INT, 
         category_name VARCHAR(100)
     );
     CREATE TABLE purchases (
         purchase_id INT, 
         product_id INT
     );
     CREATE TABLE reviews (
         review_id INT, 
         product_id INT, 
         review_date DATE
     );
     INSERT INTO categories VALUES 
         (1, 'Electronics'), 
         (2, 'Home'), 
         (3, 'Toys');
     INSERT INTO products VALUES 
         (1, 'Smartwatch', 1, 'BrandA'), 
         (2, 'Camera', 1, 'BrandB'), 
         (3, 'Mixer', 2, 'BrandC'), 
         (4, 'Drone', 1, 'BrandD'), 
         (5, 'Puzzle', 3, 'BrandE');
     INSERT INTO reviews VALUES 
         (1, 1, '2023-01-01'), 
         (2, 1, '2023-02-01'), 
         (3, 3, '2023-03-01');

SELECT * FROM PRODUCTS
SELECT * FROM REVIEWS
SELECT * FROM PURCHASES
SELECT * FROM CATEGORIES

/*
Find all products that have never been purchased and include their category, manufacturer, and the last review date.
*/

--PRODUCT_NAME
--NEVER PURCHASED (PRODUCT ID IS NULL)
--CATEGORY
--MANUFACTURER
--LAST REVIEW DATE

--APPROACH 1
	
SELECT 
    p.product_name,
    p.manufacturer,
    c.category_name,
    MAX(r.review_date) AS last_review_date
FROM 
    products p
LEFT JOIN 
    reviews r ON p.product_id = r.product_id
LEFT JOIN 
    categories c ON p.category_id = c.category_id
LEFT JOIN 
    purchases pu ON p.product_id = pu.product_id
WHERE 
    pu.product_id IS NULL
GROUP BY 
    p.product_name, p.manufacturer, c.category_name;

--APPROACH 2

SELECT p.product_id, p.product_name, c.category_name, p.manufacturer, MAX(r.review_date) AS last_review_date 
     FROM products p 
     JOIN categories c ON p.category_id = c.category_id 
     LEFT JOIN purchases pu ON p.product_id = pu.product_id 
     LEFT JOIN reviews r ON p.product_id = r.product_id 
     GROUP BY p.product_id, p.product_name, c.category_name, p.manufacturer 
     HAVING COUNT(pu.purchase_id) = 0;

