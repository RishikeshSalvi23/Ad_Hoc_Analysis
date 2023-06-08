/* 7. Get the complete report of the Gross sales amount for the customer  “Atliq Exclusive”  for each month. 
 This analysis helps to  get an idea of low and high-performing months and take strategic decisions. 
 The final report contains these columns: 
 Month 
 Year 
 Gross sales Amount */
SELECT 
	CONCAT(MONTHNAME(s.date), '(', YEAR(s.date), ')') AS Month,
    s.fiscal_year AS fiscal_year,
    ROUND((SUM(g.gross_price*s.sold_quantity)),2) AS gross_sales_amount
FROM dim_customer c
JOIN fact_sales_monthly s
ON c.customer_code = s.customer_code
JOIN fact_gross_price g
ON s.product_code = g.product_code
WHERE c.customer = 'Atliq Exclusive'
GROUP BY Month, fiscal_year
ORDER BY fiscal_year;