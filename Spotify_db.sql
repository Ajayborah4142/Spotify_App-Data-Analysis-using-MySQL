DROP DATABASE IF EXISTS Spotify;
CREATE DATABASE Spotify;
USE Spotify;

DROP TABLE IF EXISTS spotify_data;

CREATE TABLE spotify_data (
spotify_track_uri VARCHAR(200) ,
date DATE ,
platform VARCHAR(100) ,
ms_played INT ,
track_name VARCHAR(100) ,
artist_name VARCHAR(100) ,
album_name VARCHAR(100) ,
reason_start VARCHAR(100) ,
reason_end VARCHAR(100) ,
shuffle VARCHAR(50) ,
skipped VARCHAR(20)

);

SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE 'C:/Users/Lenovo/OneDrive/Documents/SQL Programming/spotify_history2.csv'  INTO TABLE spotify_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


--- 1) How To Look Your Data 

SELECT * FROM spotify_data;

--- 2) Find Maximum And Minimum Played Songs

SELECT MAX(ms_played), MIN(ms_played) 
FROM spotify_data ; 

--- 3) Find the Top 10 Most Popular Songs 


SELECT 
    track_name, MAX(ms_played) AS Total
FROM
    spotify_data
GROUP BY track_name
ORDER BY Total DESC
LIMIT 10;

--- 4) List Of  Artists in Your Database 

SELECT DISTINCT artist_name FROM spotify_data ;

--- 5) Find the all Duplicate Rows In Table

SELECT 
    spotify_track_uri,
    date,
    platform,
    ms_played,
    track_name,
    artist_name,
    album_name,
    reason_start,
    reason_end,
    shuffle,
    skipped,
    COUNT(*)
FROM
    spotify_data
GROUP BY spotify_track_uri , date , platform , ms_played , track_name , artist_name , album_name , reason_start , reason_end , shuffle , skipped
HAVING COUNT(*) > 1 ;  


--- 6) Top 5 Platform with Most Songs In The Dataset

SELECT 
    platform, MAX(ms_played) AS ms_played
FROM
    spotify_data
GROUP BY platform
ORDER BY ms_played DESC
LIMIT 5;


--- 7) Average Songs Played by Artist name 

SELECT 
    AVG(ms_played) AS Average_Of_Each_Song, artist_name
FROM
    spotify_data
GROUP BY artist_name
ORDER BY Average_Of_Each_Song DESC;

--- 8) Songs Released After 2020 With Popular Over 80 

SELECT EXTRACT(YEAR FROM date) AS Year, ms_played, track_name
FROM spotify_data
WHERE EXTRACT(YEAR FROM date) > 2020
ORDER BY ms_played DESC
LIMIT 80 ;

--- 9)Crete New Column Hr_played And  Ms_played Convert to Hours in Hr_played 

ALTER TABLE spotify_data
ADD COLUMN hr_played INT DEFAULT 0;

UPDATE spotify_data 
SET hr_played = ms_played / 60
WHERE hr_played = 0 ;

SET SQL_SAFE_UPDATES = 0;

--- 10) Top 10 Most Played Album Names 

SELECT 
    album_name,
    SUM(hr_played) AS Total_Played_In_Hours
FROM
    spotify_data
GROUP BY album_name
ORDER BY Total_Played_In_Hours DESC
LIMIT 10;










