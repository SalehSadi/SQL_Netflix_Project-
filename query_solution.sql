-- 1. Count the number of Movies vs TV Shows

SELECT 
     typee,
     COUNT(*) as totat_content 
FROM nexflix
GROUP BY typee

-- 2. Find the most common rating for movies and TV shows

SELECT
        typee, 
        rating, 
    COUNT(*) count_rating
FROM nexflix
GROUP BY typee, rating
ORDER BY typee, 
COUNT(*) DESC;

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * -- this code has all the columns, however one can select specfic columns, instead of the * or the whole table 
FROM nexflix
WHERE typee = 'Movie'
AND release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix

SELECT TOP 5
  country, 
  COUNT(*) AS total_content
FROM nexflix
WHERE country IS NOT NULL AND country <> ''
GROUP BY country
ORDER BY total_content DESC -- Intead of top 5, one can limit to 5 at the end as well 

-- 5. Identify the longest movie

SELECT TOP 1 *
FROM nexflix
WHERE typee = 'Movie'
ORDER BY CAST(REPLACE(duration, ' min', '') AS INT) DESC 

-- 6. Find content added in the last 5 years

SELECT *
FROM nexflix
WHERE TRY_CONVERT(DATE, date_added) >= DATEADD(YEAR, -5, GETDATE()); 

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM nexflix
WHERE director LIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM nexflix
WHERE typee = 'TV Show'
  AND CAST(
        REPLACE(
            REPLACE(duration, ' Seasons', ''),
            ' Season', ''
        ) AS INT
      ) > 5;

-- 9. Count the number of content items in each genre

SELECT listed_in AS genre, 
  COUNT(*) AS total_content
FROM nexflix
GROUP BY listed_in
ORDER BY total_content DESC;

-- 10.Find each year and the average numbers of content release in India on nexflix. 

SELECT release_year,
       COUNT(*) AS total_content,
       (SELECT AVG(yearly_total)
        FROM (
            SELECT COUNT(*) AS yearly_total
            FROM nexflix
            WHERE country LIKE '%India%'
            GROUP BY release_year
        ) AS t
       ) AS avg_per_year
FROM nexflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC

-- 11. List all movies that are documentaries

SELECT *
FROM nexflix
WHERE typee = 'Movie'
AND listed_in LIKE '%Documentar%';

-- 12. Find all content without a director

SELECT *
FROM nexflix
WHERE director IS NULL OR director = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT 
  COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
  AND [cast] LIKE '%Salman Khan%'
  AND release_year >= YEAR(GETDATE()) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT TOP 10
    TRIM(value) AS actor,
    COUNT(*) AS movie_count
FROM nexflix
CROSS APPLY STRING_SPLIT([castt], ',')
WHERE typee = 'Movie'
  AND country LIKE '%India%'
  AND TRIM(value) <> ''
GROUP BY TRIM(value)
ORDER BY movie_count DESC;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

SELECT 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' 
          OR LOWER(description) LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total_items
FROM nexflix
GROUP BY 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' 
          OR LOWER(description) LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END;


















