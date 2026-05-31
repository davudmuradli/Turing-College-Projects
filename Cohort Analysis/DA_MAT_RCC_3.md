# Project Description

Your Product Manager (PM) has tasked you with analyzing subscription churn from a weekly retention perspective. The PM believes that viewing retention data on a monthly basis takes too long and may cause critical insights to be missed. To address this, you aim to calculate weekly retention rates for cohorts of users who started their subscriptions within a specific week and track how many remain active in the following 6 weeks. This analysis should be based on the data available in the [turing_data_analytics.subscriptions](https://console.cloud.google.com/bigquery?ws=!1m5!1m4!4m3!1stc-da-1!2sturing_data_analytics!3ssubscriptions) table.

The task requires you to write an SQL query to extract cohort data from BigQuery, specifically focusing on weekly retention from `week 0` (the start of the subscription) through `week 6`. You'll need to visualize this data to reveal trends using tools such as Google Sheets, Tableau, or Power BI. Assume that you are doing this analysis on `2021-02-07`.

<br>

Let's break down the steps that would help you to achieve meaningful results:

1. **Understand the Table Structure**: familiarize yourself with the schema of the subscriptions table, especially fields like subscription start and end dates and user pseudo ID, to prepare for analysis. Try to explore the data, evaluating missing records or duplications.

2. **Calculate Retention for a Single Cohort**: Start by calculating the weekly retention for a cohort of users who started their subscriptions within a specific week (e.g., `2021-01-04` to `2021-01-11`). Track their activity over the subsequent 6 weeks. Use the appropriate function to truncate the subscription start date to the beginning of the week (e.g., Monday).

3. **Extend Analysis to Multiple Cohorts**: Modify the query to calculate retention for all cohorts. Consider using conditional aggregation to count users for each week they are active and track their activity from Week 0 to Week 6.  

4. **Export the Data**: Once the query executes, export the results in CSV format or directly to Google Sheets for easy analysis. After you've run your query, click the Save Results button and choose where to save the results. If you only need to export an SQL query from BigQuery to Google Sheets or a similar platform, run your query, then go to the query results and click Open In => Sheets/Tableau.

5. **Visualize the Data**: One of the best descriptive visuals is a heatmap displaying retention across different cohorts and weeks, with color gradients (for example, green for high retention and red for low) to highlight trends. Additionally, line or bar charts can help you to track how retention changes from week to week for each cohort, setting cohort week on the x-axis and retention rate on the y-axis.

6. **Interpret the Results**: Review the visualizations to identify key trends. Look for sharp drop-offs in retention, high-performing cohorts, or specific weeks when retention peaks or dips. Understand what factors may contribute to these patterns to provide actionable insights.

Your final visualization should display retention rates for each cohort, allowing you to compare retention trends over the 6-week period easily. This visualization should provide a clear and intuitive picture of how user retention evolves from one week to the next.

<br>

## Evaluation Criteria for a Graded Project Submission

- SQL: Correct columns were identified for analysis
- SQL: Correct logic was created to make the analysis
- SQL code is formatted well and is readable
- Visualization is clear and communicates the message/answer
- Analysis, findings, and main points are clearly structured
- General understanding of the topic
- Analytical approach to the problem, providing justified, actionable, and useful insights

As you complete the task, remember that understanding the relationship between churn and retention rate is key. Once you've completed the analysis and visualizations, you should be able to provide a summary that includes your findings, insights, and any recommendations based on the data. You may also be asked to explain your approach, including the methodology behind your cohort analysis and the SQL queries used to extract the data.

<br>

> During a task review, you may get asked questions that test your understanding of covered topics.

**Sample Questions**:

- What is the relationship between churn and retention rate?
- What is negative churn?
- How would you define user retention?
- What are user retention cohorts, and why are they valuable?

<br>

### Submission

When submitting your work, save your SQL query in a .sql file and upload it to your GitHub repository with all other relevant files (e.g., Spreadsheet link or Visualization files).  
