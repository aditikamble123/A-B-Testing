create database ab_data;
use ab_data;
SHOW tables;
SELECT * from ab_data;

SELECT COUNT(*) FROM ab_data;
ALTER TABLE ab_data CHANGE `group` group_name VARCHAR(255);

SELECT DISTINCT landing_page FROM ab_data;

SELECT COUNT(*) FROM ab_data WHERE group_name = 'control' AND landing_page != 'old_page';
SELECT COUNT(*) FROM ab_data WHERE group_name = 'treatment' AND landing_page != 'new_page';

CREATE TABLE ab_test_cleaned AS
SELECT * FROM ab_data
WHERE (group_name = 'control' AND landing_page = 'old_page')
   OR (group_name = 'treatment' AND landing_page = 'new_page');
   
SELECT group_name,
       COUNT(*) AS total_users,
       SUM(converted) AS total_conversions,
       ROUND(AVG(converted), 4) AS conversion_rate
FROM ab_test_cleaned
GROUP BY group_name;

SELECT DATE(timestamp) AS event_date,
       group_name,
       COUNT(*) AS total_visits,
       SUM(converted) AS conversions,
       ROUND(AVG(converted), 4) AS conversion_rate
FROM ab_test_cleaned
GROUP BY DATE(timestamp), group_name
ORDER BY event_date;

CREATE TEMPORARY TABLE first_seen AS
SELECT user_id, MIN(DATE(timestamp)) AS signup_date
FROM ab_test_cleaned
GROUP BY user_id;

SELECT f.signup_date,
       a.group_name,
       COUNT(*) AS total_users,
       ROUND(SUM(a.converted)/COUNT(*), 4) AS conversion_rate
FROM ab_test_cleaned a
JOIN first_seen f ON a.user_id = f.user_id
GROUP BY f.signup_date, a.group_name
ORDER BY f.signup_date;

CREATE VIEW ab_dashboard_view AS
SELECT user_id, timestamp, group_name, landing_page, converted
FROM ab_test_cleaned;

SELECT group_name,
       COUNT(*) AS total_users,
       SUM(converted) AS total_conversions
FROM ab_test_cleaned
GROUP BY group_name;





