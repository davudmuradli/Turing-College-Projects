WITH params AS (
  SELECT DATE('2021-02-07') AS analysis_date
),

cohorts AS (
  SELECT
    user_pseudo_id,
    DATE_TRUNC(subscription_start, WEEK(MONDAY)) AS cohort_week,
    subscription_start,
    subscription_end
  FROM `tc-da-1.turing_data_analytics.subscriptions`
  WHERE subscription_start <= (SELECT analysis_date FROM params)
),

cohort_sizes AS (
  SELECT
    cohort_week,
    COUNT(DISTINCT user_pseudo_id) AS cohort_size
  FROM cohorts
  GROUP BY cohort_week
),

activity AS (
  SELECT
    c.cohort_week,
    c.user_pseudo_id,
    1 AS wk0,  
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 1 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 1 WEEK))
         THEN 1 ELSE 0 END) AS wk1,
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 2 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 2 WEEK))
         THEN 1 ELSE 0 END) AS wk2,
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 3 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 3 WEEK))
         THEN 1 ELSE 0 END) AS wk3,
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 4 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 4 WEEK))
         THEN 1 ELSE 0 END) AS wk4,
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 5 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 5 WEEK))
         THEN 1 ELSE 0 END) AS wk5,
    MAX(CASE WHEN c.subscription_start <= DATE_ADD(c.cohort_week, INTERVAL 6 WEEK)
              AND (c.subscription_end IS NULL OR c.subscription_end > DATE_ADD(c.cohort_week, INTERVAL 6 WEEK))
         THEN 1 ELSE 0 END) AS wk6
  FROM cohorts c
  GROUP BY cohort_week, user_pseudo_id
)

SELECT
  a.cohort_week AS Cohort_Date,
  SUM(a.wk0) AS Week0,
  SUM(a.wk1) AS Week1,
  SUM(a.wk2) AS Week2,
  SUM(a.wk3) AS Week3,
  SUM(a.wk4) AS Week4,
  SUM(a.wk5) AS Week5,
  SUM(a.wk6) AS Week6,
  SAFE_DIVIDE(SUM(a.wk0), cs.cohort_size) AS Week0_Retention,
  SAFE_DIVIDE(SUM(a.wk1), cs.cohort_size) AS Week1_Retention,
  SAFE_DIVIDE(SUM(a.wk2), cs.cohort_size) AS Week2_Retention,
  SAFE_DIVIDE(SUM(a.wk3), cs.cohort_size) AS Week3_Retention,
  SAFE_DIVIDE(SUM(a.wk4), cs.cohort_size) AS Week4_Retention,
  SAFE_DIVIDE(SUM(a.wk5), cs.cohort_size) AS Week5_Retention,
  SAFE_DIVIDE(SUM(a.wk6), cs.cohort_size) AS Week6_Retention
FROM activity a
JOIN cohort_sizes cs USING (cohort_week)
GROUP BY a.cohort_week, cs.cohort_size
ORDER BY cohort_week;
