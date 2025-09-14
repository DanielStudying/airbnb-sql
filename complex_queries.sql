-- Complex SQL Queries for Airbnb Data Mart
-- Demonstrates triple relationships, recursive queries, and business logic


-- Triple relationship 1: User-Property-Amenity preferences
-- Tracks which amenities specific users value for properties they view
SELECT 
    u.user_id,
    u.email,
    up.first_name,
    up.last_name,
    p.property_id,
    p.title as property_name,
    p.property_type,
    a.amenity_id,
    a.amenity_name,
    a.category as amenity_category,
    upap.importance_score,
    upap.last_viewed,
    COUNT(*) OVER (PARTITION BY u.user_id) as total_preferences_by_user
FROM user_property_amenity_preferences upap
JOIN users u ON upap.user_id = u.user_id
JOIN user_profiles up ON u.user_id = up.user_id
JOIN properties p ON upap.property_id = p.property_id
JOIN amenities a ON upap.amenity_id = a.amenity_id
WHERE upap.importance_score >= 4
ORDER BY u.user_id, upap.importance_score DESC, upap.last_viewed DESC;

-- Triple relationship 2: Booking-Review-Response
-- Shows review conversations between guests and hosts
SELECT 
    b.booking_id,
    b.property_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    r.review_id,
    r.overall_rating,
    r.public_review,
    guest_profile.first_name as guest_name,
    host_profile.first_name as host_name,
    brr.response_text,
    brr.is_public,
    brr.created_at as response_date,
    DATEDIFF(brr.created_at, r.created_at) as days_to_respond
FROM booking_review_responses brr
JOIN bookings b ON brr.booking_id = b.booking_id
JOIN reviews r ON brr.review_id = r.review_id
JOIN users guest ON b.guest_id = guest.user_id
JOIN user_profiles guest_profile ON guest.user_id = guest_profile.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN users host ON p.host_id = host.user_id
JOIN user_profiles host_profile ON host.user_id = host_profile.user_id
WHERE r.overall_rating <= 3  -- Focus on issues
ORDER BY b.check_in_date DESC, brr.created_at;

-- Triple relationship 3: Property-Booking-Discount
-- Analyzes discount usage across properties and bookings
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.base_price_per_night,
    b.booking_id,
    b.check_in_date,
    b.total_price as booking_total,
    pc.code as promo_code,
    pc.discount_type,
    pc.discount_value,
    pbd.discount_amount,
    (b.total_price + pbd.discount_amount) as original_price_before_discount,
    ROUND((pbd.discount_amount / (b.total_price + pbd.discount_amount) * 100), 2) as discount_percentage
FROM property_booking_discounts pbd
JOIN properties p ON pbd.property_id = p.property_id
JOIN bookings b ON pbd.booking_id = b.booking_id
JOIN promo_codes pc ON pbd.promo_id = pc.promo_id
WHERE b.status IN ('completed', 'paid')
ORDER BY pbd.applied_at DESC;

-- ===========================================
-- RECURSIVE RELATIONSHIP QUERY
-- ===========================================

-- Recursive referral network analysis
-- Shows multi-level referral chains
WITH RECURSIVE referral_chain AS (
    -- Base: direct referrals
    SELECT 
        ur.referrer_user_id,
        ur.referred_user_id,
        ur.referral_code,
        ur.referral_bonus,
        ur.status,
        1 as referral_level,
        CAST(ur.referrer_user_id AS CHAR(500)) as referral_path
    FROM user_referrals ur
    WHERE ur.status = 'completed'
    
    UNION ALL
    
    -- Recursive: multi-level referrals
    SELECT 
        rc.referrer_user_id,
        ur.referred_user_id,
        ur.referral_code,
        ur.referral_bonus,
        ur.status,
        rc.referral_level + 1,
        CONCAT(rc.referral_path, ' -> ', ur.referred_user_id)
    FROM referral_chain rc
    JOIN user_referrals ur ON rc.referred_user_id = ur.referrer_user_id
    WHERE ur.status = 'completed'
        AND rc.referral_level < 5
)
SELECT 
    rc.referrer_user_id,
    up.first_name as referrer_name,
    rc.referral_level,
    COUNT(DISTINCT rc.referred_user_id) as referrals_at_level,
    SUM(rc.referral_bonus) as total_bonus_at_level,
    GROUP_CONCAT(rc.referred_user_id) as referred_users
FROM referral_chain rc
JOIN user_profiles up ON rc.referrer_user_id = up.user_id
GROUP BY rc.referrer_user_id, up.first_name, rc.referral_level
ORDER BY rc.referrer_user_id, rc.referral_level;

-- ===========================================
-- COMPLEX BUSINESS QUERIES
-- ===========================================

-- Commission and revenue analysis by location
-- Shows platform earnings from both guest and host fees
SELECT 
    c.country_name,
    c.currency_code,
    ci.city_name,
    n.neighborhood_name,
    COUNT(DISTINCT p.property_id) as total_properties,
    COUNT(DISTINCT b.booking_id) as total_bookings,
    SUM(b.total_price) as gross_booking_value,
    SUM(b.airbnb_service_fee) as total_guest_fees,  -- 6-12%
    SUM(b.host_service_fee) as total_host_fees,     -- 3%
    SUM(b.airbnb_service_fee + b.host_service_fee) as total_platform_revenue,
    ROUND(AVG(b.airbnb_service_fee / b.total_price * 100), 2) as avg_guest_fee_percent,
    ROUND(AVG(b.host_service_fee / b.total_price * 100), 2) as avg_host_fee_percent
FROM countries c
JOIN cities ci ON c.country_id = ci.country_id
JOIN neighborhoods n ON ci.city_id = n.city_id
JOIN properties p ON n.neighborhood_id = p.neighborhood_id
JOIN bookings b ON p.property_id = b.property_id
WHERE b.status IN ('completed', 'paid')
    AND b.check_in_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
GROUP BY c.country_name, c.currency_code, ci.city_name, n.neighborhood_name
ORDER BY total_platform_revenue DESC;

-- Host payout verification (24-hour rule)
-- Ensures payouts are scheduled correctly after guest check-in
SELECT 
    hp.host_profile_id,
    u.email as host_email,
    up.first_name,
    up.last_name,
    hp.bank_account,
    b.booking_id,
    b.check_in_date,
    b.total_price,
    b.host_service_fee,
    hpo.amount as payout_amount,
    hpo.scheduled_date,
    hpo.status,
    DATEDIFF(hpo.scheduled_date, b.check_in_date) as days_after_checkin,
    CASE 
        WHEN DATEDIFF(hpo.scheduled_date, b.check_in_date) = 1 THEN 'Correct'
        WHEN DATEDIFF(hpo.scheduled_date, b.check_in_date) < 1 THEN 'Too Early'
        ELSE 'Delayed'
    END as payout_timing
FROM host_payouts hpo
JOIN bookings b ON hpo.booking_id = b.booking_id
JOIN host_profiles hp ON hpo.host_id = hp.user_id
JOIN users u ON hp.user_id = u.user_id
JOIN user_profiles up ON u.user_id = up.user_id
WHERE b.status = 'completed'
ORDER BY b.check_in_date DESC;

-- Property performance with amenity correlation
-- Identifies which amenities drive better reviews and revenue
SELECT 
    p.property_id,
    p.title,
    p.property_type,
    p.max_guests,
    p.bedrooms,
    p.bathrooms,
    p.base_price_per_night,
    COUNT(DISTINCT pam.amenity_id) as total_amenities,
    COUNT(DISTINCT CASE WHEN a.category = 'safety' THEN a.amenity_id END) as safety_amenities,
    COUNT(DISTINCT CASE WHEN a.category = 'outdoor' THEN a.amenity_id END) as outdoor_amenities,
    COUNT(DISTINCT b.booking_id) as total_bookings,
    SUM(b.total_price) as total_revenue,
    AVG(CAST(r.overall_rating AS DECIMAL(3,2))) as avg_rating,
    AVG(CAST(r.cleanliness_rating AS DECIMAL(3,2))) as avg_cleanliness,
    AVG(CAST(r.value_rating AS DECIMAL(3,2))) as avg_value
FROM properties p
LEFT JOIN property_amenities_map pam ON p.property_id = pam.property_id
LEFT JOIN amenities a ON pam.amenity_id = a.amenity_id
LEFT JOIN bookings b ON p.property_id = b.property_id AND b.status = 'completed'
LEFT JOIN reviews r ON b.booking_id = r.booking_id
WHERE p.status = 'active'
GROUP BY p.property_id, p.title, p.property_type, p.max_guests, 
         p.bedrooms, p.bathrooms, p.base_price_per_night
HAVING COUNT(DISTINCT b.booking_id) >= 5
ORDER BY total_revenue DESC;

-- Social media impact on user activity
-- Analyzes Facebook integration effect on bookings
SELECT 
    u.user_id,
    u.email,
    u.user_type,
    up.first_name,
    up.last_name,
    sc.platform,
    sc.connected_at,
    COUNT(DISTINCT CASE WHEN b.created_at > sc.connected_at THEN b.booking_id END) as bookings_after_social,
    COUNT(DISTINCT CASE WHEN b.created_at <= sc.connected_at THEN b.booking_id END) as bookings_before_social,
    AVG(CASE WHEN b.created_at > sc.connected_at THEN b.total_price END) as avg_spend_after,
    AVG(CASE WHEN b.created_at <= sc.connected_at THEN b.total_price END) as avg_spend_before
FROM social_connections sc
JOIN users u ON sc.user_id = u.user_id
JOIN user_profiles up ON u.user_id = up.user_id
LEFT JOIN bookings b ON u.user_id = b.guest_id
WHERE sc.platform = 'facebook'
GROUP BY u.user_id, u.email, u.user_type, up.first_name, up.last_name, sc.platform, sc.connected_at
HAVING COUNT(DISTINCT b.booking_id) > 0
ORDER BY bookings_after_social DESC;

-- Guest lifetime value analysis
-- Calculates total spend and loyalty metrics (fixed: removed total_spent reference)
WITH guest_metrics AS (
    SELECT 
        gp.user_id,
        up.first_name,
        up.last_name,
        gp.guest_since,
        gp.loyalty_tier,
        COUNT(DISTINCT b.booking_id) as total_bookings,
        SUM(b.total_price) as lifetime_value,
        AVG(b.total_price) as avg_booking_value,
        COUNT(DISTINCT p.property_id) as unique_properties,
        COUNT(DISTINCT ci.city_id) as cities_visited,
        MIN(b.check_in_date) as first_booking,
        MAX(b.check_in_date) as last_booking,
        AVG(CAST(r.overall_rating AS DECIMAL(3,2))) as avg_rating_given
    FROM guest_profiles gp
    JOIN user_profiles up ON gp.user_id = up.user_id
    JOIN bookings b ON gp.user_id = b.guest_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
    JOIN cities ci ON n.city_id = ci.city_id
    LEFT JOIN reviews r ON b.booking_id = r.booking_id AND r.reviewer_id = gp.user_id
    WHERE b.status IN ('completed', 'paid')
    GROUP BY gp.user_id, up.first_name, up.last_name, gp.guest_since, gp.loyalty_tier
)
SELECT 
    *,
    DATEDIFF(last_booking, first_booking) as customer_lifetime_days,
    DATEDIFF(CURRENT_DATE, last_booking) as days_since_last_booking,
    ROUND(lifetime_value / GREATEST(DATEDIFF(last_booking, first_booking), 1), 2) as daily_value,
    CASE 
        WHEN lifetime_value > 10000 AND total_bookings > 10 THEN 'VIP'
        WHEN lifetime_value > 5000 AND total_bookings > 5 THEN 'Premium'
        WHEN lifetime_value > 2000 AND total_bookings > 2 THEN 'Regular'
        ELSE 'Occasional'
    END as customer_segment
FROM guest_metrics
ORDER BY lifetime_value DESC;

-- Host performance ranking (using total_earnings from table)
-- Comprehensive host evaluation across multiple metrics
SELECT 
    hp.user_id,
    up.first_name,
    up.last_name,
    hp.host_since,
    hp.response_rate,
    hp.response_time_hours,
    hp.superhost_status,
    hp.total_earnings,  -- Using the actual column from host_profiles
    COUNT(DISTINCT p.property_id) as property_count,
    COUNT(DISTINCT b.booking_id) as total_bookings,
    AVG(b.total_price) as avg_booking_value,
    AVG(CAST(r.overall_rating AS DECIMAL(3,2))) as avg_rating_received,
    COUNT(DISTINCT r.review_id) as total_reviews,
    RANK() OVER (ORDER BY hp.total_earnings DESC) as earnings_rank,
    RANK() OVER (ORDER BY AVG(CAST(r.overall_rating AS DECIMAL(3,2))) DESC) as rating_rank
FROM host_profiles hp
JOIN user_profiles up ON hp.user_id = up.user_id
LEFT JOIN properties p ON hp.user_id = p.host_id
LEFT JOIN bookings b ON p.property_id = b.property_id AND b.status = 'completed'
LEFT JOIN reviews r ON b.booking_id = r.booking_id AND r.reviewee_id = hp.user_id
GROUP BY hp.user_id, up.first_name, up.last_name, hp.host_since, 
         hp.response_rate, hp.response_time_hours, hp.superhost_status, hp.total_earnings
HAVING COUNT(DISTINCT b.booking_id) > 0
ORDER BY hp.total_earnings DESC;

-- Seasonal pricing optimization
-- Analyzes price variations and occupancy by season
SELECT 
    ci.city_name,
    p.property_type,
    QUARTER(pa.date) as quarter,
    CASE 
        WHEN MONTH(pa.date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(pa.date) IN (3, 4, 5) THEN 'Spring'  
        WHEN MONTH(pa.date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END as season,
    COUNT(DISTINCT p.property_id) as properties,
    AVG(pa.price) as avg_seasonal_price,
    AVG(p.base_price_per_night) as avg_base_price,
    ROUND((AVG(pa.price) - AVG(p.base_price_per_night)) / AVG(p.base_price_per_night) * 100, 2) as price_premium_pct,
    COUNT(DISTINCT b.booking_id) as bookings,
    ROUND(COUNT(DISTINCT b.booking_id) * 100.0 / COUNT(DISTINCT pa.availability_id), 2) as occupancy_rate
FROM property_availability pa
JOIN properties p ON pa.property_id = p.property_id
JOIN neighborhoods n ON p.neighborhood_id = n.neighborhood_id
JOIN cities ci ON n.city_id = ci.city_id
LEFT JOIN bookings b ON p.property_id = b.property_id 
    AND pa.date BETWEEN b.check_in_date AND DATE_SUB(b.check_out_date, INTERVAL 1 DAY)
    AND b.status != 'cancelled'
WHERE pa.date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR) AND CURRENT_DATE
GROUP BY ci.city_name, p.property_type, QUARTER(pa.date),
    CASE 
        WHEN MONTH(pa.date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(pa.date) IN (3, 4, 5) THEN 'Spring'  
        WHEN MONTH(pa.date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END
ORDER BY ci.city_name, quarter;

-- Search to booking conversion
-- Tracks user search patterns that lead to bookings
SELECT 
    sh.user_id,
    up.first_name,
    up.last_name,
    sh.location,
    sh.property_type as searched_type,
    sh.num_guests as searched_guests,
    sh.min_price,
    sh.max_price,
    COUNT(DISTINCT sh.search_id) as total_searches,
    COUNT(DISTINCT b.booking_id) as bookings_made,
    AVG(b.total_price) as avg_booking_price,
    MIN(DATEDIFF(b.created_at, sh.searched_at)) as min_days_to_book,
    ROUND(COUNT(DISTINCT b.booking_id) * 100.0 / COUNT(DISTINCT sh.search_id), 2) as conversion_rate
FROM search_history sh
JOIN user_profiles up ON sh.user_id = up.user_id
LEFT JOIN bookings b ON sh.user_id = b.guest_id
    AND b.created_at > sh.searched_at
    AND b.created_at < DATE_ADD(sh.searched_at, INTERVAL 30 DAY)
WHERE sh.searched_at >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY sh.user_id, up.first_name, up.last_name, sh.location, 
         sh.property_type, sh.num_guests, sh.min_price, sh.max_price
HAVING COUNT(DISTINCT sh.search_id) >= 3
ORDER BY conversion_rate DESC;

-- Message response time analysis
-- Evaluates host communication performance
SELECT 
    hp.user_id,
    up.first_name,
    up.last_name,
    hp.response_time_hours as stated_response_time,
    COUNT(DISTINCT m1.message_id) as messages_received,
    COUNT(DISTINCT m2.message_id) as messages_replied,
    ROUND(COUNT(DISTINCT m2.message_id) * 100.0 / COUNT(DISTINCT m1.message_id), 2) as reply_rate,
    AVG(TIMESTAMPDIFF(HOUR, m1.sent_at, m2.sent_at)) as actual_avg_response_hours,
    MIN(TIMESTAMPDIFF(HOUR, m1.sent_at, m2.sent_at)) as fastest_response,
    MAX(TIMESTAMPDIFF(HOUR, m1.sent_at, m2.sent_at)) as slowest_response
FROM host_profiles hp
JOIN user_profiles up ON hp.user_id = up.user_id
JOIN messages m1 ON hp.user_id = m1.receiver_id
LEFT JOIN messages m2 ON m1.sender_id = m2.receiver_id 
    AND m1.receiver_id = m2.sender_id
    AND m2.sent_at > m1.sent_at
    AND m2.sent_at < DATE_ADD(m1.sent_at, INTERVAL 7 DAY)
WHERE m1.is_automated = FALSE
GROUP BY hp.user_id, up.first_name, up.last_name, hp.response_time_hours
HAVING COUNT(DISTINCT m1.message_id) >= 10
ORDER BY reply_rate DESC, actual_avg_response_hours ASC;

-- Wishlist conversion analysis
-- Tracks which saved properties get booked
SELECT 
    w.user_id,
    up.first_name,
    up.last_name,
    w.name as wishlist_name,
    w.privacy,
    COUNT(DISTINCT wp.property_id) as saved_properties,
    COUNT(DISTINCT b.property_id) as booked_properties,
    ROUND(COUNT(DISTINCT b.property_id) * 100.0 / COUNT(DISTINCT wp.property_id), 2) as conversion_rate,
    AVG(DATEDIFF(b.created_at, wp.added_at)) as avg_days_to_book,
    SUM(b.total_price) as revenue_from_wishlist
FROM wishlists w
JOIN user_profiles up ON w.user_id = up.user_id
JOIN wishlist_properties wp ON w.wishlist_id = wp.wishlist_id
LEFT JOIN bookings b ON wp.property_id = b.property_id 
    AND b.guest_id = w.user_id
    AND b.created_at > wp.added_at
WHERE w.created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
GROUP BY w.user_id, up.first_name, up.last_name, w.wishlist_id, w.name, w.privacy
HAVING COUNT(DISTINCT wp.property_id) >= 3
ORDER BY conversion_rate DESC;

-- User verification impact (fixed JOIN logic)
-- Shows how verification affects user behavior
SELECT 
    u.user_type,
    uv.verification_type,
    uv.is_verified,
    COUNT(DISTINCT u.user_id) as user_count,
    COUNT(DISTINCT CASE WHEN u.user_id = b.guest_id THEN b.booking_id END) as guest_bookings,
    COUNT(DISTINCT CASE WHEN u.user_id = p.host_id THEN b.booking_id END) as host_bookings,
    AVG(b.total_price) as avg_booking_value,
    AVG(CAST(r.overall_rating AS DECIMAL(3,2))) as avg_rating,
    COUNT(DISTINCT p.property_id) as properties_managed
FROM users u
JOIN user_verifications uv ON u.user_id = uv.user_id
LEFT JOIN bookings b ON u.user_id = b.guest_id
LEFT JOIN properties p ON u.user_id = p.host_id
LEFT JOIN bookings b2 ON p.property_id = b2.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id OR b2.booking_id = r.booking_id
WHERE uv.is_verified = TRUE
GROUP BY u.user_type, uv.verification_type, uv.is_verified
ORDER BY u.user_type, (guest_bookings + host_bookings) DESC;

-- ===========================================
-- TEST QUERIES FOR EACH TABLE (Assignment requirement)
-- ===========================================

-- Test all 26 tables with basic queries
SELECT 'users' as table_name, COUNT(*) as row_count FROM users
UNION ALL SELECT 'user_profiles', COUNT(*) FROM user_profiles
UNION ALL SELECT 'host_profiles', COUNT(*) FROM host_profiles
UNION ALL SELECT 'guest_profiles', COUNT(*) FROM guest_profiles
UNION ALL SELECT 'countries', COUNT(*) FROM countries
UNION ALL SELECT 'cities', COUNT(*) FROM cities
UNION ALL SELECT 'neighborhoods', COUNT(*) FROM neighborhoods
UNION ALL SELECT 'properties', COUNT(*) FROM properties
UNION ALL SELECT 'property_addresses', COUNT(*) FROM property_addresses
UNION ALL SELECT 'amenities', COUNT(*) FROM amenities
UNION ALL SELECT 'property_amenities_map', COUNT(*) FROM property_amenities_map
UNION ALL SELECT 'property_photos', COUNT(*) FROM property_photos
UNION ALL SELECT 'property_availability', COUNT(*) FROM property_availability
UNION ALL SELECT 'property_rules', COUNT(*) FROM property_rules
UNION ALL SELECT 'bookings', COUNT(*) FROM bookings
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'host_payouts', COUNT(*) FROM host_payouts
UNION ALL SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL SELECT 'messages', COUNT(*) FROM messages
UNION ALL SELECT 'wishlists', COUNT(*) FROM wishlists
UNION ALL SELECT 'wishlist_properties', COUNT(*) FROM wishlist_properties
UNION ALL SELECT 'social_connections', COUNT(*) FROM social_connections
UNION ALL SELECT 'user_verifications', COUNT(*) FROM user_verifications
UNION ALL SELECT 'search_history', COUNT(*) FROM search_history
UNION ALL SELECT 'promo_codes', COUNT(*) FROM promo_codes
UNION ALL SELECT 'user_property_amenity_preferences', COUNT(*) FROM user_property_amenity_preferences
UNION ALL SELECT 'booking_review_responses', COUNT(*) FROM booking_review_responses
UNION ALL SELECT 'property_booking_discounts', COUNT(*) FROM property_booking_discounts
UNION ALL SELECT 'user_referrals', COUNT(*) FROM user_referrals;

-- Data integrity check
SELECT 'Orphaned profiles' as issue, COUNT(*) as count
FROM user_profiles up
LEFT JOIN users u ON up.user_id = u.user_id
WHERE u.user_id IS NULL
UNION ALL
SELECT 'Properties without addresses', COUNT(*)
FROM properties p
LEFT JOIN property_addresses pa ON p.property_id = pa.property_id
WHERE pa.property_id IS NULL
UNION ALL
SELECT 'Bookings without payments', COUNT(*)
FROM bookings b
LEFT JOIN payments p ON b.booking_id = p.booking_id
WHERE b.status = 'paid' AND p.payment_id IS NULL
UNION ALL
SELECT 'Invalid date ranges', COUNT(*)
FROM bookings
WHERE check_in_date >= check_out_date;

-- Platform KPIs summary
SELECT 
    (SELECT COUNT(*) FROM users WHERE user_type IN ('host', 'both')) as total_hosts,
    (SELECT COUNT(*) FROM users WHERE user_type IN ('guest', 'both')) as total_guests,
    (SELECT COUNT(*) FROM properties WHERE status = 'active') as active_properties,
    (SELECT COUNT(*) FROM bookings WHERE status = 'completed') as completed_bookings,
    (SELECT SUM(total_price) FROM bookings WHERE status = 'completed') as gross_revenue,
    (SELECT SUM(airbnb_service_fee + host_service_fee) FROM bookings WHERE status = 'completed') as platform_revenue,
    (SELECT AVG(CAST(overall_rating AS DECIMAL(3,2))) FROM reviews) as avg_platform_rating,
    (SELECT COUNT(*) FROM host_profiles WHERE superhost_status = TRUE) as superhost_count;