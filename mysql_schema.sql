-- buybot-website/mysql_schema.sql
-- This file contains the SQL commands to set up the database schema for the BuyBot website.

-- Create Database (if it does not exist)
CREATE DATABASE IF NOT EXISTS buybot_db;

-- Use the newly created database
USE buybot_db;

-- Table for Users
-- In a real application, 'password_hash' would store securely hashed passwords.
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Stores a hashed password (e.g., using PHP's password_hash())
    date_of_birth VARCHAR(10), -- Stored as string for flexibility (e.g., DD/MM/YYYY)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Products
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    shop_name VARCHAR(255),
    stars INT DEFAULT 0, -- Rating out of 5
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Training Programs
CREATE TABLE IF NOT EXISTS training_programs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    duration VARCHAR(50),
    credits VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Junction table to link users to the training programs they have joined
-- A user can join multiple programs, and a program can have multiple users.
CREATE TABLE IF NOT EXISTS user_joined_programs (
    user_id INT,
    program_id INT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, program_id), -- Ensures a user can only join a program once
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES training_programs(id) ON DELETE CASCADE
);

-- Optional: Insert initial dummy data for demonstration purposes
-- Users
INSERT INTO users (name, email, password_hash, date_of_birth) VALUES
('Jiah Mashaal', 'jiah@example.com', 'hashed_pass_jiah', '01/01/2000'),
('John Doe', 'john.doe@example.com', 'hashed_pass_john', '15/05/1990'),
('Jane Smith', 'jane.smith@example.com', 'hashed_pass_jane', '22/11/1985');

-- Products
INSERT INTO products (name, description, image_url, shop_name, stars, category) VALUES
('Z FLIP AND Z FOLD 2024', 'Latest foldable phones from SAMGEE ELETRICS', 'https://buybot.neocities.org/img_6711%20(1).webp', 'SAMGEE ELETRICS', 5, 'Electronics'),
('STANLEY CUPS', 'Insulated tumblers for hot and cold beverages', 'https://buybot.neocities.org/Stanley-cups-011024-tout-7122075a1e6a46a2a2bc84faca226f54.jpg', 'MOLLY.SHOP', 4, 'Drinkware'),
('JONI'S BOTANICALS', 'HOUSE PLANTS, POT PLANTS, SEEDS AND MUCH MORE', 'https://buybot.neocities.org/us-homegoods-tile-1.jpg', 'Joni's Botanicals', 3, 'Home Goods'),
('DELIGHT'S LIGHTS', 'CHANDLIERS, DOWN LIGHTS, LAMPS AND MUCH MORE', 'https://buybot.neocities.org/unnamed.jpg', 'Delight's Lights', 3, 'Home Goods'),
('LEMORE SKIN', 'THE ENTIRE ORGANIC REJUVINATION LEMORE RANGE', 'https://buybot.neocities.org/cosmetics.webp', 'Lemore Skin', 2, 'Cosmetics');

-- Training Programs
INSERT INTO training_programs (title, description, image_url, duration, credits) VALUES
('COSMETICS PROGRAM', 'Learn everything about cosmetics retail.', 'https://buybot.neocities.org/makeup-cosmetics.webp', '3 weeks', '5'),
('FURNISHINGS PROGRAM', 'Master the art of selling home furnishings.', 'https://buybot.neocities.org/furniture-on-white-background-ai-generative-photo.jpg', '4 weeks', '6'),
('The Ultimate Guide to Store Fronts', 'Learn all you need to know about the store fronts that take customers from scrolling to shopping.', 'https://buybot.neocities.org/mict-skills-academy-palanganatham-madurai-institutes-for-mobile-phone-servicing-ra5has4nri.jpg', '3 week', '5'),
('The Ultimate Guide to Shipping', 'Learn all it all from drop shipping to door to door.', 'https://buybot.neocities.org/mict-skills-academy-palanganatham-madurai-institutes-for-mobile-phone-servicing-ra5has4nri.jpg', '2 week', '4');

-- User Joined Programs (example relationships)
-- Assuming user 'Jiah Mashaal' (id=1) joined 'COSMETICS PROGRAM' (id=1)
INSERT INTO user_joined_programs (user_id, program_id) VALUES
(1, 1);
-- Assuming user 'John Doe' (id=2) joined 'The Ultimate Guide to Store Fronts' (id=3)
INSERT INTO user_joined_programs (user_id, program_id) VALUES
(2, 3);
