-- Erstelle temporäre Tabelle mit den nächsten edges für jeden poi
CREATE TABLE links_temp AS
	(SELECT a_id, edge_id, distance_to_edge, fraction
	FROM (
		SELECT auswahl.id AS a_id,
			edge.id AS edge_id,
			ST_DISTANCE(edge.geom, auswahl.geom) AS distance_to_edge,
			ST_LINELOCATEPOINT(edge.geom, auswahl.geom) AS fraction,
			ROW_NUMBER() OVER (PARTITION BY auswahl.id ORDER BY ST_DISTANCE(edge.geom, auswahl.geom)) AS rn
		FROM edge, pois AS auswahl
		GROUP BY auswahl.id, edge.id, ST_LINELOCATEPOINT(edge.geom, auswahl.geom)
	) AS subquery
	WHERE rn = 1
	)