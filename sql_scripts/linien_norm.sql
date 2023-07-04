CREATE TABLE linien_norm AS SELECT * FROM linien_raw WHERE 1=0;

INSERT INTO linien_norm 
SELECT id, geom, objectid, ltyp, ltyptxt, 
       regexp_replace(unnest(string_to_array(t.lbezeichnu, ',')), '\s', '', 'g') AS lbezeichnu
FROM linien_raw t;