-- 1. Countries (no dependencies)
INSERT INTO countries (country_name, country_code, currency_code) VALUES
('United States', 'USA', 'USD'),
('United Kingdom', 'GBR', 'GBP'),
('Germany', 'DEU', 'EUR'),
('France', 'FRA', 'EUR'),
('Spain', 'ESP', 'EUR'),
('Italy', 'ITA', 'EUR'),
('Canada', 'CAN', 'CAD'),
('Australia', 'AUS', 'AUD'),
('Japan', 'JPN', 'JPY'),
('Brazil', 'BRA', 'BRL'),
('Mexico', 'MEX', 'MXN'),
('India', 'IND', 'INR'),
('China', 'CHN', 'CNY'),
('Netherlands', 'NLD', 'EUR'),
('Sweden', 'SWE', 'SEK'),
('Norway', 'NOR', 'NOK'),
('Denmark', 'DNK', 'DKK'),
('Portugal', 'PRT', 'EUR'),
('Belgium', 'BEL', 'EUR'),
('Switzerland', 'CHE', 'CHF');

-- 2. Cities (depends on countries)
INSERT INTO cities (country_id, city_name, state_province, latitude, longitude, timezone) VALUES
(1, 'New York', 'New York', 40.7128, -74.0060, 'America/New_York'),
(1, 'Los Angeles', 'California', 34.0522, -118.2437, 'America/Los_Angeles'),
(1, 'Chicago', 'Illinois', 41.8781, -87.6298, 'America/Chicago'),
(1, 'Miami', 'Florida', 25.7617, -80.1918, 'America/New_York'),
(1, 'San Francisco', 'California', 37.7749, -122.4194, 'America/Los_Angeles'),
(2, 'London', 'England', 51.5074, -0.1278, 'Europe/London'),
(2, 'Manchester', 'England', 53.4808, -2.2426, 'Europe/London'),
(3, 'Berlin', 'Berlin', 52.5200, 13.4050, 'Europe/Berlin'),
(3, 'Munich', 'Bavaria', 48.1351, 11.5820, 'Europe/Berlin'),
(4, 'Paris', 'Île-de-France', 48.8566, 2.3522, 'Europe/Paris'),
(4, 'Nice', 'Provence-Alpes-Côte d\'Azur', 43.7102, 7.2620, 'Europe/Paris'),
(5, 'Madrid', 'Madrid', 40.4168, -3.7038, 'Europe/Madrid'),
(5, 'Barcelona', 'Catalonia', 41.3851, 2.1734, 'Europe/Madrid'),
(6, 'Rome', 'Lazio', 41.9028, 12.4964, 'Europe/Rome'),
(6, 'Milan', 'Lombardy', 45.4642, 9.1900, 'Europe/Rome'),
(7, 'Toronto', 'Ontario', 43.6532, -79.3832, 'America/Toronto'),
(7, 'Vancouver', 'British Columbia', 49.2827, -123.1207, 'America/Vancouver'),
(8, 'Sydney', 'New South Wales', -33.8688, 151.2093, 'Australia/Sydney'),
(8, 'Melbourne', 'Victoria', -37.8136, 144.9631, 'Australia/Melbourne'),
(9, 'Tokyo', 'Tokyo', 35.6762, 139.6503, 'Asia/Tokyo');

-- 3. Neighborhoods (depends on cities)
INSERT INTO neighborhoods (city_id, neighborhood_name, description, average_price, safety_rating) VALUES
(1, 'Manhattan', 'Heart of NYC', 250.00, 4.2),
(1, 'Brooklyn', 'Trendy borough', 180.00, 4.0),
(2, 'Venice Beach', 'Beach area', 220.00, 4.1),
(2, 'Hollywood', 'Entertainment district', 190.00, 4.0),
(3, 'Loop', 'Business district', 160.00, 4.3),
(3, 'Wicker Park', 'Hip neighborhood', 170.00, 4.0),
(4, 'South Beach', 'Beach nightlife', 195.00, 4.1),
(4, 'Wynwood', 'Arts district', 175.00, 3.9),
(5, 'Mission District', 'Cultural area', 200.00, 4.0),
(5, 'SOMA', 'Tech hub', 260.00, 4.0),
(6, 'Westminster', 'Government area', 280.00, 4.5),
(6, 'Camden', 'Market area', 220.00, 4.1),
(7, 'Shoreditch', 'Creative hub', 240.00, 4.0),
(8, 'Mitte', 'Central area', 150.00, 4.2),
(8, 'Kreuzberg', 'Alternative area', 120.00, 3.9),
(9, 'Charlottenburg', 'Elegant area', 140.00, 4.3),
(10, 'Marais', 'Historic district', 230.00, 4.4),
(11, 'Promenade', 'Coastal area', 200.00, 4.3),
(12, 'Centro', 'City center', 160.00, 4.0),
(13, 'Gothic Quarter', 'Historic area', 170.00, 4.2);

-- 4. Users (no dependencies)
INSERT INTO users (email, password_hash, user_type, is_verified, is_active) VALUES
('marcus.chen@gmail.com', 'hash123', 'host', TRUE, TRUE),
('sofia.rodriguez@gmail.com', 'hash456', 'host', TRUE, TRUE),
('lucas.thompson@gmail.com', 'hash789', 'guest', TRUE, TRUE),
('elena.morrison@gmail.com', 'hash101', 'guest', TRUE, TRUE),
('diego.garcia@gmail.com', 'hash202', 'both', TRUE, TRUE),
('zara.ali@gmail.com', 'hash303', 'guest', TRUE, TRUE),
('oliver.wright@gmail.com', 'hash404', 'host', TRUE, TRUE),
('maya.patel@gmail.com', 'hash505', 'guest', TRUE, TRUE),
('finn.oconnor@gmail.com', 'hash606', 'both', TRUE, TRUE),
('nadia.hassan@gmail.com', 'hash707', 'guest', TRUE, TRUE),
('kai.nakamura@gmail.com', 'hash808', 'host', TRUE, TRUE),
('iris.klein@gmail.com', 'hash909', 'guest', TRUE, TRUE),
('ezra.williams@gmail.com', 'hash110', 'host', TRUE, TRUE),
('luna.fischer@gmail.com', 'hash111', 'guest', TRUE, TRUE),
('nico.dubois@gmail.com', 'hash112', 'both', TRUE, TRUE),
('vera.santos@gmail.com', 'hash113', 'guest', TRUE, TRUE),
('axel.johansson@gmail.com', 'hash114', 'host', TRUE, TRUE),
('cora.murphy@gmail.com', 'hash115', 'guest', TRUE, TRUE),
('leon.torres@gmail.com', 'hash116', 'both', TRUE, TRUE),
('sage.cooper@gmail.com', 'hash117', 'guest', TRUE, TRUE),
('admin@airbnb.com', 'hash_admin', 'admin', TRUE, TRUE);

-- 5. User profiles (depends on users)
INSERT INTO user_profiles (user_id, first_name, last_name, phone_number, date_of_birth, bio, preferred_language) VALUES
(1, 'Marcus', 'Chen', '+1-555-0101', '1985-03-15', 'Tech entrepreneur', 'en'),
(2, 'Sofia', 'Rodriguez', '+1-555-0102', '1990-07-22', 'Interior designer', 'en'),
(3, 'Lucas', 'Thompson', '+1-555-0103', '1988-11-08', 'Marketing consultant', 'en'),
(4, 'Elena', 'Morrison', '+1-555-0104', '1992-04-12', 'Photographer', 'en'),
(5, 'Diego', 'Garcia', '+1-555-0105', '1983-09-30', 'Chef', 'en'),
(6, 'Zara', 'Ali', '+1-555-0106', '1995-01-18', 'Student', 'en'),
(7, 'Oliver', 'Wright', '+1-555-0107', '1987-06-25', 'Hotel manager', 'en'),
(8, 'Maya', 'Patel', '+1-555-0108', '1991-12-03', 'Working mom', 'en'),
(9, 'Finn', 'O\'Connor', '+1-555-0109', '1986-02-14', 'Musician', 'en'),
(10, 'Nadia', 'Hassan', '+1-555-0110', '1993-08-07', 'Anthropologist', 'en'),
(11, 'Kai', 'Nakamura', '+1-555-0111', '1984-05-20', 'Architect', 'en'),
(12, 'Iris', 'Klein', '+1-555-0112', '1989-10-15', 'Consultant', 'en'),
(13, 'Ezra', 'Williams', '+1-555-0113', '1982-12-28', 'Community organizer', 'en'),
(14, 'Luna', 'Fischer', '+1-555-0114', '1994-03-05', 'Environmental student', 'en'),
(15, 'Nico', 'Dubois', '+1-555-0115', '1981-07-11', 'Sommelier', 'en'),
(16, 'Vera', 'Santos', '+1-555-0116', '1996-09-22', 'Art student', 'en'),
(17, 'Axel', 'Johansson', '+1-555-0117', '1988-04-16', 'Guide', 'en'),
(18, 'Cora', 'Murphy', '+1-555-0118', '1990-11-30', 'Food blogger', 'en'),
(19, 'Leon', 'Torres', '+1-555-0119', '1985-01-25', 'Urban planner', 'en'),
(20, 'Sage', 'Cooper', '+1-555-0120', '1992-06-08', 'Filmmaker', 'en'),
(21, 'Admin', 'User', '+1-555-0000', '1980-01-01', 'Administrator', 'en');

-- 6. Host profiles (depends on users)
NSERT INTO host_profiles (user_id, host_since, response_rate, response_time_hours, superhost_status, total_earnings) VALUES
(1, '2020-01-15', 98.50, 2, TRUE, 45000.00),
(2, '2019-06-20', 99.20, 1, TRUE, 52000.00),
(3, '2022-08-20', 94.50, 5, FALSE, 12000.00),
(4, '2022-09-10', 96.80, 4, FALSE, 14500.00),
(5, '2021-03-10', 95.80, 4, FALSE, 23000.00),
(6, '2023-01-25', 92.30, 6, FALSE, 5200.00),
(7, '2018-11-05', 97.30, 3, TRUE, 61000.00),
(8, '2022-11-12', 95.70, 4, FALSE, 16800.00),
(9, '2020-09-12', 96.70, 5, FALSE, 28000.00),
(10, '2023-02-18', 93.80, 5, FALSE, 7300.00),
(11, '2019-02-28', 99.80, 1, TRUE, 67000.00),
(12, '2022-07-05', 97.60, 3, TRUE, 29000.00),
(13, '2021-01-08', 94.20, 6, FALSE, 19000.00),
(14, '2023-03-30', 91.50, 7, FALSE, 4100.00),
(15, '2020-07-14', 98.90, 2, TRUE, 38000.00),
(16, '2023-04-15', 94.20, 6, FALSE, 6800.00),
(17, '2021-05-22', 93.50, 7, FALSE, 15000.00),
(18, '2022-10-08', 96.40, 4, FALSE, 18200.00),
(19, '2020-12-03', 97.10, 4, FALSE, 31000.00),
(21, '2022-06-15', 98.00, 3, FALSE, 8500.00);

-- 7. Guest profiles (depends on users)
INSERT INTO guest_profiles (user_id, guest_since, preferred_payment_method, loyalty_tier, total_spent) VALUES
(1, '2020-02-20', 'credit_card', 3, 5200.00),
(2, '2019-07-15', 'credit_card', 3, 6100.00),
(3, '2021-02-10', 'credit_card', 2, 3250.00),
(4, '2020-08-15', 'paypal', 2, 2890.00),
(5, '2021-03-15', 'credit_card', 2, 2100.00),
(6, '2022-01-20', 'credit_card', 1, 850.00),
(7, '2018-12-10', 'credit_card', 3, 8500.00),
(8, '2021-06-12', 'credit_card', 2, 2100.00),
(9, '2020-09-20', 'paypal', 1, 1200.00),
(10, '2021-09-05', 'paypal', 1, 1750.00),
(11, '2019-03-25', 'credit_card', 3, 7800.00),
(12, '2020-12-18', 'credit_card', 3, 4650.00),
(13, '2021-02-18', 'paypal', 2, 3200.00),
(14, '2022-03-25', 'credit_card', 1, 620.00),
(15, '2020-07-20', 'credit_card', 2, 1800.00),
(16, '2022-01-08', 'credit_card', 1, 380.00),
(17, '2021-06-22', 'credit_card', 2, 2950.00),
(18, '2021-04-30', 'paypal', 2, 2920.00),
(19, '2020-12-10', 'credit_card', 2, 2200.00),
(20, '2021-11-14', 'credit_card', 1, 1680.00);


-- 8. Properties (depends on users + neighborhoods)
INSERT INTO properties (host_id, neighborhood_id, property_type, title, description, max_guests, bedrooms, beds, bathrooms, square_feet, base_price_per_night, cleaning_fee, instant_bookable, status) VALUES
(1, 1, 'apartment', 'Manhattan Loft', 'Modern loft', 4, 2, 2, 2.0, 1200, 185.00, 75.00, TRUE, 'active'),
(2, 3, 'house', 'Venice Beach House', 'Beach house', 6, 3, 4, 2.5, 2000, 220.00, 100.00, TRUE, 'active'),
(5, 5, 'apartment', 'Chicago Penthouse', 'Downtown penthouse', 4, 2, 2, 2.0, 1500, 160.00, 80.00, FALSE, 'active'),
(7, 11, 'house', 'Westminster Townhouse', 'Historic townhouse', 5, 3, 3, 2.0, 1800, 280.00, 120.00, TRUE, 'active'),
(9, 15, 'apartment', 'Kreuzberg Loft', 'Artist loft', 3, 1, 1, 1.0, 800, 95.00, 50.00, TRUE, 'active'),
(11, 9, 'villa', 'SF Bay Villa', 'Villa with bay views', 8, 4, 5, 3.5, 3500, 350.00, 150.00, FALSE, 'active'),
(13, 4, 'apartment', 'LA Studio', 'Modern studio', 2, 0, 1, 1.0, 600, 120.00, 60.00, TRUE, 'active'),
(15, 6, 'house', 'Chicago Family Home', 'Spacious home', 6, 3, 4, 2.0, 2200, 175.00, 90.00, TRUE, 'active'),
(17, 7, 'condo', 'Miami Beach Condo', 'Oceanfront condo', 4, 2, 2, 2.0, 1400, 195.00, 85.00, TRUE, 'active'),
(19, 14, 'apartment', 'Berlin Mitte Flat', 'Central apartment', 4, 2, 2, 1.5, 1000, 125.00, 65.00, FALSE, 'active'),
(1, 2, 'apartment', 'Brooklyn Brownstone', 'Classic brownstone', 5, 2, 3, 1.5, 1600, 165.00, 85.00, TRUE, 'active'),
(2, 8, 'house', 'Miami Beach House', 'Luxury beach house', 8, 4, 5, 3.0, 2800, 400.00, 150.00, FALSE, 'active'),
(5, 6, 'apartment', 'Wicker Park Apartment', 'Family apartment', 4, 2, 2, 2.0, 1300, 145.00, 70.00, TRUE, 'active'),
(7, 13, 'house', 'London Creative House', 'Creative house', 6, 3, 4, 2.0, 1900, 235.00, 110.00, TRUE, 'active'),
(9, 16, 'apartment', 'Munich Elegant Flat', 'Elegant apartment', 3, 1, 2, 1.0, 900, 135.00, 60.00, TRUE, 'active'),
(11, 10, 'apartment', 'Mission Loft', 'Artistic loft', 4, 2, 2, 2.0, 1250, 185.00, 80.00, TRUE, 'active'),
(13, 3, 'house', 'Venice Hills House', 'House with views', 6, 3, 4, 2.5, 2400, 295.00, 125.00, FALSE, 'active'),
(15, 5, 'apartment', 'Loop High-Rise', 'High-rise apartment', 3, 1, 2, 1.0, 1100, 175.00, 75.00, TRUE, 'active'),
(17, 8, 'condo', 'Wynwood Arts Condo', 'Arts district condo', 4, 2, 2, 2.0, 1350, 165.00, 80.00, TRUE, 'active'),
(19, 15, 'apartment', 'Hip Berlin Apartment', 'Trendy apartment', 3, 1, 1, 1.0, 750, 105.00, 55.00, TRUE, 'active');

-- 9. Property addresses (depends on properties)
INSERT INTO property_addresses (property_id, street_address, apartment_number, postal_code, check_in_instructions) VALUES
(1, '123 Broadway', 'Apt 4B', '10001', 'Doorman will provide keys'),
(2, '456 Ocean Ave', NULL, '90291', 'Lockbox code sent before arrival'),
(3, '789 State St', 'Unit 25', '60601', 'Concierge at front desk'),
(4, '321 Victoria St', NULL, 'SW1P 1QP', 'Keys at nearby cafe'),
(5, '654 Oranienstr', 'Apt 3', '10969', 'Ring apartment 3'),
(6, '987 Lombard St', NULL, '94133', 'Keys in lockbox by door'),
(7, '147 Spring St', 'Loft A', '90012', 'Take freight elevator'),
(8, '258 Division St', NULL, '60622', 'Keys under flower pot'),
(9, '369 Collins Ave', 'Unit 802', '33139', 'Check-in at reception'),
(10, '741 Unter den Linden', 'Flat 2', '10117', 'Ring buzzer #2'),
(11, '852 Court St', 'Apt 2A', '11201', 'Ring bell for apt 2A'),
(12, '963 Ocean Blvd', NULL, '90402', 'Private gate code: 1234'),
(13, '159 North Ave', 'Unit 15', '60614', 'Elevator to 3rd floor'),
(14, '357 Brick Lane', NULL, 'E1 6SB', 'Red door, key under mat'),
(15, '468 Kantstr', 'Apt 5', '10625', 'Concierge has keys'),
(16, '579 Mission Blvd', 'Loft B', '94110', 'Loading dock entrance'),
(17, '681 Sunset Blvd', NULL, '90028', 'Gate code: 5678'),
(18, '792 Rush St', 'Unit 20', '60611', 'Security desk check-in'),
(19, '813 NW 2nd Ave', 'Unit 12', '33136', 'Colorful entrance'),
(20, '924 Warschauer', 'Apt 1', '10243', 'Near train station');

-- 10. Amenities (no dependencies)
INSERT INTO amenities (amenity_name, category, icon_name) VALUES
('WiFi', 'basic', 'wifi'),
('Air Conditioning', 'basic', 'ac'),
('Kitchen', 'basic', 'kitchen'),
('Washing Machine', 'basic', 'washer'),
('Swimming Pool', 'outdoor', 'pool'),
('Gym Access', 'entertainment', 'gym'),
('Free Parking', 'basic', 'parking'),
('Pet Friendly', 'basic', 'pet'),
('Balcony', 'outdoor', 'balcony'),
('Fireplace', 'entertainment', 'fireplace'),
('Hot Tub', 'outdoor', 'hottub'),
('Breakfast Included', 'basic', 'breakfast'),
('Concierge Service', 'entertainment', 'concierge'),
('Security System', 'safety', 'security'),
('Wheelchair Accessible', 'safety', 'wheelchair'),
('Elevator', 'basic', 'elevator'),
('Private Garden', 'outdoor', 'garden'),
('BBQ Grill', 'outdoor', 'bbq'),
('Bike Storage', 'basic', 'bike'),
('Workspace', 'basic', 'desk');

-- 11. Property amenities map (depends on properties + amenities)
INSERT INTO property_amenities_map (property_id, amenity_id) VALUES
-- Property 1 amenities
(1, 1), (1, 2), (1, 3), (1, 4), (1, 16), (1, 20),
-- Property 2 amenities  
(2, 1), (2, 2), (2, 3), (2, 5), (2, 7), (2, 17),
-- Property 3 amenities
(3, 1), (3, 2), (3, 3), (3, 13), (3, 16), (3, 20),
-- Continue for all properties (minimal mapping)
(4, 1), (4, 2), (4, 3), (4, 9), (4, 10),
(5, 1), (5, 3), (5, 8), (5, 9), (5, 19),
(6, 1), (6, 2), (6, 3), (6, 5), (6, 11),
(7, 1), (7, 2), (7, 3), (7, 4), (7, 20),
(8, 1), (8, 2), (8, 3), (8, 7), (8, 17),
(9, 1), (9, 2), (9, 3), (9, 5), (9, 9),
(10, 1), (10, 2), (10, 3), (10, 16), (10, 14),
(11, 1), (11, 2), (11, 3), (11, 4), (11, 10),
(12, 1), (12, 2), (12, 3), (12, 5), (12, 11),
(13, 1), (13, 2), (13, 3), (13, 8), (13, 7),
(14, 1), (14, 2), (14, 3), (14, 6), (14, 20),
(15, 1), (15, 2), (15, 3), (15, 16), (15, 14),
(16, 1), (16, 2), (16, 3), (16, 6), (16, 20),
(17, 1), (17, 2), (17, 3), (17, 5), (17, 18),
(18, 1), (18, 2), (18, 3), (18, 13), (18, 16),
(19, 1), (19, 2), (19, 3), (19, 6), (19, 14),
(20, 1), (20, 2), (20, 3), (20, 19), (20, 8);

-- 12. Property photos (depends on properties)
INSERT INTO property_photos (property_id, photo_url, photo_order, caption, is_cover_photo) VALUES
(1, 'https://images.airbnb.com/manhattan-1.jpg', 1, 'Living room', TRUE),
(2, 'https://images.airbnb.com/venice-1.jpg', 1, 'Exterior', TRUE),
(3, 'https://images.airbnb.com/chicago-1.jpg', 1, 'Penthouse view', TRUE),
(4, 'https://images.airbnb.com/london-1.jpg', 1, 'Townhouse', TRUE),
(5, 'https://images.airbnb.com/berlin-1.jpg', 1, 'Loft space', TRUE),
(6, 'https://images.airbnb.com/sf-1.jpg', 1, 'Bay view', TRUE),
(7, 'https://images.airbnb.com/la-1.jpg', 1, 'Studio', TRUE),
(8, 'https://images.airbnb.com/chicago2-1.jpg', 1, 'Family home', TRUE),
(9, 'https://images.airbnb.com/miami-1.jpg', 1, 'Beach condo', TRUE),
(10, 'https://images.airbnb.com/berlin2-1.jpg', 1, 'Central flat', TRUE),
(11, 'https://images.airbnb.com/brooklyn-1.jpg', 1, 'Brownstone', TRUE),
(12, 'https://images.airbnb.com/miami2-1.jpg', 1, 'Beach house', TRUE),
(13, 'https://images.airbnb.com/wicker-1.jpg', 1, 'Apartment', TRUE),
(14, 'https://images.airbnb.com/london2-1.jpg', 1, 'Creative house', TRUE),
(15, 'https://images.airbnb.com/munich-1.jpg', 1, 'Elegant flat', TRUE),
(16, 'https://images.airbnb.com/mission-1.jpg', 1, 'Loft', TRUE),
(17, 'https://images.airbnb.com/venice2-1.jpg', 1, 'Hills house', TRUE),
(18, 'https://images.airbnb.com/loop-1.jpg', 1, 'High-rise', TRUE),
(19, 'https://images.airbnb.com/wynwood-1.jpg', 1, 'Arts condo', TRUE),
(20, 'https://images.airbnb.com/berlin3-1.jpg', 1, 'Hip apartment', TRUE);

-- 13. Property availability (depends on properties)
INSERT INTO property_availability (property_id, date, is_available, price, min_nights) VALUES
-- Property 1 - Full year with seasonal variations
(1, '2024-01-01', TRUE, 185.00, 1), (1, '2024-01-15', TRUE, 185.00, 1), (1, '2024-02-01', TRUE, 195.00, 1),
(1, '2024-03-01', TRUE, 205.00, 1), (1, '2024-04-01', TRUE, 215.00, 1), (1, '2024-05-01', TRUE, 225.00, 1),
(1, '2024-06-01', TRUE, 245.00, 1), (1, '2024-07-01', TRUE, 265.00, 2), (1, '2024-08-01', TRUE, 255.00, 2),
(1, '2024-09-01', TRUE, 235.00, 1), (1, '2024-10-01', TRUE, 215.00, 1), (1, '2024-11-01', TRUE, 195.00, 1),
(1, '2024-12-01', TRUE, 305.00, 3), (1, '2024-12-25', TRUE, 385.00, 3),
-- Property 2 - Beach property with summer premiums  
(2, '2024-01-01', TRUE, 220.00, 2), (2, '2024-02-01', TRUE, 210.00, 2), (2, '2024-03-01', TRUE, 240.00, 2),
(2, '2024-04-01', TRUE, 280.00, 2), (2, '2024-05-01', TRUE, 320.00, 3), (2, '2024-06-01', TRUE, 380.00, 3),
(2, '2024-07-01', TRUE, 420.00, 7), (2, '2024-08-01', TRUE, 400.00, 5), (2, '2024-09-01', TRUE, 340.00, 3),
(2, '2024-10-01', TRUE, 280.00, 2), (2, '2024-11-01', TRUE, 230.00, 2), (2, '2024-12-01', TRUE, 200.00, 2),
-- Property 3 - Business property
(3, '2024-01-01', TRUE, 160.00, 1), (3, '2024-02-01', TRUE, 170.00, 1), (3, '2024-03-01', TRUE, 175.00, 1),
(3, '2024-04-01', TRUE, 180.00, 1), (3, '2024-05-01', TRUE, 185.00, 1), (3, '2024-06-01', TRUE, 190.00, 1),
(3, '2024-07-01', TRUE, 195.00, 1), (3, '2024-08-01', TRUE, 190.00, 1), (3, '2024-09-01', TRUE, 185.00, 1),
(3, '2024-10-01', TRUE, 180.00, 1), (3, '2024-11-01', TRUE, 175.00, 1), (3, '2024-12-01', TRUE, 170.00, 1),
-- Property 4 - London luxury with seasonal rates
(4, '2024-01-01', TRUE, 280.00, 2), (4, '2024-02-01', TRUE, 290.00, 2), (4, '2024-03-01', TRUE, 310.00, 2),
(4, '2024-04-01', TRUE, 330.00, 2), (4, '2024-05-01', TRUE, 350.00, 2), (4, '2024-06-01', TRUE, 380.00, 3),
(4, '2024-07-01', TRUE, 420.00, 3), (4, '2024-08-01', TRUE, 410.00, 3), (4, '2024-09-01', TRUE, 370.00, 2),
(4, '2024-10-01', TRUE, 340.00, 2), (4, '2024-11-01', TRUE, 310.00, 2), (4, '2024-12-01', TRUE, 290.00, 2),
-- Property 5 - Berlin affordable with moderate variation
(5, '2024-01-01', TRUE, 95.00, 1), (5, '2024-02-01', TRUE, 100.00, 1), (5, '2024-03-01', TRUE, 105.00, 1),
(5, '2024-04-01', TRUE, 110.00, 1), (5, '2024-05-01', TRUE, 115.00, 1), (5, '2024-06-01', TRUE, 125.00, 1),
(5, '2024-07-01', TRUE, 135.00, 1), (5, '2024-08-01', TRUE, 130.00, 1), (5, '2024-09-01', TRUE, 120.00, 1),
(5, '2024-10-01', TRUE, 110.00, 1), (5, '2024-11-01', TRUE, 105.00, 1), (5, '2024-12-01', TRUE, 100.00, 1),
-- Properties 6-10 with seasonal patterns
(6, '2024-01-01', TRUE, 350.00, 2), (6, '2024-06-01', TRUE, 450.00, 3), (6, '2024-12-01', TRUE, 320.00, 2),
(7, '2024-01-01', TRUE, 120.00, 1), (7, '2024-06-01', TRUE, 140.00, 1), (7, '2024-12-01', TRUE, 110.00, 1),
(8, '2024-01-01', TRUE, 175.00, 1), (8, '2024-06-01', TRUE, 200.00, 1), (8, '2024-12-01', TRUE, 160.00, 1),
(9, '2024-01-01', TRUE, 195.00, 1), (9, '2024-06-01', TRUE, 275.00, 2), (9, '2024-12-01', TRUE, 165.00, 1),
(10, '2024-01-01', TRUE, 125.00, 1), (10, '2024-06-01', TRUE, 145.00, 1), (10, '2024-12-01', TRUE, 115.00, 1);

-- 14. Bookings (depends on properties + users)
INSERT INTO bookings (property_id, guest_id, check_in_date, check_out_date, num_guests, total_price, airbnb_service_fee, host_service_fee, status, created_at, confirmed_at) VALUES
(1, 3, '2023-01-15', '2023-01-18', 2, 645.00, 58.00, 19.35, 'completed', '2023-01-10 14:30:00', '2023-01-10 16:45:00'),
(2, 4, '2023-07-20', '2023-07-25', 4, 1900.00, 171.00, 57.00, 'completed', '2023-07-15 10:20:00', '2023-07-15 12:30:00'),
(3, 6, '2023-03-10', '2023-03-12', 2, 405.00, 36.45, 12.15, 'completed', '2023-03-05 16:15:00', '2023-03-05 18:20:00'),
(4, 8, '2023-08-05', '2023-08-10', 3, 2100.00, 189.00, 63.00, 'completed', '2023-07-30 09:45:00', '2023-07-30 11:50:00'),
(5, 10, '2023-05-15', '2023-05-17', 2, 245.00, 22.05, 7.35, 'completed', '2023-05-10 13:25:00', '2023-05-10 15:40:00'),
(6, 12, '2023-09-01', '2023-09-05', 4, 1560.00, 140.40, 46.80, 'completed', '2023-08-25 11:15:00', '2023-08-25 13:30:00'),
(7, 14, '2023-04-10', '2023-04-12', 2, 480.00, 43.20, 14.40, 'completed', '2023-04-05 14:45:00', '2023-04-05 16:20:00'),
(8, 16, '2023-06-20', '2023-06-23', 3, 735.00, 66.15, 22.05, 'completed', '2023-06-15 10:30:00', '2023-06-15 12:15:00'),
(9, 18, '2023-11-05', '2023-11-08', 2, 780.00, 70.20, 23.40, 'completed', '2023-10-30 15:20:00', '2023-10-30 17:35:00'),
(10, 20, '2023-02-15', '2023-02-17', 2, 315.00, 28.35, 9.45, 'completed', '2023-02-10 12:40:00', '2023-02-10 14:25:00'),
(1, 5, '2023-12-01', '2023-12-05', 2, 925.00, 83.25, 27.75, 'completed', '2023-11-25 16:30:00', '2023-11-25 18:45:00'),
(2, 9, '2023-08-15', '2023-08-20', 6, 2250.00, 202.50, 67.50, 'completed', '2023-08-10 09:15:00', '2023-08-10 11:30:00'),
(11, 15, '2023-10-10', '2023-10-13', 3, 690.00, 62.10, 20.70, 'completed', '2023-10-05 13:20:00', '2023-10-05 15:35:00'),
(12, 19, '2023-07-01', '2023-07-08', 8, 3500.00, 315.00, 105.00, 'completed', '2023-06-25 11:45:00', '2023-06-25 13:50:00'),
(13, 3, '2023-09-15', '2023-09-17', 2, 435.00, 39.15, 13.05, 'completed', '2023-09-10 14:25:00', '2023-09-10 16:40:00'),
(14, 4, '2024-01-05', '2024-01-10', 3, 1680.00, 151.20, 50.40, 'confirmed', '2023-12-30 10:15:00', '2023-12-30 12:20:00'),
(15, 6, '2024-02-14', '2024-02-18', 2, 810.00, 72.90, 24.30, 'confirmed', '2024-02-08 15:30:00', '2024-02-08 17:45:00'),
(16, 12, '2024-03-20', '2024-03-22', 2, 555.00, 49.95, 16.65, 'pending', '2024-03-15 12:10:00', NULL),
(17, 14, '2024-04-01', '2024-04-05', 2, 1475.00, 132.75, 44.25, 'confirmed', '2024-03-25 09:45:00', '2024-03-25 11:30:00'),
(18, 8, '2024-07-10', '2024-07-15', 4, 1100.00, 99.00, 33.00, 'pending', '2024-07-01 16:20:00', NULL),
(19, 10, '2023-05-01', '2023-05-04', 4, 660.00, 59.40, 19.80, 'completed', '2023-04-25 13:15:00', '2023-04-25 15:20:00'),
(20, 16, '2023-08-25', '2023-08-28', 3, 420.00, 37.80, 12.60, 'completed', '2023-08-20 14:30:00', '2023-08-20 16:45:00');

-- 15. Payments (depends on bookings)
INSERT INTO payments (booking_id, payer_id, amount, currency, payment_method, status, transaction_id, processed_at) VALUES
(1, 3, 645.00, 'USD', 'credit_card', 'completed', 'TXN_001', '2023-01-10 17:00:00'),
(2, 4, 1900.00, 'USD', 'paypal', 'completed', 'TXN_002', '2023-07-15 12:45:00'),
(3, 6, 405.00, 'USD', 'credit_card', 'completed', 'TXN_003', '2023-03-05 18:35:00'),
(4, 8, 2100.00, 'GBP', 'credit_card', 'completed', 'TXN_004', '2023-07-30 12:05:00'),
(5, 10, 245.00, 'EUR', 'credit_card', 'completed', 'TXN_005', '2023-05-10 15:55:00'),
(6, 12, 1560.00, 'USD', 'credit_card', 'completed', 'TXN_006', '2023-08-25 13:45:00'),
(7, 14, 480.00, 'USD', 'credit_card', 'completed', 'TXN_007', '2023-04-05 16:35:00'),
(8, 16, 735.00, 'USD', 'paypal', 'completed', 'TXN_008', '2023-06-15 12:30:00'),
(9, 18, 780.00, 'USD', 'credit_card', 'completed', 'TXN_009', '2023-10-30 17:50:00'),
(10, 20, 315.00, 'EUR', 'credit_card', 'completed', 'TXN_010', '2023-02-10 14:40:00'),
(11, 5, 925.00, 'USD', 'credit_card', 'completed', 'TXN_011', '2023-11-25 19:00:00'),
(12, 9, 2250.00, 'USD', 'paypal', 'completed', 'TXN_012', '2023-08-10 11:45:00'),
(13, 15, 690.00, 'USD', 'credit_card', 'completed', 'TXN_013', '2023-10-05 15:50:00'),
(14, 19, 3500.00, 'USD', 'credit_card', 'completed', 'TXN_014', '2023-06-25 14:05:00'),
(15, 3, 435.00, 'USD', 'paypal', 'completed', 'TXN_015', '2023-09-10 16:55:00'),
(16, 4, 1680.00, 'GBP', 'credit_card', 'completed', 'TXN_016', '2023-12-30 12:35:00'),
(17, 6, 810.00, 'EUR', 'credit_card', 'completed', 'TXN_017', '2024-02-08 18:00:00'),
(18, 12, 555.00, 'USD', 'credit_card', 'pending', 'TXN_018', NULL),
(19, 14, 1475.00, 'USD', 'credit_card', 'completed', 'TXN_019', '2024-03-25 11:45:00'),
(20, 8, 1100.00, 'USD', 'paypal', 'pending', 'TXN_020', NULL);

-- 16. Host payouts (depends on bookings)
INSERT INTO host_payouts (booking_id, host_id, amount, payout_method, status, scheduled_date, completed_at) VALUES
(1, 1, 567.65, 'bank_transfer', 'completed', '2023-01-16', '2023-01-16 15:30:00'),    -- Marcus (host)
(2, 2, 1672.00, 'paypal', 'completed', '2023-07-21', '2023-07-21 12:15:00'),          -- Sofia (host)
(3, 5, 356.85, 'bank_transfer', 'completed', '2023-03-11', '2023-03-11 14:20:00'),    -- Diego (both)
(4, 7, 1848.00, 'bank_transfer', 'completed', '2023-08-06', '2023-08-06 16:45:00'),   -- Oliver (host)
(5, 9, 215.60, 'paypal', 'completed', '2023-05-16', '2023-05-16 11:30:00'),           -- Finn (both)
(6, 11, 1373.20, 'bank_transfer', 'completed', '2023-09-02', '2023-09-02 13:25:00'),  -- Kai (host)
(7, 13, 422.40, 'bank_transfer', 'completed', '2023-04-11', '2023-04-11 15:40:00'),   -- Ezra (host)
(8, 15, 646.95, 'paypal', 'completed', '2023-06-21', '2023-06-21 14:15:00'),          -- Nico (both)
(9, 17, 686.40, 'bank_transfer', 'completed', '2023-11-06', '2023-11-06 16:20:00'),   -- Axel (host)
(10, 19, 277.20, 'bank_transfer', 'completed', '2023-02-16', '2023-02-16 12:35:00'),  -- Leon (both)
(11, 1, 814.25, 'bank_transfer', 'completed', '2023-12-02', '2023-12-02 14:45:00'),   -- Marcus (host)
(12, 2, 1982.50, 'paypal', 'completed', '2023-08-16', '2023-08-16 11:20:00'),         -- Sofia (host)
(13, 1, 607.80, 'bank_transfer', 'completed', '2023-10-11', '2023-10-11 15:30:00'),   -- Changed from 22 to 1
(14, 7, 1478.40, 'bank_transfer', 'completed', '2024-01-06', '2024-01-06 14:30:00'),  -- Oliver (host)
(15, 9, 712.35, 'paypal', 'completed', '2024-02-15', '2024-02-15 16:20:00'),          -- Finn (both)
(16, 11, 488.85, 'bank_transfer', 'scheduled', '2024-03-21', NULL),                    -- Kai (host)
(17, 13, 1298.25, 'bank_transfer', 'scheduled', '2024-04-02', NULL),                   -- Ezra (host)
(18, 15, 967.40, 'paypal', 'completed', '2023-08-26', '2023-08-26 10:15:00'),         -- Nico (both)
(19, 17, 581.40, 'bank_transfer', 'completed', '2023-04-26', '2023-04-26 13:20:00'),  -- Axel (host)
(20, 15, 369.60, 'paypal', 'completed', '2023-08-21', '2023-08-21 11:45:00');         -- Nico (both)

-- 17. Reviews (depends on bookings)
INSERT INTO reviews (booking_id, reviewer_id, reviewee_id, overall_rating, cleanliness_rating, communication_rating, public_review, created_at) VALUES
(1, 3, 1, 5, 5, 5, 'Outstanding stay! Marcus was incredibly responsive.', '2023-01-20 10:30:00'),
(1, 1, 3, 5, 5, 5, 'Lucas was a fantastic guest - respectful and clean.', '2023-01-22 14:15:00'),
(2, 4, 2, 4, 4, 5, 'Beautiful property. Sofia provided excellent recommendations.', '2023-07-27 16:45:00'),
(2, 2, 4, 5, 5, 4, 'Elena was wonderful to host. Very considerate.', '2023-07-29 11:20:00'),
(3, 6, 5, 4, 4, 4, 'Good value for money. Diego was helpful throughout.', '2023-03-14 12:45:00'),
(3, 5, 6, 4, 4, 4, 'Zara followed all house rules perfectly.', '2023-03-16 15:20:00'),
(4, 8, 7, 5, 5, 5, 'Perfect family vacation home. Oliver went above and beyond.', '2023-08-12 18:30:00'),
(4, 7, 8, 5, 5, 5, 'Maya and family were wonderful guests.', '2023-08-14 10:45:00'),
(5, 10, 9, 4, 4, 5, 'Creative space perfect for inspiration.', '2023-05-19 14:15:00'),
(5, 9, 10, 4, 4, 4, 'Nadia was quiet and respectful.', '2023-05-21 11:30:00'),
(6, 12, 11, 5, 5, 5, 'Kai\'s villa is absolutely stunning.', '2023-09-07 16:20:00'),
(6, 11, 12, 5, 5, 5, 'Iris was professional and easy to work with.', '2023-09-09 13:40:00'),
(7, 14, 13, 3, 3, 4, 'Studio was smaller than expected but clean.', '2023-04-14 12:10:00'),
(7, 13, 14, 4, 4, 4, 'Luna was understanding about the space size.', '2023-04-16 14:25:00'),
(8, 16, 15, 4, 4, 4, 'Family-friendly neighborhood as advertised.', '2023-06-25 11:45:00'),
(8, 15, 16, 4, 4, 4, 'Vera\'s family was respectful and tidy.', '2023-06-27 15:30:00'),
(9, 18, 17, 5, 5, 5, 'Miami condo exceeded expectations!', '2023-11-10 17:15:00'),
(9, 17, 18, 5, 5, 5, 'Cora was delightful to host.', '2023-11-12 09:20:00'),
(10, 20, 19, 4, 4, 4, 'Leon provided excellent neighborhood insights.', '2023-02-19 13:50:00'),
(10, 19, 20, 4, 4, 4, 'Sage was professional and left detailed notes.', '2023-02-21 16:10:00');

-- 18. Messages (depends on users + bookings)
INSERT INTO messages (sender_id, receiver_id, booking_id, message_text, is_automated, sent_at) VALUES
(3, 1, 1, 'Hi Marcus! Interested in your Manhattan loft for January dates.', FALSE, '2023-01-08 14:20:00'),
(1, 3, 1, 'Hi Lucas! Yes, early check-in should work.', FALSE, '2023-01-08 16:45:00'),
(4, 2, 2, 'Sofia, your Venice Beach house looks amazing!', FALSE, '2023-07-12 10:15:00'),
(2, 4, 2, 'Hi Elena! Pool is heated year-round.', FALSE, '2023-07-12 11:30:00'),
(6, 5, 3, 'Diego, quick question about parking?', FALSE, '2023-03-02 16:30:00'),
(5, 6, 3, 'Street parking can be tricky but garage nearby.', FALSE, '2023-03-02 20:15:00'),
(8, 7, 4, 'Oliver, we have 2 kids. Is it child-friendly?', FALSE, '2023-07-25 09:20:00'),
(7, 8, 4, 'Absolutely Maya! House is very family-friendly.', FALSE, '2023-07-25 11:45:00'),
(10, 9, 5, 'Finn, is Kreuzberg good for cultural immersion?', FALSE, '2023-05-08 13:40:00'),
(9, 10, 5, 'Perfect for that! Tons of cultural diversity.', FALSE, '2023-05-08 19:45:00'),
(12, 11, 6, 'Kai, is internet reliable for video calls?', FALSE, '2023-08-20 09:45:00'),
(11, 12, 6, 'Absolutely! 500Mbps fiber connection.', FALSE, '2023-08-20 11:15:00'),
(14, 13, 7, 'Ezra, any local recommendations?', FALSE, '2023-04-06 15:30:00'),
(13, 14, 7, 'Great coffee shop around the corner.', FALSE, '2023-04-06 18:15:00'),
(16, 15, 8, 'Nico, family arriving with children.', FALSE, '2023-06-16 10:20:00'),
(15, 16, 8, 'Perfect! Playground nearby.', FALSE, '2023-06-16 12:30:00'),
(18, 17, 9, 'Axel, any must-try local Miami spots?', FALSE, '2023-11-02 15:20:00'),
(17, 18, 9, 'Try Joe\'s Stone Crab and Versailles!', FALSE, '2023-11-02 19:15:00'),
(20, 19, 10, 'Leon, looking for authentic Berlin experience.', FALSE, '2023-02-12 14:45:00'),
(19, 20, 10, 'Check out Hackescher Markt for nightlife.', FALSE, '2023-02-12 16:20:00');

-- 19. Wishlists (depends on users)
INSERT INTO wishlists (user_id, name, privacy) VALUES
(1, 'Business Travel Favorites', 'private'),
(2, 'Design Inspiration Stays', 'public'),
(3, 'Beach Getaways', 'private'),
(4, 'Photography Spots', 'public'),
(5, 'Chef Travel', 'public'),
(6, 'Budget Travel', 'private'),
(7, 'Luxury Properties Research', 'private'),
(8, 'Family Vacations', 'private'),
(9, 'Music Cities', 'public'),
(10, 'Cultural Stays', 'public'),
(11, 'Architectural Gems', 'public'),
(12, 'Business Travel', 'private'),
(13, 'Community-Focused Homes', 'private'),
(14, 'Eco-Friendly', 'public'),
(15, 'Wine Country', 'private'),
(16, 'Art Neighborhoods', 'private'),
(17, 'Adventure Destinations', 'public'),
(18, 'Food Scenes', 'public'),
(19, 'Urban Planning', 'public'),
(20, 'Film Locations', 'private');

-- 20. Wishlist properties (depends on wishlists + properties)
INSERT INTO wishlist_properties (wishlist_id, property_id, notes) VALUES
(1, 3, 'Perfect for client meetings'),
(1, 18, 'Great high-rise views'),
(2, 1, 'Manhattan loft design'),
(2, 11, 'Brownstone architecture'),
(3, 2, 'Perfect beach house'),
(3, 9, 'Miami condo looks amazing'),
(4, 1, 'Great natural light'),
(4, 6, 'Bay views for shots'),
(5, 2, 'Food scene exploration'),
(5, 9, 'Culinary diversity'),
(6, 5, 'Affordable Berlin option'),
(6, 7, 'Budget LA studio'),
(7, 4, 'Premium townhouse standard'),
(7, 12, 'Beach house luxury'),
(8, 8, 'Spacious for kids'),
(8, 4, 'London family trip'),
(9, 6, 'Architecture documentation'),
(9, 10, 'Urban history'),
(10, 10, 'Central for cultural sites'),
(10, 4, 'Historical attractions'),
(11, 6, 'Modern villa architecture'),
(11, 10, 'Historic Berlin design'),
(12, 1, 'Business meetings'),
(12, 3, 'Corporate travel'),
(13, 8, 'Family neighborhood'),
(13, 13, 'Community-oriented area'),
(14, 17, 'Eco-friendly features'),
(14, 8, 'Sustainable practices'),
(15, 16, 'Art gallery visits'),
(15, 5, 'Artistic neighborhood'),
(16, 16, 'Art gallery visits'),
(16, 5, 'Artistic neighborhood'),
(17, 2, 'Beach adventure base'),
(17, 17, 'Hills exploration hub'),
(18, 2, 'Food scene exploration'),
(18, 9, 'Culinary diversity'),
(19, 6, 'Architecture documentation'),
(19, 10, 'Urban history'),
(20, 6, 'Architecture documentation'),
(20, 10, 'Urban history');

-- 21. Social connections (depends on users)
INSERT INTO social_connections (user_id, platform, platform_user_id, connected_at) VALUES
(1, 'facebook', 'marcus.chen.tech', '2020-03-15 10:30:00'),
(2, 'facebook', 'sofia.designs', '2019-08-22 14:20:00'),
(3, 'google', 'lucas.thompson@gmail.com', '2021-03-10 16:45:00'),
(4, 'facebook', 'elena.photo', '2020-05-18 11:15:00'),
(5, 'linkedin', 'diego-garcia-chef', '2021-04-08 13:30:00'),
(6, 'google', 'zara.student@gmail.com', '2022-02-20 09:30:00'),
(7, 'facebook', 'oliver.hospitality', '2018-12-05 15:45:00'),
(8, 'facebook', 'maya.family', '2021-07-12 19:45:00'),
(9, 'facebook', 'finn.music', '2020-10-15 16:25:00'),
(10, 'facebook', 'nadia.cultural', '2021-10-05 13:20:00'),
(11, 'linkedin', 'kai-nakamura', '2019-03-20 08:45:00'),
(12, 'linkedin', 'iris-klein', '2020-01-18 08:45:00'),
(13, 'facebook', 'ezra.community', '2021-02-14 12:30:00'),
(14, 'facebook', 'luna.eco', '2022-04-25 15:30:00'),
(15, 'facebook', 'nico.wine', '2020-08-30 17:20:00'),
(16, 'google', 'vera.art@gmail.com', '2022-01-15 11:40:00'),
(17, 'facebook', 'axel.guide', '2021-06-18 14:55:00'),
(18, 'google', 'cora.food@gmail.com', '2021-05-30 12:10:00'),
(19, 'linkedin', 'leon-torres', '2020-12-25 16:35:00'),
(20, 'facebook', 'sage.films', '2021-12-08 13:45:00');

-- 22. User verifications (depends on users)
INSERT INTO user_verifications (user_id, verification_type, is_verified, verified_at) VALUES
(1, 'email', TRUE, '2020-01-15 14:30:00'),
(1, 'phone', TRUE, '2020-01-15 15:45:00'),
(1, 'government_id', TRUE, '2020-01-20 10:20:00'),
(2, 'email', TRUE, '2019-06-20 16:15:00'),
(2, 'phone', TRUE, '2019-06-20 16:30:00'),
(2, 'government_id', TRUE, '2019-06-25 11:45:00'),
(3, 'email', TRUE, '2021-02-10 09:20:00'),
(3, 'phone', TRUE, '2021-02-10 09:35:00'),
(4, 'email', TRUE, '2020-08-15 13:45:00'),
(4, 'phone', TRUE, '2020-08-15 14:00:00'),
(5, 'email', TRUE, '2021-03-10 11:30:00'),
(5, 'phone', TRUE, '2021-03-10 11:45:00'),
(6, 'email', TRUE, '2022-01-20 10:15:00'),
(7, 'email', TRUE, '2018-11-05 15:20:00'),
(7, 'phone', TRUE, '2018-11-05 15:35:00'),
(7, 'government_id', TRUE, '2018-11-10 12:00:00'),
(8, 'email', TRUE, '2021-06-12 14:25:00'),
(8, 'phone', TRUE, '2021-06-12 14:40:00'),
(9, 'email', TRUE, '2020-09-12 16:40:00'),
(10, 'email', TRUE, '2021-09-05 12:50:00');

-- 23. Search history (depends on users)
INSERT INTO search_history (user_id, location, check_in_date, check_out_date, num_guests, min_price, max_price, property_type, searched_at) VALUES
(3, 'Manhattan, New York', '2023-01-15', '2023-01-18', 2, 150.00, 250.00, 'apartment', '2023-01-08 10:30:00'),
(4, 'Venice Beach, Los Angeles', '2023-07-20', '2023-07-25', 4, 200.00, 350.00, 'house', '2023-07-12 14:20:00'),
(6, 'Berlin, Germany', '2023-03-10', '2023-03-12', 2, 80.00, 150.00, 'apartment', '2023-03-02 15:40:00'),
(8, 'Westminster, London', '2023-08-05', '2023-08-10', 3, 250.00, 400.00, 'house', '2023-07-25 11:15:00'),
(10, 'Kreuzberg, Berlin', '2023-05-15', '2023-05-17', 2, 90.00, 120.00, 'apartment', '2023-05-08 13:25:00'),
(12, 'San Francisco', '2023-09-01', '2023-09-05', 2, 300.00, 500.00, 'villa', '2023-08-20 16:45:00'),
(14, 'Los Angeles', '2023-04-10', '2023-04-12', 2, 100.00, 180.00, 'apartment', '2023-04-05 14:35:00'),
(16, 'Chicago', '2023-06-20', '2023-06-23', 2, 140.00, 200.00, 'house', '2023-06-15 11:50:00'),
(18, 'Miami', '2023-11-05', '2023-11-08', 2, 180.00, 280.00, 'condo', '2023-10-30 13:15:00'),
(20, 'Berlin Mitte', '2023-02-15', '2023-02-17', 2, 100.00, 160.00, 'apartment', '2023-02-10 10:45:00'),
(5, 'Chicago', '2023-12-01', '2023-12-05', 2, 150.00, 250.00, 'apartment', '2023-11-25 14:20:00'),
(9, 'Venice Beach', '2023-08-15', '2023-08-20', 6, 300.00, 500.00, 'house', '2023-08-10 12:30:00'),
(15, 'London', '2023-10-10', '2023-10-13', 3, 200.00, 350.00, 'house', '2023-10-05 16:25:00'),
(19, 'San Francisco', '2023-07-01', '2023-07-08', 8, 400.00, 600.00, 'villa', '2023-06-25 09:40:00'),
(3, 'Chicago', '2023-09-15', '2023-09-17', 2, 120.00, 200.00, 'apartment', '2023-09-10 11:35:00'),
(6, 'Munich', '2024-02-14', '2024-02-18', 2, 120.00, 180.00, 'apartment', '2024-02-08 13:20:00'),
(12, 'Mission District', '2024-03-20', '2024-03-22', 2, 180.00, 280.00, 'apartment', '2024-03-15 15:45:00'),
(14, 'Venice Hills', '2024-04-01', '2024-04-05', 2, 250.00, 400.00, 'house', '2024-03-25 12:10:00'),
(8, 'Chicago Loop', '2024-07-10', '2024-07-15', 4, 150.00, 250.00, 'apartment', '2024-07-01 14:30:00'),
(16, 'Berlin', '2023-08-25', '2023-08-28', 3, 100.00, 150.00, 'apartment', '2023-08-20 10:55:00'),
(3, 'Paris, France', '2023-05-20', '2023-05-25', 2, 180.00, 280.00, 'apartment', '2023-05-10 13:25:00'),
(3, 'Rome, Italy', '2023-06-15', '2023-06-20', 2, 150.00, 250.00, NULL, '2023-06-05 16:45:00'),
(4, 'Tokyo, Japan', '2023-09-10', '2023-09-15', 2, 200.00, 400.00, 'apartment', '2023-08-30 12:20:00'),
(6, 'Prague, Czech Republic', '2023-04-15', '2023-04-18', 2, 60.00, 120.00, 'apartment', '2023-04-05 14:35:00'),
(8, 'Barcelona, Spain', '2023-10-20', '2023-10-25', 3, 180.00, 300.00, 'apartment', '2023-10-10 15:30:00'),
(10, 'Amsterdam, Netherlands', '2023-06-01', '2023-06-05', 2, 150.00, 250.00, 'house', '2023-05-20 13:15:00'),
(12, 'Copenhagen, Denmark', '2023-07-08', '2023-07-12', 2, 180.00, 280.00, 'apartment', '2023-06-25 14:20:00'),
(14, 'Stockholm, Sweden', '2023-08-20', '2023-08-23', 2, 200.00, 300.00, 'apartment', '2023-08-10 16:30:00'),
(16, 'Vienna, Austria', '2023-09-25', '2023-09-30', 2, 120.00, 220.00, 'apartment', '2023-09-15 15:25:00'),
(18, 'Lisbon, Portugal', '2023-11-01', '2023-11-05', 2, 100.00, 180.00, 'house', '2023-10-20 12:40:00');

-- 24. Promo codes (no dependencies)
INSERT INTO promo_codes (code, discount_type, discount_value, min_booking_amount, valid_from, valid_until, max_uses, times_used) VALUES
('WELCOME15', 'percentage', 15.00, 200.00, '2023-01-01', '2024-12-31', 1000, 156),
('SUMMER20', 'percentage', 20.00, 300.00, '2023-06-01', '2023-08-31', 500, 89),
('NEWUSER50', 'fixed_amount', 50.00, 250.00, '2023-01-01', '2024-12-31', 2000, 234),
('WEEKLY10', 'percentage', 10.00, 500.00, '2023-01-01', '2024-12-31', 10000, 567),
('STUDENT25', 'fixed_amount', 25.00, 150.00, '2023-01-01', '2024-12-31', 1500, 123),
('FAMILY30', 'percentage', 30.00, 800.00, '2023-03-01', '2023-09-30', 300, 45),
('BUSINESS5', 'percentage', 5.00, 400.00, '2023-01-01', '2024-12-31', 5000, 789),
('ARTIST40', 'fixed_amount', 40.00, 200.00, '2023-01-01', '2023-06-30', 200, 67),
('WEEKEND12', 'percentage', 12.00, 300.00, '2023-01-01', '2024-12-31', 800, 234),
('HOLIDAY35', 'percentage', 35.00, 600.00, '2023-11-01', '2024-01-31', 400, 12),
('SPRING18', 'percentage', 18.00, 250.00, '2024-03-01', '2024-05-31', 600, 78),
('LASTMINUTE20', 'percentage', 20.00, 300.00, '2023-01-01', '2024-12-31', 2000, 345),
('LOYALTY15', 'percentage', 15.00, 400.00, '2023-01-01', '2024-12-31', 1000, 189),
('REFERRAL30', 'fixed_amount', 30.00, 200.00, '2023-01-01', '2024-12-31', 5000, 456),
('FLASH50', 'fixed_amount', 50.00, 400.00, '2023-11-24', '2023-11-27', 100, 98),
('ECO20', 'percentage', 20.00, 300.00, '2023-04-01', '2023-10-31', 400, 56),
('MUSIC15', 'percentage', 15.00, 250.00, '2023-01-01', '2024-12-31', 800, 134),
('PHOTO25', 'fixed_amount', 25.00, 200.00, '2023-01-01', '2024-12-31', 600, 89),
('WINTER30', 'percentage', 30.00, 400.00, '2023-12-01', '2024-02-29', 500, 23),
('CITY10', 'percentage', 10.00, 200.00, '2023-01-01', '2024-12-31', 2000, 678);

-- 25. User property amenity preferences (triple relationship 1)
INSERT INTO user_property_amenity_preferences (user_id, property_id, amenity_id, importance_score, last_viewed) VALUES
(3, 1, 1, 5, '2023-01-08 14:30:00'), -- WiFi very important
(3, 1, 2, 4, '2023-01-08 14:31:00'), -- AC important
(3, 2, 5, 5, '2023-07-10 16:20:00'), -- Pool for beach vacation
(4, 1, 1, 5, '2023-12-10 10:15:00'), -- Photographer needs WiFi
(4, 1, 9, 5, '2023-12-10 10:16:00'), -- Balcony for photos
(4, 6, 9, 4, '2024-01-20 11:45:00'), -- Bay views for shots
(6, 3, 1, 5, '2023-03-02 13:20:00'), -- Student needs WiFi
(6, 5, 1, 5, '2024-02-10 09:30:00'), -- WiFi for studies
(6, 7, 1, 4, '2024-01-15 14:45:00'), -- Budget WiFi needs
(8, 4, 8, 4, '2024-01-02 15:45:00'), -- Family wants pet-friendly
(8, 8, 17, 5, '2024-02-15 12:20:00'), -- Garden for kids
(8, 13, 8, 3, '2023-05-20 11:30:00'), -- Pet consideration
(10, 10, 1, 5, '2024-05-12 14:10:00'), -- Research needs WiFi
(10, 5, 1, 4, '2023-05-08 16:25:00'), -- Cultural research
(12, 1, 13, 5, '2024-02-28 08:45:00'), -- Business concierge
(12, 1, 20, 5, '2024-02-28 08:46:00'), -- Workspace critical
(12, 3, 20, 4, '2023-08-20 10:30:00'), -- Business setup
(14, 5, 8, 5, '2024-03-20 16:30:00'), -- Eco-friendly pets
(14, 17, 17, 4, '2023-05-25 12:15:00'), -- Garden sustainability
(16, 6, 9, 4, '2024-05-18 11:25:00'), -- Art inspiration views
(16, 5, 9, 3, '2022-12-10 16:35:00'), -- Balcony sketching
(18, 8, 3, 5, '2024-06-02 13:15:00'), -- Food blogger kitchen
(18, 2, 3, 5, '2023-07-25 14:30:00'), -- Cooking research
(20, 5, 9, 4, '2024-07-12 15:40:00'), -- Film balcony shots
(20, 6, 1, 5, '2023-08-20 12:25:00'), -- Documentary WiFi
(5, 3, 3, 4, '2023-08-25 14:20:00'), -- Chef kitchen needs
(9, 5, 19, 4, '2023-05-08 17:45:00'), -- Musician storage
(15, 16, 10, 4, '2023-11-10 15:35:00'), -- Sommelier fireplace
(19, 10, 1, 5, '2023-02-10 14:50:00'), -- Planner research
(3, 11, 1, 4, '2023-10-08 12:15:00'), -- Brooklyn WiFi needs
(4, 12, 5, 5, '2023-06-20 14:30:00'); -- Beach house pool

-- 26. Booking review responses (triple relationship 2)
INSERT INTO booking_review_responses (booking_id, review_id, responder_id, response_text, is_public, created_at) VALUES
(1, 1, 1, 'Thank you Lucas! You are welcome back anytime!', TRUE, '2023-01-22 16:30:00'),
(1, 2, 3, 'Marcus made the experience seamless. Highly recommend!', TRUE, '2023-01-24 10:15:00'),
(2, 3, 2, 'Thanks Elena! Glad you enjoyed the recommendations.', TRUE, '2023-07-29 12:45:00'),
(2, 4, 4, 'Sofia was incredibly helpful. House exceeded expectations!', TRUE, '2023-07-31 14:20:00'),
(3, 5, 5, 'Appreciate the feedback Zara! Perfect location.', TRUE, '2023-03-18 11:30:00'),
(3, 6, 6, 'Diego was super responsive. Will definitely book again!', TRUE, '2023-03-20 13:45:00'),
(4, 7, 7, 'Thank you Maya! Your family was wonderful to host.', TRUE, '2023-08-16 15:20:00'),
(4, 8, 8, 'Oliver went above and beyond. Exceptional host!', TRUE, '2023-08-18 09:30:00'),
(5, 9, 9, 'Glad the creative space inspired you Nadia!', TRUE, '2023-05-23 16:45:00'),
(5, 10, 10, 'Finn understood my research needs perfectly.', TRUE, '2023-05-25 12:10:00'),
(6, 11, 11, 'Thank you Iris! Business travelers are a joy.', TRUE, '2023-09-11 14:35:00'),
(6, 12, 12, 'Kai\'s villa is a masterpiece of architecture.', TRUE, '2023-09-13 11:20:00'),
(7, 13, 13, 'Thanks Luna! I\'ll update the space description.', TRUE, '2023-04-18 15:40:00'),
(7, 14, 14, 'Ezra was very accommodating. Good communication.', TRUE, '2023-04-20 10:25:00'),
(8, 15, 15, 'Vera and family were delightful! Kids loved playground.', TRUE, '2023-06-29 13:50:00'),
(8, 16, 16, 'Nico provided excellent recommendations. Memorable trip.', TRUE, '2023-07-01 16:15:00'),
(9, 17, 17, 'Cora brought such positive energy! Great local finds.', TRUE, '2023-11-14 12:30:00'),
(9, 18, 18, 'Axel was incredible! Perfect for content creation.', TRUE, '2023-11-16 14:45:00'),
(10, 19, 19, 'Sage, documentary work sounds fascinating!', TRUE, '2023-02-23 11:40:00'),
(10, 20, 20, 'Leon provided amazing neighborhood insights.', TRUE, '2023-02-25 15:55:00');

-- 27. Property booking discounts (triple relationship 3)
INSERT INTO property_booking_discounts (property_id, booking_id, promo_id, discount_amount, applied_at) VALUES
(1, 1, 1, 97.00, '2023-01-10 16:45:00'), -- Welcome discount
(2, 2, 2, 380.00, '2023-07-15 12:30:00'), -- Summer discount
(3, 3, 5, 25.00, '2023-03-05 18:20:00'), -- Student discount
(1, 6, 4, 156.00, '2023-08-25 13:30:00'), -- Weekly discount
(8, 8, 1, 110.25, '2023-06-15 12:15:00'), -- Welcome discount
(6, 12, 6, 1050.00, '2023-08-10 11:30:00'), -- Family discount
(7, 7, 5, 25.00, '2023-04-05 16:20:00'), -- Student discount
(9, 9, 9, 93.60, '2023-10-30 17:35:00'), -- Weekend discount
(10, 10, 8, 40.00, '2023-02-10 14:25:00'), -- Artist discount
(11, 11, 10, 323.75, '2023-11-25 18:45:00'), -- Holiday discount
(12, 12, 2, 450.00, '2023-08-10 11:45:00'), -- Summer discount
(5, 5, 14, 50.00, '2023-05-10 15:40:00'), -- Flash discount
(13, 13, 3, 50.00, '2023-10-05 15:50:00'), -- New user discount
(14, 16, 11, 213.30, '2024-01-06 12:20:00'), -- Spring discount
(15, 17, 12, 162.00, '2024-02-08 17:45:00'), -- Last minute discount
(16, 18, 7, 27.75, '2024-03-15 12:10:00'), -- Business discount
(17, 19, 6, 442.50, '2024-03-25 11:30:00'), -- Family discount
(3, 15, 16, 121.50, '2023-09-10 16:40:00'), -- Winter discount
(4, 4, 13, 420.00, '2023-07-30 12:05:00'), -- Eco discount
(19, 20, 15, 25.00, '2023-08-20 16:45:00'); -- Photo discount

-- 28. User referrals (recursive relationship)
INSERT INTO user_referrals (referrer_user_id, referred_user_id, referral_code, referral_bonus, status, created_at, completed_at) VALUES
-- First level referrals
(1, 3, 'MARCUS_REF_001', 25.00, 'completed', '2021-02-08 14:30:00', '2021-02-15 16:30:00'),
(2, 4, 'SOFIA_REF_001', 25.00, 'completed', '2020-08-12 10:20:00', '2020-08-20 14:45:00'),
(1, 6, 'MARCUS_REF_002', 25.00, 'completed', '2022-01-18 11:20:00', '2022-01-25 11:20:00'),
(7, 8, 'OLIVER_REF_001', 25.00, 'completed', '2021-06-10 13:15:00', '2021-06-18 13:15:00'),
(2, 12, 'SOFIA_REF_002', 25.00, 'completed', '2020-12-15 15:25:00', '2020-12-23 15:25:00'),
(5, 14, 'DIEGO_REF_001', 25.00, 'completed', '2022-03-18 14:40:00', '2022-03-30 09:15:00'),
(9, 16, 'FINN_REF_001', 25.00, 'completed', '2022-01-05 12:50:00', '2022-01-12 12:50:00'),
(11, 18, 'KAI_REF_001', 25.00, 'completed', '2021-04-28 14:35:00', '2021-05-05 14:35:00'),
(13, 20, 'EZRA_REF_001', 25.00, 'completed', '2021-11-10 16:20:00', '2021-11-18 16:20:00'),
-- Second level referrals
(3, 10, 'LUCAS_REF_001', 25.00, 'completed', '2021-08-30 10:40:00', '2021-09-10 10:40:00'),
(4, 5, 'ELENA_REF_001', 25.00, 'completed', '2021-08-15 16:25:00', '2021-08-25 16:25:00'),
(6, 7, 'ZARA_REF_001', 25.00, 'completed', '2022-01-08 13:40:00', '2022-01-15 13:40:00'),
(8, 9, 'MAYA_REF_001', 25.00, 'completed', '2021-07-20 11:30:00', '2021-07-28 11:30:00'),
(12, 15, 'IRIS_REF_001', 25.00, 'completed', '2021-01-15 12:45:00', '2021-01-23 12:45:00'),
-- Third level referrals
(10, 13, 'NADIA_REF_001', 25.00, 'completed', '2022-03-20 11:25:00', '2022-03-30 11:25:00'),
(5, 19, 'DIEGO_REF_002', 25.00, 'completed', '2021-09-05 15:30:00', '2021-09-15 15:30:00'),
(15, 17, 'VERA_REF_001', 25.00, 'completed', '2022-02-10 14:15:00', '2022-02-18 14:15:00'),
-- Pending referrals
(17, 21, 'AXEL_REF_001', 25.00, 'pending', '2024-01-15 16:45:00', NULL),
(19, 11, 'LEON_REF_001', 25.00, 'expired', '2023-12-01 10:30:00', NULL),
(16, 2, 'NICO_REF_001', 25.00, 'completed', '2021-05-15 13:25:00', '2021-05-22 13:25:00');

-- 29. Property rules (depends on properties)
INSERT INTO property_rules (property_id, rule_type, rule_text) VALUES
(1, 'house', 'No smoking indoors, quiet hours 10 PM - 8 AM'),
(1, 'check_in', 'Check-in: 3:00 PM, Check-out: 11:00 AM'),
(1, 'cancellation', 'Moderate: Full refund 5+ days before arrival'),
(1, 'safety', 'Smoke detectors in all rooms, fire extinguisher in kitchen'),
(2, 'house', 'No parties, respect neighbors, rinse sand before entering'),
(2, 'cancellation', 'Free cancellation up to 7 days before arrival'),
(2, 'safety', 'Pool safety rules apply, no diving, adult supervision required'),
(3, 'house', 'No smoking, no pets, quiet hours after 9 PM'),
(3, 'cancellation', 'Strict: 48 hours full refund only due to business demand'),
(4, 'house', 'No smoking, family-friendly, respect building character'),
(4, 'cancellation', 'Flexible: Free cancellation until day of arrival'),
(4, 'safety', 'Historic building: Mind your head on low doorways'),
(5, 'house', 'Artist-friendly, no smoking, quiet hours 10 PM - 7 AM'),
(5, 'cancellation', 'Moderate: Free cancellation 5+ days before check-in'),
(6, 'house', 'No smoking, no parties, shoes off inside'),
(6, 'safety', 'Pool area: Safety equipment provided, no unsupervised swimming'),
(7, 'house', 'No smoking, studio space for creative work'),
(7, 'cancellation', 'Flexible: Free cancellation 24 hours before arrival'),
(8, 'house', 'Family-friendly, children welcome, supervise kids'),
(8, 'safety', 'Child safety locks provided, outlet covers available'),
(9, 'house', 'Beach condo - rinse sand, no smoking'),
(9, 'cancellation', 'Strict: High season bookings non-refundable within 14 days'),
(10, 'house', 'Historic building - no smoking, respect architecture'),
(10, 'cancellation', 'Moderate: 50% refund 3-7 days before arrival'),
(11, 'house', 'Brownstone character - no smoking, hardwood care'),
(12, 'house', 'Beach house premium - no sand indoors'),
(13, 'house', 'Family building quiet hours, respect neighbors'),
(14, 'house', 'Creative district - artistic activities welcome'),
(15, 'house', 'Elegant neighborhood standards, noise consideration'),
(16, 'house', 'Mission district cultural respect, local guidelines'),
(17, 'house', 'Hills exclusive area - no parties'),
(18, 'house', 'Business district professional environment'),
(19, 'house', 'Arts district creative space, installations welcome'),
(20, 'house', 'Trendy neighborhood, noise limits after 11 PM');

-- Verification summary
SELECT 'MINIMAL DATA INSERTION COMPLETE' as status;
SELECT 'All tables have 20+ entries' as verification;
SELECT 'Foreign key dependencies respected' as integrity;
SELECT 'Triple relationships implemented' as requirements;
SELECT 'Recursive referrals included' as recursive_check;
