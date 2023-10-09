-- What is the average overall rating per lisiting by attribute?

CREATE VIEW attributes_rating AS
SELECT district, neighbourhood,
		property_type, room_type,
		accommodates, bedrooms, amenities,
		review_scores_rating
FROM Listings;

CREATE VIEW district_rate AS
SELECT district, 
		AVG(review_scores_rating) AS district_rating
FROM attributes_rating
GROUP BY district;

CREATE VIEW neighborhood_rate AS
SELECT neighbourhood, 
		AVG(review_scores_rating) AS neighborhood_rating
FROM attributes_rating
GROUP BY neighbourhood;

CREATE VIEW property_rate AS
SELECT property_type, 
		AVG(review_scores_rating) AS property_rating
FROM attributes_rating
GROUP BY property_type;

CREATE VIEW room_rate AS
SELECT room_type, 
		AVG(review_scores_rating) AS room_rating
FROM attributes_rating
GROUP BY room_type;

CREATE VIEW amenities_rate AS 
SELECT amenities, 
		AVG(review_scores_rating) AS amenities_rating
FROM attributes_rating
GROUP BY amenities;

CREATE VIEW accommodates_rate AS 
SELECT accommodates, 
		AVG(review_scores_rating) AS accommodates_rating
FROM attributes_rating
GROUP BY accommodates;

CREATE VIEW bedrooms_rate AS 
SELECT bedrooms, 
		AVG(review_scores_rating) AS bedrooms_rating
FROM attributes_rating
GROUP BY bedrooms;

SELECT TOP 1 (SELECT AVG(district_rating)
		FROM district_rate) AS avg_district_rating,
		(SELECT AVG(neighborhood_rating)
		FROM neighborhood_rate) AS avg_neighborhood_rating,
		(SELECT AVG(property_rating)
		FROM property_rate) AS avg_property_rating,
		(SELECT AVG(room_rating)
		FROM room_rate) AS avg_room_rating,
		(SELECT AVG(amenities_rating)
		FROM amenities_rate) AS avg_amenities_rating,
		(SELECT AVG(accommodates_rating)
		FROM accommodates_rate) AS avg_accommodates_rating,
		(SELECT AVG(bedrooms_rating)
		FROM bedrooms_rate) AS avg_bedrooms_rating
FROM Listings;