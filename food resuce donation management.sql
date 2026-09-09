create database food_rescue;
USE food_rescue;
SELECT DATABASE();
CREATE TABLE donors (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    location VARCHAR(100)
);
SHOW TABLES;
INSERT INTO donors
(donor_name, phone, email, location)
VALUES
('Fresh Bites Restaurant', '9876543210', 'fresh@gmail.com', 'Hyderabad'),
('Green Bakery', '9876543211', 'green@gmail.com', 'Secunderabad'),
('Daily Meals', '9876543212', 'daily@gmail.com', 'Kukatpally'),
('Food Corner', '9876543213', 'food@gmail.com', 'Madhapur'),
('Healthy Kitchen', '9876543214', 'healthy@gmail.com', 'Gachibowli');
SELECT * FROM donors;
CREATE TABLE food_items (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    food_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    quantity INT NOT NULL,
    expiry_date DATE,
    status VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (donor_id) REFERENCES donors(donor_id)
);
SHOW TABLES;
DESCRIBE food_items;
INSERT INTO food_items
(donor_id, food_name, category, quantity, expiry_date, status)
VALUES
(1, 'Rice Meals', 'Cooked Food', 50, '2026-09-10', 'Available'),
(1, 'Vegetable Biryani', 'Cooked Food', 30, '2026-09-10', 'Available'),
(2, 'Bread', 'Bakery', 40, '2026-09-11', 'Available'),
(2, 'Buns', 'Bakery', 25, '2026-09-11', 'Available'),
(3, 'Curd Rice', 'Cooked Food', 35, '2026-09-10', 'Available'),
(3, 'Chapati', 'Cooked Food', 60, '2026-09-11', 'Available'),
(4, 'Vegetable Curry', 'Cooked Food', 20, '2026-09-10', 'Available'),
(4, 'Fruits', 'Fruits', 45, '2026-09-12', 'Available'),
(5, 'Idli', 'Cooked Food', 50, '2026-09-10', 'Available'),
(5, 'Biscuits', 'Packaged Food', 30, '2026-09-15', 'Available');
SELECT * FROM food_items;
CREATE TABLE organizations (
    org_id INT PRIMARY KEY AUTO_INCREMENT,
    org_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(15),
    location VARCHAR(100)
);
INSERT INTO organizations
(org_name, contact_person, phone, location)
VALUES
('Helping Hands NGO', 'Ravi Kumar', '9988776655', 'Hyderabad'),
('Hope Foundation', 'Priya Sharma', '9988776656', 'Secunderabad'),
('Care & Share Trust', 'Anil Reddy', '9988776657', 'Kukatpally'),
('Food For All', 'Sneha Rao', '9988776658', 'Madhapur'),
('Community Support Center', 'Kiran Das', '9988776659', 'Gachibowli');
SELECT * FROM organizations;
SELECT * FROM donors;
CREATE TABLE donations (
    donation_id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT NOT NULL,
    org_id INT NOT NULL,
    donation_date DATE NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (food_id) REFERENCES food_items(food_id),
    FOREIGN KEY (org_id) REFERENCES organizations(org_id)
);
SHOW TABLES;
DESCRIBE donations;
INSERT INTO donations
(food_id, org_id, donation_date, quantity, status)
VALUES
(1, 1, '2026-09-09', 40, 'Completed'),
(2, 2, '2026-09-09', 25, 'Completed'),
(3, 3, '2026-09-09', 30, 'Pending'),
(4, 4, '2026-09-09', 20, 'Completed'),
(5, 5, '2026-09-09', 30, 'Pending'),
(6, 1, '2026-09-09', 50, 'Completed'),
(7, 2, '2026-09-09', 15, 'Pending'),
(8, 3, '2026-09-09', 35, 'Completed');
SELECT * FROM donations;
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    donation_id INT NOT NULL,
    rating INT,
    comments VARCHAR(255),
    feedback_date DATE,

    FOREIGN KEY (donation_id) REFERENCES donations(donation_id)
);
SHOW TABLES;
DESCRIBE feedback;
INSERT INTO feedback
(donation_id, rating, comments, feedback_date)
VALUES
(1, 5, 'Food was fresh and well packed', '2026-09-09'),
(2, 4, 'Good quality food', '2026-09-09'),
(4, 5, 'Very helpful donation', '2026-09-09'),
(6, 4, 'Food was delivered on time', '2026-09-09'),
(8, 5, 'Excellent support', '2026-09-09');
SELECT * FROM feedback;
SELECT * FROM donors;
SELECT donor_name, location
FROM donors;
SELECT *
FROM donors
WHERE location = 'Hyderabad';
SELECT *
FROM food_items
WHERE status = 'Available';
SELECT *
FROM food_items
WHERE quantity > 40;
SELECT *
FROM food_items
ORDER BY quantity DESC;
SELECT COUNT(*) AS total_donors
FROM donors;
SELECT SUM(quantity) AS total_quantity
FROM donations
WHERE status = 'Completed';
SELECT AVG(rating) AS average_rating
FROM feedback;
SELECT status, COUNT(*) AS total
FROM donations
GROUP BY status;
SELECT
    f.food_id,
    f.food_name,
    f.quantity,
    d.donor_name
FROM food_items f
JOIN donors d
    ON f.donor_id = d.donor_id;
    SELECT
    dn.donation_id,
    f.food_name,
    o.org_name,
    dn.quantity,
    dn.donation_date,
    dn.status
FROM donations dn
JOIN food_items f
    ON dn.food_id = f.food_id
JOIN organizations o
    ON dn.org_id = o.org_id;
    SELECT
    dn.donation_id,
    d.donor_name,
    f.food_name,
    o.org_name,
    dn.quantity,
    dn.donation_date,
    dn.status
FROM donations dn
JOIN food_items f
    ON dn.food_id = f.food_id
JOIN donors d
    ON f.donor_id = d.donor_id
JOIN organizations o
    ON dn.org_id = o.org_id;
    SELECT
    dn.donation_id,
    o.org_name,
    dn.quantity,
    fb.rating,
    fb.comments
FROM donations dn
JOIN organizations o
    ON dn.org_id = o.org_id
JOIN feedback fb
    ON dn.donation_id = fb.donation_id;
    SELECT AVG(quantity)
FROM food_items;
SELECT food_name, quantity
FROM food_items
WHERE quantity > (
    SELECT AVG(quantity)
    FROM food_items
);
SELECT donation_id, food_id, quantity
FROM donations
WHERE quantity > (
    SELECT AVG(quantity)
    FROM donations
);
SELECT donor_name
FROM donors
WHERE donor_id IN (
    SELECT donor_id
    FROM food_items
);
SELECT org_name
FROM organizations
WHERE org_id IN (
    SELECT org_id
    FROM donations
    WHERE status = 'Completed'
);
SELECT donor_name
FROM donors
WHERE donor_id = (
    SELECT donor_id
    FROM food_items
    GROUP BY donor_id
    ORDER BY SUM(quantity) DESC
    LIMIT 1
);
CREATE VIEW available_food AS
SELECT
    f.food_id,
    f.food_name,
    f.category,
    f.quantity,
    f.expiry_date,
    d.donor_name
FROM food_items f
JOIN donors d
    ON f.donor_id = d.donor_id
WHERE f.status = 'Available';
SELECT * FROM available_food;
CREATE VIEW completed_donations AS
SELECT
    dn.donation_id,
    d.donor_name,
    f.food_name,
    o.org_name,
    dn.quantity,
    dn.donation_date
FROM donations dn
JOIN food_items f
    ON dn.food_id = f.food_id
JOIN donors d
    ON f.donor_id = d.donor_id
JOIN organizations o
    ON dn.org_id = o.org_id
WHERE dn.status = 'Completed';
SELECT * FROM completed_donations;
CREATE VIEW donor_summary AS
SELECT
    d.donor_id,
    d.donor_name,
    COUNT(f.food_id) AS food_items,
    COALESCE(SUM(f.quantity), 0) AS total_quantity
FROM donors d
LEFT JOIN food_items f
    ON d.donor_id = f.donor_id
GROUP BY d.donor_id, d.donor_name;
SELECT * FROM donor_summary;
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';
DELIMITER //

CREATE PROCEDURE GetDonorDetails(IN p_donor_id INT)
BEGIN
    SELECT
        d.donor_name,
        d.phone,
        d.email,
        f.food_name,
        f.category,
        f.quantity,
        f.expiry_date,
        f.status
    FROM donors d
    JOIN food_items f
        ON d.donor_id = f.donor_id
    WHERE d.donor_id = p_donor_id;
END //

DELIMITER ;
CALL GetDonorDetails(1);
DELIMITER //

CREATE PROCEDURE GetOrganizationDonations(IN p_org_id INT)
BEGIN
    SELECT
        o.org_name,
        f.food_name,
        d.quantity,
        d.donation_date,
        d.status
    FROM organizations o
    JOIN donations d
        ON o.org_id = d.org_id
    JOIN food_items f
        ON d.food_id = f.food_id
    WHERE o.org_id = p_org_id;
END //

DELIMITER ;
CALL GetOrganizationDonations(1);
SHOW PROCEDURE STATUS
WHERE Db = 'food_rescue';
DELIMITER //

CREATE FUNCTION CalculateFoodValue(
    p_quantity INT,
    p_price_per_unit DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_quantity * p_price_per_unit;
END //

DELIMITER ;
SELECT CalculateFoodValue(50, 40) AS estimated_value;
SELECT
    food_name,
    quantity,
    CalculateFoodValue(quantity, 40) AS estimated_value
FROM food_items;
SHOW FUNCTION STATUS
WHERE Db = 'food_rescue';
DELIMITER //

CREATE TRIGGER update_food_status
AFTER UPDATE ON donations
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' THEN
        UPDATE food_items
        SET status = 'Donated'
        WHERE food_id = NEW.food_id;
    END IF;
END //

DELIMITER ;
SHOW TRIGGERS
WHERE `Trigger` = 'update_food_status';
SELECT *
FROM donations
WHERE donation_id = 3;
UPDATE donations
SET status = 'Completed'
WHERE donation_id = 3;
SELECT food_id, food_name, status
FROM food_items
WHERE food_id = 3;
SELECT food_id, food_name, quantity, status
FROM food_items
WHERE food_id = 4;
START TRANSACTION;
UPDATE donations
SET status = 'Completed'
WHERE donation_id = 7;
UPDATE food_items
SET quantity = quantity - 15
WHERE food_id = 7;
COMMIT;
START TRANSACTION;

UPDATE food_items
SET quantity = quantity - 10
WHERE food_id = 8;
SELECT food_id, food_name, quantity
FROM food_items
WHERE food_id = 8;
ROLLBACK;
SELECT food_id, food_name, quantity
FROM food_items
WHERE food_id = 8;
SELECT food_id, food_name, quantity
FROM food_items
WHERE food_id = 8;
SELECT *
FROM food_items
WHERE status = 'Available';
CREATE INDEX idx_food_status
ON food_items(status);
SELECT *
FROM donations
WHERE donation_date = '2026-09-09';
CREATE INDEX idx_donation_date
ON donations(donation_date);
SHOW INDEX FROM food_items;
SHOW INDEX FROM donations;
SELECT
    d.donor_name,
    COUNT(f.food_id) AS total_food_items,
    COALESCE(SUM(f.quantity), 0) AS total_quantity
FROM donors d
LEFT JOIN food_items f
    ON d.donor_id = f.donor_id
GROUP BY d.donor_id, d.donor_name
ORDER BY total_quantity DESC;
SELECT
    o.org_name,
    COUNT(d.donation_id) AS total_donations,
    SUM(d.quantity) AS total_quantity
FROM organizations o
JOIN donations d
    ON o.org_id = d.org_id
WHERE d.status = 'Completed'
GROUP BY o.org_id, o.org_name
ORDER BY total_quantity DESC;
SELECT
    status,
    COUNT(*) AS total_donations,
    SUM(quantity) AS total_quantity
FROM donations
GROUP BY status;
SELECT
    f.food_name,
    f.category,
    f.quantity,
    f.expiry_date,
    d.donor_name
FROM food_items f
JOIN donors d
    ON f.donor_id = d.donor_id
WHERE f.status = 'Available'
ORDER BY f.expiry_date ASC;
SELECT
    o.org_name,
    f.rating,
    f.comments,
    f.feedback_date
FROM feedback f
JOIN donations d
    ON f.donation_id = d.donation_id
JOIN organizations o
    ON d.org_id = o.org_id
ORDER BY f.rating DESC;
SELECT
    dn.donation_id,
    d.donor_name,
    f.food_name,
    f.category,
    o.org_name,
    dn.quantity,
    dn.donation_date,
    dn.status
FROM donations dn
JOIN food_items f
    ON dn.food_id = f.food_id
JOIN donors d
    ON f.donor_id = d.donor_id
JOIN organizations o
    ON dn.org_id = o.org_id
ORDER BY dn.donation_date DESC;