-- DISCRIPTIVE ANALYSIS OF ISTANBUL'S SHOPING MALLS 

-- PRODUCT INSIGHTS
## 1. TOP PRODUCTS BY REVENUE GENERATED
SELECT category, round(SUM(price),0) total_revenue
	FROM orders o
		JOIN payments p ON p.pay_id = o.pay_id
		GROUP BY category 
		ORDER BY SUM(price) DESC;

## 2. TOP PRODUCTS BY QUANTITY SOLD
SELECT category, SUM(quantity) total_quantity
	FROM orders o
		GROUP BY category 
		ORDER BY SUM(quantity) DESC;
	
## 3. WHAT PRODUCTS ARE WHICH GENDERS PURCHASING THE MOST?
SELECT category, gender,SUM(quantity)
	FROM orders o
		JOIN customers c ON c.customer_id = o.cust_id
        GROUP BY category, gender
        ORDER BY 1,2;
        
## 4. WHAT PRODUCTS ARE WHICH AGE GROUP PURCHAING THE MOST?
SELECT category,
	CASE WHEN age < 30 THEN 'Young Adult'
		 WHEN age < 50 THEN 'Middle Aged'
		 ELSE 'Seniors'
	END AS age_category , SUM(quantity) total_quantity
		FROM customers c
        JOIN orders o ON o.cust_id = c.customer_id
        GROUP BY 1,2
        ORDER BY 1,2 ;
	
-- CUSTOMER INSIGHTS

## 5. WHICH AGE GROUP GENERATES THEY MOST REVENUE
SELECT
	CASE WHEN age < 30 THEN 'Young Adult'
		 WHEN age < 50 THEN 'Middle Aged'
		 ELSE 'Seniors'
	END AS age_category , ROUND(SUM(price),0) revenue
		FROM customers c
        JOIN orders o ON o.cust_id = c.customer_id
        JOIN payments p ON p.pay_id = o.pay_id
        GROUP BY age_category
        ORDER BY revenue ;

## 6. WHICH PAYMENT METHOD ARE CUSTOMERS USING THE MOST?
SELECT pay_method, COUNT(pay_method) frequency
	FROM payments
    GROUP BY pay_method
    ORDER BY 2 DESC;

## 7. MOST POPUAR SHOPPING MALL
SELECT shopping_mall, COUNT(shopping_mall) frequency
	FROM orders
    GROUP BY shopping_mall
    ORDER BY 2 DESC;


    
        


