-- Funnel performance analysis

-- total # of leads
SELECT
	COUNT(*) AS total_leads
FROM leads;

-- how many of the leads converted into deals
-- total leads/ total deals
-- doesn't mean they closed the deals
SELECT 
    ROUND(COUNT(DISTINCT deals.lead_id)::NUMERIC / COUNT(DISTINCT leads.lead_id) * 100, 2) AS conversion_rate_percent
FROM leads
LEFT JOIN deals ON leads.lead_id = deals.lead_id;


-- average deal size and total revenue
SELECT 
	ROUND(AVG(deal_size),2) AS AVG_Deal_Size,
	SUM(deal_size)
FROM deals
Where status = 'Won';


-- what is the win rate
SELECT status,
COUNT(*) as Num_deals,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percent_of_total
FROM deals
GROUP BY status


-- create a funnel_summary view
CREATE OR REPLACE VIEW funnel_summary AS
WITH total_leads_cte AS (
    SELECT COUNT(*) AS total_leads
    FROM leads
),
converted_leads_cte AS (
    SELECT COUNT(DISTINCT deals.lead_id) AS converted_leads
    FROM deals
),
conversion_rate_cte AS (
    SELECT 
        ROUND(
            (SELECT converted_leads FROM converted_leads_cte)::NUMERIC 
            / (SELECT total_leads FROM total_leads_cte) * 100, 2
        ) AS conversion_rate_percent
),
revenue_cte AS (
    SELECT 
        ROUND(AVG(deal_size), 2) AS avg_deal_size,
        SUM(deal_size) AS total_revenue
    FROM deals
    WHERE status = 'Won'
),
win_rate_cte AS (
    SELECT 
        SUM(CASE WHEN status = 'Won' THEN 1 ELSE 0 END) AS won_deals,
        SUM(CASE WHEN status = 'Lost' THEN 1 ELSE 0 END) AS lost_deals
    FROM deals
)
SELECT 
    (SELECT total_leads FROM total_leads_cte) AS total_leads,
    (SELECT converted_leads FROM converted_leads_cte) AS total_converted_leads,
    (SELECT conversion_rate_percent FROM conversion_rate_cte) AS conversion_rate_percent,
    (SELECT avg_deal_size FROM revenue_cte) AS average_deal_size,
    (SELECT total_revenue FROM revenue_cte) AS total_revenue,
    (SELECT won_deals FROM win_rate_cte) AS total_won_deals,
    (SELECT lost_deals FROM win_rate_cte) AS total_lost_deals;


-- to look the view we'll simple run this query
SELECT * FROM funnel_summary;