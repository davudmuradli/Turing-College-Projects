# Fast Food Marketing Campaign — A/B Testing Analysis

A fast-food chain ran **three different marketing promotions (Promotion 1, Promotion 2, Promotion 3)** across multiple store locations.  
The goal of this A/B test is to determine **which promotion drives the highest weekly sales**.

Each location participated in one promotion for several weeks.  
The dataset contains weekly sales per location and promotion.

---

## Goal

The goal of this A/B test is to determine **which promotion drives the highest weekly sales**.

---

## Target Metric

The **target metric** is:

> **Average weekly sales per location (in thousands of dollars).**

This directly measures the campaign’s financial impact and aligns with the business objective — increasing store revenue.

---

## Data Preparation

The dataset was provided at the `(LocationID, PromotionID, Week)` level.  
Before testing, it was aggregated to **one record per `(LocationID, PromotionID)`**, calculating the average weekly sales for each location.

A summary of the resulting group-level statistics is shown below:

| Promotion | # Locations | Mean Weekly Sales (k$) | SD | Min | Max |
|------------|--------------|-------------------------|----|-----|-----|
| 1 | 43 | 58.10 | 16.03 | 37.79 | 95.09 |
| 2 | 47 | 47.33 | 14.50 | 27.84 | 83.16 |
| 3 | 47 | 55.36 | 16.38 | 31.19 | 88.58 |

 **Detailed queries and results:** [Google Sheets Link](https://docs.google.com/spreadsheets/d/1PHraqD-eotsRizcSkOxxr97iwzRxGl9ifeh12n2UETM/edit?usp=sharing)

---

## Decision & Recommendations

- **Promotion 1** achieved the **highest average weekly sales** (≈ \$58.1k).  
- It performed **significantly better than Promotion 2** (p < 0.01).  
- However, **Promotion 1 vs Promotion 3** was **not significantly different** at the 99% confidence level.

 **Recommendation:**  
Adopt **Promotion 1** as the primary marketing campaign, as it produced the highest sales overall and shows statistically superior performance compared to Promotion 2.  

---

## Appendix

- **SQL Queries and Outputs:** [Google Sheets Link](https://docs.google.com/spreadsheets/d/1PHraqD-eotsRizcSkOxxr97iwzRxGl9ifeh12n2UETM/edit?usp=sharing)  

---

**Conclusion:**  
Promotion 1 yields the highest sales and is statistically better than Promotion 2.  
It is recommended as the best-performing marketing campaign for rollout.

