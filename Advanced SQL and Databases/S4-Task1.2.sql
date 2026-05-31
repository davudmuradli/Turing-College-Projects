WITH
  sales_order_header AS (
  SELECT
    CustomerID,
    COUNT(SalesOrderID) AS number_of_sales,
    SUM(TotalDue) AS total_amount_with_tax,
    MAX(OrderDate) AS last_order_date
  FROM
    `tc-da-1.adwentureworks_db.salesorderheader`
  GROUP BY
    CustomerID ),
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
  address.addressline2 AS address_line_2,
  state.name AS State,
  country.name AS Country,
  sales_order_header.number_of_sales,
  sales_order_header.total_amount_with_tax,
  sales_order_header.last_order_date
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
CROSS JOIN
  latest_order_date
WHERE
  sales_order_header.last_order_date < DATE_SUB(latest_order_date.last_order_date, INTERVAL 365 DAY)
ORDER BY
  sales_order_header.total_amount_with_tax DESC
LIMIT
  200;
