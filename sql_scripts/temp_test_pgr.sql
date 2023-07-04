SELECT * FROM pgr_TSP(
    $$
    SELECT * FROM pgr_withPointsCostMatrix(
        'SELECT id, source, target, cost, rev_cost as reverse_cost FROM edge ORDER BY id',
        'SELECT id AS pid, edge_id, fraction from start_ziel_familie',
        array[-29852202, -34, -47], 
		directed := false)
    $$,
    start_id := -29852202,
    randomize := false
);


-- Schritt 1: Erstellen Sie eine temporäre Tabelle mit den Start- und Zielpunkten
CREATE TABLE start_ziel_familie AS
SELECT id, edge_id, geom, fraction, from_to
FROM familie
UNION ALL
SELECT id, edge_id, geom, fraction, from_to
FROM pois
WHERE id = 34 OR id = 47;

-- Vom AirBNB zum Donauturm
CREATE TABLE routing_familie AS
SELECT route.*, edge.geom FROM pgr_withPoints(
    'SELECT id, source, target, cost, rev_cost FROM edge ORDER BY id',
    'SELECT id as pid, edge_id, fraction from start_ziel_familie',
	-29852202,
	-34,
	directed := false) AS route
JOIN edge ON route.edge = edge.id
ORDER BY seq