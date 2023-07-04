-- Erstelle neue Spalten in der Tabelle familie (wiederhole für andere Tabellen)
ALTER TABLE familie
ADD COLUMN edge_id INT DEFAULT 0,
ADD COLUMN distance_to_edge FLOAT DEFAULT 0.0,
ADD COLUMN fraction FLOAT DEFAULT 0.0;

-- Neue Werte für die erstellten Spalten
-- sub ist der temporäre Name der Abfrage unten
UPDATE familie 
SET edge_id = sub.edge_id, 
	distance_to_edge = sub.distance_to_edge, 
	fraction = sub.fraction
FROM (
-- Werte werden aus einer Zwischenselektion genommen. Diese gibt die id, die Distanz und den Bruchteil der Kante zurück, die 
-- Dem Airbnb am nächsten liegt
	SELECT edge.id edge_id,
		MIN(ST_DISTANCE(edge.geom, auswahl.geom)) distance_to_edge,
		ST_LINELOCATEPOINT(edge.geom, auswahl.geom) fraction
	FROM
		edge,
		familie as auswahl
	GROUP BY
		auswahl.id,
		edge.id,
		ST_LINELOCATEPOINT(edge.geom, auswahl.geom)
	ORDER BY
		distance_to_edge
	LIMIT 1) AS sub
