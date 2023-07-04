-- Jungendgruppe
SELECT * FROM airbnbs
WHERE price_int <= 200 AND
	beds >= 10 AND
	review_scores_rating >= 3 AND
	property_type = 'Entire rental unit' AND
	amenities LIKE '%Kitchen%'
ORDER BY price ASC
LIMIT 1

-- Familie mit Kinder
-- Familie mit Kinder
SELECT *, ST_DISTANCE(a.geom, s.geom) FROM airbnbs a, stephansdom s
WHERE a.price_int <= 300 AND
	a.beds >= 4 AND
	a.host_is_superhost = 'True' AND
	a.amenities LIKE '%Security cameras on property%' AND
	a.amenities LIKE '%Pets allowed%' AND
	a.amenities LIKE '%Elevator%'
ORDER BY ST_DISTANCE(a.geom, s.geom)
LIMIT 5;

-- YUPPIs
SELECT * FROM airbnbs a, stephansdom s
WHERE a.host_is_superhost = 'True' AND
	a.amenities LIKE '%Wifi%' AND
	a.amenities LIKE '%Dedicated workspace%' AND
	(ST_DISTANCE(a.geom, s.geom) < 1000 OR a.neighbourhood_cleansed = 'Innere Stadt') AND
	a.review_scores_rating > 4.5 AND
	a.review_scores_cleanliness  > 4.8
ORDER BY a.review_scores_rating ASC
LIMIT 5;