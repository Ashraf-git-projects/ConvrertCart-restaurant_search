-- seed/seed.sql
-- Run this while connected to the 'restaurant_search' database.
-- Example: mysql -u root -p restaurant_search < seed/seed.sql

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE restaurants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL
);

CREATE TABLE menu_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  price INT NOT NULL,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  menu_item_id INT NOT NULL,
  order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- Insert sample restaurants
INSERT INTO restaurants (name, city) VALUES
('Hyderabadi Spice House', 'Hyderabad'),
('Biryaniwala', 'Hyderabad'),
('Urban Flavors', 'Bengaluru'),
('Taste of Lucknow', 'Lucknow'),
('South Grill', 'Chennai');

-- Insert sample menu items
-- Restaurant 1 (Hyderabadi Spice House)
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(1, 'Chicken Biryani', 220),
(1, 'Veg Biryani', 150),
(1, 'Mutton Biryani', 320);

-- Restaurant 2 (Biryaniwala)
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(2, 'Chicken Biryani', 200),
(2, 'Egg Biryani', 140),
(2, 'Paneer Biryani', 250);

-- Restaurant 3 (Urban Flavors)
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(3, 'Chicken Biryani', 180),
(3, 'Veg Biryani', 130),
(3, 'Hyderabadi Chicken Biryani', 230);

-- Restaurant 4 (Taste of Lucknow)
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(4, 'Lucknowi Biryani', 280),
(4, 'Chicken Biryani', 260);

-- Restaurant 5 (South Grill)
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(5, 'Chettinad Chicken', 210),
(5, 'Chicken Biryani', 240);

-- Insert sample orders (one row per order). Orders distributed to simulate counts.

-- Orders for restaurant 1 - Chicken Biryani (menu_item id 1)
INSERT INTO orders (menu_item_id) VALUES
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1); -- 12 orders

-- Veg Biryani (menu_item id 2)
INSERT INTO orders (menu_item_id) VALUES (2),(2),(2),(2),(2); -- 5 orders

-- Mutton Biryani (menu_item id 3)
INSERT INTO orders (menu_item_id) VALUES (3),(3),(3); -- 3 orders

-- Restaurant 2 - Chicken Biryani (menu_item id 4)
INSERT INTO orders (menu_item_id) VALUES
(4),(4),(4),(4),(4),(4),(4),(4),(4); -- 9 orders

-- Egg Biryani (menu_item id 5)
INSERT INTO orders (menu_item_id) VALUES (5),(5); -- 2 orders

-- Paneer Biryani (menu_item id 6)
INSERT INTO orders (menu_item_id) VALUES (6),(6),(6),(6); -- 4 orders

-- Restaurant 3 - Chicken Biryani (menu_item id 7)
INSERT INTO orders (menu_item_id) VALUES (7),(7),(7),(7),(7),(7); -- 6 orders

-- Veg Biryani (menu_item id 8)
INSERT INTO orders (menu_item_id) VALUES (8),(8); -- 2 orders

-- Hyderabadi Chicken Biryani (menu_item id 9)
INSERT INTO orders (menu_item_id) VALUES (9),(9),(9),(9),(9),(9),(9); -- 7 orders

-- Restaurant 4 - Lucknowi Biryani (menu_item id 10)
INSERT INTO orders (menu_item_id) VALUES (10),(10),(10); -- 3 orders

-- Restaurant 4 - Chicken Biryani (menu_item id 11)
INSERT INTO orders (menu_item_id) VALUES (11),(11),(11),(11),(11); -- 5 orders

-- Restaurant 5 - Chettinad Chicken (menu_item id 12)
INSERT INTO orders (menu_item_id) VALUES (12),(12); -- 2 orders

-- Restaurant 5 - Chicken Biryani (menu_item id 13)
INSERT INTO orders (menu_item_id) VALUES (13),(13),(13),(13),(13),(13),(13),(13),(13),(13); -- 10 orders

-- Done
