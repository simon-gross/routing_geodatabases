-- Temporäre Tabelle mit Airbnb und Pois
CREATE TABLE start_ziel_yuppies AS
-- AirBNB
SELECT id, edge_id, geom, fraction, from_to
FROM yuppies
UNION ALL
-- Ziele 
SELECT id, edge_id, geom, fraction, from_to
FROM pois
WHERE id = 18 OR id = 59 OR id = 100 OR id = 129;


-- Travelling Sales Person zwischen den Zielen
CREATE TABLE tsp_yuppies AS
SELECT * FROM pgr_TSP(
    $$
    SELECT * FROM pgr_withPointsCostMatrix(
        'SELECT id, source, target, cost, rev_cost as reverse_cost FROM edge ORDER BY id',
        'SELECT id AS pid, edge_id, fraction from start_ziel_yuppies',
		ARRAY[-722218494877165719, -59, -100, -18, -129], 
		directed := false)
    $$,
    start_id := -722218494877165719,
    randomize := false
);

-- Vom AirBNB zum Donauturm
CREATE TABLE full_routing_yuppies AS
SELECT route.*, edge.geom FROM pgr_withpoints(
    'SELECT id, source, target, cost, rev_cost FROM edge ORDER BY id',
    'SELECT id as pid, edge_id, fraction from start_ziel_yuppies',
	ARRAY[-722218494877165719, -59, -100, -18, -129],
	ARRAY[-722218494877165719, -59, -100, -18, -129],
	directed := false) AS route
JOIN edge ON route.edge = edge.id
ORDER BY seq;