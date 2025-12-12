-- craete db first 
CREATE DATABASE netflix_db 
-- after craeteing the db, the have to create table inside the db, however, we have to check the raw data first, check the columns, contents, data types, max lenght etc etc in order to build the table. 
DROP TABLE IF EXISTS nexflix; -- 
CREATE TABLE nexflix -- datatype are set based on the raw data, as we'll be importing the data 
(
	show_id	VARCHAR(5), 
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

-- Importing the data to the table, we just created 

BULK INSERT dbo.nexflix
FROM 'C:\Users\User\Desktop\SQL\nexflix\nexflix.csv'
WITH (
    FORMAT='CSV',
    FIRSTROW=2, -- important to note this, as we have the actual information from the second now, we dont need to columns as we already have those in our table 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001'
);
