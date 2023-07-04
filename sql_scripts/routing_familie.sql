-- Temporäre Tabelle mit Airbnb und Pois
CREATE TABLE start_ziel_familie AS
-- AirBNB
SELECT id, edge_id, geom, fraction, from_to
FROM familie
UNION ALL
-- Ziele 
SELECT id, edge_id, geom, fraction, from_to
FROM pois
WHERE id = 34 OR id = 88 OR id = 99;


-- Travelling Sales Person zwischen den Zielen
CREATE TABLE tsp_familie AS
SELECT * FROM pgr_TSP(
    $$
    SELECT * FROM pgr_withPointsCostMatrix(
        'SELECT id, source, target, cost, rev_cost as reverse_cost FROM edge ORDER BY id',
        'SELECT id AS pid, edge_id, fraction from start_ziel_familie',
        array[-29852202, -34, -88, -99], 
		directed := false)
    $$,
    start_id := -29852202,
    randomize := false
);

-- Vom AirBNB zum Donauturm
CREATE TABLE full_routing_familie AS
SELECT route.*, edge.geom FROM pgr_withpoints(
    'SELECT id, source, target, cost, rev_cost FROM edge ORDER BY id',
    'SELECT id as pid, edge_id, fraction from start_ziel_familie',
	ARRAY[-29852202, -99, -34, -88],
	ARRAY[-99, -34, -88, -29852202],
	directed := false) AS route
JOIN edge ON route.edge = edge.id
ORDER BY seq;