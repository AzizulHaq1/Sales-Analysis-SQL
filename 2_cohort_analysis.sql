SELECT 
	cohort_year,
	SUM(total_net_revenue) AS total_revenue,
	count(DISTINCT customerkey) AS total_customer,
	SUM(total_net_revenue)  / count(DISTINCT customerkey) AS customer_revenue
FROM  
    cohort_analysis
WHERE orderdate = first_purchase_date 
GROUP BY 
    cohort_year
