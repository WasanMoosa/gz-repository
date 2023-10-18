{{ config(schema='transaction') }}

WITH 

sales AS (SELECT * FROM {{ ref('stg_sales') }} )

  ,product AS (SELECT * FROM `gz_raw_data.raw_gz_product`)

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id 
  ###########
	-- qty --
	,s.qty 
  -- revenue --
  ,s.turnover
  -- cost --
  ,p.purchase_price
	,ROUND(s.qty*CAST(p.purchase_price AS FLOAT64),2) AS purchase_cost
	-- margin --
	,
    ROUND(s.turnover- ROUND(s.qty*CAST(p.purchase_price AS FLOAT64),2),2)
 AS product_margin
    ,
   ROUND( SAFE_DIVIDE( (s.turnover - s.qty*CAST(p.purchase_price AS FLOAT64)) , s.turnover ) , 2)
 As product_margin_percent
FROM sales s
INNER JOIN {{ref('stg_product')}} p ON s.products_id = p.products_id