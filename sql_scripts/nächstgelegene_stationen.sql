ALTER TABLE airbnbs ADD COLUMN station_id INTEGER;

UPDATE airbnbs
SET station_id = (
	SELECT id
	FROM stops
	ORDER BY airbnbs.geom <-> stops.geom
	LIMIT 1
);

ALTER TABLE airbnbs ADD CONSTRAINT fk_airbnbs_station_id
    FOREIGN KEY (station_id)
    REFERENCES stops(id);