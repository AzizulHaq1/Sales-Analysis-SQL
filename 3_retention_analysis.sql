
WITH customer_last_purchase AS (
SELECT 
	customerkey,
	full_name,
	orderdate,
	ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
	first_purchase_date 
FROM 
	cohort_analysis
	
)
SELECT 
    customerkey,
    full_name,
    first_purchase_date,
    orderdate AS last_purchase_date,
    CASE 
	    WHEN orderdate < (SELECT MAX(orderdate) FROM sales)- INTERVAL '6 months' THEN 'Churned'
    ELSE 'active' 
    END AS customer_status
    
FROM customer_last_purchase 

WHERE rn =1
  AND first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'