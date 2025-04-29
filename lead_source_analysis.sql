-- lead source effectiveness

-- which lead sources genrate the most 

SELECT 
    lead_source,
    COUNT(*) AS total_leads
FROM leads
GROUP BY lead_source
ORDER BY total_leads DESC;

-- which lead source has the highest conversion rate
SELECT 
    l.lead_source,
    COUNT(d.lead_id) AS converted_leads,
    COUNT(l.lead_id) AS total_leads,
    ROUND(COUNT(d.lead_id)::NUMERIC / COUNT(l.lead_id) * 100, 2) AS conversion_rate_percent
FROM leads l
LEFT JOIN deals d ON l.lead_id = d.lead_id
GROUP BY l.lead_source
ORDER BY conversion_rate_percent DESC;

-- what is the average deal size perlead source

SELECT 
    l.lead_source,
    ROUND(AVG(d.deal_size), 0) AS avg_deal_size
FROM leads l
JOIN deals d ON l.lead_id = d.lead_id
WHERE d.status = 'Won'
GROUP BY l.lead_source
ORDER BY avg_deal_size DESC;

--Win Percentage per source
SELECT 
    l.lead_source,
    SUM(CASE WHEN d.status = 'Won' THEN 1 ELSE 0 END) AS won_deals,
    COUNT(d.lead_id) AS total_deals,
    ROUND(SUM(CASE WHEN d.status = 'Won' THEN 1 ELSE 0 END)::NUMERIC / COUNT(d.lead_id) * 100, 2) AS win_rate_percent
FROM leads l
JOIN deals d ON l.lead_id = d.lead_id
GROUP BY l.lead_source
ORDER BY win_rate_percent DESC;

