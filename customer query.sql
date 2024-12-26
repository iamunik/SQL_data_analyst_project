-- Total number of customers from each region
SELECT 
    region,
    COUNT("customerID") AS total_customers
FROM 
    customer_data 
GROUP BY 
    region
ORDER BY 
    total_customers DESC;

-- Most popular subscription type by number of customers
SELECT 
    "subscriptionType",
    COUNT("customerID") AS customer_count
FROM 
    customer_data
GROUP BY 
    "subscriptionType"
ORDER BY 
    customer_count DESC
LIMIT 1;

-- Customers who cancelled ther subscription within 6 months
SELECT 
    "customerID",
    "customer_name",
    "region",
    "subscriptionType",
    "subscriptionStart",
    "subscriptionEnds"
FROM 
    customer_data
WHERE 
    cancelled = 'TRUE'
    AND "subscriptionEnds" <= "subscriptionStart" + INTERVAL '6 months';

-- calculate average subscription duration for all customers
SELECT 
    AVG(
		"subscriptionEnds" - "subscriptionStart"
	) AS avg_subscription_duration_days
FROM 
    customer_data;

-- Customers with subscription longer than 12 months	
SELECT 
    "customerID",
    "customer_name",
    "region",
    "subscriptionType"
FROM 
    customer_data
WHERE 
    AGE("subscriptionEnds", "subscriptionStart") > INTERVAL '12 months'
ORDER BY 
	"customer_name" ASC
LIMIT 1;

-- Total revenue by subcription type
SELECT 
    "subscriptionType",
    SUM("revenue") AS total_revenue
FROM 
    customer_data 
GROUP BY 
    "subscriptionType"
ORDER BY 
    total_revenue DESC;

-- Top 3 regions by subcription cancellations
SELECT 
    region,
    COUNT("customerID") AS cancellations
FROM 
    customer_data
WHERE 
    cancelled = 'TRUE'
GROUP BY 
    region
ORDER BY 
    cancellations DESC
LIMIT 3;

-- Total number of active and cancelled subscriptions
SELECT 
    COUNT(
		CASE WHEN cancelled = 'FALSE' THEN 1 END
	) AS active_subscriptions,
    COUNT(
		CASE WHEN cancelled = 'TRUE' THEN 1 END
	) AS cancelled_subscriptions
FROM 
    customer_data; 
