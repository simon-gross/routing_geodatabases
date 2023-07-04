-- Correlated Subquery um die Spalten richtig hinzuzufügen
UPDATE pois
SET distance_to_edge = (
    SELECT links_temp.distance_to_edge 
	FROM links_temp 
	WHERE links_temp.a_id = pois.id
),
edge_id = (
    SELECT links_temp.edge_id 
	FROM links_temp 
	WHERE links_temp.a_id = pois.id
),
fraction = (
    SELECT links_temp.fraction 
	FROM links_temp 
	WHERE links_temp.a_id = pois.id
)