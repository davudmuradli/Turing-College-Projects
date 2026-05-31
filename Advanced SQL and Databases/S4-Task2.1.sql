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
  order_month,
  country_region_code,
  region
