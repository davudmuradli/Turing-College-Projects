WITH
  sales_order_header AS (
  SELECT
    CustomerID, TerritoryID as territory_id,
    COUNT(SalesOrderID) AS number_of_sales,
    SUM(TotalDue) AS total_amount_with_tax,
    MAX(OrderDate) AS last_order_date
  FROM
    `tc-da-1.adwentureworks_db.salesorderheader`
  GROUP BY
    CustomerID,TerritoryID ),
  latest_customer_address AS (
  SELECT
    CustomerID,
    MAX(AddressID) AS AddressID
  FROM
    `tc-da-1.adwentureworks_db.customeraddress`
  GROUP BY
    CustomerID ),
  latest_order_date AS (
  SELECT
    MAX(OrderDate) AS last_order_date
  FROM
    `tc-da-1.adwentureworks_db.salesorderheader`)
SELECT
  customer.CustomerID AS customer_id,
  contact.Firstname AS first_name,
  contact.LastName AS last_name,
  CONCAT(contact.Firstname, ' ', contact.LastName) AS full_name,
  CASE
    WHEN contact.Title IS NULL THEN CONCAT('Dear ', contact.LastName)
    ELSE CONCAT(contact.Title, ' ', contact.LastName)
END
  AS addressing_title,
  contact.Emailaddress AS email_address,
  contact.phone,
  customer.accountnumber AS account_number,
  customer.customertype AS customer_type,
  address.city,
  address.addressline1 AS address_line_1,
  REGEXP_EXTRACT(address.addressline1, r'\b\d+\b') AS address_no,
  REPLACE( TRIM(REGEXP_REPLACE(address.addressline1, r'\b\d+\b', '')), ',', '' ) AS address_st,
  address.addressline2 AS address_line_2,
  state.name AS State,
  country.name AS Country,
  sales_order_header.number_of_sales,
  sales_order_header.total_amount_with_tax,
  sales_order_header.last_order_date,
  CASE
    WHEN sales_order_header.last_order_date < DATE_SUB(latest_order_date.last_order_date, INTERVAL 365 DAY) THEN 'Inactive'
    ELSE 'Active'
END
  AS status
FROM
  `tc-da-1.adwentureworks_db.customer` customer
JOIN
  `tc-da-1.adwentureworks_db.individual` individual
ON
  customer.CustomerID = individual.CustomerID
JOIN
  `tc-da-1.adwentureworks_db.contact` contact
ON
  contact.ContactId = individual.ContactID
JOIN
  latest_customer_address lca
ON
  customer.CustomerID = lca.CustomerID
JOIN
  `tc-da-1.adwentureworks_db.address` address
ON
  lca.AddressID = address.AddressID
JOIN
  `tc-da-1.adwentureworks_db.stateprovince` state
ON
  state.StateProvinceID = address.StateProvinceID
JOIN
  `tc-da-1.adwentureworks_db.countryregion` country
ON
  state.CountryRegionCode = country.CountryRegionCode
LEFT JOIN
  sales_order_header
ON
  sales_order_header.CustomerID = customer.CustomerID
JOIN `tc-da-1.adwentureworks_db.salesterritory` sales_teritory ON sales_teritory.TerritoryID = sales_order_header.territory_id
CROSS JOIN
  latest_order_date
WHERE
  sales_order_header.last_order_date > DATE_SUB(latest_order_date.last_order_date, INTERVAL 365 DAY)
  AND (sales_order_header.total_amount_with_tax >= 2500
    OR sales_order_header.number_of_sales > 5)
  AND sales_teritory.group = 'North America'
ORDER BY
  country,
  state,
  sales_order_header.last_order_date
LIMIT
  500;