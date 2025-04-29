-- Revenue Forecasting and Growth potential

-- which industries bring the highest revenue?

SELECT 
    l.industry,
    SUM(d.deal_size) AS total_revenue
FROM leads l
JOIN deals d ON l.lead_id = d.lead_id
WHERE d.status = 'Won'
GROUP BY l.industry
ORDER BY total_revenue DESC;

--Are there sources or industries that consistently close higher-value deals?

SELECT -- by source
    l.lead_source,
    ROUND(AVG(d.deal_size), 2) AS avg_deal_size
FROM leads l
JOIN deals d ON l.lead_id = d.lead_id
WHERE d.status = 'Won'
GROUP BY l.lead_source
ORDER BY avg_deal_size DESC;


-- by industry
SELECT 
    l.industry,
    ROUND(AVG(d.deal_size), 2) AS avg_deal_size
FROM leads l
JOIN deals d ON l.lead_id = d.lead_id
WHERE d.status = 'Won'
GROUP BY l.industry
ORDER BY avg_deal_size DESC;

-- What’s the projected revenue if conversion rate improves by 10%?
WITH current_numbers AS (
    SELECT 
        (SELECT COUNT(*) FROM leads) AS total_leads,
        (SELECT COUNT(*) FROM deals WHERE status = 'Won') AS total_won_deals,
        (SELECT SUM(deal_size) FROM deals WHERE status = 'Won') AS total_revenue
),
projection AS (
    SELECT 
        total_leads,
        total_won_deals,
        total_revenue,
        ROUND((total_won_deals::NUMERIC / total_leads) * 100, 2) AS current_conversion_rate_percent,
        ROUND(((total_won_deals * 1.10) / total_leads) * 100, 2) AS projected_conversion_rate_percent,
        ROUND(total_revenue * 1.10) AS projected_revenue
    FROM current_numbers
)
SELECT *
FROM projection;

