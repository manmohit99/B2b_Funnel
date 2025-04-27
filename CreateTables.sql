


CREATE TABLE leads (
    lead_id INTEGER PRIMARY KEY,
    company_name TEXT,
    industry TEXT,
    lead_source TEXT,
    created_at DATE
);

CREATE TABLE touchpoints (
    touchpoint_id INTEGER PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(lead_id),
    channel TEXT,
    interaction_type TEXT,
    timestamp TIMESTAMP
);

CREATE TABLE deals (
    lead_id INTEGER PRIMARY KEY REFERENCES leads(lead_id),
    status TEXT,
    deal_size INTEGER,
    stage TEXT,
    closed_date DATE
);

CREATE TABLE deals_temp (
    lead_id INTEGER,
    status TEXT,
    deal_size INTEGER,
    stage TEXT,
    closed_date DATE
);

CREATE TABLE touchpoints_temp (
    touchpoint_id INTEGER PRIMARY KEY,
    lead_id INT,
    channel TEXT,
    interaction_type TEXT,
    timestamp TIMESTAMP
);