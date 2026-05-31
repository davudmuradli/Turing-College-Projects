WITH order_data AS (
  SELECT
    territory.CountryRegionCode AS country,
    header.SalesOrderID,
    header.TotalDue
  FROM
    `tc-da-1.adwentureworks_db.salesorderheader` AS header
  JOIN
    `tc-da-1.adwentureworks_db.salesterritory` AS territory
  ON
    header.TerritoryID = territory.TerritoryID
)

SELECT
  country,

  CASE
    WHEN SUM(TotalDue) >= 1000000 THEN
      CONCAT('$', ROUND(SUM(TotalDue) / 1000000, 1), 'M')
    WHEN SUM(TotalDue) >= 1000 THEN
      CONCAT('$', ROUND(SUM(TotalDue) / 1000, 1), 'K')
    ELSE
      CONCAT('$', ROUND(SUM(TotalDue), 2))
  END AS formatted_total_due,

  CASE
    WHEN SUM(TotalDue) / COUNT(SalesOrderID) >= 1000000 THEN
      CONCAT('$', ROUND(SUM(TotalDue) / COUNT(SalesOrderID) / 1000000, 1), 'M')
    WHEN SUM(TotalDue) / COUNT(SalesOrderID) >= 1000 THEN
      CONCAT('$', ROUND(SUM(TotalDue) / COUNT(SalesOrderID) / 1000, 1), 'K')
    ELSE
      CONCAT('$', ROUND(SUM(TotalDue) / COUNT(SalesOrderID), 2))
  END AS formatted_profit_per_product,

  COUNT(DISTINCT SalesOrderID) AS number_of_orders

FROM
  order_data
GROUP BY
  country
ORDER BY
  SUM(TotalDue) DESC;
