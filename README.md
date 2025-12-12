
# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project performs a detailed analysis of Netflix's movies and TV shows dataset using SQL. The goal is to derive actionable insights, explore trends, and answer key business questions regarding content distribution, ratings, genres, countries, and more.

## Objectives

- Analyze the distribution of content types (Movies vs TV Shows).  
- Identify the most common ratings for different content types.  
- List movies released in specific years and TV shows with multiple seasons.  
- Explore content by countries, directors, and actors.  
- Categorize content based on keywords like "kill" and "violence".  

## Dataset

- **Dataset Link:** [Netflix Movies & TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)  

## Schema

```sql
DROP TABLE IF EXISTS nexflix;
CREATE TABLE nexflix
(
    show_id      VARCHAR(5),
    typee        VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    castt        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
````

## SQL Queries and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
    typee,
    COUNT(*) AS total_content 
FROM nexflix
GROUP BY typee;
```

**Objective:** Understand the distribution of content types on Netflix.

---

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
SELECT
    typee, 
    rating, 
    COUNT(*) AS count_rating
FROM nexflix
GROUP BY typee, rating
ORDER BY typee, COUNT(*) DESC;
```

**Objective:** Identify the most frequent ratings by content type.

---

### 3. List All Movies Released in 2020

```sql
SELECT * 
FROM nexflix
WHERE typee = 'Movie'
  AND release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

---

### 4. Find the Top 5 Countries with the Most Content

```sql
SELECT TOP 5
    country, 
    COUNT(*) AS total_content
FROM nexflix
WHERE country IS NOT NULL AND country <> ''
GROUP BY country
ORDER BY total_content DESC;
```

**Objective:** Identify countries with the highest content count.

---

### 5. Identify the Longest Movie

```sql
SELECT TOP 1 *
FROM nexflix
WHERE typee = 'Movie'
ORDER BY CAST(REPLACE(duration, ' min', '') AS INT) DESC;
```

**Objective:** Find the movie with the longest duration.

---

### 6. Find Content Added in the Last 5 Years

```sql
SELECT *
FROM nexflix
WHERE TRY_CONVERT(DATE, date_added) >= DATEADD(YEAR, -5, GETDATE());
```

**Objective:** Retrieve recently added content.

---

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT *
FROM nexflix
WHERE director LIKE '%Rajiv Chilaka%';
```

**Objective:** List all works by a specific director.

---

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM nexflix
WHERE typee = 'TV Show'
  AND CAST(REPLACE(REPLACE(duration, ' Seasons', ''), ' Season', '') AS INT) > 5;
```

**Objective:** Identify long-running TV shows.

---

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT listed_in AS genre, 
       COUNT(*) AS total_content
FROM nexflix
GROUP BY listed_in
ORDER BY total_content DESC;
```

**Objective:** Determine genre popularity on Netflix.

---

### 10. Average Number of Content Released Each Year in India

```sql
SELECT release_year,
       COUNT(*) AS total_content,
       (SELECT AVG(yearly_total)
        FROM (
            SELECT COUNT(*) AS yearly_total
            FROM nexflix
            WHERE country LIKE '%India%'
            GROUP BY release_year
        ) AS t) AS avg_per_year
FROM nexflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC;
```

**Objective:** Analyze yearly content trends in India.

---

### 11. List All Documentary Movies

```sql
SELECT *
FROM nexflix
WHERE typee = 'Movie'
  AND listed_in LIKE '%Documentar%';
```

**Objective:** Retrieve documentary movies.

---

### 12. Find Content Without a Director

```sql
SELECT *
FROM nexflix
WHERE director IS NULL OR director = '';
```

**Objective:** Identify content missing director information.

---

### 13. Count Movies Actor 'Salman Khan' Appeared in Last 10 Years

```sql
SELECT COUNT(*) AS total_movies
FROM nexflix
WHERE typee = 'Movie'
  AND castt LIKE '%Salman Khan%'
  AND release_year >= YEAR(GETDATE()) - 10;
```

**Objective:** Track actor appearances over time.

---

### 14. Top 10 Actors in Indian Movies

```sql
SELECT TOP 10
    TRIM(value) AS actor,
    COUNT(*) AS movie_count
FROM nexflix
CROSS APPLY STRING_SPLIT(castt, ',')
WHERE typee = 'Movie'
  AND country LIKE '%India%'
  AND TRIM(value) <> ''
GROUP BY TRIM(value)
ORDER BY movie_count DESC;
```

**Objective:** Find the most prolific actors in Indian content.

---

### 15. Categorize Content as 'Good' or 'Bad'

```sql
SELECT 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' 
          OR LOWER(description) LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total_items
FROM nexflix
GROUP BY CASE 
            WHEN LOWER(description) LIKE '%kill%' 
              OR LOWER(description) LIKE '%violence%' 
            THEN 'Bad'
            ELSE 'Good'
         END;
```

**Objective:** Categorize content based on keywords in descriptions.

---

## Findings and Conclusion

* **Content Distribution:** The dataset includes a variety of movies and TV shows.
* **Ratings Insights:** Most content falls under specific ratings, reflecting target audiences.
* **Geographical Trends:** India and a few other countries contribute the most content.
* **Content Categorization:** Keywords help separate violent content from general content.

This analysis provides actionable insights for content strategy, audience engagement, and understanding Netflix’s global offerings.




