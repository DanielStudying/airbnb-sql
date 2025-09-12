-- =====================================================
-- 1. TRIPLE RELATIONSHIP QUERIES (Join over three tables)
-- =====================================================

-- Query 1: Guest Booking Analysis with Host and Property Details
-- This query demonstrates a triple relationship between guests, properties, and hosts
-- Shows guest booking patterns, property types, and host performance
SELECT 
    g.user_id,
    up.first_name,
    up.last_name,
    up.guest_since,
    COUNT(b.booking_id) as total_bookings,
    AVG(b.total_price) as avg_booking_value,
    p.property_type,
    p.title as property_title,
    hp.host_since,
    hp.superhost_status,
    hp.response_rate,
    c.city_name,
    n.neighborhood_name
FROM guest_profiles g
JOIN user_profiles up ON g.user_id = up.user_id
JOIN bookings b ON g.user_id = b.guest_id
JOIN properties p ON b.property_id = p.property_id
JOIN host_profiles hp ON p.host_id = hp.user_id
JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
JOIN cities c ON n.city_id = c.city_id
WHERE b.booking_status = 'completed'
GROUP BY g.user_id, up.first_name, up.last_name, up.guest_since, p.property_type, 
         p.title, hp.host_since, hp.superhost_status, hp.response_rate, c.city_name, n.neighborhood_name
ORDER BY total_bookings DESC, avg_booking_value DESC;

-- Query 2: Property Performance Analysis with Amenities and Reviews
-- Triple relationship: Properties, Amenities, and Reviews
-- Analyzes property performance based on amenities and guest satisfaction
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.max_guests,
    p.bedrooms,
    p.bathrooms,
    COUNT(DISTINCT pam.amenity_id) as total_amenities,
    SUM(CASE WHEN pa.amenity_category = 'luxury' THEN 1 ELSE 0 END) as luxury_amenities,
    SUM(CASE WHEN pa.amenity_category = 'basic' THEN 1 ELSE 0 END) as basic_amenities,
    AVG(r.rating) as avg_rating,
    AVG(r.cleanliness_rating) as avg_cleanliness,
    AVG(r.value_rating) as avg_value,
    COUNT(r.review_id) as total_reviews,
    c.city_name,
    n.neighborhood_name,
    n.average_rating as neighborhood_rating
FROM properties p
JOIN property_amenity_mapping pam ON p.property_id = pam.property_id
JOIN property_amenities pa ON pam.amenity_id = pa.amenity_id
JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
JOIN cities c ON n.city_id = c.city_id
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
WHERE pam.is_available = TRUE
GROUP BY p.property_id, p.title, p.property_type, p.max_guests, p.bedrooms, p.bathrooms,
         c.city_name, n.neighborhood_name, n.average_rating
HAVING COUNT(r.review_id) >= 1
ORDER BY avg_rating DESC, total_amenities DESC;

-- Query 3: Financial Analysis with Bookings, Payments, and Commission
-- Triple relationship: Bookings, Payments, and Platform Revenue
-- Analyzes financial performance and commission structure
SELECT 
    c.city_name,
    c.country_code,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_price) as total_revenue,
    AVG(b.total_price) as avg_booking_value,
    SUM(p.amount) as total_payments_received,
    SUM(p.commission_amount) as total_commission,
    ROUND((SUM(p.commission_amount) / SUM(p.amount)) * 100, 2) as commission_percentage,
    COUNT(DISTINCT b.guest_id) as unique_guests,
    COUNT(DISTINCT p.property_id) as unique_properties,
    ROUND(AVG(p.amount), 2) as avg_payment_amount
FROM cities c
JOIN neighborhoods n ON c.city_id = n.city_id
JOIN properties p ON n.neighborhood_id = p.neighborhood_id
JOIN bookings b ON p.property_id = b.property_id
JOIN payments py ON b.booking_id = py.booking_id
WHERE py.payment_status = 'completed'
GROUP BY c.city_name, c.country_code
ORDER BY total_revenue DESC, total_commission DESC;

-- =====================================================
-- 2. RECURSIVE RELATIONSHIP QUERIES
-- =====================================================

-- Query 4: Service Provider Network Analysis
-- Demonstrates recursive relationships in service provider networks
-- Note: This uses Common Table Expression (CTE) syntax that works in most modern databases
WITH RECURSIVE service_network AS (
    -- Base case: direct service providers
    SELECT 
        sp.service_provider_id,
        sp.user_id,
        sp.service_type,
        sp.company_name,
        0 as network_level,
        sp.service_provider_id as network_path
    FROM service_providers sp
    
    UNION ALL
    
    -- Recursive case: connected service providers
    SELECT 
        sp2.service_provider_id,
        sp2.user_id,
        sp2.service_type,
        sp2.company_name,
        sn.network_level + 1,
        CONCAT(sn.network_path, ',', sp2.service_provider_id) as network_path
    FROM service_network sn
    JOIN service_providers sp2 ON sp2.service_type = sn.service_type
    WHERE sp2.service_provider_id != sn.service_provider_id
    AND sn.network_level < 3
)
SELECT 
    network_level,
    service_type,
    COUNT(*) as provider_count,
    AVG(rating) as avg_rating,
    GROUP_CONCAT(DISTINCT company_name SEPARATOR ', ') as companies
FROM service_network sn
JOIN service_providers sp ON sn.service_provider_id = sp.service_provider_id
GROUP BY network_level, service_type
ORDER BY network_level, service_type;

-- =====================================================
-- 3. ADVANCED ANALYTICAL QUERIES
-- =====================================================

-- Query 5: Seasonal Booking Pattern Analysis
-- Analyzes booking patterns across different seasons and locations
SELECT 
    c.city_name,
    c.country_code,
    MONTH(b.check_in_date) as month,
    CASE 
        WHEN MONTH(b.check_in_date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(b.check_in_date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(b.check_in_date) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(b.check_in_date) IN (9, 10, 11) THEN 'Fall'
    END as season,
    COUNT(b.booking_id) as booking_count,
    AVG(b.total_price) as avg_price,
    SUM(b.total_price) as total_revenue,
    COUNT(DISTINCT b.guest_id) as unique_guests,
    ROUND(AVG(r.rating), 2) as avg_guest_rating
FROM cities c
JOIN neighborhoods n ON c.city_id = n.city_id
JOIN properties p ON n.neighborhood_id = p.neighborhood_id
JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
WHERE b.booking_status IN ('completed', 'confirmed')
    AND b.check_in_date >= '2024-01-01'
GROUP BY c.city_name, c.country_code, MONTH(b.check_in_date)
ORDER BY c.city_name, month;

-- Query 6: Host Performance Ranking with Multiple Metrics
-- Comprehensive host ranking system using multiple performance indicators
WITH host_metrics AS (
    SELECT 
        hp.user_id,
        up.first_name,
        up.last_name,
        hp.host_since,
        hp.response_rate,
        hp.response_time,
        hp.superhost_status,
        hp.verification_level,
        COUNT(DISTINCT p.property_id) as total_properties,
        COUNT(b.booking_id) as total_bookings,
        SUM(b.total_price) as total_revenue,
        AVG(b.total_price) as avg_booking_value,
        AVG(r.rating) as avg_guest_rating,
        COUNT(r.review_id) as total_reviews,
        COUNT(DISTINCT b.guest_id) as unique_guests,
        ROUND(AVG(r.cleanliness_rating), 2) as avg_cleanliness,
        ROUND(AVG(r.communication_rating), 2) as avg_communication,
        ROUND(AVG(r.location_rating), 2) as avg_location,
        ROUND(AVG(r.value_rating), 2) as avg_value
    FROM host_profiles hp
    JOIN user_profiles up ON hp.user_id = up.user_id
    LEFT JOIN properties p ON hp.user_id = p.host_id
    LEFT JOIN bookings b ON p.property_id = b.property_id
    LEFT JOIN reviews r ON b.booking_id = r.booking_id
    WHERE b.booking_status IN ('completed', 'confirmed') OR b.booking_status IS NULL
    GROUP BY hp.user_id, up.first_name, up.last_name, hp.host_since, hp.response_rate,
             hp.response_time, hp.superhost_status, hp.verification_level
),
host_scores AS (
    SELECT 
        *,
        -- Calculate composite score (0-100)
        ROUND(
            (COALESCE(response_rate, 0) * 0.15) +
            ((100 - COALESCE(response_time, 10)) * 0.10) +
            (CASE WHEN superhost_status THEN 20 ELSE 0 END) +
            (CASE WHEN verification_level = 'superhost' THEN 15 ELSE 5 END) +
            (COALESCE(avg_guest_rating, 0) * 10) +
            (CASE WHEN total_reviews >= 10 THEN 10 ELSE total_reviews END) +
            (CASE WHEN total_properties >= 3 THEN 10 ELSE total_properties * 3.33 END)
        , 2) as performance_score
    FROM host_metrics
)
SELECT 
    user_id,
    first_name,
    last_name,
    host_since,
    superhost_status,
    verification_level,
    total_properties,
    total_bookings,
    total_revenue,
    avg_booking_value,
    avg_guest_rating,
    total_reviews,
    performance_score,
    RANK() OVER (ORDER BY performance_score DESC) as host_rank
FROM host_scores
WHERE total_bookings > 0
ORDER BY performance_score DESC;

-- Query 7: Property Market Analysis with Competitive Positioning
-- Analyzes property positioning in the market based on price, amenities, and ratings
WITH property_analysis AS (
    SELECT 
        p.property_id,
        p.title,
        p.property_type,
        p.max_guests,
        p.bedrooms,
        p.bathrooms,
        p.square_meters,
        c.city_name,
        n.neighborhood_name,
        n.average_rating as neighborhood_rating,
        n.safety_score,
        n.walkability_score,
        n.transit_score,
        COUNT(DISTINCT pam.amenity_id) as total_amenities,
        SUM(CASE WHEN pa.amenity_category = 'luxury' THEN 1 ELSE 0 END) as luxury_amenities,
        AVG(b.total_price) as avg_price,
        COUNT(b.booking_id) as total_bookings,
        AVG(r.rating) as avg_rating,
        COUNT(r.review_id) as total_reviews
    FROM properties p
    JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
    JOIN cities c ON n.city_id = c.city_id
    LEFT JOIN property_amenity_mapping pam ON p.property_id = pam.property_id
    LEFT JOIN property_amenities pa ON pam.amenity_id = pa.amenity_id
    LEFT JOIN bookings b ON p.property_id = b.property_id
    LEFT JOIN reviews r ON b.booking_id = r.booking_id
    WHERE pam.is_available = TRUE OR pam.is_available IS NULL
    GROUP BY p.property_id, p.title, p.property_type, p.max_guests, p.bedrooms, p.bathrooms,
             p.square_meters, c.city_name, n.neighborhood_name, n.average_rating, n.safety_score,
             n.walkability_score, n.transit_score
),
market_positioning AS (
    SELECT 
        *,
        -- Calculate price per guest
        ROUND(avg_price / max_guests, 2) as price_per_guest,
        -- Calculate price per square meter
        ROUND(avg_price / square_meters, 2) as price_per_sqm,
        -- Calculate amenity density
        ROUND((total_amenities / square_meters) * 100, 2) as amenity_density,
        -- Market positioning score
        ROUND(
            (COALESCE(avg_rating, 0) * 20) +
            (CASE WHEN total_reviews >= 5 THEN 20 ELSE total_reviews * 4 END) +
            (neighborhood_rating * 15) +
            (safety_score * 10) +
            (walkability_score * 10) +
            (transit_score * 10) +
            (CASE WHEN luxury_amenities >= 3 THEN 15 ELSE luxury_amenities * 5 END)
        , 2) as market_score
    FROM property_analysis
)
SELECT 
    property_id,
    title,
    property_type,
    city_name,
    neighborhood_name,
    max_guests,
    bedrooms,
    bathrooms,
    square_meters,
    avg_price,
    price_per_guest,
    price_per_sqm,
    total_amenities,
    luxury_amenities,
    amenity_density,
    avg_rating,
    total_reviews,
    neighborhood_rating,
    safety_score,
    walkability_score,
    transit_score,
    market_score,
    RANK() OVER (PARTITION BY city_name ORDER BY market_score DESC) as city_rank,
    RANK() OVER (PARTITION BY property_type ORDER BY market_score DESC) as type_rank
FROM market_positioning
WHERE total_bookings > 0
ORDER BY market_score DESC;

-- =====================================================
-- 4. BUSINESS INTELLIGENCE QUERIES
-- =====================================================

-- Query 8: Revenue Forecasting and Trend Analysis
-- Predicts future revenue based on historical patterns and seasonal trends
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(b.check_in_date, '%Y-%m-01') as month,
        c.city_name,
        c.country_code,
        COUNT(b.booking_id) as bookings,
        SUM(b.total_price) as revenue,
        AVG(b.total_price) as avg_price,
        COUNT(DISTINCT b.guest_id) as unique_guests
    FROM bookings b
    JOIN properties p ON b.property_id = p.property_id
    JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
    JOIN cities c ON n.city_id = c.city_id
    WHERE b.booking_status IN ('completed', 'confirmed')
        AND b.check_in_date >= '2023-01-01'
    GROUP BY DATE_FORMAT(b.check_in_date, '%Y-%m-01'), c.city_name, c.country_code
),
revenue_trends AS (
    SELECT 
        *,
        LAG(revenue) OVER (PARTITION BY city_name ORDER BY month) as prev_month_revenue,
        LAG(bookings) OVER (PARTITION BY city_name ORDER BY month) as prev_month_bookings,
        ROUND(
            ((revenue - LAG(revenue) OVER (PARTITION BY city_name ORDER BY month)) / 
             LAG(revenue) OVER (PARTITION BY city_name ORDER BY month)) * 100, 2
        ) as revenue_growth_percent,
        ROUND(
            ((bookings - LAG(bookings) OVER (PARTITION BY city_name ORDER BY month)) / 
             LAG(bookings) OVER (PARTITION BY city_name ORDER BY month)) * 100, 2
        ) as booking_growth_percent
    FROM monthly_revenue
)
SELECT 
    month,
    city_name,
    country_code,
    bookings,
    revenue,
    avg_price,
    unique_guests,
    prev_month_revenue,
    prev_month_bookings,
    revenue_growth_percent,
    booking_growth_percent,
    -- Simple trend prediction (next month estimate)
    ROUND(
        revenue * (1 + COALESCE(revenue_growth_percent, 0) / 100), 2
    ) as predicted_next_month_revenue
FROM revenue_trends
ORDER BY city_name, month;

-- Query 9: Customer Lifetime Value Analysis
-- Calculates customer lifetime value and segments customers by value
WITH customer_bookings AS (
    SELECT 
        b.guest_id,
        up.first_name,
        up.last_name,
        up.guest_since,
        COUNT(b.booking_id) as total_bookings,
        SUM(b.total_price) as total_spent,
        AVG(b.total_price) as avg_booking_value,
        MIN(b.check_in_date) as first_booking,
        MAX(b.check_in_date) as last_booking,
        COUNT(DISTINCT p.city_id) as cities_visited,
        COUNT(DISTINCT p.property_type) as property_types_tried,
        AVG(r.rating) as avg_rating_given,
        COUNT(r.review_id) as reviews_left
    FROM bookings b
    JOIN user_profiles up ON b.guest_id = up.user_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
    JOIN cities c ON n.city_id = c.city_id
    LEFT JOIN reviews r ON b.booking_id = r.booking_id
    WHERE b.booking_status IN ('completed', 'confirmed')
    GROUP BY b.guest_id, up.first_name, up.last_name, up.guest_since
),
customer_segments AS (
    SELECT 
        *,
        -- Calculate customer lifetime value
        ROUND(total_spent * (1 + (total_bookings * 0.1)), 2) as clv,
        -- Calculate days since first booking
        DATEDIFF(CURRENT_DATE, first_booking) as days_since_first,
        -- Calculate average days between bookings
        CASE 
            WHEN total_bookings > 1 THEN 
                DATEDIFF(last_booking, first_booking) / (total_bookings - 1)
            ELSE NULL 
        END as avg_days_between_bookings,
        -- Customer segment based on CLV and behavior
        CASE 
            WHEN total_spent >= 2000 AND total_bookings >= 5 THEN 'VIP'
            WHEN total_spent >= 1000 AND total_bookings >= 3 THEN 'Regular'
            WHEN total_spent >= 500 AND total_bookings >= 2 THEN 'Occasional'
            ELSE 'New'
        END as customer_segment
    FROM customer_bookings
)
SELECT 
    guest_id,
    first_name,
    last_name,
    guest_since,
    total_bookings,
    total_spent,
    avg_booking_value,
    first_booking,
    last_booking,
    cities_visited,
    property_types_tried,
    avg_rating_given,
    reviews_left,
    clv,
    days_since_first,
    avg_days_between_bookings,
    customer_segment,
    RANK() OVER (ORDER BY clv DESC) as clv_rank,
    DATE_ADD(CURRENT_DATE, INTERVAL 
        CASE 
            WHEN avg_days_between_bookings IS NOT NULL THEN 
                DATEDIFF(CURRENT_DATE, last_booking) + avg_days_between_bookings
            ELSE 30
        END DAY
    ) as predicted_next_booking
FROM customer_segments
ORDER BY clv DESC;

-- Query 10: Operational Efficiency Metrics
-- Analyzes platform operational efficiency and identifies improvement areas
SELECT 
    'Platform Performance Metrics' as metric_category,
    COUNT(DISTINCT u.user_id) as total_users,
    COUNT(DISTINCT CASE WHEN u.user_type = 'host' THEN u.user_id END) as total_hosts,
    COUNT(DISTINCT CASE WHEN u.user_type = 'guest' THEN u.user_id END) as total_guests,
    COUNT(DISTINCT p.property_id) as total_properties,
    COUNT(DISTINCT b.booking_id) as total_bookings,
    ROUND(AVG(b.total_price), 2) as avg_booking_value,
    ROUND(SUM(b.total_price), 2) as total_platform_revenue
FROM users u
LEFT JOIN properties p ON u.user_id = p.host_id
LEFT JOIN bookings b ON p.property_id = b.property_id

UNION ALL

SELECT 
    'Host Performance Metrics' as metric_category,
    COUNT(DISTINCT hp.user_id) as total_hosts,
    ROUND(AVG(hp.response_rate), 2) as avg_response_rate,
    ROUND(AVG(hp.response_time), 2) as avg_response_time,
    COUNT(CASE WHEN hp.superhost_status THEN 1 END) as superhost_count,
    ROUND(
        (COUNT(CASE WHEN hp.superhost_status THEN 1 END) / COUNT(*)) * 100, 2
    ) as superhost_percentage,
    ROUND(AVG(p.max_guests), 2) as avg_property_capacity,
    ROUND(AVG(p.bedrooms), 2) as avg_bedrooms
FROM host_profiles hp
LEFT JOIN properties p ON hp.user_id = p.host_id

UNION ALL

SELECT 
    'Guest Satisfaction Metrics' as metric_category,
    COUNT(DISTINCT r.reviewer_id) as total_reviewers,
    ROUND(AVG(r.rating), 2) as overall_rating,
    ROUND(AVG(r.cleanliness_rating), 2) as avg_cleanliness,
    ROUND(AVG(r.communication_rating), 2) as avg_communication,
    ROUND(AVG(r.location_rating), 2) as avg_location,
    ROUND(AVG(r.value_rating), 2) as avg_value,
    COUNT(r.review_id) as total_reviews
FROM reviews r

UNION ALL

SELECT 
    'Financial Performance Metrics' as metric_category,
    COUNT(DISTINCT py.payment_id) as total_payments,
    ROUND(SUM(py.amount), 2) as total_payment_volume,
    ROUND(SUM(py.commission_amount), 2) as total_commission,
    ROUND(
        (SUM(py.commission_amount) / SUM(py.amount)) * 100, 2
    ) as commission_percentage,
    ROUND(AVG(py.amount), 2) as avg_payment_amount,
    COUNT(CASE WHEN py.payment_status = 'completed' THEN 1 END) as completed_payments,
    ROUND(
        (COUNT(CASE WHEN py.payment_status = 'completed' THEN 1 END) / COUNT(*)) * 100, 2
    ) as payment_success_rate
FROM payments py;

-- =====================================================
-- 5. DATA QUALITY AND VALIDATION QUERIES
-- =====================================================

-- Query 11: Data Integrity Validation
-- Identifies potential data quality issues and inconsistencies
SELECT 
    'Data Quality Issues' as issue_type,
    'Users without profiles' as description,
    COUNT(*) as issue_count
FROM users u
LEFT JOIN user_profiles up ON u.user_id = up.user_id
WHERE up.user_id IS NULL

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Properties without neighborhoods' as description,
    COUNT(*) as issue_count
FROM properties p
LEFT JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
WHERE n.neighborhood_id IS NULL

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Bookings without payments' as description,
    COUNT(*) as issue_count
FROM bookings b
LEFT JOIN payments py ON b.booking_id = py.booking_id
WHERE py.booking_id IS NULL AND b.booking_status IN ('confirmed', 'completed')

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Reviews without bookings' as description,
    COUNT(*) as issue_count
FROM reviews r
LEFT JOIN bookings b ON r.booking_id = b.booking_id
WHERE b.booking_id IS NULL

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Invalid booking dates' as description,
    COUNT(*) as issue_count
FROM bookings b
WHERE b.check_in_date >= b.check_out_date

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Negative prices' as description,
    COUNT(*) as issue_count
FROM bookings b
WHERE b.total_price < 0

UNION ALL

SELECT 
    'Data Quality Issues' as issue_type,
    'Invalid ratings' as description,
    COUNT(*) as issue_count
FROM reviews r
WHERE r.rating < 1 OR r.rating > 5;

-- Query 12: Referential Integrity Check
-- Verifies that all foreign key relationships are properly maintained
SELECT 
    'Referential Integrity Check' as check_type,
    'Orphaned user profiles' as description,
    COUNT(*) as orphan_count
FROM user_profiles up
LEFT JOIN users u ON up.user_id = u.user_id
WHERE u.user_id IS NULL

UNION ALL

SELECT 
    'Referential Integrity Check' as check_type,
    'Orphaned properties' as description,
    COUNT(*) as orphan_count
FROM properties p
LEFT JOIN users u ON p.host_id = u.user_id
WHERE u.user_id IS NULL

UNION ALL

SELECT 
    'Referential Integrity Check' as check_type,
    'Orphaned bookings' as description,
    COUNT(*) as orphan_count
FROM bookings b
LEFT JOIN properties p ON b.property_id = p.property_id
WHERE p.property_id IS NULL

UNION ALL

SELECT 
    'Referential Integrity Check' as check_type,
    'Orphaned payments' as description,
    COUNT(*) as orphan_count
FROM payments py
LEFT JOIN bookings b ON py.booking_id = b.booking_id
WHERE b.booking_id IS NULL

UNION ALL

SELECT 
    'Referential Integrity Check' as check_type,
    'Orphaned reviews' as description,
    COUNT(*) as orphan_count
FROM reviews r
LEFT JOIN bookings b ON r.booking_id = b.booking_id
WHERE b.booking_id IS NULL;

-- =====================================================
-- 6. PERFORMANCE OPTIMIZATION QUERIES
-- =====================================================

-- Query 13: Index Usage Analysis
-- Identifies tables that would benefit from additional indexing
-- Note: This query works in MySQL. For PostgreSQL, use pg_stats table
SELECT 
    TABLE_SCHEMA as schemaname,
    TABLE_NAME as tablename,
    COLUMN_NAME as attname,
    CARDINALITY as n_distinct,
    NULL as correlation,
    NULL as most_common_vals,
    NULL as most_common_freqs
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'airbnb_data_mart'
    AND TABLE_NAME IN ('users', 'properties', 'bookings', 'reviews', 'payments')
ORDER BY TABLE_NAME, CARDINALITY DESC;

-- Query 14: Query Performance Analysis
-- Analyzes query execution plans and identifies optimization opportunities
-- Note: Use EXPLAIN ANALYZE in PostgreSQL, EXPLAIN in MySQL
EXPLAIN
SELECT 
    p.title,
    p.property_type,
    c.city_name,
    n.neighborhood_name,
    AVG(b.total_price) as avg_price,
    COUNT(b.booking_id) as total_bookings,
    AVG(r.rating) as avg_rating
FROM properties p
JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
JOIN cities c ON n.city_id = c.city_id
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
WHERE c.country_code = 'USA'
    AND b.check_in_date >= '2024-01-01'
GROUP BY p.property_id, p.title, p.property_type, c.city_name, n.neighborhood_name
HAVING COUNT(b.booking_id) >= 1
ORDER BY avg_rating DESC, total_bookings DESC;