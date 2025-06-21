## 🧪 A/B Testing Analysis: Should We Launch the New Landing Page?

##📌 Overview
This project analyzes the results of a real-world A/B test comparing two landing page designs — a control (old) page and a treatment (new) page — to determine whether the new design increases conversion rates.

🎯 Goal: Use statistical and visual analysis to decide whether the treatment group (new page) performs significantly better than the control group (old page).

#🚀 Business Problem
SaaS companies frequently experiment with landing pages to improve sign-up conversion. In this experiment, the company wants to assess whether launching a redesigned landing page improves user conversion. A decision must be made based on data.

Stakeholders: Product managers, marketing team, UX designers

Success Metric: Statistically significant increase in conversion rate

##🧰 Tech Stack
Layer	Tools Used
📊 BI / Reporting	Power BI Desktop
🧠 Statistical Test	Python (statsmodels)
🗃️ Data Storage	MySQL
🧹 Cleaning & ETL	SQL queries
📁 Dataset Source	Cleaned A/B data (ab_data.csv)

##🗃 Dataset Details
Total Users: 61,601

Fields:

user_id: Unique ID
timestamp: Event time
group_name: control or treatment
landing_page: old or new page
converted: 1 if converted, 0 otherwise

##✅ Key Steps
1. Data Cleaning (SQL)
Removed 3,893 mismatched rows where group ≠ landing_page
Final clean dataset: 61,601 rows

SELECT * FROM ab_test_data
WHERE (group_name = 'control' AND landing_page = 'old_page')
OR (group_name = 'treatment' AND landing_page = 'new_page');
   
2. Metric Calculation (DAX)
Created the following measures in Power BI:

Total Users = COUNT(ab_test_cleaned[user_id])
Total Conversions = SUM(ab_test_cleaned[converted])
Conversion Rate = DIVIDE([Total Conversions], [Total Users])

3. Statistical Testing (Python)

from statsmodels.stats.proportion import proportions_ztest

successes = [control_conversions, treatment_conversions]
nobs = [control_total, treatment_total]
z_stat, p_value = proportions_ztest(successes, nobs)

🧪 Result:

Z-statistic: 1.1255
P-value: 0.2604

##No significant difference — the new page does not improve conversion.

##📊 Power BI Dashboard Features

KPI Cards: Control/Treatment conversion rates and total users
Bar Chart: Conversion rate by group
Line Chart: Daily trend of conversion rates
Funnel Visual: Group-wise funnel from users to conversions
Interactive Filters: Drill down by date, group, landing page

##💡 Final Insights & Recommendation
The A/B test showed no statistically significant improvement in conversion from the new landing page (p = 0.2604).
Recommendation: Do not roll out the new design. Maintain current landing page and consider testing other UX elements.

##📈 Screenshots
![Screenshot (240)](https://github.com/user-attachments/assets/d5a0e144-7d60-4482-a809-4cfda262bb8d)

##🧠 What I Learned
Designing A/B test analysis using SQL, DAX, and Python

Performing statistical hypothesis testing with z-test

Building interactive business dashboards in Power BI

Translating data into decisions for product teams
