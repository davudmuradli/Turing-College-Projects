# 📊 Marketing Campaign & Website Engagement Analysis

## Overview

This project analyzes user engagement and marketing campaign performance using website tracking data from BigQuery. The goal was to understand how session duration varies across weekdays and traffic sources.

All data processing was done in **BigQuery SQL**, and results were visualized in [**Google Sheets**](https://docs.google.com/spreadsheets/d/1n9P3qqicGpYIIpv8rMm5uDWocmb3n2X2D2ZXiKKSsJg/edit?usp=sharing) using pivot tables and charts.

---

## Methodology

Since session IDs were not available, sessions were modeled using a standard rule:

- A new session starts after **30 minutes of inactivity**
- Session duration was calculated as the time between the first and last event

To improve accuracy, sessions shorter than **10 seconds** were excluded to remove bounce noise.

Median session duration was used instead of average due to skewed data.

---

## Key Findings

- User engagement is stable across weekdays (~40–45 seconds median duration).
- Referral traffic shows the highest engagement across all days.
- Direct and organic traffic have shorter session durations.
- Weekday differences are minimal compared to campaign effects.

---

## Limitations

- No real session identifiers in the dataset
- Many single-event sessions recorded as very short visits
- Some campaign data is missing or anonymized ("data deleted")

---

## Tools Used

- **Google BigQuery** – SQL queries and data processing  
- **Google Sheets** – tables, pivot analysis, and visualizations   [Link](https://docs.google.com/spreadsheets/d/1n9P3qqicGpYIIpv8rMm5uDWocmb3n2X2D2ZXiKKSsJg/edit?usp=sharing)

---

## Conclusion

Weekday has limited impact on engagement, while traffic source plays a much stronger role. Referral traffic consistently drives the most engaged users.
