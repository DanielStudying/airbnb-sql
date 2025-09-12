CREATE DATABASE IF NOT EXISTS airbnb_data_mart;
USE airbnb_data_mart;

-- =====================================================
-- 1. USERS TABLE (Base entity for all platform users)
-- =====================================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    user_type ENUM('host', 'guest', 'admin', 'service_provider') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (user_type IN ('host', 'guest', 'admin', 'service_provider'))
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email),
    INDEX idx_user_type (user_type),
    INDEX idx_created_at (created_at)
);

-- =====================================================
-- 2. USER_PROFILES TABLE (Extended user information)
-- =====================================================
CREATE TABLE user_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    profile_picture VARCHAR(500),
    bio TEXT,
    preferred_language VARCHAR(10) DEFAULT 'en',
    timezone VARCHAR(50) DEFAULT 'UTC',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_names (first_name, last_name)
);

-- =====================================================
-- 3. HOST_PROFILES TABLE (Host-specific information)
-- =====================================================
CREATE TABLE host_profiles (
    host_profile_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    host_since DATE NOT NULL,
    response_rate DECIMAL(5,2) DEFAULT 0.00,
    response_time INT DEFAULT 0, -- in hours
    superhost_status BOOLEAN DEFAULT FALSE,
    verification_level ENUM('basic', 'verified', 'superhost') DEFAULT 'basic', -- For PostgreSQL: VARCHAR(20) CHECK (verification_level IN ('basic', 'verified', 'superhost'))
    bank_account_info BLOB, -- encrypted
    tax_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_superhost (superhost_status),
    INDEX idx_verification (verification_level)
);

-- =====================================================
-- 4. GUEST_PROFILES TABLE (Guest-specific information)
-- =====================================================
CREATE TABLE guest_profiles (
    guest_profile_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    guest_since DATE NOT NULL,
    preferred_payment_method ENUM('credit_card', 'paypal', 'bank_transfer') DEFAULT 'credit_card', -- For PostgreSQL: VARCHAR(20) CHECK (preferred_payment_method IN ('credit_card', 'paypal', 'bank_transfer'))
    emergency_contact VARCHAR(500),
    dietary_restrictions TEXT,
    accessibility_needs TEXT,
    loyalty_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_loyalty (loyalty_points)
);

-- =====================================================
-- 5. COUNTRIES TABLE (Country information)
-- =====================================================
CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    country_name VARCHAR(100) NOT NULL UNIQUE,
    country_code VARCHAR(3) NOT NULL UNIQUE,
    currency_code VARCHAR(3) DEFAULT 'USD',
    phone_code VARCHAR(10),
    timezone_offset VARCHAR(10),
    INDEX idx_country_code (country_code),
    INDEX idx_currency (currency_code)
);

-- =====================================================
-- 6. CITIES TABLE (City information)
-- =====================================================
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    country_id INT NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    population INT,
    timezone VARCHAR(50),
    FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE,
    INDEX idx_country_id (country_id),
    INDEX idx_city_name (city_name),
    INDEX idx_coordinates (latitude, longitude)
);

-- =====================================================
-- 7. NEIGHBORHOODS TABLE (Neighborhood information)
-- =====================================================
CREATE TABLE neighborhoods (
    neighborhood_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    city_id INT NOT NULL,
    neighborhood_name VARCHAR(100) NOT NULL,
    description TEXT,
    average_rating DECIMAL(3,2) DEFAULT 0.00,
    safety_score DECIMAL(3,2) DEFAULT 0.00,
    walkability_score DECIMAL(3,2) DEFAULT 0.00,
    transit_score DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE,
    INDEX idx_city_id (city_id),
    INDEX idx_neighborhood_name (neighborhood_name),
    INDEX idx_rating (average_rating)
);

-- =====================================================
-- 8. PROPERTIES TABLE (Property listings)
-- =====================================================
CREATE TABLE properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    host_id INT NOT NULL,
    neighborhood_id INT NOT NULL,
    property_type ENUM('apartment', 'house', 'villa', 'condo', 'cabin', 'loft') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (property_type IN ('apartment', 'house', 'villa', 'condo', 'cabin', 'loft'))
    title VARCHAR(200) NOT NULL,
    description TEXT,
    max_guests INT NOT NULL,
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    square_meters DECIMAL(8,2),
    instant_bookable BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(neighborhood_id) ON DELETE CASCADE,
    INDEX idx_host_id (host_id),
    INDEX idx_neighborhood_id (neighborhood_id),
    INDEX idx_property_type (property_type),
    INDEX idx_max_guests (max_guests),
    INDEX idx_instant_bookable (instant_bookable)
);

-- =====================================================
-- 9. PROPERTY_ADDRESSES TABLE (Detailed property addresses)
-- =====================================================
CREATE TABLE property_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    street_address VARCHAR(200) NOT NULL,
    apartment_unit VARCHAR(50),
    floor_number INT,
    building_name VARCHAR(100),
    access_instructions TEXT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id)
);

-- =====================================================
-- 10. PROPERTY_AMENITIES TABLE (Available amenities)
-- =====================================================
CREATE TABLE property_amenities (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    amenity_name VARCHAR(100) NOT NULL UNIQUE,
    amenity_category ENUM('basic', 'comfort', 'luxury', 'safety', 'accessibility') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (amenity_category IN ('basic', 'comfort', 'luxury', 'safety', 'accessibility'))
    description TEXT,
    icon_url VARCHAR(500),
    INDEX idx_category (amenity_category)
);

-- =====================================================
-- 11. PROPERTY_AMENITY_MAPPING TABLE (Property-amenity relationships)
-- =====================================================
CREATE TABLE property_amenity_mapping (
    mapping_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    notes TEXT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES property_amenities(amenity_id) ON DELETE CASCADE,
    UNIQUE KEY unique_property_amenity (property_id, amenity_id),
    INDEX idx_property_id (property_id),
    INDEX idx_amenity_id (amenity_id)
);

-- =====================================================
-- 12. PROPERTY_PHOTOS TABLE (Property images)
-- =====================================================
CREATE TABLE property_photos (
    photo_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    photo_url VARCHAR(500) NOT NULL,
    photo_order INT DEFAULT 0,
    caption TEXT,
    is_primary BOOLEAN DEFAULT FALSE,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_photo_order (photo_order),
    INDEX idx_is_primary (is_primary)
);

-- =====================================================
-- 13. PROPERTY_AVAILABILITY TABLE (Availability calendar)
-- =====================================================
CREATE TABLE property_availability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    date DATE NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    price_per_night DECIMAL(10,2),
    minimum_stay INT DEFAULT 1,
    maximum_stay INT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    UNIQUE KEY unique_property_date (property_id, date),
    INDEX idx_property_id (property_id),
    INDEX idx_date (date),
    INDEX idx_availability (is_available)
);

-- =====================================================
-- 14. BOOKINGS TABLE (Reservation information)
-- =====================================================
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    booking_status ENUM('pending', 'confirmed', 'completed', 'cancelled', 'no_show') DEFAULT 'pending', -- For PostgreSQL: VARCHAR(20) CHECK (booking_status IN ('pending', 'confirmed', 'completed', 'cancelled', 'no_show'))
    special_requests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_guest_id (guest_id),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_booking_status (booking_status),
    INDEX idx_dates (check_in_date, check_out_date)
);

-- =====================================================
-- 15. PAYMENTS TABLE (Payment information)
-- =====================================================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer', 'crypto') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer', 'crypto'))
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending', -- For PostgreSQL: VARCHAR(20) CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded'))
    transaction_id VARCHAR(100),
    commission_amount DECIMAL(10,2) DEFAULT 0.00,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    INDEX idx_booking_id (booking_id),
    INDEX idx_payment_status (payment_status),
    INDEX idx_payment_date (payment_date),
    INDEX idx_transaction_id (transaction_id)
);

-- =====================================================
-- 16. REVIEWS TABLE (Guest and host reviews)
-- =====================================================
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    booking_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    cleanliness_rating DECIMAL(2,1) CHECK (cleanliness_rating >= 1 AND cleanliness_rating <= 5),
    accuracy_rating DECIMAL(2,1) CHECK (accuracy_rating >= 1 AND accuracy_rating <= 5),
    communication_rating DECIMAL(2,1) CHECK (communication_rating >= 1 AND communication_rating <= 5),
    location_rating DECIMAL(2,1) CHECK (location_rating >= 1 AND location_rating <= 5),
    check_in_rating DECIMAL(2,1) CHECK (check_in_rating >= 1 AND check_in_rating <= 5),
    value_rating DECIMAL(2,1) CHECK (value_rating >= 1 AND value_rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_booking_reviewer (booking_id, reviewer_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_reviewer_id (reviewer_id),
    INDEX idx_rating (rating),
    INDEX idx_review_date (review_date)
);

-- =====================================================
-- 17. MESSAGES TABLE (Communication between users)
-- =====================================================
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    booking_id INT,
    message_text TEXT NOT NULL,
    message_type ENUM('general', 'booking', 'support', 'system') DEFAULT 'general', -- For PostgreSQL: VARCHAR(20) CHECK (message_type IN ('general', 'booking', 'support', 'system'))
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL,
    INDEX idx_sender_id (sender_id),
    INDEX idx_receiver_id (receiver_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_message_type (message_type),
    INDEX idx_sent_at (sent_at)
);

-- =====================================================
-- 18. SUPPORT_TICKETS TABLE (Customer support)
-- =====================================================
CREATE TABLE support_tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    assigned_admin_id INT,
    ticket_type ENUM('technical', 'billing', 'dispute', 'general', 'safety') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (ticket_type IN ('technical', 'billing', 'dispute', 'general', 'safety'))
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium', -- For PostgreSQL: VARCHAR(20) CHECK (priority IN ('low', 'medium', 'high', 'urgent'))
    status ENUM('open', 'in_progress', 'resolved', 'closed') DEFAULT 'open', -- For PostgreSQL: VARCHAR(20) CHECK (status IN ('open', 'in_progress', 'resolved', 'closed'))
    subject VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_admin_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_assigned_admin_id (assigned_admin_id),
    INDEX idx_ticket_type (ticket_type),
    INDEX idx_priority (priority),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- =====================================================
-- 19. SERVICE_PROVIDERS TABLE (External service providers)
-- =====================================================
CREATE TABLE service_providers (
    service_provider_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    service_type ENUM('cleaning', 'photography', 'maintenance', 'concierge', 'transportation') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (service_type IN ('cleaning', 'photography', 'maintenance', 'concierge', 'transportation'))
    company_name VARCHAR(200),
    business_license VARCHAR(100),
    service_area TEXT,
    hourly_rate DECIMAL(8,2),
    rating DECIMAL(3,2) DEFAULT 0.00,
    total_jobs INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_service_type (service_type),
    INDEX idx_rating (rating)
);

-- =====================================================
-- 20. SERVICE_REQUESTS TABLE (Service requests)
-- =====================================================
CREATE TABLE service_requests (
    service_request_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    service_provider_id INT NOT NULL,
    service_type ENUM('cleaning', 'photography', 'maintenance', 'concierge', 'transportation') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (service_type IN ('cleaning', 'photography', 'maintenance', 'concierge', 'transportation'))
    requested_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending', -- For PostgreSQL: VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'in_progress', 'completed', 'cancelled'))
    description TEXT NOT NULL,
    estimated_cost DECIMAL(8,2),
    actual_cost DECIMAL(8,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (service_provider_id) REFERENCES service_providers(service_provider_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_service_provider_id (service_provider_id),
    INDEX idx_service_type (service_type),
    INDEX idx_status (status),
    INDEX idx_requested_date (requested_date)
);

-- =====================================================
-- 21. PROPERTY_RULES TABLE (House rules and policies)
-- =====================================================
CREATE TABLE property_rules (
    rule_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    rule_type ENUM('house_rules', 'check_in', 'check_out', 'cancellation', 'pet_policy', 'smoking_policy') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (rule_type IN ('house_rules', 'check_in', 'check_out', 'cancellation', 'pet_policy', 'smoking_policy'))
    rule_text TEXT NOT NULL,
    is_required BOOLEAN DEFAULT FALSE,
    penalty_amount DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_rule_type (rule_type)
);

-- =====================================================
-- 22. DISCOUNTS TABLE (Pricing discounts)
-- =====================================================
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    property_id INT NOT NULL,
    discount_type ENUM('weekly', 'monthly', 'seasonal', 'promotional', 'loyalty') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (discount_type IN ('weekly', 'monthly', 'seasonal', 'promotional', 'loyalty'))
    discount_percentage DECIMAL(5,2) NOT NULL,
    minimum_stay INT DEFAULT 1,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_discount_type (discount_type),
    INDEX idx_valid_dates (valid_from, valid_until),
    INDEX idx_is_active (is_active)
);

-- =====================================================
-- 23. NOTIFICATIONS TABLE (User notifications)
-- =====================================================
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    notification_type ENUM('booking', 'message', 'payment', 'review', 'system', 'promotional') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (notification_type IN ('booking', 'message', 'payment', 'review', 'system', 'promotional'))
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_notification_type (notification_type),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at)
);

-- =====================================================
-- 24. USER_VERIFICATIONS TABLE (User verification status)
-- =====================================================
CREATE TABLE user_verifications (
    verification_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    user_id INT NOT NULL,
    verification_type ENUM('email', 'phone', 'identity', 'payment_method', 'social_media') NOT NULL, -- For PostgreSQL: VARCHAR(20) CHECK (verification_type IN ('email', 'phone', 'identity', 'payment_method', 'social_media'))
    verification_status ENUM('pending', 'verified', 'failed', 'expired') DEFAULT 'pending', -- For PostgreSQL: VARCHAR(20) CHECK (verification_status IN ('pending', 'verified', 'failed', 'expired'))
    verification_method VARCHAR(50),
    verified_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_verification_type (verification_type),
    INDEX idx_verification_status (verification_status)
);

-- =====================================================
-- 25. PLATFORM_SETTINGS TABLE (System configuration)
-- =====================================================
CREATE TABLE platform_settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY, -- For PostgreSQL: SERIAL PRIMARY KEY
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT NOT NULL,
    setting_description TEXT,
    is_editable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_setting_key (setting_key),
    INDEX idx_is_editable (is_editable)
);

