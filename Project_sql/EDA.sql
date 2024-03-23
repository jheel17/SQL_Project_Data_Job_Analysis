-- Query to find the total number of job postings:
-- Purpose: This query calculates the total number of job postings available in the dataset.

SELECT COUNT(*) AS total_job_postings
FROM job_postings_fact;

--Query to find the average salary across all job postings:
--Purpose: This query calculates the average salary across all job postings to provide an overall
--understanding of the salary distribution.

SELECT ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;

--Query to find the top 5 companies with the highest number of job postings:
--Purpose: This query identifies the companies that have the highest number of job postings, 
--helping to understand which companies are actively hiring.

SELECT c.name AS company_name, 
    COUNT(jpf.job_id) AS num_job_postings
FROM company_dim AS c
JOIN job_postings_fact AS jpf 
ON c.company_id = jpf.company_id
GROUP BY c.name
ORDER BY num_job_postings DESC
LIMIT 5;

--Query to find the top 5 most common skills required for job postings:
--Purpose: This query identifies the most common skills required for job postings, 
--assisting in understanding the skillset in demand.

SELECT s.skills, COUNT(sjd.skill_id) AS num_job_postings
FROM skills_dim AS s
JOIN skills_job_dim  AS sjd 
ON s.skill_id = sjd.skill_id
GROUP BY s.skills
ORDER BY num_job_postings DESC
LIMIT 5;

--Query to analyze the distribution of job postings by location:
--Purpose: This query provides insights into the distribution of job postings by location,
--helping to identify regions with high demand for jobs.

SELECT job_location, COUNT(*) AS num_job_postings
FROM job_postings_fact
GROUP BY job_location
ORDER BY num_job_postings DESC;

--Query to identify trends in job postings over time:
--Purpose: This query analyzes the number of job postings over time, 
--allowing for the identification of trends and patterns.

SELECT EXTRACT(YEAR FROM job_posted_date) AS posting_year, COUNT(*) AS num_job_postings
FROM job_postings_fact
GROUP BY posting_year
ORDER BY posting_year;

