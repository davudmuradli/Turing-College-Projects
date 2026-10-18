# Customer RFM Segmentation: Online Retail

RFM (Recency, Frequency, Monetary) analysis of online retail customers from December 2010 to November 2011. Customers are scored in quartiles and grouped into segments to show which groups marketing should prioritize. Built with SQL in BigQuery and an interactive dashboard in Tableau.

**Dashboard:** [Tableau Public](https://public.tableau.com/app/profile/davud.muradli/viz/RFMAnalysis_17580474985760/Dashboard1?publish=yes)

---

## Skills

### SQL (BigQuery), RFM Analysis, Customer Segmentation, Quartile Scoring, Tableau

---

## Business Context

The marketing team needs to decide which customers to target with retention and reactivation campaigns. RFM analysis ranks customers by how recently they bought, how often they buy, and how much they spend, so marketing can focus budget on the most valuable groups.

The analysis uses one year of transactions, from 2010-12-01 to 2011-12-01. Recency is measured from 2011-12-01.

---

## Goal

- Calculate recency, frequency, and monetary value for each customer.
- Convert each metric into a 1 to 4 score using quartiles.
- Segment customers into Best Customers, Loyal Customers, Big Spenders, Lost Customers, and Other.
- Present the segments in a dashboard and recommend where marketing should focus.

---

## Approach

1. **Filtered the data:** Used transactions from 2010-12-01 to 2011-12-01 and excluded rows without a `CustomerID`.
2. **Calculated RFM values per customer:**
   - **Recency:** days from the customer's last order to 2011-12-01.
   - **Frequency:** number of distinct invoices.
   - **Monetary:** total spend, calculated as `UnitPrice * Quantity`.
3. **Set quartile thresholds:** Used `APPROX_QUANTILES(..., 4)` on each metric.
4. **Scored customers:** Assigned 1 to 4 for R, F, and M. For recency, fewer days since the last order earns a higher score. For frequency and monetary, a higher value earns a higher score.
5. **Segmented customers:**
   - **Best Customers:** R, F, and M scores all at least 3.
   - **Loyal Customers:** F score at least 3.
   - **Big Spenders:** M score at least 3.
   - **Lost Customers:** R and F scores both 1.
   - **Other:** everything else.
6. **Built the dashboard:** Created an interactive Tableau dashboard with KPIs, segment sizes, spending by segment, a recency scatter plot, and an RFM heatmap.

---

## SQL

[Insert your final query here, or link to the file.]

```sql
-- RFM values, quartiles, scores, and segments
WITH
rfm_values AS (
  SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS orders, --pay attention if it is return, can damage the data
    SUM(UnitPrice * Quantity) AS order_value,
    MAX(InvoiceDate) AS last_order_date,
    DATE_DIFF(DATE '2011-12-01', DATE(MAX(InvoiceDate)), DAY) AS recency_days --
  FROM `tc-da-1.turing_data_analytics.rfm`
  WHERE InvoiceDate BETWEEN '2010-12-01' AND '2011-12-01'
    AND CustomerID IS NOT NULL
  GROUP BY CustomerID
),
quartiles AS (
  SELECT
    APPROX_QUANTILES(recency_days, 4) AS r_quart,
    APPROX_QUANTILES(orders, 4) AS f_quart,
    APPROX_QUANTILES(order_value, 4) AS m_quart
  FROM rfm_values
),
rfm_scored AS (
  SELECT
    r.CustomerID,
    r.recency_days,
    r.orders,
    r.order_value,
    CASE 
      WHEN r.recency_days <= q.r_quart[OFFSET(1)] THEN 4
      WHEN r.recency_days <= q.r_quart[OFFSET(2)] THEN 3
      WHEN r.recency_days <= q.r_quart[OFFSET(3)] THEN 2
      ELSE 1 END AS R_score,
    CASE 
      WHEN r.orders <= q.f_quart[OFFSET(1)] THEN 1
      WHEN r.orders <= q.f_quart[OFFSET(2)] THEN 2
      WHEN r.orders <= q.f_quart[OFFSET(3)] THEN 3
      ELSE 4 END AS F_score,
    CASE 
      WHEN r.order_value <= q.m_quart[OFFSET(1)] THEN 1
      WHEN r.order_value <= q.m_quart[OFFSET(2)] THEN 2
      WHEN r.order_value <= q.m_quart[OFFSET(3)] THEN 3
      ELSE 4 END AS M_score
  FROM rfm_values r
  CROSS JOIN quartiles q
)
SELECT
  CustomerID,
  recency_days,
  orders,
  order_value,
  R_score,
  F_score,
  M_score,
  CONCAT(CAST(R_score AS STRING),
         CAST(F_score AS STRING),
         CAST(M_score AS STRING)) AS rfm_score,
  CASE
    WHEN R_score >= 3 AND F_score >= 3 AND M_score >= 3 THEN 'Best Customers'
    WHEN F_score >= 3 THEN 'Loyal Customers'
    WHEN M_score >= 3 THEN 'Big Spenders'
    WHEN R_score = 1 AND F_score = 1 THEN 'Lost Customers'
    ELSE 'Other' --more categories to be specific for other
  END AS segment
FROM rfm_scored
ORDER BY rfm_score DESC
Limit 50;
```

---

## Results

### Dashboard Overview

![RFM dashboard overview](images/rfm_dashboard_overview.png)

The dashboard shows **4,331 customers** and **total revenue of about $7.96M**. Best Customers are the largest group by count and by far the largest by revenue.

### Recency vs. Orders

![Recency vs orders](images/rfm_recency_scatter.png)

Each bubble is a customer. Most high-order customers cluster at low recency, meaning they bought recently. Customers with recency beyond the median (about 50 days) have few orders, and many have not bought in over 200 days.

### Segment Summary

| Segment | Customers (approx.) | Share of customers | Revenue (approx.) | Share of revenue |
|---|---|---|---|---|
| Best Customers | 1,330 | 31% | $6.0M | 76% |
| Loyal Customers | 850 | 20% | $0.9M | 11% |
| Big Spenders | 360 | 8% | $0.3M | 4% |
| Lost Customers | 590 | 14% | $0.1M | 1% |
| Other | 1,200 | 28% | $0.2M | 3% |

*Values are read from the dashboard charts and rounded. Customer counts sum to about 4,330, matching the 4,331 total.*

---

## Key Insights

- **Best Customers drive most of the revenue.** About **31%** of customers generate roughly **76%** of revenue, so retaining this group matters most.
- **Loyal Customers are a strong second group.** They make up about **20%** of customers but only about **11%** of revenue, which suggests lower order values.
- **Big Spenders are a small group.** They are about **8%** of customers and **4%** of revenue. Their spend per customer is high, but the group is small.
- **Lost Customers are a sizable group with little value.** About **14%** of customers have not bought recently and buy rarely, contributing about **1%** of revenue.
- **The Other segment is large.** It holds about **28%** of customers, which means the segment rules leave many customers unclassified. It should be split further before taking action on it.

---

## Recommendations

- **Protect Best Customers.** Reward them with loyalty benefits, early access, or personal outreach to keep them active.
- **Convert Loyal Customers into Best Customers.** Target them with offers that increase order value, such as bundles or minimum-spend incentives.
- **Grow Big Spenders' purchase frequency.** Use reminders or replenishment campaigns to bring them back more often.
- **Reactivate Lost Customers selectively.** Test low-cost win-back campaigns on a sample first, and measure response before spending more.
- **Break down the Other segment.** Split it into more specific groups so marketing can target customers with clearer profiles.

---

## Limitations

- Returns are not separated from purchases. Cancelled invoices can inflate frequency and monetary values, so the results may be overstated for some customers.
- Quartile thresholds depend on this one-year window and this customer base. Scores would shift with a different period.
- Recency is measured from 2011-12-01, the end of the data, so customers who bought near the end of the window score high by default.
- The Other segment is large, so some customers are not clearly profiled by these rules.
- RFM describes past behavior. It doesn't show why customers buy or stop buying.

---

**Conclusion:**
Best Customers are about 31% of customers and about 76% of revenue, making them the priority for retention. Loyal Customers offer the next best opportunity to grow order value, while Lost Customers contribute little and should get only low-cost reactivation efforts.
