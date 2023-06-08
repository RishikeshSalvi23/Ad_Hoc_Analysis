/* 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
The final output contains these 
 fields, 
 division 
 product_code 
 product 
 total_sold_quantity 
 rank_order */
WITH pro AS (
				SELECT 
					p.division,
					s.product_code,
					p.product,
					SUM(s.sold_quantity) AS total_sold_quantity
				FROM dim_product p
				JOIN fact_sales_monthly s 
				ON p.product_code = s.product_code
				WHERE s.fiscal_year = 2021
				GROUP BY division, s.product_code, p.product),
	top_pro AS (SELECT *, RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) AS rnk_order
	            FROM pro)
SELECT *
FROM top_pro
WHERE rnk_order <= 3;

