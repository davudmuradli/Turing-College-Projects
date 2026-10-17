# E-commerce Funnel Analysis: Country and Device Breakdown

Funnel analysis of raw web event data in BigQuery, showing where users drop off between the first session and purchase. The funnel is compared across the top 3 countries and across mobile and desktop devices, using SQL and Google Sheets.

---

## Skills

### SQL (BigQuery), Funnel Analysis, Conditional Aggregation, Google Sheets, Data Visualization

---

## Business Context

The business wanted to know where users drop out of the purchase journey and whether the funnel differs by country. The analysis covers the three countries with the most activity (United States, India, Canada) and compares mobile and desktop users.

---

## Goal

- Build a sales funnel from `raw_events` with one record per user and event.
- Compare funnel conversion across the top 3 countries.
- Identify the largest drop-off points and suggest where to act.

---

## Approach

1. **Explored the raw data:** Reviewed `raw_events` and noted that repeated events inflate counts. For example, one user can trigger the same event many times.
2. **Deduplicated events:** Kept the first occurrence of each event per user (`MIN(event_timestamp)`), so each user counts at most once per event.
3. **Selected funnel steps:** Chose six events from session start to purchase: `session_start`, `view_item`, `select_item`, `add_to_cart`, `begin_checkout`, `purchase`.
4. **Identified top countries:** Ranked countries by activity and selected the top 3: United States, India, and Canada.
5. **Calculated funnel metrics:** Used conditional aggregation to pivot the counts by country, then calculated the share of sessions at each step and the step-to-step drop-off.
6. **Visualized the results:** Built stacked funnel charts by country and separate funnel charts for mobile and desktop in Google Sheets.

---

## SQL

Final query for the country funnel (shortened). The full version is in the appendix.

```sql
WITH funnel_events AS (
  SELECT
    user_pseudo_id,
    event_name,
    MIN(event_timestamp) AS first_event_ts,
    country
  FROM `tc-da-1.turing_data_analytics.raw_events`
  WHERE event_name IN ('session_start', 'view_item', 'select_item',
                       'add_to_cart', 'begin_checkout', 'purchase')
    AND country IN ('United States', 'India', 'Canada')
  GROUP BY user_pseudo_id, event_name, country
),

event_counts AS (
  SELECT
    event_name,
    country,
    COUNT(DISTINCT user_pseudo_id) AS users
  FROM funnel_events
  GROUP BY event_name, country
),

pivoted AS (
  SELECT
    CASE event_name
      WHEN 'session_start'  THEN 1
      WHEN 'view_item'      THEN 2
      WHEN 'select_item'    THEN 3
      WHEN 'add_to_cart'    THEN 4
      WHEN 'begin_checkout' THEN 5
      WHEN 'purchase'       THEN 6
    END AS event_order,
    event_name,
    MAX(CASE WHEN country = 'United States' THEN users END) AS united_states_events,
    MAX(CASE WHEN country = 'India'         THEN users END) AS india_events,
    MAX(CASE WHEN country = 'Canada'        THEN users END) AS canada_events
  FROM event_counts
  GROUP BY event_order, event_name
)

SELECT
  event_order,
  event_name,
  united_states_events,
  india_events,
  canada_events,
  ROUND(100 * (united_states_events + india_events + canada_events)
        / FIRST_VALUE(united_states_events + india_events + canada_events)
          OVER (ORDER BY event_order), 2) AS full_perc,
  ROUND(100 * united_states_events / FIRST_VALUE(united_states_events) OVER (ORDER BY event_order), 2) AS us_perc,
  ROUND(100 * india_events / FIRST_VALUE(india_events) OVER (ORDER BY event_order), 2) AS india_perc,
  ROUND(100 * canada_events / FIRST_VALUE(canada_events) OVER (ORDER BY event_order), 2) AS canada_perc
FROM pivoted
ORDER BY event_order;
```

---

## Results

### Funnel by Country

| Event | United States | India | Canada |
|---|---|---|---|
| session_start | 117,160 (100%) | 25,059 (100%) | 20,037 (100%) |
| view_item | 26,953 (23.01%) | 5,795 (23.13%) | 4,653 (23.22%) |
| select_item | 5,853 (5.00%) | 1,223 (4.88%) | 988 (4.93%) |
| add_to_cart | 5,603 (4.78%) | 1,162 (4.64%) | 993 (4.96%) |
| begin_checkout | 4,310 (3.68%) | 878 (3.50%) | 764 (3.81%) |
| purchase | 1,942 (1.66%) | 406 (1.62%) | 355 (1.77%) |

![Funnel by country](images/funnel_by_country.png)

### Funnel by Device

| Event | Mobile | Desktop |
|---|---|---|
| session_start | 107,981 (100%) | 157,079 (100%) |
| view_item | 24,810 (22.98%) | 36,323 (23.12%) |
| begin_checkout | 3,968 (3.67%) | 5,665 (3.61%) |
| add_payment_info | 2,387 (2.21%) | 3,352 (2.13%) |
| purchase | 1,851 (1.71%) | 2,541 (1.62%) |

![Funnel by device](images/funnel_by_device.png)

---

## Key Insights

- **Most users never view a product.** Only about **23%** of users reach a product page, in every country and on both devices. This points to a site-wide problem with navigation or discovery, not a problem in one market.
- **Selecting a product is the sharpest drop in the funnel.** About **21%** of users who view an item go on to select it (≈5% of all users), so roughly **79%** of viewers leave at this step.
- **Checkout to purchase loses over half of users.** Roughly **55%** of users who start checkout don't complete a purchase. The drop is similar in each country: about 55% for the United States, 54% for India, and 53% for Canada.
- **Conversion is nearly identical across countries.** The three countries differ mainly in volume. The United States accounts for most users (117k at session start), while India (25k) and Canada (20k) are much smaller. Conversion rates at every step differ by less than one percentage point.
- **Mobile and desktop convert similarly.** Both devices reach product pages at about 23%. Mobile ends slightly higher at purchase (1.71% vs 1.62%), but the gap is small. Mobile has about 108k users versus 157k on desktop.

---

## Recommendations

- **Improve product discovery (all countries).** About 77% of users never reach a product page. Prioritize navigation, homepage design, and product recommendations.
- **Make product pages more compelling.** Since most viewers don't select an item, test clearer product information, images, pricing, and calls to action on product pages.
- **Streamline checkout globally.** Reduce form fields, add guest checkout, and offer more payment options. This is especially important in India, where payment options may matter more.
- **Test localized messaging.** Country conversion rates are similar, but currency display, language, and local promotions may still improve results.
- **Use cross-device retargeting.** Users may browse on one device and buy on another. Check whether mobile and desktop sessions belong to the same users before making changes.

---

## Limitations

- Counts are **distinct users per event**, not raw event totals. A user counts once per step, so the numbers show reach rather than activity.
- The device funnel uses `add_payment_info` and omits `select_item` and `add_to_cart`, so it is not an exact match for the country funnel.
- The country ranking and the funnel use slightly different event lists, so the top-country totals differ slightly from the funnel totals.
- Traffic sources aren't in this analysis. Differences between mobile and desktop could reflect acquisition channels rather than the experience itself.

---

## Appendix

- **Queries and results:** [Google Sheets Link](https://docs.google.com/spreadsheets/d/1-PazqbbR2dSb6p7bVr1_-SDu2q77VGZM-Z9E61MPuWQ/edit?usp=sharing)

---

**Conclusion:**
The main problem is at the top of the funnel: about 77% of users never reach a product page, and that pattern holds across countries and devices. Checkout also loses about 55% of users before purchase. Improving discovery and checkout would likely have the biggest impact, and country differences are small by comparison.
