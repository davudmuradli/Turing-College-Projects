# 📊 E-Commerce Product Analytics Project (AARRR & Behavioral Analysis)

## 📌 Project Overview
This project analyzes user behavior and revenue dynamics of the **Google Merchandise Store** using event-level data from BigQuery (`turing_data_analytics.raw_events`).

**The goal of the analysis was to:**
* Understand user behavior across the purchase funnel.
* Measure time-to-purchase dynamics.
* Segment users by device category.
* Evaluate product performance using the **AARRR framework**.
* Extract actionable business insights.

The analysis combines **SQL (BigQuery)**, **Tableau** visualizations, and **Google Sheets** for structured reporting.

---

## 🛠 Tools & Technologies
* **Google BigQuery** – Data extraction & transformation (SQL)
* **Tableau** – Data visualization & dashboard development
* **Google Sheets** – Supporting calculations & structured reporting
* **GitHub** – Project documentation

---

## 🗂 Dataset
**Source table:** `tc-da-1.turing_data_analytics.raw_events`

The dataset contains event-level interaction data, including:
* **Event information:** `event_name`, `event_date`, `event_timestamp`
* **User identifier:** `user_pseudo_id`
* **Device information:** `category`, `browser`, `operating_system`
* **Geographic data:** `country`
* **Traffic source data:** `source`, `medium`, `campaign`
* **Transaction data:** `purchase_revenue_in_usd`, `transaction_id`

---

## 📈 Key Analyses Performed

### 1️⃣ Time-to-Purchase Analysis
* Measured duration between `session_start` and first purchase.
* Calculated daily average and median time-to-purchase.
* Segmented by device category (mobile, desktop, tablet).
* Identified volatility and abnormal spikes (notably January).

> **Key Insight:** Average time-to-purchase is approximately **18 minutes**. January showed abnormal volatility, requiring further segmentation.

### 2️⃣ Device-Level Analysis
* Compared purchase behavior across desktop, mobile, and tablet.
* Identified strong similarity between mobile and desktop.
* Detected extreme volatility in tablet (likely due to small sample size).

> **Key Insight:** No structural device friction observed; tablet metrics remain unstable due to low volume.

### 3️⃣ AARRR Framework Analysis
| Metric | Value |
| :--- | :--- |
| **Acquisition** (Total Users) | 270,154 |
| **Retention** (Returning Users) | 29,713 |
| **Retention Rate** | ~11% |
| **Total Revenue** | $362,165 |
| **ARPU** | $1.34 |

> **Key Insight:** The platform attracts high traffic volume with moderate retention. Revenue is primarily driven by a specific subset of purchasing users.

---

## 📊 Visualizations
Visualizations were built in **Tableau**, including:
* Daily time-to-purchase trends
* Device-level comparisons
* Volatility analysis
* AARRR breakdown

*Presentation slides are attached in this repository.*

---

## 📎 Additional Resources
* **📊 Presentation Slides:** 
* **📄 Google Spreadsheet (includes SQL queries):** (https://docs.google.com/spreadsheets/d/1ZcsrPbGcrGhojub0oyBPp3wcml-GpMeL4pw-f18hnSg/edit?usp=sharing)

> **Note:** All SQL code used in the analysis is included in the final sheet of the spreadsheet file.

---

## ⚠️ Limitations & Future Improvements
**Current Limitations:**
* Time-to-purchase is measured within the same day.
* Outliers may affect average values.
* No full session boundary logic implemented.
* Retention defined as activity on more than one distinct day.

**Future Improvements:**
* Cohort retention analysis.
* Revenue split by new vs. returning users.
* Percentile-based duration analysis.
* Outlier trimming.

---

## 🎯 Conclusion
This project demonstrates the ability to transform raw event-level data into structured metrics, apply product analytics frameworks like **AARRR**, perform deep behavioral analysis, and identify segmentation opportunities to drive business value.
