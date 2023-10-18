SELECT
date_date,
paid_source,
campaign_key,
camPGN_name As campaign_name,
CAST(ads_cost AS FLOAT64) AS ads_cost,
impression,
click
FROM
`gz_raw_data.raw_gz_bing`