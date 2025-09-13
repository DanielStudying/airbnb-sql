-- =====================================================
-- Sample Data Insertion for Airbnb Database
-- =====================================================

-- Insert sample countries
INSERT INTO countries (country_name, country_code, currency_code, phone_code, timezone_offset) VALUES
('United States', 'USA', 'USD', '+1', '-5'),
('United Kingdom', 'GBR', 'GBP', '+44', '+0'),
('Germany', 'DEU', 'EUR', '+49', '+1'),
('France', 'FRA', 'EUR', '+33', '+1'),
('Spain', 'ESP', 'EUR', '+34', '+1'),
('Italy', 'ITA', 'EUR', '+39', '+1'),
('Netherlands', 'NLD', 'EUR', '+31', '+1'),
('Canada', 'CAN', 'CAD', '+1', '-5'),
('Australia', 'AUS', 'AUD', '+61', '+10'),
('Japan', 'JPN', 'JPY', '+81', '+9'),
('Brazil', 'BRA', 'BRL', '+55', '-3'),
('Mexico', 'MEX', 'MXN', '+52', '-6'),
('India', 'IND', 'INR', '+91', '+5.5'),
('China', 'CHN', 'CNY', '+86', '+8'),
('South Korea', 'KOR', 'KRW', '+82', '+9'),
('Singapore', 'SGP', 'SGD', '+65', '+8'),
('Switzerland', 'CHE', 'CHF', '+41', '+1'),
('Sweden', 'SWE', 'SEK', '+46', '+1'),
('Norway', 'NOR', 'NOK', '+47', '+1'),
('Denmark', 'DNK', 'DKK', '+45', '+1');

-- Insert sample cities
INSERT INTO cities (country_id, city_name, state_province, postal_code, latitude, longitude, population, timezone) VALUES
(1, 'New York', 'New York', '10001', 40.7128, -74.0060, 8336817, 'America/New_York'),
(1, 'Los Angeles', 'California', '90001', 34.0522, -118.2437, 3979576, 'America/Los_Angeles'),
(1, 'Chicago', 'Illinois', '60601', 41.8781, -87.6298, 2693976, 'America/Chicago'),
(1, 'Miami', 'Florida', '33101', 25.7617, -80.1918, 454279, 'America/New_York'),
(1, 'San Francisco', 'California', '94102', 37.7749, -122.4194, 873965, 'America/Los_Angeles'),
(2, 'London', 'England', 'SW1A 1AA', 51.5074, -0.1278, 8982000, 'Europe/London'),
(2, 'Manchester', 'England', 'M1 1AA', 53.4808, -2.2426, 547627, 'Europe/London'),
(2, 'Birmingham', 'England', 'B1 1AA', 52.4862, -1.8904, 1141816, 'Europe/London'),
(2, 'Liverpool', 'England', 'L1 1AA', 53.4084, -2.9916, 513441, 'Europe/London'),
(2, 'Edinburgh', 'Scotland', 'EH1 1AA', 55.9533, -3.1883, 488050, 'Europe/London'),
(3, 'Berlin', 'Berlin', '10115', 52.5200, 13.4050, 3669491, 'Europe/Berlin'),
(3, 'Munich', 'Bavaria', '80331', 48.1351, 11.5820, 1471508, 'Europe/Berlin'),
(3, 'Hamburg', 'Hamburg', '20095', 53.5511, 9.9937, 1841179, 'Europe/Berlin'),
(3, 'Cologne', 'North Rhine-Westphalia', '50667', 50.9375, 6.9603, 1085664, 'Europe/Berlin'),
(3, 'Frankfurt', 'Hesse', '60311', 50.1109, 8.6821, 753056, 'Europe/Berlin'),
(4, 'Paris', 'Île-de-France', '75001', 48.8566, 2.3522, 2161000, 'Europe/Paris'),
(4, 'Marseille', 'Provence-Alpes-Côte d\'Azur', '13001', 43.2965, 5.3698, 861635, 'Europe/Paris'),
(4, 'Lyon', 'Auvergne-Rhône-Alpes', '69001', 45.7578, 4.8320, 513275, 'Europe/Paris'),
(4, 'Toulouse', 'Occitanie', '31000', 43.6047, 1.4442, 479553, 'Europe/Paris'),
(4, 'Nice', 'Provence-Alpes-Côte d\'Azur', '06000', 43.7102, 7.2620, 342522, 'Europe/Paris');

-- Insert sample users
INSERT INTO users (email, password_hash, user_type, is_verified, is_active) VALUES
('john.doe@email.com', 'hash123', 'host', TRUE, TRUE),
('jane.smith@email.com', 'hash456', 'host', TRUE, TRUE),
('mike.johnson@email.com', 'hash789', 'guest', TRUE, TRUE),
('sarah.wilson@email.com', 'hash101', 'guest', TRUE, TRUE),
('david.brown@email.com', 'hash202', 'host', TRUE, TRUE),
('emma.davis@email.com', 'hash303', 'guest', TRUE, TRUE),
('robert.miller@email.com', 'hash404', 'host', TRUE, TRUE),
('lisa.garcia@email.com', 'hash505', 'guest', TRUE, TRUE),
('thomas.rodriguez@email.com', 'hash606', 'host', TRUE, TRUE),
('jennifer.martinez@email.com', 'hash707', 'guest', TRUE, TRUE),
('christopher.lee@email.com', 'hash808', 'host', TRUE, TRUE),
('amanda.white@email.com', 'hash909', 'guest', TRUE, TRUE),
('daniel.taylor@email.com', 'hash110', 'host', TRUE, TRUE),
('ashley.anderson@email.com', 'hash111', 'guest', TRUE, TRUE),
('james.thomas@email.com', 'hash112', 'host', TRUE, TRUE),
('nicole.jackson@email.com', 'hash113', 'guest', TRUE, TRUE),
('kevin.martin@email.com', 'hash114', 'host', TRUE, TRUE),
('stephanie.lee@email.com', 'hash115', 'guest', TRUE, TRUE),
('brian.gonzalez@email.com', 'hash116', 'host', TRUE, TRUE),
('rachel.perez@email.com', 'hash117', 'guest', TRUE, TRUE),
('admin@airbnb.com', 'admin_hash', 'admin', TRUE, TRUE);

-- Insert sample user profiles
INSERT INTO user_profiles (user_id, first_name, last_name, phone_number, date_of_birth, bio, preferred_language, timezone) VALUES
(1, 'John', 'Doe', '+1-555-0101', '1985-03-15', 'Experienced host with beautiful properties', 'en', 'America/New_York'),
(2, 'Jane', 'Smith', '+1-555-0102', '1990-07-22', 'Professional host offering luxury accommodations', 'en', 'America/Los_Angeles'),
(3, 'Mike', 'Johnson', '+1-555-0103', '1988-11-08', 'Frequent traveler and adventure seeker', 'en', 'America/Chicago'),
(4, 'Sarah', 'Wilson', '+1-555-0104', '1992-04-12', 'Business traveler and photography enthusiast', 'en', 'America/New_York'),
(5, 'David', 'Brown', '+1-555-0105', '1983-09-30', 'Local host with insider knowledge', 'en', 'America/Los_Angeles'),
(6, 'Emma', 'Davis', '+1-555-0106', '1995-01-18', 'Student traveler on a budget', 'en', 'America/Chicago'),
(7, 'Robert', 'Miller', '+1-555-0107', '1987-06-25', 'Professional property manager', 'en', 'America/New_York'),
(8, 'Lisa', 'Garcia', '+1-555-0108', '1991-12-03', 'Family traveler with kids', 'en', 'America/Los_Angeles'),
(9, 'Thomas', 'Rodriguez', '+1-555-0109', '1986-02-14', 'Experienced host in prime locations', 'en', 'America/Chicago'),
(10, 'Jennifer', 'Martinez', '+1-555-0110', '1993-08-07', 'Solo traveler and culture enthusiast', 'en', 'America/New_York'),
(11, 'Christopher', 'Lee', '+1-555-0111', '1984-05-20', 'Luxury property specialist', 'en', 'America/Los_Angeles'),
(12, 'Amanda', 'White', '+1-555-0112', '1989-10-15', 'Business professional and frequent guest', 'en', 'America/Chicago'),
(13, 'Daniel', 'Taylor', '+1-555-0113', '1982-12-28', 'Local expert and community leader', 'en', 'America/New_York'),
(14, 'Ashley', 'Anderson', '+1-555-0114', '1994-03-05', 'Adventure seeker and nature lover', 'en', 'America/Los_Angeles'),
(15, 'James', 'Thomas', '+1-555-0115', '1981-07-11', 'Professional host with attention to detail', 'en', 'America/Chicago'),
(16, 'Nicole', 'Jackson', '+1-555-0116', '1996-09-22', 'Student and budget traveler', 'en', 'America/New_York'),
(17, 'Kevin', 'Martin', '+1-555-0117', '1988-04-16', 'Experienced host in tourist areas', 'en', 'America/Los_Angeles'),
(18, 'Stephanie', 'Lee', '+1-555-0118', '1990-11-30', 'Family traveler and foodie', 'en', 'America/Chicago'),
(19, 'Brian', 'Gonzalez', '+1-555-0119', '1985-01-25', 'Local host with cultural insights', 'en', 'America/New_York'),
(20, 'Rachel', 'Perez', '+1-555-0120', '1992-06-08', 'Solo traveler and photographer', 'en', 'America/Los_Angeles'),
(21, 'Admin', 'User', '+1-555-0000', '1980-01-01', 'System administrator', 'en', 'UTC');

-- Insert sample host profiles
INSERT INTO host_profiles (user_id, host_since, response_rate, response_time, superhost_status, verification_level) VALUES
(1, '2020-01-15', 98.5, 2, TRUE, 'superhost'),
(2, '2019-06-20', 99.2, 1, TRUE, 'superhost'),
(5, '2021-03-10', 95.8, 4, FALSE, 'verified'),
(7, '2018-11-05', 97.3, 3, TRUE, 'superhost'),
(9, '2020-09-12', 96.7, 5, FALSE, 'verified'),
(11, '2019-02-28', 99.8, 1, TRUE, 'superhost'),
(13, '2021-01-08', 94.2, 6, FALSE, 'verified'),
(15, '2020-07-14', 98.9, 2, TRUE, 'superhost'),
(17, '2021-05-22', 93.5, 7, FALSE, 'verified'),
(19, '2020-12-03', 97.1, 4, FALSE, 'verified');

-- Insert sample guest profiles
INSERT INTO guest_profiles (user_id, guest_since, preferred_payment_method, loyalty_points) VALUES
(3, '2021-02-10', 'credit_card', 1250),
(4, '2020-08-15', 'paypal', 890),
(6, '2022-01-20', 'credit_card', 450),
(8, '2021-06-12', 'credit_card', 1100),
(10, '2021-09-05', 'paypal', 750),
(12, '2020-12-18', 'credit_card', 1650),
(14, '2022-03-25', 'credit_card', 320),
(16, '2022-01-08', 'credit_card', 180),
(18, '2021-04-30', 'paypal', 920),
(20, '2021-11-14', 'credit_card', 680);

-- Insert sample neighborhoods
INSERT INTO neighborhoods (city_id, neighborhood_name, description, average_rating, safety_score, walkability_score, transit_score) VALUES
(1, 'Manhattan', 'Heart of NYC with iconic landmarks', 4.5, 4.2, 4.8, 4.9),
(1, 'Brooklyn', 'Trendy borough with diverse culture', 4.3, 4.0, 4.5, 4.6),
(1, 'Queens', 'Multicultural area with great food', 4.1, 3.8, 4.2, 4.4),
(2, 'Downtown LA', 'Urban center with entertainment', 4.0, 3.9, 4.3, 4.5),
(2, 'Venice Beach', 'Coastal area with beach culture', 4.4, 4.1, 4.6, 4.2),
(2, 'Hollywood', 'Entertainment capital of the world', 4.2, 4.0, 4.4, 4.7),
(3, 'Loop', 'Business district and shopping', 4.1, 4.3, 4.7, 4.8),
(3, 'Wicker Park', 'Hip neighborhood with nightlife', 4.3, 4.0, 4.5, 4.3),
(3, 'Lincoln Park', 'Family-friendly area with parks', 4.5, 4.4, 4.6, 4.4),
(4, 'South Beach', 'Famous beach area and nightlife', 4.4, 4.1, 4.5, 4.3),
(4, 'Brickell', 'Financial district and luxury', 4.2, 4.3, 4.4, 4.6),
(4, 'Wynwood', 'Arts district with murals', 4.0, 3.9, 4.2, 4.1),
(5, 'Fisherman\'s Wharf', 'Tourist area with seafood', 4.1, 4.2, 4.3, 4.4),
(5, 'Mission District', 'Cultural area with great food', 4.3, 4.0, 4.6, 4.5),
(5, 'North Beach', 'Italian neighborhood and nightlife', 4.2, 4.1, 4.4, 4.3),
(6, 'Westminster', 'Royal and government area', 4.4, 4.5, 4.8, 4.9),
(6, 'Camden', 'Trendy area with markets', 4.2, 4.1, 4.5, 4.6),
(6, 'Shoreditch', 'Creative and tech hub', 4.3, 4.0, 4.6, 4.7),
(6, 'Notting Hill', 'Charming area with markets', 4.5, 4.3, 4.7, 4.5),
(6, 'Soho', 'Entertainment and nightlife', 4.1, 4.0, 4.4, 4.8),
(11, 'Mitte', 'Central area with history', 4.3, 4.2, 4.6, 4.7),
(11, 'Kreuzberg', 'Alternative and multicultural', 4.1, 3.9, 4.4, 4.5),
(11, 'Charlottenburg', 'Elegant area with shopping', 4.4, 4.3, 4.5, 4.6),
(11, 'Neukölln', 'Trendy and diverse area', 4.0, 3.8, 4.3, 4.4),
(11, 'Prenzlauer Berg', 'Family-friendly and green', 4.5, 4.4, 4.7, 4.5);

-- Insert sample properties
INSERT INTO properties (host_id, neighborhood_id, property_type, title, description, max_guests, bedrooms, bathrooms, square_meters, instant_bookable) VALUES
(1, 1, 'apartment', 'Luxury Manhattan Loft', 'Beautiful loft in the heart of Manhattan', 4, 2, 2, 120.5, TRUE),
(2, 5, 'house', 'Venice Beach Villa', 'Stunning villa steps from the beach', 6, 3, 3, 200.0, TRUE),
(5, 7, 'apartment', 'Downtown Chicago Penthouse', 'Modern penthouse with city views', 4, 2, 2, 150.0, FALSE),
(7, 16, 'house', 'Charming London Townhouse', 'Traditional townhouse in Westminster', 5, 3, 2, 180.0, TRUE),
(9, 20, 'apartment', 'Berlin Mitte Luxury Apartment', 'Contemporary apartment in city center', 3, 1, 1, 85.0, TRUE),
(11, 13, 'villa', 'San Francisco Bay Villa', 'Luxury villa with bay views', 8, 4, 4, 300.0, FALSE),
(13, 4, 'apartment', 'Downtown LA Modern Loft', 'Stylish loft in the heart of LA', 3, 1, 1, 95.0, TRUE),
(15, 8, 'house', 'Wicker Park Family Home', 'Spacious family home in trendy area', 6, 3, 2, 220.0, TRUE),
(17, 10, 'condo', 'South Beach Oceanfront Condo', 'Luxury condo with ocean views', 4, 2, 2, 140.0, TRUE),
(19, 22, 'apartment', 'Berlin Kreuzberg Artist Loft', 'Creative loft in alternative area', 3, 1, 1, 75.0, FALSE);

-- Insert sample amenities
INSERT INTO property_amenities (amenity_name, amenity_category, description) VALUES
('WiFi', 'basic', 'High-speed wireless internet'),
('Air Conditioning', 'comfort', 'Central air conditioning'),
('Kitchen', 'basic', 'Fully equipped kitchen'),
('Washing Machine', 'comfort', 'In-unit laundry facilities'),
('Pool', 'luxury', 'Private or shared swimming pool'),
('Gym', 'luxury', 'Fitness center access'),
('Parking', 'basic', 'Free parking on premises'),
('Pet Friendly', 'comfort', 'Pets allowed'),
('Balcony', 'comfort', 'Private balcony or terrace'),
('Fireplace', 'luxury', 'Wood-burning or gas fireplace'),
('Hot Tub', 'luxury', 'Private hot tub'),
('Breakfast', 'comfort', 'Breakfast included'),
('Concierge', 'luxury', '24/7 concierge service'),
('Security System', 'safety', 'Security cameras and alarms'),
('Wheelchair Accessible', 'accessibility', 'Accessible for guests with mobility needs'),
('Elevator', 'basic', 'Building elevator access'),
('Garden', 'comfort', 'Private garden or outdoor space'),
('BBQ Grill', 'comfort', 'Outdoor barbecue facilities'),
('Bicycle Storage', 'comfort', 'Secure bicycle storage'),
('Ski Storage', 'luxury', 'Ski equipment storage');

-- Insert sample property-amenity mappings
INSERT INTO property_amenity_mapping (property_id, amenity_id, is_available) VALUES
(1, 1, TRUE), (1, 2, TRUE), (1, 3, TRUE), (1, 4, TRUE), (1, 7, TRUE),
(2, 1, TRUE), (2, 2, TRUE), (2, 3, TRUE), (2, 5, TRUE), (2, 6, TRUE),
(3, 1, TRUE), (3, 2, TRUE), (3, 3, TRUE), (3, 7, TRUE), (3, 16, TRUE),
(4, 1, TRUE), (4, 2, TRUE), (4, 3, TRUE), (4, 4, TRUE), (4, 17, TRUE),
(5, 1, TRUE), (5, 2, TRUE), (5, 3, TRUE), (5, 7, TRUE), (5, 16, TRUE);

-- Insert sample bookings
INSERT INTO bookings (property_id, guest_id, check_in_date, check_out_date, total_price, booking_status, special_requests) VALUES
(1, 3, '2024-01-15', '2024-01-18', 450.00, 'completed', 'Early check-in if possible'),
(2, 4, '2024-02-20', '2024-02-25', 800.00, 'confirmed', 'Late check-out requested'),
(3, 6, '2024-03-10', '2024-03-12', 300.00, 'completed', 'Quiet room preferred'),
(4, 8, '2024-04-05', '2024-04-10', 1200.00, 'confirmed', 'Family-friendly amenities needed'),
(5, 10, '2024-05-15', '2024-05-17', 200.00, 'pending', 'Flexible check-in time'),
(1, 12, '2024-06-01', '2024-06-05', 750.00, 'confirmed', 'Business traveler - need desk'),
(2, 14, '2024-07-10', '2024-07-15', 1000.00, 'pending', 'Beach access important'),
(3, 16, '2024-08-20', '2024-08-22', 400.00, 'confirmed', 'Student budget - basic amenities'),
(4, 18, '2024-09-05', '2024-09-10', 1500.00, 'pending', 'Family with young children'),
(5, 20, '2024-10-15', '2024-10-17', 250.00, 'confirmed', 'Artist looking for creative space');

-- Insert sample payments
INSERT INTO payments (booking_id, amount, currency, payment_method, payment_status, commission_amount) VALUES
(1, 450.00, 'USD', 'credit_card', 'completed', 45.00),
(2, 800.00, 'USD', 'paypal', 'completed', 80.00),
(3, 300.00, 'USD', 'credit_card', 'completed', 30.00),
(4, 1200.00, 'GBP', 'credit_card', 'completed', 120.00),
(5, 200.00, 'EUR', 'credit_card', 'pending', 20.00),
(6, 750.00, 'USD', 'credit_card', 'completed', 75.00),
(7, 1000.00, 'USD', 'paypal', 'pending', 100.00),
(8, 400.00, 'USD', 'credit_card', 'completed', 40.00),
(9, 1500.00, 'GBP', 'credit_card', 'pending', 150.00),
(10, 250.00, 'EUR', 'credit_card', 'completed', 25.00);

-- Insert sample reviews
INSERT INTO reviews (booking_id, reviewer_id, rating, cleanliness_rating, accuracy_rating, communication_rating, location_rating, check_in_rating, value_rating, review_text) VALUES
(1, 3, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 'Excellent stay! The apartment was perfect and the location was ideal.'),
(2, 4, 4.5, 4.0, 5.0, 5.0, 5.0, 4.0, 4.5, 'Beautiful villa with amazing beach access. Highly recommended!'),
(3, 6, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 'Good value for money, clean and comfortable.'),
(4, 8, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 'Perfect family vacation home. Everything we needed was there.'),
(6, 12, 4.5, 4.5, 4.5, 5.0, 5.0, 4.0, 4.5, 'Great business trip accommodation. Very professional.'),
(8, 16, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 'Good student accommodation, clean and affordable.'),
(10, 20, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 'Perfect creative space for artists. Loved the atmosphere!');

-- Insert sample messages
INSERT INTO messages (sender_id, receiver_id, booking_id, message_text, message_type, is_read) VALUES
(1, 3, 1, 'Welcome! I hope you enjoy your stay in Manhattan.', 'booking', TRUE),
(3, 1, 1, 'Thank you! The apartment is beautiful.', 'booking', TRUE),
(2, 4, 2, 'Check-in instructions sent. Looking forward to hosting you!', 'booking', TRUE),
(4, 2, 2, 'Perfect, see you soon!', 'booking', TRUE),
(5, 6, 3, 'Your room is ready. Check-in anytime after 3 PM.', 'booking', TRUE),
(6, 5, 3, 'Great, I\'ll arrive around 4 PM.', 'booking', TRUE),
(7, 8, 4, 'Welcome to London! The townhouse is ready for your family.', 'booking', TRUE),
(8, 7, 4, 'Thank you! We\'re excited about our London adventure.', 'booking', TRUE);

-- Insert sample support tickets
INSERT INTO support_tickets (user_id, assigned_admin_id, ticket_type, priority, status, subject, description) VALUES
(3, 21, 'technical', 'medium', 'resolved', 'App login issue', 'Having trouble logging into the mobile app'),
(4, 21, 'billing', 'low', 'open', 'Payment confirmation', 'Need confirmation of my recent payment'),
(6, 21, 'general', 'low', 'open', 'Account verification', 'How to verify my account?'),
(8, 21, 'dispute', 'high', 'in_progress', 'Booking cancellation dispute', 'Disputing cancellation charges'),
(10, 21, 'technical', 'medium', 'open', 'Photo upload problem', 'Cannot upload photos to my profile');

-- Insert sample service providers
INSERT INTO service_providers (user_id, service_type, company_name, business_license, service_area, hourly_rate, rating) VALUES
(1, 'cleaning', 'CleanPro Services', 'CLN001', 'Manhattan, Brooklyn', 25.00, 4.8),
(2, 'photography', 'PhotoPerfect', 'PHO001', 'Los Angeles Area', 50.00, 4.9),
(5, 'maintenance', 'FixIt Fast', 'MNT001', 'Chicago Metro', 35.00, 4.7),
(7, 'concierge', 'Luxury Concierge', 'CON001', 'Central London', 40.00, 4.9),
(9, 'cleaning', 'Sparkle Clean', 'CLN002', 'Berlin Area', 20.00, 4.6);

-- Insert sample service requests
INSERT INTO service_requests (property_id, service_provider_id, service_type, requested_date, status, description, estimated_cost, actual_cost) VALUES
(1, 1, 'cleaning', '2024-01-19', 'completed', 'Post-guest cleaning service', 100.00, 100.00),
(2, 2, 'photography', '2024-02-26', 'completed', 'Professional property photos', 200.00, 200.00),
(3, 3, 'maintenance', '2024-03-13', 'in_progress', 'Fix air conditioning unit', 150.00, NULL),
(4, 4, 'concierge', '2024-04-11', 'confirmed', 'Airport transfer service', 80.00, NULL),
(5, 5, 'cleaning', '2024-05-18', 'pending', 'Regular cleaning service', 60.00, NULL);

-- Insert sample property rules
INSERT INTO property_rules (property_id, rule_type, rule_text, is_required, penalty_amount) VALUES
(1, 'house_rules', 'No smoking, no parties, quiet hours 10 PM - 8 AM', TRUE, 100.00),
(1, 'check_in', 'Check-in: 3 PM, Check-out: 11 AM', TRUE, 50.00),
(2, 'house_rules', 'No pets, no smoking, respect neighbors', TRUE, 150.00),
(2, 'cancellation', 'Free cancellation up to 7 days before arrival', FALSE, 0.00),
(3, 'house_rules', 'No parties, no smoking, keep noise down', TRUE, 75.00),
(4, 'house_rules', 'Family-friendly, no smoking, no parties', TRUE, 100.00),
(5, 'house_rules', 'No smoking, no pets, respect building rules', TRUE, 50.00);

-- Insert sample discounts
INSERT INTO discounts (property_id, discount_type, discount_percentage, minimum_stay, valid_from, valid_until, is_active) VALUES
(1, 'weekly', 15.00, 7, '2024-01-01', '2024-12-31', TRUE),
(1, 'monthly', 25.00, 30, '2024-01-01', '2024-12-31', TRUE),
(2, 'seasonal', 20.00, 3, '2024-11-01', '2024-03-31', TRUE),
(3, 'weekly', 10.00, 7, '2024-01-01', '2024-12-31', TRUE),
(4, 'promotional', 30.00, 2, '2024-06-01', '2024-08-31', TRUE),
(5, 'monthly', 20.00, 30, '2024-01-01', '2024-12-31', TRUE);

-- Insert sample notifications
INSERT INTO notifications (user_id, notification_type, title, message, is_read) VALUES
(3, 'booking', 'Booking Confirmed', 'Your booking for Manhattan Loft is confirmed!', TRUE),
(4, 'payment', 'Payment Received', 'Payment of $800 received for Venice Beach Villa', TRUE),
(6, 'review', 'New Review', 'You received a 4-star review for your stay', TRUE),
(8, 'message', 'New Message', 'You have a new message from your host', FALSE),
(10, 'system', 'Account Verified', 'Your account has been successfully verified', TRUE);

-- Insert sample user verifications
INSERT INTO user_verifications (user_id, verification_type, verification_status, verification_method) VALUES
(1, 'email', 'verified', 'email_verification'),
(1, 'phone', 'verified', 'sms_verification'),
(1, 'identity', 'verified', 'document_upload'),
(2, 'email', 'verified', 'email_verification'),
(2, 'phone', 'verified', 'sms_verification'),
(3, 'email', 'verified', 'email_verification'),
(4, 'email', 'verified', 'email_verification'),
(5, 'email', 'verified', 'email_verification'),
(5, 'phone', 'verified', 'sms_verification'),
(6, 'email', 'verified', 'email_verification');

-- Insert sample platform settings
INSERT INTO platform_settings (setting_key, setting_value, setting_description, is_editable) VALUES
('commission_rate', '10', 'Platform commission percentage', FALSE),
('max_photos_per_property', '20', 'Maximum photos allowed per property', TRUE),
('min_booking_notice', '24', 'Minimum hours notice for instant booking', TRUE),
('max_guests_per_booking', '16', 'Maximum guests allowed per booking', TRUE),
('review_timeout_days', '14', 'Days after checkout to leave a review', TRUE),
('cancellation_policy_strict', 'true', 'Enable strict cancellation policy', TRUE),
('instant_booking_enabled', 'true', 'Enable instant booking feature', TRUE),
('superhost_threshold', '4.8', 'Minimum rating for superhost status', FALSE),
('verification_required', 'true', 'Require verification for new users', TRUE),
('support_email', 'support@airbnb.com', 'Customer support email address', FALSE);

-- Display sample data summary
SELECT 'Sample Data Insertion Complete' as status;
SELECT COUNT(*) as total_countries FROM countries;
SELECT COUNT(*) as total_cities FROM cities;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_properties FROM properties;
SELECT COUNT(*) as total_bookings FROM bookings;
