CREATE TABLE start_ziel_jugendgruppe AS
-- Common Table Expression für die Selektion der Nachtclubs
WITH sel AS(SELECT * from pois WHERE category = 'nightlife')
-- AirBNB
SELECT id, edge_id, geom, fraction, from_to
FROM jugendgruppe
UNION ALL

-- Ziele (die drei Clubs die am nächsten beieinander liegen
SELECT id, edge_id, geom, fraction, from_to FROM (
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
	ON pois.id IN (clubs.id, clubs.id2, clubs.id3)
	) AS temp


-- Travelling Sales Person zwischen den Zielen
CREATE TABLE tsp_jugendgruppe AS
SELECT * FROM pgr_TSP(
    $$
    SELECT * FROM pgr_withPointsCostMatrix(
        'SELECT id, source, target, cost, rev_cost as reverse_cost FROM edge ORDER BY id',
        'SELECT id AS pid, edge_id, fraction from start_ziel_jugendgruppe',
        ARRAY[-3185091, -90, -119, -12], 
		directed := false)
    $$,
    start_id := -3185091,
    randomize := false
);


-- Vom AirBNB zum Donauturm
CREATE TABLE full_routing_jugendgruppe AS
SELECT route.*, edge.geom FROM pgr_withpoints(
    'SELECT id, source, target, cost, rev_cost FROM edge ORDER BY id',
    'SELECT id as pid, edge_id, fraction from start_ziel_jugendgruppe',
	ARRAY[-3185091, -90, -119, -12],
	ARRAY[-3185091, -90, -119, -12],
	directed := false) AS route
JOIN edge ON route.edge = edge.id
ORDER BY seq;