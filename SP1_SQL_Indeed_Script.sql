-- How many rows are in the data_analyst_jobs table?
--Answer: 1793

SELECT *
FROM data_analyst_jobs;

-- Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
--Answer: ExxonMobil

SELECT *
FROM
	data_analyst_jobs
LIMIT
	10;

-- How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
--Answer: 21 ; 27

SELECT 
	COUNT(location) AS postings_in_TN
FROM 
	data_analyst_jobs
WHERE 
	location = 'TN';

SELECT 
	COUNT(location) AS postings_in_TN_or_KY
FROM 
	data_analyst_jobs
WHERE 
	location = 'TN' OR location = 'KY';

-- How many postings in Tennessee have a star rating above 4?
-- Answer: 416

SELECT 
	COUNT(location) AS star_rating_above_4_TN
FROM 
	data_analyst_jobs
WHERE
	star_rating > 4;

-- How many postings in the dataset have a review count between 500 and 1000?
--Answer: 151

SELECT 
	COUNT(review_count) AS review_count_bw_500_1000
FROM
	data_analyst_jobs
WHERE 
	review_count BETWEEN 500 AND 1000;

-- Show the average star rating for companies in each state. 
-- The output should show the state as state and the average rating for the state as avg_rating. 
-- Which state shows the highest average rating?
-- Answer: See script for part 1 ; NE (max_avg_rating = 4.20)

SELECT 
	location AS state,
	ROUND(AVG(star_rating), 2) AS avg_rating
FROM
	data_analyst_jobs
GROUP BY
	location;

SELECT
	location AS state,
	ROUND(AVG(star_rating), 2) AS max_avg_rating
FROM
	data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY
	location
ORDER BY
	max_avg_rating DESC;

-- Select unique job titles from the data_analyst_jobs table. How many are there?
-- Answer: See script for part 1 ; 881

SELECT 
	DISTINCT title AS unique_job_titles
FROM 
	data_analyst_jobs;

SELECT
	COUNT(DISTINCT title) AS unique_job_titles
FROM
	data_analyst_jobs;

-- How many unique job titles are there for California companies?
-- Answer: 230

SELECT 
	COUNT(DISTINCT title) AS unique_job_titles_CA
FROM
	data_analyst_jobs
WHERE 
	location = 'CA';

-- Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.
-- How many companies are there with more that 5000 reviews across all locations?
-- Answer: 71 

SELECT
	company,
	ROUND(AVG(star_rating), 2) AS avg_star_rating,
	SUM(review_count) AS total_reviews
FROM
	data_analyst_jobs
GROUP BY 
	company
HAVING 
	SUM(review_count) > 5000;

-- Add the code to order the query in #9 from highest to lowest average star rating. 
-- Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
-- What is that rating?

SELECT
	company,
	location,
	SUM(review_count) AS total_reviews,
	ROUND(AVG(star_rating), 2) AS avg_star_rating
FROM
	data_analyst_jobs
GROUP BY 
	company, 
	location
HAVING
	SUM(review_count) > 5000
ORDER BY
	avg_star_rating DESC;

-- Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
-- Answer: 774

SELECT
	DISTINCT title
FROM 
	data_analyst_jobs
WHERE 
	title ILIKE '%analyst%';

SELECT
	COUNT(DISTINCT title) AS count_job_title_analyst
FROM 
	data_analyst_jobs
WHERE 
	title ILIKE '%analyst%';

-- How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
-- What word do these positions have in common?
-- Answer: 4 ; Tableau (Data visualization)

SELECT 
	COUNT(DISTINCT title)
FROM 
	data_analyst_jobs
WHERE 
	title NOT ILIKE '%Analyst%'
	AND title NOT ILIKE '%Analytics%';

SELECT 
	DISTINCT title
FROM 
	data_analyst_jobs
WHERE 
	title NOT ILIKE '%Analyst%'
	AND title NOT ILIKE '%Analytics%';

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. 
-- Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? 
-- How many jobs have been listed for more than 3 weeks for each of the top 4?	

-- Answer: Internet and Software, Banks and Financial Services, Consulting and Business Services
--         Health Care  ;  232

SELECT 
	domain,
	skill,
	days_since_posting
FROM 
 data_analyst_jobs
WHERE 
	skill ILIKE '%SQL%'
	AND domain IS NOT NULL
	AND days_since_posting > 21;

SELECT
	domain,
	COUNT(*) AS hard_to_fill_jobs 
FROM 
	data_analyst_jobs
WHERE 
	skill ILIKE '%SQL%'
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY 
	domain
ORDER BY
	hard_to_fill_jobs DESC
LIMIT 4;







