WITH
  province_tax AS (
    SELECT
      state.CountryRegionCode,
      state.StateProvinceID,
      MAX(tax.TaxRate) AS max_tax_rate
    FROM
      `tc-da-1.adwentureworks_db.stateprovince` AS state
    LEFT JOIN
      `tc-da-1.adwentureworks_db.salestaxrate` AS tax
    ON
      state.StateProvinceID = tax.StateProvinceID
    GROUP BY
      state.CountryRegionCode, state.StateProvinceID
  ),
    country_tax_stats AS (
    SELECT
      CountryRegionCode,
      ROUND(AVG(max_tax_rate), 1) AS mean_tax_rate,
      ROUND(COUNTIF(max_tax_rate IS NOT NULL) / COUNT(*), 2) AS perc_provinces_w_tax
    FROM
      province_tax
    GROUP BY
      CountryRegionCode
  ),

  table1 AS (
    SELECT
      LAST_DAY(DATE(order_header.OrderDate)) AS order_month,
      territory.CountryRegionCode AS country_region_code,
      territory.Name AS region,
      COUNT(order_header.SalesOrderID) AS number_of_orders,
      COUNT(DISTINCT order_header.CustomerID) AS number_of_customers,
      COUNT(DISTINCT order_header.SalesPersonID) AS no_salespersons,
      CAST(SUM(order_header.TotalDue)AS INT) AS total_with_tax
    FROM
      `tc-da-1.adwentureworks_db.salesorderheader` AS order_header
    JOIN
      `tc-da-1.adwentureworks_db.salesterritory` AS territory
    ON
      order_header.TerritoryID = territory.TerritoryID
    GROUP BY
      order_month, country_region_code, region
  )
SELECT
  t1.*,
  RANK() OVER (PARTITION BY t1.country_region_code ORDER BY t1.total_with_tax DESC) AS country_sales_rank,
  SUM(t1.total_with_tax) OVER (PARTITION BY t1.region ORDER BY t1.order_month) AS cumulative_sum,
  tax_stats.mean_tax_rate,
  tax_stats.perc_provinces_w_tax,
FROM
  table1 t1
JOIN
  country_tax_stats tax_stats
ON
  t1.country_region_code = tax_stats.CountryRegionCode
WHERE
  t1.country_region_code = 'US'
ORDER BY
  country_sales_rank;
