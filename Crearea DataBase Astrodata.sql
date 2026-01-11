USE Astro_Data;

CREATE TABLE Rockets (
    rocket_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    height_m INT NOT NULL,
    stages INT NOT NULL,
    propulsion_type VARCHAR(50) NOT NULL,
    reusable ENUM('Yes','No') NOT NULL
) ;


CREATE TABLE  Launch_Sites (
    site_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    site_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
) ;

CREATE TABLE  Missions (
    mission_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rocket_id INT NOT NULL,
    launch_site_id INT NOT NULL,
    mission_name VARCHAR(100) NOT NULL,
    mission_type ENUM('Satellite Deployment','Planetary Exploration','Observatory','Research') NOT NULL,
    launch_date DATE NOT NULL,
    duration_minutes INT NOT NULL,
    total_duration_minutes INT NOT NULL,
    FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id),
    FOREIGN KEY (launch_site_id) REFERENCES Launch_Sites(site_id)
) ;

CREATE TABLE  Payloads (
    payload_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    mission_id INT NOT NULL,
    launch_site_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    payload_type ENUM('Planet','Star','Moon','Satellite') NOT NULL,
    origin ENUM('Orbit','Planet','Star','Moon') NOT NULL,
    mass_kg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (mission_id) REFERENCES Missions(mission_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (launch_site_id) REFERENCES Launch_Sites(site_id)
) ;


CREATE TABLE  Components (
    component_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rocket_id INT NOT NULL,
    component_name VARCHAR(100) NOT NULL,
    component_type ENUM(
        'Structural', 'Propulsion', 'Guidance', 'Payload',
        'Avionics', 'Recovery', 'Thermal', 'Power', 'FuelSystem', 'Instrumentation'
    ) NOT NULL,
    material VARCHAR(50),
    weight_kg DECIMAL(10,2),
    stage INT,
    power_kw DECIMAL(10,2),
    thermal_resistance_degC DECIMAL(8,2),
    thrust_kn DECIMAL(10,2),
    sensor_type VARCHAR(50),
    quantity INT DEFAULT 1,
    FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id)
) ;


CREATE TABLE  Astronauts (
    astronaut_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rocket_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    gender ENUM('M','F') NOT NULL,
    nationality VARCHAR(50),
    profession VARCHAR(100),
    mission_role VARCHAR(100),
    FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id)
) ;

####################################################################
INSERT INTO Rockets (rocket_id, name, height_m, stages, propulsion_type, reusable) VALUES
(1, 'Falcon 9', 70, 2, 'Liquid', 'No'),
(2, 'Falcon Heavy', 70, 3, 'Liquid', 'No'),
(3, 'Electron', 18, 2, 'Liquid', 'No'),
(4, 'Vega', 30, 2, 'Solid', 'No'),
(5, 'Ariane 5', 52, 2, 'Liquid', 'No'),
(6, 'Atlas V', 58, 2, 'Liquid', 'No'),
(7, 'Delta IV', 70, 2, 'Liquid', 'No'),
(8, 'Long March 5', 57, 2, 'Liquid', 'No'),
(9, 'Soyuz', 46, 2, 'Liquid', 'No'),
(10, 'New Shepard', 18, 1, 'Liquid', 'No'),
(11, 'Starship', 120, 2, 'Liquid', 'No'),
(12, 'Dream Chaser', 12, 1, 'Liquid', 'No'),
(13, 'Test Rocket 1', 20, 1, 'Liquid', 'No'),
(14, 'Test Rocket 2', 25, 1, 'Liquid', 'No'),
(15, 'Test Rocket 3', 35, 1, 'Liquid', 'No');


INSERT INTO Launch_Sites (site_name, country, latitude, longitude) VALUES
('Cape Canaveral / Kennedy Space Center', 'USA', 28.392200, -80.607700),
('Vandenberg Space Force Base', 'USA', 34.742000, -120.572400),
('Wallops Flight Facility', 'USA', 37.940000, -75.466000),
('Baikonur Cosmodrome', 'Kazakhstan', 45.920000, 63.342000);

INSERT INTO Missions (rocket_id, launch_site_id, mission_name, mission_type, launch_date, duration_minutes, total_duration_minutes) VALUES
(1, 1, 'Mission 1', 'Research', '2024-08-15', 90, 210),
(2, 1, 'Mission 2', 'Satellite Deployment', '2024-09-10', 120, 260),
(3, 2, 'Mission 3', 'Observatory', '2024-09-28', 60, 135),
(4, 1, 'Mission 4', 'Research', '2024-10-18', 90, 210),
(5, 3, 'Mission 5', 'Satellite Deployment', '2024-11-05', 120, 260),
(6, 2, 'Mission 6', 'Observatory', '2024-12-12', 60, 135),
(7, 3, 'Mission 7', 'Research', '2025-01-20', 90, 210),
(8, 2, 'Mission 8', 'Satellite Deployment', '2025-02-08', 120, 260),
(9, 1, 'Mission 9', 'Research', '2025-03-14', 90, 210),
(10, 3, 'Mission 10', 'Observatory', '2025-04-22', 60, 135),
(11, 3, 'Mission 11', 'Research', '2025-06-03', 90, 210),
(12, 2, 'Mission 12', 'Observatory', '2025-07-19', 60, 135);

INSERT INTO Payloads (mission_id, launch_site_id, name, payload_type, origin, mass_kg) VALUES
-- Mission 1
(1, 1, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(1, 1, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(1, 1, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(1, 1, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(1, 1, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(1, 1, 'Stellar Camera', 'Star', 'Star', 60.00),
(1, 1, 'Magnetic Field Sensor', 'Satellite', 'Orbit', 35.00),
(1, 1, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(1, 1, 'Comms Satellite A', 'Satellite', 'Orbit', 500.00),
(1, 1, 'Comms Satellite B', 'Satellite', 'Orbit', 450.00),
(1, 1, 'Observation Telescope', 'Star', 'Star', 200.00),
(1, 1, 'Lunar Lander', 'Moon', 'Moon', 150.00),
-- Mission 2
(2, 1, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(2, 1, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(2, 1, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(2, 1, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(2, 1, 'Stellar Camera', 'Star', 'Star', 60.00),
(2, 1, 'Comms Satellite C', 'Satellite', 'Orbit', 480.00),
(2, 1, 'Comms Satellite D', 'Satellite', 'Orbit', 520.00),
(2, 1, 'Lunar Rover', 'Moon', 'Moon', 120.00),
-- Mission 3
(3, 2, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(3, 2, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(3, 2, 'Observation Telescope', 'Star', 'Star', 200.00),
(3, 2, 'Stellar Camera', 'Star', 'Star', 60.00),
(3, 2, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(3, 2, 'Moon Probe', 'Moon', 'Moon', 100.00),

-- Mission 4
(4, 3, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(4, 3, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(4, 3, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(4, 3, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(4, 3, 'Stellar Camera', 'Star', 'Star', 60.00),
(4, 3, 'Moon Lander', 'Moon', 'Moon', 140.00),

-- Mission 5
(5, 1, 'Comms Satellite E', 'Satellite', 'Orbit', 500.00),
(5, 1, 'Comms Satellite F', 'Satellite', 'Orbit', 450.00),
(5, 1, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(5, 1, 'Observation Telescope', 'Star', 'Star', 200.00),
(5, 1, 'Stellar Camera', 'Star', 'Star', 60.00),

-- Mission 6
(6, 2, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(6, 2, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(6, 2, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(6, 2, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(6, 2, 'Stellar Camera', 'Star', 'Star', 60.00),
(6, 2, 'Magnetic Field Sensor', 'Satellite', 'Orbit', 35.00),
(6, 2, 'Moon Rover', 'Moon', 'Moon', 130.00),

-- Mission 7
(7, 3, 'Comms Satellite G', 'Satellite', 'Orbit', 480.00),
(7, 3, 'Comms Satellite H', 'Satellite', 'Orbit', 520.00),
(7, 3, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(7, 3, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(7, 3, 'Observation Telescope', 'Star', 'Star', 200.00),
(7, 3, 'Stellar Camera', 'Star', 'Star', 60.00),
(7, 3, 'Planetary Camera', 'Planet', 'Planet', 80.00),

-- Mission 8
(8, 2, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(8, 2, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(8, 2, 'Observation Telescope', 'Star', 'Star', 200.00),
(8, 2, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(8, 2, 'Comms Satellite I', 'Satellite', 'Orbit', 500.00),

-- Mission 9
(9, 1, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(9, 1, 'Observation Telescope', 'Star', 'Star', 200.00),
(9, 1, 'Stellar Camera', 'Star', 'Star', 60.00),

-- Mission 10
(10, 3, 'Observation Telescope', 'Star', 'Star', 200.00),
(10, 3, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(10, 3, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),

-- Mission 11
(11, 1, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(11, 1, 'Stellar Camera', 'Star', 'Star', 60.00),
(11, 1, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(11, 1, 'Moon Lander', 'Moon', 'Moon', 150.00),

-- Mission 12
(12, 2, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(12, 2, 'Observation Telescope', 'Star', 'Star', 200.00),
(12, 2, 'Comms Satellite J', 'Satellite', 'Orbit', 480.00),
(12, 2, 'Moon Rover', 'Moon', 'Moon', 130.00);

INSERT INTO Components
(rocket_id, component_name, component_type, material, weight_kg, stage, power_kw, thermal_resistance_degC, thrust_kn, sensor_type, quantity)
VALUES
-- Racheta 1 – Falcon 9 (total 549,000 kg)
(1, 'Body Tube', 'Structural', 'Aluminum', 150000, 1, NULL, NULL, NULL, NULL, 1),
(1, 'Fins', 'Structural', 'Aluminum', 1250, 1, NULL, NULL, NULL, NULL, 4),
(1, 'Main Engine', 'Propulsion', 'Steel', 190000, 1, NULL, NULL, 7600, NULL, 1),
(1, 'Thrusters', 'Propulsion', 'Titanium', 100, 2, NULL, NULL, 400, NULL, 4),
(1, 'Flight Computer', 'Guidance', 'Silicon', 100, 1, 5, NULL, NULL, 'Inertial', 1),
(1, 'Communication System', 'Avionics', 'Copper/Plastic', 50, 1, 3, NULL, NULL, 'Radio', 1),
(1, 'Thermal Tiles', 'Thermal', 'Ceramic', 40, 2, NULL, 2000, NULL, NULL, 50),
(1, 'Solar Panels', 'Power', 'Silicon', 250, 2, 10, NULL, NULL, NULL, 2),
(1, 'Satellite Payload', 'Payload', 'Composite', 10000, 2, NULL, NULL, NULL, 'Camera', 1),
(1, 'Parachute', 'Recovery', 'Nylon', 1000, 2, NULL, NULL, NULL, NULL, 1),
(1, 'Battery Pack', 'Power', 'Lithium', 100, 1, 15, NULL, NULL, NULL, 2),
(1, 'Fuel Tank', 'FuelSystem', 'Titanium', 180000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 2 – Falcon Heavy (total 1,420,000 kg)
(2, 'Body Tube', 'Structural', 'AluComponentsminum', 400000, 1, NULL, NULL, NULL, NULL, 1),
(2, 'Fins', 'Structural', 'Aluminum', 2000, 1, NULL, NULL, NULL, NULL, 4),
(2, 'Main Engine', 'Propulsion', 'Steel', 500000, 1, NULL, NULL, 7200, NULL, 1),
(2, 'Thrusters', 'Propulsion', 'Titanium', 375, 2, NULL, NULL, 380, NULL, 4),
(2, 'Flight Computer', 'Guidance', 'Silicon', 200, 1, 5, NULL, NULL, 'Inertial', 1),
(2, 'Communication System', 'Avionics', 'Copper/Plastic', 100, 1, 3, NULL, NULL, 'Radio', 1),
(2, 'Thermal Tiles', 'Thermal', 'Ceramic', 100, 2, NULL, 2000, NULL, NULL, 50),
(2, 'Solar Panels', 'Power', 'Silicon', 750, 2, 10, NULL, NULL, NULL, 2),
(2, 'Satellite Payload', 'Payload', 'Composite', 60000, 2, NULL, NULL, NULL, 'Camera', 1),
(2, 'Parachute', 'Recovery', 'Nylon', 3000, 2, NULL, NULL, NULL, NULL, 1),
(2, 'Battery Pack', 'Power', 'Lithium', 250, 1, 15, NULL, NULL, NULL, 2),
(2, 'Fuel Tank', 'FuelSystem', 'Titanium', 350000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 3 – Electron (total 12,500 kg)
(3, 'Body Tube', 'Structural', 'Aluminum', 3000, 1, NULL, NULL, NULL, NULL, 1),
(3, 'Fins', 'Structural', 'Aluminum', 100, 1, NULL, NULL, NULL, NULL, 4),
(3, 'Main Engine', 'Propulsion', 'Steel', 5000, 1, NULL, 2000, 760, NULL, 1),
(3, 'Thrusters', 'Propulsion', 'Titanium', 200, 2, NULL, NULL, 80, NULL, 4),
(3, 'Flight Computer', 'Guidance', 'Silicon', 50, 1, 1, NULL, NULL, 'Inertial', 1),
(3, 'Communication System', 'Avionics', 'Copper/Plastic', 25, 1, 0.5, NULL, NULL, 'Radio', 1),
(3, 'Thermal Tiles', 'Thermal', 'Ceramic', 25, 2, NULL, 50, NULL, NULL, 10),
(3, 'Solar Panels', 'Power', 'Silicon', 50, 2, 2, NULL, NULL, NULL, 2),
(3, 'Satellite Payload', 'Payload', 'Composite', 500, 2, NULL, NULL, NULL, 'Camera', 1),
(3, 'Parachute', 'Recovery', 'Nylon', 50, 2, NULL, NULL, NULL, NULL, 1),
(3, 'Battery Pack', 'Power', 'Lithium', 30, 1, 1, NULL, NULL, NULL, 2),
(3, 'Fuel Tank', 'FuelSystem', 'Titanium', 4000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 4 – Vega (total 13,100 kg)
(4, 'Body Tube', 'Structural', 'Aluminum', 3500, 1, NULL, NULL, NULL, NULL, 1),
(4, 'Fins', 'Structural', 'Aluminum', 120, 1, NULL, NULL, NULL, NULL, 4),
(4, 'Main Engine', 'Propulsion', 'Steel', 5200, 1, NULL, 2000, 800, NULL, 1),
(4, 'Thrusters', 'Propulsion', 'Titanium', 180, 2, NULL, NULL, 90, NULL, 4),
(4, 'Flight Computer', 'Guidance', 'Silicon', 60, 1, 1, NULL, NULL, 'Inertial', 1),
(4, 'Communication System', 'Avionics', 'Copper/Plastic', 30, 1, 0.5, NULL, NULL, 'Radio', 1),
(4, 'Thermal Tiles', 'Thermal', 'Ceramic', 30, 2, NULL, 50, NULL, NULL, 10),
(4, 'Solar Panels', 'Power', 'Silicon', 50, 2, 2, NULL, NULL, NULL, 2),
(4, 'Satellite Payload', 'Payload', 'Composite', 500, 2, NULL, NULL, NULL, 'Camera', 1),
(4, 'Parachute', 'Recovery', 'Nylon', 50, 2, NULL, NULL, NULL, NULL, 1),
(4, 'Battery Pack', 'Power', 'Lithium', 35, 1, 1, NULL, NULL, NULL, 2),
(4, 'Fuel Tank', 'FuelSystem', 'Titanium', 4800, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 5 – Ariane 5 (total 780,000 kg)
(5, 'Body Tube', 'Structural', 'Aluminum', 200000, 1, NULL, NULL, NULL, NULL, 1),
(5, 'Fins', 'Structural', 'Aluminum', 1500, 1, NULL, NULL, NULL, NULL, 4),
(5, 'Main Engine', 'Propulsion', 'Steel', 250000, 1, NULL, NULL, 7000, NULL, 1),
(5, 'Thrusters', 'Propulsion', 'Titanium', 300, 2, NULL, NULL, 350, NULL, 4),
(5, 'Flight Computer', 'Guidance', 'Silicon', 150, 1, 5, NULL, NULL, 'Inertial', 1),
(5, 'Communication System', 'Avionics', 'Copper/Plastic', 100, 1, 3, NULL, NULL, 'Radio', 1),
(5, 'Thermal Tiles', 'Thermal', 'Ceramic', 200, 2, NULL, 2000, NULL, NULL, 50),
(5, 'Solar Panels', 'Power', 'Silicon', 500, 2, 10, NULL, NULL, NULL, 2),
(5, 'Satellite Payload', 'Payload', 'Composite', 10000, 2, NULL, NULL, NULL, 'Camera', 1),
(5, 'Parachute', 'Recovery', 'Nylon', 2000, 2, NULL, NULL, NULL, NULL, 1),
(5, 'Battery Pack', 'Power', 'Lithium', 200, 1, 15, NULL, NULL, NULL, 2),
(5, 'Fuel Tank', 'FuelSystem', 'Titanium', 310000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 6 – Atlas V (total 334,500 kg)

(6, 'Body Tube', 'Structural', 'Aluminum', 100000, 1, NULL, NULL, NULL, NULL, 1),
(6, 'Fins', 'Structural', 'Aluminum', 800, 1, NULL, NULL, NULL, NULL, 4),
(6, 'Main Engine', 'Propulsion', 'Steel', 120000, 1, NULL, NULL, 4000, NULL, 1),
(6, 'Thrusters', 'Propulsion', 'Titanium', 150, 2, NULL, NULL, 300, NULL, 4),
(6, 'Flight Computer', 'Guidance', 'Silicon', 120, 1, 5, NULL, NULL, 'Inertial', 1),
(6, 'Communication System', 'Avionics', 'Copper/Plastic', 80, 1, 3, NULL, NULL, 'Radio', 1),
(6, 'Thermal Tiles', 'Thermal', 'Ceramic', 120, 2, NULL, 1500, NULL, NULL, 50),
(6, 'Solar Panels', 'Power', 'Silicon', 300, 2, 10, NULL, NULL, NULL, 2),
(6, 'Satellite Payload', 'Payload', 'Composite', 5000, 2, NULL, NULL, NULL, 'Camera', 1),
(6, 'Parachute', 'Recovery', 'Nylon', 1000, 2, NULL, NULL, NULL, NULL, 1),
(6, 'Battery Pack', 'Power', 'Lithium', 100, 1, 15, NULL, NULL, NULL, 2),
(6, 'Fuel Tank', 'FuelSystem', 'Titanium', 110000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 7 – Delta IV (total 733,000 kg)
(7, 'Body Tube', 'Structural', 'Aluminum', 180000, 1, NULL, NULL, NULL, NULL, 1),
(7, 'Fins', 'Structural', 'Aluminum', 1200, 1, NULL, NULL, NULL, NULL, 4),
(7, 'Main Engine', 'Propulsion', 'Steel', 300000, 1, NULL, NULL, 6000, NULL, 1),
(7, 'Thrusters', 'Propulsion', 'Titanium', 250, 2, NULL, NULL, 400, NULL, 4),
(7, 'Flight Computer', 'Guidance', 'Silicon', 180, 1, 5, NULL, NULL, 'Inertial', 1),
(7, 'Communication System', 'Avionics', 'Copper/Plastic', 100, 1, 3, NULL, NULL, 'Radio', 1),
(7, 'Thermal Tiles', 'Thermal', 'Ceramic', 250, 2, NULL, 2000, NULL, NULL, 50),
(7, 'Solar Panels', 'Power', 'Silicon', 500, 2, 10, NULL, NULL, NULL, 2),
(7, 'Satellite Payload', 'Payload', 'Composite', 15000, 2, NULL, NULL, NULL, 'Camera', 1),
(7, 'Parachute', 'Recovery', 'Nylon', 2000, 2, NULL, NULL, NULL, NULL, 1),
(7, 'Battery Pack', 'Power', 'Lithium', 250, 1, 15, NULL, NULL, NULL, 2),
(7, 'Fuel Tank', 'FuelSystem', 'Titanium', 233565, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 8 – Long March 5 (total 867,000 kg)
(8, 'Body Tube', 'Structural', 'Aluminum', 220000, 1, NULL, NULL, NULL, NULL, 1),
(8, 'Fins', 'Structural', 'Aluminum', 1500, 1, NULL, NULL, NULL, NULL, 4),
(8, 'Main Engine', 'Propulsion', 'Steel', 350000, 1, NULL, NULL, 7200, NULL, 1),
(8, 'Thrusters', 'Propulsion', 'Titanium', 300, 2, NULL, NULL, 450, NULL, 4),
(8, 'Flight Computer', 'Guidance', 'Silicon', 200, 1, 5, NULL, NULL, 'Inertial', 1),
(8, 'Communication System', 'Avionics', 'Copper/Plastic', 100, 1, 3, NULL, NULL, 'Radio', 1),
(8, 'Thermal Tiles', 'Thermal', 'Ceramic', 300, 2, NULL, 2200, NULL, NULL, 50),
(8, 'Solar Panels', 'Power', 'Silicon', 600, 2, 10, NULL, NULL, NULL, 2),
(8, 'Satellite Payload', 'Payload', 'Composite', 20000, 2, NULL, NULL, NULL, 'Camera', 1),
(8, 'Parachute', 'Recovery', 'Nylon', 2500, 2, NULL, NULL, NULL, NULL, 1),
(8, 'Battery Pack', 'Power', 'Lithium', 300, 1, 15, NULL, NULL, NULL, 2),
(8, 'Fuel Tank', 'FuelSystem', 'Titanium', 293500, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 9 – Soyuz (total 308,000 kg)
(9, 'Body Tube', 'Structural', 'Aluminum', 90000, 1, NULL, NULL, NULL, NULL, 1),
(9, 'Fins', 'Structural', 'Aluminum', 800, 1, NULL, NULL, NULL, NULL, 4),
(9, 'Main Engine', 'Propulsion', 'Steel', 120000, 1, NULL, NULL, 3500, NULL, 1),
(9, 'Thrusters', 'Propulsion', 'Titanium', 100, 2, NULL, NULL, 200, NULL, 4),
(9, 'Flight Computer', 'Guidance', 'Silicon', 100, 1, 5, NULL, NULL, 'Inertial', 1),
(9, 'Communication System', 'Avionics', 'Copper/Plastic', 50, 1, 3, NULL, NULL, 'Radio', 1),
(9, 'Thermal Tiles', 'Thermal', 'Ceramic', 100, 2, NULL, 1000, NULL, NULL, 50),
(9, 'Solar Panels', 'Power', 'Silicon', 200, 2, 5, NULL, NULL, NULL, 2),
(9, 'Satellite Payload', 'Payload', 'Composite', 5000, 2, NULL, NULL, NULL, 'Camera', 1),
(9, 'Parachute', 'Recovery', 'Nylon', 500, 2, NULL, NULL, NULL, NULL, 1),
(9, 'Battery Pack', 'Power', 'Lithium', 50, 1, 10, NULL, NULL, NULL, 2),
(9, 'Fuel Tank', 'FuelSystem', 'Titanium', 81000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 10 – New Shepard (total 75,000 kg)
(10, 'Body Tube', 'Structural', 'Aluminum', 20000, 1, NULL, NULL, NULL, NULL, 1),
(10, 'Fins', 'Structural', 'Aluminum', 400, 1, NULL, NULL, NULL, NULL, 4),
(10, 'Main Engine', 'Propulsion', 'Steel', 25000, 1, NULL, NULL, 1500, NULL, 1),
(10, 'Thrusters', 'Propulsion', 'Titanium', 50, 2, NULL, NULL, 100, NULL, 4),
(10, 'Flight Computer', 'Guidance', 'Silicon', 50, 1, 1, NULL, NULL, 'Inertial', 1),
(10, 'Communication System', 'Avionics', 'Copper/Plastic', 20, 1, 0.5, NULL, NULL, 'Radio', 1),
(10, 'Thermal Tiles', 'Thermal', 'Ceramic', 20, 2, NULL, 200, NULL, NULL, 10),
(10, 'Solar Panels', 'Power', 'Silicon', 50, 2, 2, NULL, NULL, NULL, 2),
(10, 'Satellite Payload', 'Payload', 'Composite', 500, 2, NULL, NULL, NULL, 'Camera', 1),
(10, 'Parachute', 'Recovery', 'Nylon', 100, 2, NULL, NULL, NULL, NULL, 1),
(10, 'Battery Pack', 'Power', 'Lithium', 30, 1, 1, NULL, NULL, NULL, 2),
(10, 'Fuel Tank', 'FuelSystem', 'Titanium', 25000, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 11 – Starship (total 1,200,000 kg)
(11, 'Body Tube', 'Structural', 'Steel', 400000, 1, NULL, NULL, NULL, NULL, 1),
(11, 'Fins', 'Structural', 'Steel', 2000, 1, NULL, NULL, NULL, NULL, 4),
(11, 'Main Engine', 'Propulsion', 'Steel', 450000, 1, NULL, NULL, 16000, NULL, 1),
(11, 'Thrusters', 'Propulsion', 'Titanium', 500, 2, NULL, NULL, 600, NULL, 4),
(11, 'Flight Computer', 'Guidance', 'Silicon', 300, 1, 15, NULL, NULL, 'Inertial', 1),
(11, 'Communication System', 'Avionics', 'Copper/Plastic', 200, 1, 5, NULL, NULL, 'Radio', 1),
(11, 'Thermal Tiles', 'Thermal', 'Ceramic', 500, 2, NULL, 2500, NULL, NULL, 100),
(11, 'Solar Panels', 'Power', 'Silicon', 1000, 2, 50, NULL, NULL, NULL, 4),
(11, 'Satellite Payload', 'Payload', 'Composite', 30000, 2, NULL, NULL, NULL, 'Camera', 1),
(11, 'Parachute', 'Recovery', 'Nylon', 3000, 2, NULL, NULL, NULL, NULL, 1),
(11, 'Battery Pack', 'Power', 'Lithium', 500, 1, 50, NULL, NULL, NULL, 4),
(11, 'Fuel Tank', 'FuelSystem', 'Titanium', 290200, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 12 – Dream Chaser (total 9,500 kg)
(12, 'Body Tube', 'Structural', 'Aluminum', 3000, 1, NULL, NULL, NULL, NULL, 1),
(12, 'Fins', 'Structural', 'Aluminum', 100, 1, NULL, NULL, NULL, NULL, 4),
(12, 'Main Engine', 'Propulsion', 'Steel', 3000, 1, NULL, NULL, 1200, NULL, 1),
(12, 'Thrusters', 'Propulsion', 'Titanium', 50, 2, NULL, NULL, 50, NULL, 4),
(12, 'Flight Computer', 'Guidance', 'Silicon', 50, 1, 2, NULL, NULL, 'Inertial', 1),
(12, 'Communication System', 'Avionics', 'Copper/Plastic', 20, 1, 1, NULL, NULL, 'Radio', 1),
(12, 'Thermal Tiles', 'Thermal', 'Ceramic', 50, 2, NULL, 1200, NULL, NULL, 10),
(12, 'Solar Panels', 'Power', 'Silicon', 50, 2, 2, NULL, NULL, NULL, 2),
(12, 'Satellite Payload', 'Payload', 'Composite', 200, 2, NULL, NULL, NULL, 'Camera', 1),
(12, 'Parachute', 'Recovery', 'Nylon', 50, 2, NULL, NULL, NULL, NULL, 1),
(12, 'Battery Pack', 'Power', 'Lithium', 30, 1, 1, NULL, NULL, NULL, 2),
(12, 'Fuel Tank', 'FuelSystem', 'Titanium', 2900, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 13 – Test Rocket 1 (total 20,000 kg)
(13, 'Body Tube', 'Structural', 'Aluminum', 8000, 1, NULL, NULL, NULL, NULL, 1),
(13, 'Fins', 'Structural', 'Aluminum', 100, 1, NULL, NULL, NULL, NULL, 4),
(13, 'Main Engine', 'Propulsion', 'Steel', 9000, 1, NULL, NULL, 500, NULL, 1),
(13, 'Thrusters', 'Propulsion', 'Titanium', 50, 2, NULL, NULL, 50, NULL, 4),
(13, 'Flight Computer', 'Guidance', 'Silicon', 50, 1, 1, NULL, NULL, 'Inertial', 1),
(13, 'Communication System', 'Avionics', 'Copper/Plastic', 20, 1, 1, NULL, NULL, 'Radio', 1),
(13, 'Thermal Tiles', 'Thermal', 'Ceramic', 50, 2, NULL, 800, NULL, NULL, 10),
(13, 'Solar Panels', 'Power', 'Silicon', 50, 2, 1, NULL, NULL, NULL, 2),
(13, 'Satellite Payload', 'Payload', 'Composite', 200, 2, NULL, NULL, NULL, 'Camera', 1),
(13, 'Parachute', 'Recovery', 'Nylon', 50, 2, NULL, NULL, NULL, NULL, 1),
(13, 'Battery Pack', 'Power', 'Lithium', 30, 1, 1, NULL, NULL, NULL, 2),
(13, 'Fuel Tank', 'FuelSystem', 'Titanium', 2500, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 14 – Test Rocket 2 (total 25,000 kg)
(14, 'Body Tube', 'Structural', 'Aluminum', 10000, 1, NULL, NULL, NULL, NULL, 1),
(14, 'Fins', 'Structural', 'Aluminum', 120, 1, NULL, NULL, NULL, NULL, 4),
(14, 'Main Engine', 'Propulsion', 'Steel', 11000, 1, NULL, NULL, 600, NULL, 1),
(14, 'Thrusters', 'Propulsion', 'Titanium', 70, 2, NULL, NULL, 60, NULL, 4),
(14, 'Flight Computer', 'Guidance', 'Silicon', 60, 1, 2, NULL, NULL, 'Inertial', 1),
(14, 'Communication System', 'Avionics', 'Copper/Plastic', 30, 1, 1, NULL, NULL, 'Radio', 1),
(14, 'Thermal Tiles', 'Thermal', 'Ceramic', 80, 2, NULL, 900, NULL, NULL, 10),
(14, 'Solar Panels', 'Power', 'Silicon', 60, 2, 2, NULL, NULL, NULL, 2),
(14, 'Satellite Payload', 'Payload', 'Composite', 300, 2, NULL, NULL, NULL, 'Camera', 1),
(14, 'Parachute', 'Recovery', 'Nylon', 60, 2, NULL, NULL, NULL, NULL, 1),
(14, 'Battery Pack', 'Power', 'Lithium', 40, 1, 1, NULL, NULL, NULL, 2),
(14, 'Fuel Tank', 'FuelSystem', 'Titanium', 12500, 1, NULL, NULL, NULL, NULL, 2),

-- Racheta 15 – Test Rocket 3 (total 35,000 kg)
(15, 'Body Tube', 'Structural', 'Aluminum', 14000, 1, NULL, NULL, NULL, NULL, 1),
(15, 'Fins', 'Structural', 'Aluminum', 150, 1, NULL, NULL, NULL, NULL, 4),
(15, 'Main Engine', 'Propulsion', 'Steel', 17000, 1, NULL, NULL, 700, NULL, 1),
(15, 'Thrusters', 'Propulsion', 'Titanium', 100, 2, NULL, NULL, 80, NULL, 4),
(15, 'Flight Computer', 'Guidance', 'Silicon', 80, 1, 2, NULL, NULL, 'Inertial', 1),
(15, 'Communication System', 'Avionics', 'Copper/Plastic', 50, 1, 2, NULL, NULL, 'Radio', 1),
(15, 'Thermal Tiles', 'Thermal', 'Ceramic', 100, 2, NULL, 1000, NULL, NULL, 10),
(15, 'Solar Panels', 'Power', 'Silicon', 100, 2, 3, NULL, NULL, NULL, 2),
(15, 'Satellite Payload', 'Payload', 'Composite', 500, 2, NULL, NULL, NULL, 'Camera', 1),
(15, 'Parachute', 'Recovery', 'Nylon', 100, 2, NULL, NULL, NULL, NULL, 1),
(15, 'Battery Pack', 'Power', 'Lithium', 50, 1, 3, NULL, NULL, NULL, 2),
(15, 'Fuel Tank', 'FuelSystem', 'Titanium', 15000, 1, NULL, NULL, NULL, NULL, 2);

INSERT INTO Astronauts (rocket_id, first_name, last_name, age, gender, nationality, profession, mission_role) VALUES
(1, 'Maria', 'Ciobanu', 38, 'F', 'Moldova', 'Medic specialist', 'Flight Engineer'),
(1, 'Andrei', 'Rusu', 35, 'M', 'România', 'Pilot militar', 'Pilot'),
(1, 'Yuki', 'Tanaka', 38, 'F', 'Japonia', 'Inginer robotică JAXA', 'Flight Engineer'),
(9, 'Vasile', 'Lungu', 41, 'M', 'Moldova', 'Pilot cosmonaut', 'Commander'),
(9, 'Irina', 'Marin', 34, 'F', 'România', 'Chimist', 'Mission Specialist'),
(9, 'Petru', 'Stoica', 36, 'M', 'România', 'Medic', 'Flight Engineer'),
(9, 'Sophie', 'Dubois', 36, 'F', 'Franța', 'Astrofizician ESA', 'Mission Specialist');

