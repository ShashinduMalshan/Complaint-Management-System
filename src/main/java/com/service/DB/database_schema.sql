-- Complaint Management System Database Schema

-- Create the database (if not exists)
CREATE DATABASE IF NOT EXISTS complaint_management_db;

-- Use the database
USE complaint_management_db;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);

-- Create complaints table
CREATE TABLE complaints (
    comId INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    remarks VARCHAR(255) DEFAULT 'none',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user
INSERT INTO users (name, password, role) VALUES ('admin', 'admin123', 'admin');

-- Add indexes for better performance
CREATE INDEX idx_user_id ON complaints (user_id);
CREATE INDEX idx_status ON complaints (status);
CREATE INDEX idx_created_at ON complaints (created_at);