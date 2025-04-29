-- Time & Sales cycle insights

-- average time from lead createion to deal closure

SELECT 
    d.status,
    ROUND(AVG(d.closed_date - l.created_at), 2) AS avg_days
FROM deals d
JOIN leads l ON d.lead_id = l.lead_id
GROUP BY d.status
ORDER BY avg_days ASC;


-- how does time to close vary by source or deal status?

SELECT 
    ROUND(AVG(d.closed_date - l.created_at), 2) AS avg_days_to_close
FROM deals d
JOIN leads l ON d.lead_id = l.lead_id
WHERE d.status = 'Won';


-- are Quicker deals more likely to close successfully?

SELECT 
    d.status,
    ROUND(AVG(d.closed_date - l.created_at), 2) AS avg_days
FROM deals d
JOIN leads l ON d.lead_id = l.lead_id
GROUP BY d.status
ORDER BY avg_days ASC;


