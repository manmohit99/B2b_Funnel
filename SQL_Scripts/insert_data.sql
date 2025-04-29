INSERT INTO deals
SELECT *
FROM deals_temp
WHERE lead_id IN (SELECT lead_id FROM leads);


INSERT INTO touchpoints
SELECT *
FROM touchpoints_temp
WHERE lead_id IN (SELECT lead_id FROM leads);


SELECT *
FROM touchpoints

DROP TABLE deals_temp;
DROP TABLE touchpoints_temp;