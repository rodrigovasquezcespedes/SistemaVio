CREATE DATABASE customs_agency;
USE customs_agency;

-- Table for shipping lines (Navieras)
CREATE TABLE shipping_lines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);

-- Table for ships (Naves)
CREATE TABLE ships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    shipping_line_id INT,
    FOREIGN KEY (shipping_line_id) REFERENCES shipping_lines(id)
);

-- Table for containers
CREATE TABLE containers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(100),
    ship_id INT,
    guaranteed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ship_id) REFERENCES ships(id)
);

-- Table for dispatches (Despachos)
CREATE TABLE dispatches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bl_number VARCHAR(50) NOT NULL UNIQUE,
    ship_id INT,
    FOREIGN KEY (ship_id) REFERENCES ships(id)
);

-- Table for container inspections (Revisiones)
CREATE TABLE inspections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    container_id INT,
    inspection_type ENUM('Aduana', 'SAG', 'Seremi de Salud', 'Sernapesca'),
    status ENUM('Pending', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (container_id) REFERENCES containers(id)
);

-- Table for operations (Programacion y Retiro)
CREATE TABLE operations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    container_id INT,
    schedule_datetime DATETIME,
    transport_sequence INT AUTO_INCREMENT,
    FOREIGN KEY (container_id) REFERENCES containers(id)
);

-- Table for transport coordination
CREATE TABLE transport (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operation_id INT,
    truck_info VARCHAR(255),
    driver_name VARCHAR(255),
    contact_info VARCHAR(255),
    FOREIGN KEY (operation_id) REFERENCES operations(id)
);

-- Table for clients
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(50)
);

-- Relationship between clients and dispatches
ALTER TABLE dispatches ADD COLUMN client_id INT;
ALTER TABLE dispatches ADD FOREIGN KEY (client_id) REFERENCES clients(id);
`;