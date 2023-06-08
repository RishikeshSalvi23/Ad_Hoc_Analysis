/* 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?  
The final output  contains these fields, 
 channel 
 gross_sales_mln 
 percentage */
WITH channel_dist AS (
						SELECT 
							c.channel,
							ROUND((SUM(g.gross_price*s.sold_quantity/1000000)),2) AS gross_sales_mln
						FROM dim_customer c
						JOIN fact_sales_monthly s
						ON c.customer_code = s.customer_code
						JOIN fact_gross_price g
						ON s.product_code = g.product_code
						WHERE s.fiscal_year = 2021
						GROUP BY c.channel)
SELECT 
	channel,
    gross_sales_mln,
    gross_sales_mln*100/SUM(gross_sales_mln)  OVER() AS distribution_percentage
FROM channel_dist
GROUP BY channel
ORDER BY gross_sales_mln DESC;