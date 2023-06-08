/* 4.Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields, segment 
 product_count_2020 
 product_count_2021 
 difference */
WITH pro_count_2020 AS (
						SELECT 
							p.segment,
							COUNT(DISTINCT p.product_code) AS product_count_2020
						FROM dim_product p 
						JOIN fact_sales_monthly s
						ON p.product_code = s.product_code
						WHERE s.fiscal_year = 2020
						GROUP BY p.segment
						ORDER BY product_count_2020 DESC),
	pro_count_2021 AS (
						SELECT 
							p.segment,
							COUNT(DISTINCT p.product_code) AS product_count_2021
						FROM dim_product p 
						JOIN fact_sales_monthly s
						ON p.product_code = s.product_code
						WHERE s.fiscal_year = 2021
						GROUP BY p.segment
						ORDER BY product_count_2021 DESC)
SELECT a.segment, product_count_2020, product_count_2021, (product_count_2021-product_count_2020) AS Difference
FROM pro_count_2020 a
JOIN pro_count_2021 b
ON a.segment = b.segment
ORDER BY Difference DESC;
