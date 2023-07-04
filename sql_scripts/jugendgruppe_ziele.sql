-- Selektiere die 3 clubs, die am nächsten zueinander sind und speichere in einer neuen Tabelle
CREATE TABLE jugendgruppe_ziele AS

WITH sel AS(SELECT * from pois WHERE category = 'nightlife')

SELECT pois.* 
FROM pois
JOIN (
	SELECT p1.id, p2.id id2, p3.id id3
	FROM sel p1, sel p2, sel p3
	WHERE p1.id <> p2.id
	  AND p1.id <> p3.id
	  AND p2.id <> p3.id
	ORDER BY ST_DISTANCE(p1.geom, p2.geom) + ST_DISTANCE(p1.geom, p3.geom) + ST_DISTANCE(p2.geom, p3.geom)
	LIMIT 1
) AS clubs
ON pois.id IN (clubs.id, clubs.id2, clubs.id3);