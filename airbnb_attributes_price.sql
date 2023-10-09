-- Which attributes (district, neighborhood, property type, room type, accomodates, bedrooms, amenities) have the most influence on price?
CREATE VIEW attributes AS
SELECT district, neighbourhood,
		property_type, room_type,
		accommodates, bedrooms, amenities,
		price
FROM Listings;

CREATE VIEW district_attr AS
SELECT district, 
		AVG(price) AS district_price
FROM attributes
GROUP BY district;

CREATE VIEW neighborhood_attr AS
SELECT neighbourhood, 
		AVG(price) AS neighborhood_price
FROM attributes
GROUP BY neighbourhood;

CREATE VIEW property_attr AS
SELECT property_type, 
		AVG(price) AS property_price
FROM attributes
GROUP BY property_type;

CREATE VIEW room_attr AS
SELECT room_type, 
		AVG(price) AS room_price
FROM attributes
GROUP BY room_type;

CREATE VIEW amenities_attr AS 
SELECT amenities, 
		AVG(price) AS amenities_price
FROM attributes
GROUP BY amenities;

CREATE VIEW accommodates_attr AS 
SELECT accommodates, 
		AVG(price) AS accommodates_price
FROM attributes
GROUP BY accommodates;

CREATE VIEW bedrooms_attr AS 
SELECT bedrooms, 
		AVG(price) AS bedrooms_price
FROM attributes
GROUP BY bedrooms;

SELECT TOP 1 (SELECT AVG(district_price)
		FROM district_attr) AS avg_of_avg_district,
		(SELECT AVG(neighborhood_price)
		FROM neighborhood_attr) AS avg_of_avg_neighborhood,
		(SELECT AVG(property_price)
		FROM property_attr) AS avg_of_avg_property,
		(SELECT AVG(room_price)
		FROM room_attr) AS avg_of_avg_room,
		(SELECT AVG(amenities_price)
		FROM amenities_attr) AS avg_of_avg_amenities,
		(SELECT AVG(accommodates_price)
		FROM accommodates_attr) AS avg_of_avg_accommodates,
		(SELECT AVG(bedrooms_price)
		FROM bedrooms_attr) AS avg_of_avg_bedrooms
FROM Listings