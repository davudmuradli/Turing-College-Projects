WITH events AS (
  SELECT
    user_pseudo_id,
    campaign,
    TIMESTAMP_MICROS(event_timestamp) AS event_time,
    FORMAT_TIMESTAMP('%A', TIMESTAMP_MICROS(event_timestamp)) AS weekday,
    EXTRACT(DAYOFWEEK FROM TIMESTAMP_MICROS(event_timestamp)) AS weekday_num
  FROM `tc-da-1.turing_data_analytics.raw_events`
),

event_gaps AS (
  SELECT
    *,
    TIMESTAMP_DIFF(
      event_time,
      LAG(event_time) OVER (PARTITION BY user_pseudo_id ORDER BY event_time),
      MINUTE
    ) AS minutes_since_prev
  FROM events
),

session_marked AS (
  SELECT
    *,
    CASE
      WHEN minutes_since_prev IS NULL OR minutes_since_prev > 30 THEN 1
      ELSE 0
    END AS new_session_flag
  FROM event_gaps
),

sessionized AS (
  SELECT
    *,
    SUM(new_session_flag) OVER (
      PARTITION BY user_pseudo_id
      ORDER BY event_time
    ) AS session_id
  FROM session_marked
),

sessions AS (
  SELECT
    user_pseudo_id,
    campaign,
    weekday,
    weekday_num,
    session_id,
    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end,
    TIMESTAMP_DIFF(MAX(event_time), MIN(event_time), SECOND) AS session_duration_sec
  FROM sessionized
  GROUP BY user_pseudo_id, campaign, weekday, weekday_num, session_id
  HAVING session_duration_sec > 10   
)

SELECT
  campaign,
  weekday,
  weekday_num,
  COUNT(*) AS sessions,
  APPROX_QUANTILES(session_duration_sec, 100)[OFFSET(50)] AS median_session_duration_sec,
  MIN(session_duration_sec) AS min_duration_sec,
  MAX(session_duration_sec) AS max_duration_sec
FROM sessions
WHERE campaign IS NOT NULL
GROUP BY campaign, weekday, weekday_num
ORDER BY max_duration_sec DESC;