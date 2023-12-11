# EXPLORATORY-ANALYSIS-OF-ISTANBUL-SHOPpING-MALL-CUSTOMER-DATA-(SQL)
## Introduction
The main of this project is explore our customer shopping dataset to answer some busniess question and generate visualazation and insights from our dataset

## Objective
The query our data and answer Business questions to gain insights on Istanbul's product and Customers

## Product Insights

1. **TOP PRODUCTS BY REVENUE GENERATED**
    ```sql
   SELECT category, round(SUM(price),0) total_revenue
	  FROM orders o
		JOIN payments p ON p.pay_id = o.pay_id
		GROUP BY category 
		ORDER BY SUM(price) DESC;
    ```
    ![Top Products by Revenue Generated](screenshots/total_amount_spent.png)

2. **TOP PRODUCTS BY QUANTITY SOLD**
    ```sql
    SELECT category, SUM(quantity) total_quantity
	    FROM orders o
		  GROUP BY category 
		  ORDER BY SUM(quantity) DESC
    ```
    ![Quantity sold](screenshots/visit_days.png)

3. **First Item Purchased by Each Customer**
    ```sql
    SELECT customer_id, MIN(purchase_date) AS first_purchase_date, FIRST_VALUE(menu_item) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS first_purchased_item FROM sales GROUP BY customer_id;
    ```
    ![First Purchased Item](screenshots/first_purchased_item.png)

4. **Most Purchased Item and Its Frequency**
    ```sql
    SELECT menu_item, COUNT(menu_item) AS purchase_count FROM sales GROUP BY menu_item ORDER BY purchase_count DESC LIMIT 1;
    ```
    ![Most Purchased Item](screenshots/most_purchased_item.png)

5. **Most Popular Item for Each Customer**
    ```sql
    SELECT customer_id, menu_item, COUNT(menu_item) AS purchase_count FROM sales GROUP BY customer_id, menu_item ORDER BY purchase_count DESC LIMIT 1;
    ```
    ![Most Popular Item](screenshots/most_popular_item.png)

6. **First Item Purchased After Joining by Each Member**
    ```sql
    SELECT m.customer_id, m.join_date, s.menu_item FROM members m LEFT JOIN sales s ON m.customer_id = s.customer_id AND s.purchase_date > m.join_date ORDER BY m.customer_id, s.purchase_date LIMIT 1;
    ```
    ![First Item After Joining](screenshots/first_item_after_joining.png)

7. **Item Purchased Just Before Joining for Each Member**
    ```sql
    SELECT m.customer_id, m.join_date, s.menu_item FROM members m LEFT JOIN sales s ON m.customer_id = s.customer_id AND s.purchase_date < m.join_date ORDER BY m.customer_id, s.purchase_date DESC LIMIT 1;
    ```
    ![Item Before Joining](screenshots/item_before_joining.png)

8. **Total Items and Amount Spent Before Joining for Each Member**
    ```sql
    SELECT m.customer_id, COUNT(s.menu_item) AS total_items, SUM(s.amount) AS total_amount FROM members m LEFT JOIN sales s ON m.customer_id = s.customer_id AND s.purchase_date < m.join_date GROUP BY m.customer_id;
    ```
    ![Total Items Before Joining](screenshots/total_items_before_joining.png)

9. **Points Calculation Based on Spending**
    ```sql
    SELECT customer_id, SUM(amount) * 10 + CASE WHEN menu_item = 'sushi' THEN SUM(amount) ELSE 0 END * 10 AS total_points FROM sales GROUP BY customer_id, menu_item;
    ```
    ![Points Calculation](screenshots/points_calculation.png)

10. **Points Earned by Customers A and B in January**
    ```sql
    SELECT customer_id, SUM(CASE WHEN purchase_date >= '2023-01-01' AND purchase_date <= '2023-01-07' THEN amount * 10 * 2 ELSE amount * 10 END) AS total_points FROM sales WHERE customer_id IN ('A', 'B') GROUP BY customer_id;
    ```
    ![Points in January](screenshots/points_in_january.png)

## Conclusion

This documentation provides a comprehensive overview of the SQL project for Danny's Diner, including the datasets, case study questions, SQL queries, and corresponding results. The screenshots enhance the clarity of the project's execution and make it easy for the team to review and understand the findings.



## Note
For more indept exploration of our dataset and generation of insights using python click the  <a href="https://nbviewer.org/github/richieskyler/Exploratory-Analysis-of-Istanbul-Shopping-Malls-Customer-data-SQL---Python/blob/main/Customer%20Shopping%20data.ipynb">EDA using python</a> .
<br>
You can also analyse your data using the Tableau Dashboard : <a href="https://public.tableau.com/app/profile/richard.oloyede/viz/IstanbullMalls1/IstanbulMallsDashboard?publish=yes">Istanbul's Shopping Mall Dashboard</a>.
