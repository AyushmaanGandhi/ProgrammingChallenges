# Ayushmaan Gandhi PMG SQL Challenge


# Question 1

SELECT date, sum(impressions) AS total_impressions 
FROM marketing_performance 
GROUP BY date;



# Question 2

SELECT state, sum(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY sum(revenue) DESC
LIMIT 3;
# The third best state, OH, generated $37577 in revenue.



# Question 3

SELECT ma.campaign_id, ma.name AS campaign_name, ma.total_cost, ma.total_impressions, ma.total_clicks, ra.total_revenue
FROM 
    (SELECT m.campaign_id, c.name, SUM(m.cost) AS total_cost, SUM(m.impressions) AS total_impressions, SUM(m.clicks) AS total_clicks
    FROM marketing_performance AS m
    LEFT JOIN campaign_info AS c
    ON m.campaign_id = c.id
    GROUP BY m.campaign_id, c.name) AS ma
LEFT JOIN 
    (SELECT campaign_id, SUM(revenue) AS total_revenue
    FROM website_revenue
    GROUP BY campaign_id) AS ra
ON ma.campaign_id = ra.campaign_id
ORDER BY ma.name;



# Question 4

SELECT geo, sum(conversions) AS total_conversions
FROM marketing_performance AS m
LEFT JOIN campaign_info AS c
ON m.campaign_id = c.id
WHERE name = 'Campaign5'
GROUP BY geo;
# GA generated the most conversions for Campaign5.



# Question 5

# Let's first take a look at which campaign had the most conversions.

SELECT name, sum(conversions) AS total_conversions
FROM marketing_performance AS m
LEFT JOIN campaign_info AS c
ON m.campaign_id = c.id
GROUP BY name
ORDER BY total_conversions DESC;

# Campaign3 had the most conversions.
# Let's now take a look at which campaign had the most profit.

SELECT ma.name, ra.total_revenue - ma.total_cost AS profit
FROM 
    (SELECT m.campaign_id, c.name, SUM(m.cost) AS total_cost
    FROM marketing_performance AS m
    LEFT JOIN campaign_info AS c
    ON m.campaign_id = c.id
    GROUP BY m.campaign_id, c.name) AS ma
LEFT JOIN 
    (SELECT campaign_id, SUM(revenue) AS total_revenue
    FROM website_revenue
    GROUP BY campaign_id) AS ra
ON ma.campaign_id = ra.campaign_id
ORDER BY profit DESC;

# Looks like Campaign3 had the most profit as well.
# Since Campaign3 had both the greatest number of conversions and profit, I think it was the most efficient.



# Question 6

SELECT DAYNAME(date) AS day, SUM(clicks) / SUM(impressions) AS ratio
FROM marketing_performance
GROUP BY DAYNAME(date)
ORDER BY ratio DESC
LIMIT 1;


