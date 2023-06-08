/*2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg*/

     
WITH uniq_prod_2020 AS (
					SELECT 
						COUNT(DISTINCT p.product_code) AS unique_products_2020
					FROM dim_product p
					JOIN fact_sales_monthly s
					ON p.product_code = s.product_code
					WHERE s.fiscal_year = 2020),
	uniq_prod_2021 AS (
						SELECT 
							COUNT(DISTINCT p.product_code) AS unique_products_2021
						FROM dim_product p
						JOIN fact_sales_monthly s
						ON p.product_code = s.product_code
						WHERE s.fiscal_year = 2021)
SELECT 
	*,
    ROUND(((unique_products_2021 - unique_products_2020)/unique_products_2020)*100,2) AS percantage_change
FROM uniq_prod_2020
CROSS JOIN uniq_prod_2021;  