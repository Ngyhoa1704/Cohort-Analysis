# Cohort Analysis Report (2018) – SQL-Based Implementation

## Overview

This project is a cohort analysis built on sales data from a fictional "SuperStore" dataset, focusing on customer retention and behavior throughout the year 2018. Using T-SQL, we grouped customers by their first purchase month (Cohort_Month) and tracked how many returned in each subsequent month (Cohort_Index 1–12). The goal was to understand customer lifecycle trends and retention performance across different acquisition months.

## What is Cohort Analysis?

Cohort analysis is a method of analyzing user behavior by segmenting data into groups (cohorts) that share a common characteristic over a specific timeframe. In this case, customers are grouped by the month they placed their first order. By tracking these groups over time, we can identify patterns such as:

- Which acquisition months brought in customers with higher long-term engagement
- How retention drops off over time
- When customers are most likely to stop returning

Instead of looking at average user behavior, cohort analysis highlights differences across segments, enabling better marketing, retention, and product strategies.

## Dataset and Logic

The cohort logic was implemented in SQL through the following key steps:

1. **Filter Orders by Year**  
   Limited the dataset to only orders made in 2018.

2. **Assign Order_Month**  
   Transformed order dates into month buckets for easier grouping.

3. **Define Cohort_Month**  
   Identified the first purchase month for each customer.

4. **Calculate Cohort_Index**  
   Measured how many months passed since a customer’s first purchase.

5. **Aggregate Data**  
   Counted the distinct number of returning customers by Cohort_Month and Cohort_Index.

6. **Pivot the Table**  
   Restructured data to display cohorts in matrix format, where each row is a cohort and each column represents a retention month (1 through 12).

7. **Normalize to Retention Rate**  
   Divided each month's customer count by the cohort’s month-1 population to show relative retention percentages.

Full SQL logic can be found in the [`Cohort_Analysis.sql`](./Cohort_Analysis.sql) file.

## Interpreting the Report
![image](https://github.com/user-attachments/assets/6182d77c-4ed5-4930-9cf4-f22e53612346)


The top chart displays the absolute number of customers in each cohort who returned in a given month. The bottom heatmap shows the same data as retention percentages.

For example, the March 2018 cohort had 110 new customers in Month 1, but only 24% returned in Month 9, and 17% were still active by Month 11. That cohort had one of the stronger mid-term retention curves.

In contrast, the July and August cohorts show a sharper drop-off after month 1, indicating weaker customer stickiness.

## Takeaways

- March 2018 had the strongest initial acquisition and maintained healthy retention rates across the year.
- Retention commonly drops steeply after month 2–3 across all cohorts, suggesting an opportunity for targeted re-engagement strategies in that timeframe.
- Later cohorts (e.g. October–December) have limited tracking data due to the analysis only covering 12 months.

## Notes

- The analysis assumes full data capture for 2018; partial data in later months may skew interpretations.
- This approach can be extended with metrics like revenue (LTV) or segmented by acquisition channel if additional fields are available.

