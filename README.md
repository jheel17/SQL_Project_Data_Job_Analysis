# Introduction:
Hey there! Dive into the data job market! Focusing on Data Analyst Roles, this project explores 💰 top paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics. 

🔍SQL queries? Check them out here: [project_sql folder](/Project_sql/)

# Background:
Currently gearing up with a Master's in Business Analytics 🎓 and on the hunt for that perfect Data Analyst role, I figured, why not play detective 🔍 in the job market first?

My quest was simple: To find out the number of remote Data Analyst jobs💻🏠
and decoded the jigsaw of skills — from SQL to SAS — to discover which are the keys 🔑 to unlocking top salaries 💰 and most wanted skills in job descriptions 🌟

Data hails from [SQL Course](https://lukebarousse.com/sql). Its packed with insights on job titles, salaries, locations, and essential skills. 

### The questions I wanted to answer through my SQL queries were: 

1. What are the top_paying data analyst jobs?
2. What skills are required for the top paying jobs?
3. What skills are most in demand for Data Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills (high demand, high salary) to learn?

# Tools I Used:

In my Data Analyst job market project, I utilized a dynamic suite of tools to navigate and analyze data effectively:

- **SQL & PostgreSQL:** 📊 SQL and PostgreSQL formed the backbone, enabling seamless querying and analysis of job market data.

- **Visual Studio Code:** 💻 Visual Studio Code provided the canvas for coding, offering a user-friendly interface and a plethora of extensions for efficient development.

- **Git:** 🔄 Git kept track of every twist and turn in the project's journey, ensuring version control and collaboration.

- **GitHub:** 🌐 GitHub served as the central repository, fostering collaboration and sharing insights with the community.

# The Analysis:

I started the project with conducting Exploratory Data Analysis (EDA) to gain valuable insights into the data analytics job market. 

Here's a summary of the key analyses I performed:

- **Total Number of Job Postings.**

| total_job_posting |
| ----------------- |
| 787686            |


- **Average Salary Across All Job Postings.**

| average_salary |
| -------------- |
|  123268.82     |

- **Top 5 Companies with the Highest Number of Job Postings.**

| company_name          | num_job_postings |
| --------------------- | ---------------- |
| Emprego               | 6661             |
| Booz Allen Hamilton   | 2890             |
| Dice                  | 2825             |
| Harnham               | 2551             |
| Insight Global        | 2254             |

- **Top 5 Most Common Skills Required for Job Postings.**

| Skill  | Number of Job Postings |
|--------|-------------------------|
| SQL    | 385,750                 |
| Python | 381,863                 |
| AWS    | 145,718                 |
| Azure  | 132,851                 |
| R      | 131,285                 |

- **Trends in Job Postings Over Time.**

| Posting Year | Number of Job Postings |
|--------------|------------------------|                |
| 2023         | 785,791                |


### Next, each query for this project aimed at investigating specific aspects  of the data analyst job market.

Here's how I approached each question: 

## 1. Top Paying Data Analyst Roles.

This SQL query identifies the top 10 highest-paying  Data Analyst roles available. By focusing on job postings with specified salaries and removing null values, the query aims to highlight lucrative opportunities for Data Analysts. 

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim 
ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location ='Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```


Here's are the key insights from the top 10 Data Analyst jobs:

- **Wide Salary Range:** Salaries range from a minimum of $184,000 to a maximum of $650,000, showcasing a significant spread in the compensation levels among these roles.

- **Diverse Employers:** Companies like Manty's, Meta, AT&T are among those offering high salaries, showing a braod interest accross different industries. 

- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Data Analytics, reflecting varied roles and specializations within Data Analytics. 

![Top Paying Roles](Project_sql\assets\salary_trends_by_common_job_titles.png)
*This Bar graph  shows the average salary for the most common job titles, illustrating that certain titles tend to offer higher salaries.*

![Top Paying Companies](Project_sql\assets\top_paying_data_analyst_jobs.png)
*This bar chart visually represents the salaries across different companies, underlining the lucrative opportunities available for Data Analysts in various industries.*


## 2. Skills Associated With Top Paying Roles.

This SQL query aimed to identify the top 10 highest-paying Data Analyst roles, focusing specifically on the skills required for these roles. By joining job postings data with company and skills information, the query extracts details about job titles, average salaries, and associated skills. It helps pinpoint the most valuable skills for high-paying Data Analyst jobs, offering insights for professionals about which competencies to develop. 

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,      
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location ='Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```

Here are the key insights from top paying job skills:

- **High Demand for Data-Related Skills:** The top skills, such as SQL, Excel, Python, and R are foundational to data analysis, suggesting a broad market demand for data proficiency.

- **Visualization Tools are Essential:** Tableau and Power BI are among the top skills, emphasizing the importance of data visualization capabilities in today's job market.

- **Versatility in Skills:** Towards the end of the graph, we see a mix of  tools like  (AWS, Azure, bitbucket, oracle, SAP, Hadoop, Databricks, Git etc.) showing that a well-rounded skill set that includes cloud services, numerical computing, big data, interactive computing, large-scale data processing, and version control can be beneficial for a data analyst looking to advance in their career.

![Top Paying Job Skills](Project_sql\assets\Top_paying_job_skills.PNG)
*This bar graph represents the frequency distribution of skills for top-paying data analyst jobs.*

## 3. Most Demanded Skills for Data Analysts.

This SQL query is crafted to discover the top five skills that are most sought after for Data Analyst positions across various job postings. This is achieved by joining these tables based on job and skill identifiers, filtering for Data Analyst positions, and then grouping and counting the occurrences of each skill to determine their demand. The result is a ranked list of the top five skills, providing crucial insights for individuals aiming to enhance their qualifications.

```sql
SELECT skills,
     COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_location ='Anywhere'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
Here are the key insights from top 5 in-demand skills:

- **SQL, Excel and Python:** These skills have the highest frequency, showcasing their importance and demand in the data analysis field.

- **Tableau and Power BI:** Following closely are Tableau and R, which are also highly sought after, likely due to their roles in data visualization and statistical analysis respectively.

![Top 5 In-Demand Skills](Project_sql\assets\demand_for_skills.png)
*The bar chart visualizes the top 5 in-demand skills, clearly showing SQL as the most sought-after skill, with a significant lead over the others.*

## 4. Top Paying Skills.
This query aims to analyze how different skills impact salary levels for data analyst positions. It aggregates data analyst job postings by skill, calculating the average salary for jobs requiring each skill and returns a list of skills ranked by the average salary of data analyst jobs that require them, showing which skills are associated with higher pay. 

```sql
SELECT skills,
     ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_location ='Anywhere'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;
```
Here are the key insights from top paying skills:

**The top five skills, based on average salary, are:**

- Pyspark - $208,172.25
- Bitbucket - $189,154.50
- Couchbase - $160,515.00
- Watson - $160,515.00
- Datarobot - $155,485.50

**Top Paying Skills:** The data suggests that skills related to big data processing (Pyspark), version control (Bitbucket), database management (Couchbase), artificial intelligence (Watson), and automated machine learning (Datarobot) are highly valued and most paid  in the market for Data Analyst roles.

![Top_Skills_Salary_Data](Project_sql\assets\average_salary_by_skill.png)
*The visualization presents the top 25 skills based on average salary for Data Analyst positions, showcasing a diverse range of highly valued skills in the field.*

## 5 Most Optimal Skills to Learn.

This query identifies Data Analyst skills that are both in high demand and associated with high average salaries, focusing on remote positions. It filters for skills appearing in more than 10 job postings, suggesting both job security and financial benefits. The query aims to offer strategic insights for career development in data analysis by pinpointing valuable skills.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY 
        skills_dim.skill_id  
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY 
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here are the key insights from most optimal skills (aka in high demand and associated with high average salaries): 

The top five skills, based on this criteria, are:

**Go** - Demand Count: 27, Average Salary: $115,319.89
**Confluence** - Demand Count: 11, Average Salary: $114,209.91
**Hadoop** - Demand Count: 22, Average Salary: $113,192.57
**Snowflake** - Demand Count: 37, Average Salary: $112,947.97
**Azure** - Demand Count: 34, Average Salary: $111,225.10

**Market Trends:** The data suggests a trend towards the value of skills in programming, big data processing, cloud computing, and project management within the data analysis job market. It reflects the industry's growing reliance on cloud-based solutions and big data technologies, as well as the importance of software development skills.

**High Demand but Relatively Standardized Salaries:** Python, R, and Tableau are likely to have high demand due to their critical role in data analysis, data visualization, and statistical modeling. However, because these skills are now standard prerequisites in the field, the supply of professionals possessing them might be relatively high, which could normalize or slightly lower the average salaries compared to more niche or emerging technologies.

**Specialized Skills:** Skills highlighted in the dataset (e.g., Go, Confluence, Hadoop, Snowflake and Azure) might be considered specialized or advanced, often requiring additional learning beyond the foundational skills. This specialization and the smaller supply of professionals with these advanced skills can drive higher average salaries.

![In_Demand_Skills_&_Associated_Salaries](Project_sql\assets\demand_salary_data_analyst_skills.png)
*This combined bar and line plot, showcases both the demand and average salary of the top skills in data analyst roles. It illustrates a balance between high-paying skills and their market demand, offering strategic insights for  career development in data analysis.*

# What I Learned Tackling SQL for the Data Job Market Project:

Jumping into SQL for this data job market project was like diving into a new adventure. Here's a more grounded recap of my journey and the skills I honed along the way:

**1. Mastering Advanced SQL Features:**
I got hands-on with some of SQL's cooler tricks, like Common Table Expressions (CTEs), window functions, and multi-table JOINs. These tools helped me pull off more sophisticated analyses, like pinpointing top-paying jobs and sorting out which skills are worth their weight in gold.

**2. Getting Good with Grouping and Aggregation:**
Learning to aggregate and group data was key for digging into trends, like figuring out which skills are in hot demand or which jobs are paying top dollar. I used SQL's aggregation functions to boil down vast oceans of data into digestible insights.

**3. Sharpening My Filtering Skills:**
I leaned heavily on the WHERE clause to filter data for specific insights, such as isolating remote jobs or focusing on particular job titles. This helped me cut through the noise and zero in on the info I really wanted.

**4. Crafting Insights from Data:**
Turning query results into meaningful insights felt like solving a series of puzzles. This project really dialed up my ability to see beyond the numbers and understand what they're telling me about the real world.


# Conclusion:

### Insights drawn from the overall analysis: 

- **Salary Diversity:** Data Analyst roles show a broad salary range from $184,000 to $650,000, indicating varied compensation across the sector.

- **Industry Variety:** High salaries are offered across diverse industries, including technology and telecommunications, showing widespread demand for data analytics skills.

- **Essential Skills:** SQL, Excel, Python, and R are foundational, with visualization tools like Tableau and Power BI also highly valued.

- **Specialized Skills Pay More:** Skills in big data processing, version control, and AI, like Pyspark and Bitbucket, command the highest salaries.

- **Emerging Skills Demand:** Advanced skills in areas like cloud computing and big data (e.g., Azure and Snowflake) are in high demand, reflecting industry trends towards cloud-based solutions and big data technologies.

### Closing Thoughts:

This project enhanced my SQL skills and provided valuable insights into the data analyst job market.  This project wasn't just about using SQL; it was about using those queries to uncover the story hidden within the data. I came away with a better grasp of how to use SQL not just as a technical skill, but as a tool for insight and discovery in the data job market.


