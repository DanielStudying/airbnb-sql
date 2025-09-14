-- Create the main database for all Airbnb data
CREATE DATABASE IF NOT EXISTS airbnb_data_mart;
USE airbnb_data_mart;

-- User accounts: login, role, status
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,         -- Internal user ID
    email VARCHAR(255) NOT NULL UNIQUE,             -- Used for login
    password_hash VARCHAR(255) NOT NULL,            -- Store only hashes
    user_type ENUM('host', 'guest', 'both', 'admin') NOT NULL, -- Permissions
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Signup time
    last_login TIMESTAMP NULL,                      -- Last seen
    is_verified BOOLEAN DEFAULT FALSE,              -- Email/ID verified
    is_active BOOLEAN DEFAULT TRUE,                 -- Account enabled
    INDEX idx_email (email),
    INDEX idx_user_type (user_type)
);

-- Extra user details, separated for flexibility
CREATE TABLE user_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,                           -- Link to users
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    profile_picture VARCHAR(500),
    bio TEXT,
    preferred_language VARCHAR(10) DEFAULT 'en',
    government_id VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
);

-- Host-specific info and metrics
CREATE TABLE host_profiles (
    host_profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,                           -- Link to users
    host_since DATE NOT NULL,                       -- When hosting started
    response_rate DECIMAL(5,2) DEFAULT 0.00,        -- % of messages answered
    response_time_hours INT DEFAULT 24,             -- Avg response time
    superhost_status BOOLEAN DEFAULT FALSE,         -- Superhost badge
    bank_account VARCHAR(500),                      -- For payouts
    tax_id VARCHAR(50),                             -- For compliance
    total_earnings DECIMAL(12,2) DEFAULT 0.00,      -- Money earned
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_superhost (superhost_status)
);

-- Guest-specific info and stats
CREATE TABLE guest_profiles (
    guest_profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    guest_since DATE NOT NULL,
    preferred_payment_method VARCHAR(50),
    emergency_contact VARCHAR(500),
    work_travel BOOLEAN DEFAULT FALSE,
    total_spent DECIMAL(12,2) DEFAULT 0.00,
    loyalty_tier INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
);

-- Country reference data
CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    country_code VARCHAR(3) NOT NULL UNIQUE,
    currency_code VARCHAR(3) DEFAULT 'USD',
    INDEX idx_country_code (country_code)
);

-- City reference data
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    timezone VARCHAR(50),
    FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE,
    INDEX idx_country_id (country_id),
    INDEX idx_city_name (city_name)
);

-- Neighborhoods within cities
CREATE TABLE neighborhoods (
    neighborhood_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    neighborhood_name VARCHAR(100) NOT NULL,
    description TEXT,
    average_price DECIMAL(10,2),
    safety_rating DECIMAL(3,2) DEFAULT 3.00,
    FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE,
    INDEX idx_city_id (city_id)
);

-- Properties listed by hosts
CREATE TABLE properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    host_id INT NOT NULL,                           -- Owner/host
    neighborhood_id INT NOT NULL,
    property_type ENUM('apartment', 'house', 'villa', 'condo', 'cabin', 'room', 'shared_room') NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    max_guests INT NOT NULL,
    bedrooms INT NOT NULL,
    beds INT NOT NULL,
    bathrooms DECIMAL(3,1) NOT NULL,
    square_feet INT,
    instant_bookable BOOLEAN DEFAULT FALSE,
    base_price_per_night DECIMAL(10,2) NOT NULL,
    cleaning_fee DECIMAL(8,2) DEFAULT 0.00,
    status ENUM('active', 'inactive', 'pending') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(neighborhood_id),
    INDEX idx_host_id (host_id),
    INDEX idx_neighborhood_id (neighborhood_id),
    INDEX idx_property_type (property_type),
    INDEX idx_status (status)
);

-- Property addresses, separated for normalization
CREATE TABLE property_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    street_address VARCHAR(200) NOT NULL,
    apartment_number VARCHAR(50),
    postal_code VARCHAR(20),
    check_in_instructions TEXT,
    parking_info TEXT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    UNIQUE KEY unique_property (property_id)
);

-- Amenity reference data
CREATE TABLE amenities (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    amenity_name VARCHAR(100) NOT NULL UNIQUE,
    category ENUM('basic', 'safety', 'kitchen', 'bathroom', 'entertainment', 'outdoor') NOT NULL,
    icon_name VARCHAR(50),
    INDEX idx_category (category)
);

-- Mapping amenities to properties
CREATE TABLE property_amenities_map (
    map_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    details VARCHAR(255),
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id) ON DELETE CASCADE,
    UNIQUE KEY unique_prop_amenity (property_id, amenity_id)
);

-- Photos for each property
CREATE TABLE property_photos (
    photo_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    photo_url VARCHAR(500) NOT NULL,
    photo_order INT DEFAULT 0,
    caption VARCHAR(255),
    room_type VARCHAR(50),
    is_cover_photo BOOLEAN DEFAULT FALSE,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id),
    INDEX idx_photo_order (photo_order)
);

-- Daily availability and pricing for properties
CREATE TABLE property_availability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    date DATE NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    price DECIMAL(10,2),
    min_nights INT DEFAULT 1,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    UNIQUE KEY unique_property_date (property_id, date),
    INDEX idx_date (date),
    INDEX idx_available (is_available)
);

-- Rules for each property (check-in, house, etc.)
CREATE TABLE property_rules (
    rule_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    rule_type ENUM('check_in', 'check_out', 'house', 'safety', 'cancellation') NOT NULL,
    rule_text TEXT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    INDEX idx_property_id (property_id)
);

-- Bookings: who, when, how much, status
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    num_guests INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    airbnb_service_fee DECIMAL(10,2) NOT NULL,
    host_service_fee DECIMAL(10,2) NOT NULL,
    status ENUM('inquiry', 'pending', 'confirmed', 'paid', 'completed', 'cancelled') DEFAULT 'pending',
    cancellation_reason TEXT,
    special_requests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (guest_id) REFERENCES users(user_id),
    INDEX idx_property_id (property_id),
    INDEX idx_guest_id (guest_id),
    INDEX idx_dates (check_in_date, check_out_date),
    INDEX idx_status (status)
);

-- Payments for bookings
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payer_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer') NOT NULL,
    status ENUM('pending', 'processing', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    transaction_id VARCHAR(100) UNIQUE,
    processed_at TIMESTAMP NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (payer_id) REFERENCES users(user_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_status (status)
);

-- Host payouts for completed bookings
CREATE TABLE host_payouts (
    payout_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    host_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payout_method ENUM('bank_transfer', 'paypal', 'payoneer') NOT NULL,
    status ENUM('scheduled', 'processing', 'completed', 'failed') DEFAULT 'scheduled',
    scheduled_date DATE NOT NULL,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (host_id) REFERENCES users(user_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_host_id (host_id),
    INDEX idx_status (status)
);

-- Reviews for bookings (guests and hosts)
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    reviewee_id INT NOT NULL,
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 5),
    cleanliness_rating INT CHECK (cleanliness_rating BETWEEN 1 AND 5),
    accuracy_rating INT CHECK (accuracy_rating BETWEEN 1 AND 5),
    communication_rating INT CHECK (communication_rating BETWEEN 1 AND 5),
    location_rating INT CHECK (location_rating BETWEEN 1 AND 5),
    checkin_rating INT CHECK (checkin_rating BETWEEN 1 AND 5),
    value_rating INT CHECK (value_rating BETWEEN 1 AND 5),
    public_review TEXT,
    private_feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id),
    FOREIGN KEY (reviewee_id) REFERENCES users(user_id),
    UNIQUE KEY unique_booking_reviewer (booking_id, reviewer_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_reviewee_id (reviewee_id),
    INDEX idx_overall_rating (overall_rating)
);

-- Messaging between users (guests, hosts, support)
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    booking_id INT,
    property_id INT,
    message_text TEXT NOT NULL,
    is_automated BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE SET NULL,
    INDEX idx_sender_receiver (sender_id, receiver_id),
    INDEX idx_sent_at (sent_at)
);

-- Wishlists for saving favorite properties
CREATE TABLE wishlists (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    privacy ENUM('public', 'private') DEFAULT 'private',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
);

-- Properties saved in wishlists
CREATE TABLE wishlist_properties (
    wishlist_property_id INT AUTO_INCREMENT PRIMARY KEY,
    wishlist_id INT NOT NULL,
    property_id INT NOT NULL,
    notes TEXT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (wishlist_id) REFERENCES wishlists(wishlist_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    UNIQUE KEY unique_wishlist_property (wishlist_id, property_id)
);

-- Social login connections (Facebook, Google, etc.)
CREATE TABLE social_connections (
    connection_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    platform ENUM('facebook', 'google', 'linkedin') NOT NULL,
    platform_user_id VARCHAR(100) NOT NULL,
    access_token VARCHAR(500),
    connected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_platform (user_id, platform),
    INDEX idx_user_id (user_id)
);

-- Verification records for users (email, phone, ID)
CREATE TABLE user_verifications (
    verification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    verification_type ENUM('email', 'phone', 'government_id', 'selfie', 'work_email') NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    verified_at TIMESTAMP NULL,
    expires_at DATE NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_type_verified (verification_type, is_verified)
);

-- Search history for analytics and UX
CREATE TABLE search_history (
    search_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    location VARCHAR(200),
    check_in_date DATE,
    check_out_date DATE,
    num_guests INT,
    min_price DECIMAL(10,2),
    max_price DECIMAL(10,2),
    property_type VARCHAR(50),
    instant_book_only BOOLEAN DEFAULT FALSE,
    searched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_searched_at (searched_at)
);

-- Promo codes for discounts
CREATE TABLE promo_codes (
    promo_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type ENUM('percentage', 'fixed_amount') NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    min_booking_amount DECIMAL(10,2) DEFAULT 0.00,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    max_uses INT DEFAULT 1,
    times_used INT DEFAULT 0,
    INDEX idx_code (code),
    INDEX idx_valid_dates (valid_from, valid_until)
);

-- User preferences for amenities in properties
CREATE TABLE user_property_amenity_preferences (
    preference_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    importance_score INT DEFAULT 3 CHECK (importance_score BETWEEN 1 AND 5),
    last_viewed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id) ON DELETE CASCADE,
    UNIQUE KEY unique_triple (user_id, property_id, amenity_id),
    INDEX idx_user_property (user_id, property_id)
);

-- Host/guest responses to reviews
CREATE TABLE booking_review_responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    review_id INT NOT NULL,
    responder_id INT NOT NULL,
    response_text TEXT NOT NULL,
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    FOREIGN KEY (responder_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_review_response (booking_id, review_id, responder_id),
    INDEX idx_review_id (review_id)
);

-- Discounts applied to bookings
CREATE TABLE property_booking_discounts (
    pbd_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    booking_id INT NOT NULL,
    promo_id INT NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (promo_id) REFERENCES promo_codes(promo_id),
    UNIQUE KEY unique_booking_promo (property_id, booking_id, promo_id),
    INDEX idx_booking_id (booking_id)
);

-- Referral program tracking
CREATE TABLE user_referrals (
    referral_id INT AUTO_INCREMENT PRIMARY KEY,
    referrer_user_id INT NOT NULL,
    referred_user_id INT NOT NULL,
    referral_code VARCHAR(50) NOT NULL,
    referral_bonus DECIMAL(8,2) DEFAULT 0.00,
    status ENUM('pending', 'completed', 'expired') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (referrer_user_id) REFERENCES users(user_id),
    FOREIGN KEY (referred_user_id) REFERENCES users(user_id),
    UNIQUE KEY unique_referred (referred_user_id),
    INDEX idx_referrer (referrer_user_id),
    INDEX idx_status (status)
);