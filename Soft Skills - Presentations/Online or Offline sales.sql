SELECT
  CASE
    WHEN header.SalesPersonID IS NULL THEN 'Online'
    ELSE 'Offline'
  END AS sales_channel,

  -- Format total_due
  CASE
    WHEN SUM(header.TotalDue) >= 1000000 THEN
      CONCAT('$', ROUND(SUM(header.TotalDue) / 1000000, 1), 'M')
    WHEN SUM(header.TotalDue) >= 1000 THEN
      CONCAT('$', ROUND(SUM(header.TotalDue) / 1000, 1), 'K')
    ELSE
      CONCAT('$', ROUND(SUM(header.TotalDue), 2))
  END AS formatted_total_due,

  COUNT(header.SalesOrderID) AS number_of_orders,

  -- Format average revenue per order
  CASE
    WHEN SUM(header.TotalDue) / COUNT(header.SalesOrderID) >= 1000000 THEN
      CONCAT('$', ROUND(SUM(header.TotalDue) / COUNT(header.SalesOrderID) / 1000000, 1), 'M')
    WHEN SUM(header.TotalDue) / COUNT(header.SalesOrderID) >= 1000 THEN
      CONCAT('$', ROUND(SUM(header.TotalDue) / COUNT(header.SalesOrderID) / 1000, 1), 'K')
    ELSE
      CONCAT('$', ROUND(SUM(header.TotalDue) / COUNT(header.SalesOrderID), 2))
  END AS formatted_avg_revenue_per_order

FROM
  `tc-da-1.adwentureworks_db.salesorderheader` AS header

GROUP BY
  sales_channel

ORDER BY
  SUM(header.TotalDue) DESC;
