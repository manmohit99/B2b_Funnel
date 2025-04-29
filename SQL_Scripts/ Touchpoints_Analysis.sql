-- Touchpoints & Journey Analysis

-- avg number of touchpoints per lead

SELECT 
    ROUND(AVG(touch_count), 2) AS avg_touchpoints_per_lead
FROM (
    SELECT 
        lead_id, 
        COUNT(*) AS touch_count
    FROM touchpoints
    GROUP BY lead_id
) AS subquery;


-- do leads with more touchpoints convert better??
WITH lead_touchpoints AS (
    SELECT 
        lead_id, 
        COUNT(*) AS touch_count
    FROM touchpoints
    GROUP BY lead_id
-- convert into 2 groups leads that converted and ones that didn't
)
SELECT 
    CASE WHEN d.lead_id IS NOT NULL THEN 'Converted' ELSE 'Not Converted' END AS conversion_status,
    ROUND(AVG(touch_count), 2) AS avg_touchpoints
FROM lead_touchpoints lt
LEFT JOIN deals d ON lt.lead_id = d.lead_id
GROUP BY conversion_status;




-- which channels are used most in successfull deals

SELECT 
    tp.channel,
    COUNT(*) AS num_touchpoints
FROM touchpoints tp
JOIN deals d ON tp.lead_id = d.lead_id
WHERE d.status = 'Won'
GROUP BY tp.channel
ORDER BY num_touchpoints DESC;

