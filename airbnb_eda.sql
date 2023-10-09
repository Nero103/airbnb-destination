/* Exploratory Data Analysis */

/* KPI */

-- How many listings are there? - KPI
SELECT COUNT(*) AS total_lisitngs
FROM Listings;

-- What is the average price of lisitngs? - KPI
SELECT AVG(price) AS avg_price
FROM Listings;

-- What is the average overall review score? - KPI
SELECT AVG(review_scores_rating) AS avg_review_score
FROM Listings;

-- What is the average accuarcy? - KPI
SELECT AVG(review_scores_accuracy) AS avg_accuracy
FROM Listings;

-- What is the average cleanliness? - KPI
SELECT AVG(review_scores_cleanliness) AS avg_cleanliness
FROM Listings;

-- What is the average checkin? - KPI
SELECT AVG(review_scores_checkin) AS avg_checkin
FROM Listings;

-- What is the average communication? - KPI
SELECT AVG(review_scores_communication) AS avg_communication
FROM Listings;

-- What is the average location? - KPI
SELECT AVG(review_scores_location) AS avg_location
FROM Listings;

-- What is the average value? - KPI
SELECT AVG(review_scores_value) AS avg_value
FROM Listings;

-- What is the average host response rate? - KPI
SELECT AVG(CAST(host_response_rate AS FLOAT)) AS avg_reponse_rate
FROM Listings;

-- What is the average host accepting rate? - KPI
SELECT AVG(CAST(host_acceptance_rate AS FLOAT)) AS avg_accepting_rate
FROM Listings;

/* Distributions */

-- What is the distribution of listings by property type?
SELECT property_type,
		COUNT(*) AS total_listings
FROM Listings
GROUP BY property_type
ORDER BY total_listings DESC;

-- How are prices distributed across listings?
SELECT price,
		city,
		COUNT(*) AS price_count
FROM Listings
GROUP BY price, city
ORDER BY price_count DESC, city ASC;

-- What is the distribution of amenities?
SELECT TRIM(REPLACE(REPLACE(REPLACE(value, '"', ''), '[', ''), ']', '')) AS amenity_tag,
		value,
		COUNT(*) AS amenities_count
FROM Listings
	CROSS APPLY string_split(amenities, ',')
GROUP BY value
ORDER BY amenities_count DESC;

-------------------------------------------------------------------------------------------
/* Value of travel */

-- Which host, by location, has the most listings?
SELECT TOP 100 host_id,
		host_location,
		SUM(host_total_listings_count) AS total_listings
FROM Listings
GROUP BY host_id, host_location
HAVING SUM(host_total_listings_count) IS NOT NULL
ORDER BY total_listings DESC;

/* Which city offers better value for travel?

-- How many listings by city have paid parking? How many do not? */
SELECT city,
		COUNT(*) AS paid_parking_count
FROM Listings
WHERE amenities LIKE '%Paid parking%'
GROUP BY city
ORDER BY paid_parking_count DESC;

-- How many listings by city have no paid parking?
SELECT city,
		COUNT(*) AS not_paid_count
FROM Listings
WHERE amenities NOT LIKE '%Paid parking%'
GROUP BY city
ORDER BY Not_paid_count DESC;

-- What is the top ten low-cost listings per price?
SELECT DISTINCT city,
		AVG(price) AS avg_price
FROM Listings
GROUP BY city
ORDER BY avg_price ASC;

-- What listing has the most unpaid parking?
SELECT host_id,
		name, 
		MAX(not_paid_count) AS max_free_parking
FROM (SELECT host_id,
		city,
		name,
		COUNT(*) AS not_paid_count
FROM Listings
WHERE amenities NOT LIKE '%Paid parking%'
GROUP BY host_id, name, city) AS max
GROUP BY host_id, name
ORDER BY max_free_parking DESC;

--------------------------------------------------------------

/* Listings and Hosts Assessment */

-- Which city has the most listings?
SELECT city,
		DENSE_RANK() OVER(ORDER BY SUM(host_total_listings_count) DESC) AS listings_rank,
		SUM(host_total_listings_count) AS total_listing
FROM Listings
GROUP BY city;

-- What is the total average price of listings by city?
SELECT city,
		ROUND(AVG(price), 2) AS avg_price
FROM Listings
GROUP BY city
ORDER BY avg_price DESC;

-- How many Superhosts to hosts are there? What are the proportions?
SELECT COUNT(DISTINCT host_id) AS hosts_count
FROM Listings;

SELECT COUNT(DISTINCT host_id) AS superhosts
FROM Listings
WHERE host_is_superhost = 't';

SELECT COUNT(DISTINCT host_id) AS non_superhosts
FROM Listings
WHERE host_is_superhost = 'f';

WITH hosts AS (
SELECT COUNT(DISTINCT host_id) AS superhosts,
		(SELECT COUNT(DISTINCT host_id)
		FROM Listings
		WHERE host_is_superhost = 'f') AS non_superhosts
FROM Listings
)
SELECT superhosts,
		non_superhosts,
		superhosts + non_superhosts AS hosts_total_count,
		ROUND(CAST(superhosts AS FLOAT) / 
			CAST(superhosts + non_superhosts AS FLOAT),2) AS superhost_percentage,
		ROUND(CAST(non_superhosts AS FLOAT) / 
			CAST(superhosts + non_superhosts AS FLOAT),2) AS non_superhost_percentage
FROM hosts;

-- Do Superhost have better response to booking request than host?
SELECT host_response_time, COUNT(host_response_time) AS host_response, 'superhost' AS source
FROM Listings
WHERE host_is_superhost = 't' AND host_response_time IS NOT NULL
GROUP BY host_response_time
UNION
SELECT host_response_time, COUNT(host_response_time) AS host_response, 'host' AS source
FROM Listings
WHERE host_is_superhost = 'f' AND host_response_time IS NOT NULL
GROUP BY host_response_time
ORDER BY host_response DESC

-- What type of host (profile pic or not) has the most instant bookings?
SELECT COUNT(instant_bookable) AS pic_instant_book_count,
		(SELECT COUNT(instant_bookable) 
		FROM Listings
		WHERE host_has_profile_pic = 'f') AS nopic_instant_book_count
FROM Listings
WHERE host_has_profile_pic = 't';

-- What are the average review scores per listing by city? Which cities are top 5 by overall rating?
SELECT TOP 5 city,
		AVG(review_scores_rating) AS avg_rating_score,
		AVG(review_scores_checkin) AS avg_checkin_score,
		AVG(review_scores_cleanliness) AS avg_cleanliness_score,
		AVG(review_scores_communication) AS avg_communication_score,
		AVG(review_scores_location) AS avg_location_score,
		AVG(review_scores_accuracy) AS avg_accuracy_score,
		AVG(review_scores_value) AS avg_value_score
FROM Listings
GROUP BY city
ORDER BY avg_rating_score DESC

-- Are there any identifiable trends or seasonality in the review data?
CREATE VIEW seasons AS
SELECT l.listing_id, review_id, r.date, name, host_location,
		city, district, neighbourhood, minimum_nights,
		maximum_nights, price, review_scores_rating,
		CASE
		WHEN MONTH(r.date) IN (3,4,5) THEN 'Spring'
		WHEN MONTH(r.date) IN (6,7,8) THEN 'Summer'
		WHEN MONTH(r.date) IN (9,10,11) THEN 'Autumn'
		ELSE 'Winter'
		END AS 'season'
FROM Listings AS l
INNER JOIN Reviews AS r
ON l.listing_id = r.listing_id;

SELECT season,
		COUNT(review_id) AS guests_count
FROM seasons
GROUP BY season
ORDER BY guests_count DESC;

SELECT city, season,
		COUNT(review_id) AS guests_count
FROM seasons
GROUP BY city, season
ORDER BY city ASC, guests_count DESC;