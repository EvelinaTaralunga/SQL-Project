
USE AstroData;

CREATE TABLE Rockets (
    rocket_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,               
    height_m INT NOT NULL,                    
    stages INT NOT NULL,                     -- Numărul de etaje: fiecare etaj se desprinde pentru eficiență
    propulsion_type VARCHAR(50) NOT NULL,    -- Tip de propulsie: Liquid, Solid
    reusable ENUM('Yes','No') NOT NULL       -- Indică dacă racheta poate fi reutilizată
);


CREATE TABLE Launch_Sites (
    site_id INT PRIMARY KEY AUTO_INCREMENT,  
    site_name VARCHAR(100) NOT NULL,         
    country VARCHAR(50) NOT NULL,            
    latitude DECIMAL(10,6),                  
    longitude DECIMAL(10,6)                  
);

CREATE TABLE Missions (
    mission_id INT PRIMARY KEY AUTO_INCREMENT, 
    rocket_id INT NOT NULL,                     
    mission_name VARCHAR(100) NOT NULL,        
    mission_type ENUM('Satellite Deployment','Planetary Exploration','Observatory','Research') NOT NULL, -- Tip misiune
    launch_date DATE NOT NULL,                  
    duration_minutes INT NOT NULL,              -- Durata colectării datelor în minute
    total_duration_minutes INT NOT NULL,        -- Durata totală cu lansare și întoarcere
    launch_site_id INT NOT NULL,                
    FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id),
    FOREIGN KEY (launch_site_id) REFERENCES Launch_Sites(site_id)
);


CREATE TABLE Payloads (
    payload_id INT PRIMARY KEY AUTO_INCREMENT,
    mission_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    payload_type ENUM('Planet','Star','Moon','Satellite') NOT NULL,
    origin ENUM('Orbit','Planet','Star') NOT NULL,
    mass_kg DECIMAL(10,2) NOT NULL
);
/* Payload Type – ce fel de obiect e
Planet → pentru studiat planetele (camere, senzori).
Star → pentru studiat stelele (telescoape, detectoare de lumină).
Moon → pentru studiat Luna (senzori, camere).
Satellite → sateliți sau echipamente de comunicații și observație.

Origin – de unde vin datele
Orbit → în spațiu, pe orbită în jurul Pământului sau altor corpuri.
Planet → direct de pe o planetă.
Moon → direct de pe Lună.
Star → direct de la stele. 
*/


CREATE TABLE Components (
    component_id INT PRIMARY KEY AUTO_INCREMENT,
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
    CONSTRAINT fk_rocket FOREIGN KEY (rocket_id)
        REFERENCES Rockets(rocket_id)
);


CREATE TABLE Astronauts (
    astronaut_id INT PRIMARY KEY AUTO_INCREMENT,
    rocket_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    gender ENUM('M','F') NOT NULL,
    nationality VARCHAR(50),
    profession VARCHAR(100),
    mission_role VARCHAR(100),
    FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
/*----------------------------------------------------------------------------------------------*/
INSERT INTO Rockets (name, height_m, stages, propulsion_type, reusable) VALUES
('Falcon 9', 70, 2, 'Liquid', 'No'),
('Falcon Heavy', 70, 3, 'Liquid', 'No'),
('Electron', 18, 2, 'Liquid', 'No'),
('Vega', 30, 2, 'Solid', 'No'),
('Ariane 5', 52, 2, 'Liquid', 'No'),
('Atlas V', 58, 2, 'Liquid', 'No'),
('Delta IV', 70, 2, 'Liquid', 'No'),
('Long March 5', 57, 2, 'Liquid', 'No'),
('Soyuz', 46, 2, 'Liquid', 'No'),
('New Shepard', 18, 1, 'Liquid', 'No'),
('Starship', 120, 2, 'Liquid', 'No'),
('Dream Chaser', 12, 1, 'Liquid', 'No'),
('Test Rocket 1', 25, 2, 'Liquid', 'No'),
('Test Rocket 2', 30, 2, 'Solid', 'No'),
('Test Rocket 3', 35, 2, 'Liquid', 'No');



INSERT INTO Launch_Sites (site_name, country, latitude, longitude) VALUES
('Cape Canaveral / Kennedy Space Center', 'USA', 28.392200, -80.607700),
('Vandenberg Space Force Base', 'USA', 34.742000, -120.572400),
('Wallops Flight Facility', 'USA', 37.940000, -75.466000),
('Baikonur Cosmodrome', 'Kazakhstan', 45.920000, 63.342000);

INSERT INTO Missions 
(mission_id, rocket_id, mission_name, mission_type, launch_date, duration_minutes, total_duration_minutes, launch_site_id)
VALUES
(1, 1, 'Mission 1', 'Research', '2024-08-15', 90, 210, 1),
(2, 2, 'Mission 2', 'Satellite Deployment', '2024-09-10', 120, 260, 1),
(3, 3, 'Mission 3', 'Observatory', '2024-09-28', 60, 135, 2),
(4, 4, 'Mission 4', 'Research', '2024-10-18', 90, 210, 1),
(5, 5, 'Mission 5', 'Satellite Deployment', '2024-11-05', 120, 260, 3),
(6, 6, 'Mission 6', 'Observatory', '2024-12-12', 60, 135, 2),
(7, 7, 'Mission 7', 'Research', '2025-01-20', 90, 210, 3),
(8, 8, 'Mission 8', 'Satellite Deployment', '2025-02-08', 120, 260, 2),
(9, 9, 'Mission 9', 'Research', '2025-03-14', 90, 210, 1),
(10, 10, 'Mission 10', 'Observatory', '2025-04-22', 60, 135, 3),
(11, 11, 'Mission 11', 'Research', '2025-06-03', 90, 210, 3),
(12, 12, 'Mission 12', 'Observatory', '2025-07-19', 60, 135, 2);

INSERT INTO Payloads (mission_id, name, payload_type, origin, mass_kg) VALUES
-- Misiunea 1
(1, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(1, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(1, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(1, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(1, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(1, 'Stellar Camera', 'Star', 'Star', 60.00),
(1, 'Magnetic Field Sensor', 'Satellite', 'Orbit', 35.00),
(1, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(1, 'Comms Satellite A', 'Satellite', 'Orbit', 500.00),
(1, 'Comms Satellite B', 'Satellite', 'Orbit', 450.00),
(1, 'Observation Telescope', 'Star', 'Star', 200.00),
(1, 'Lunar Lander', 'Moon', 'Moon', 150.00),

-- Misiunea 2
(2, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(2, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(2, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(2, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(2, 'Stellar Camera', 'Star', 'Star', 60.00),
(2, 'Comms Satellite C', 'Satellite', 'Orbit', 480.00),
(2, 'Comms Satellite D', 'Satellite', 'Orbit', 520.00),
(2, 'Lunar Rover', 'Moon', 'Moon', 120.00),

-- Misiunea 3
(3, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(3, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(3, 'Observation Telescope', 'Star', 'Star', 200.00),
(3, 'Stellar Camera', 'Star', 'Star', 60.00),
(3, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(3, 'Moon Probe', 'Moon', 'Moon', 100.00),

-- Misiunea 4
(4, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(4, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(4, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(4, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(4, 'Stellar Camera', 'Star', 'Star', 60.00),
(4, 'Moon Lander', 'Moon', 'Moon', 140.00),

-- Misiunea 5
(5, 'Comms Satellite E', 'Satellite', 'Orbit', 500.00),
(5, 'Comms Satellite F', 'Satellite', 'Orbit', 450.00),
(5, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(5, 'Observation Telescope', 'Star', 'Star', 200.00),
(5, 'Stellar Camera', 'Star', 'Star', 60.00),

-- Misiunea 6
(6, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(6, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(6, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),
(6, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(6, 'Stellar Camera', 'Star', 'Star', 60.00),
(6, 'Magnetic Field Sensor', 'Satellite', 'Orbit', 35.00),
(6, 'Moon Rover', 'Moon', 'Moon', 130.00),

-- Misiunea 7
(7, 'Comms Satellite G', 'Satellite', 'Orbit', 480.00),
(7, 'Comms Satellite H', 'Satellite', 'Orbit', 520.00),
(7, 'Atmospheric Sensor', 'Planet', 'Planet', 70.00),
(7, 'Radiation Detector', 'Satellite', 'Orbit', 10.00),
(7, 'Observation Telescope', 'Star', 'Star', 200.00),
(7, 'Stellar Camera', 'Star', 'Star', 60.00),
(7, 'Planetary Camera', 'Planet', 'Planet', 80.00),

-- Misiunea 8
(8, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(8, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(8, 'Observation Telescope', 'Star', 'Star', 200.00),
(8, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(8, 'Comms Satellite I', 'Satellite', 'Orbit', 500.00),

-- Misiunea 9
(9, 'Radiation Detector', 'Satellite', 'Orbit', 11.00),
(9, 'Observation Telescope', 'Star', 'Star', 200.00),
(9, 'Stellar Camera', 'Star', 'Star', 60.00),

-- Misiunea 10
(10, 'Observation Telescope', 'Star', 'Star', 200.00),
(10, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(10, 'Microgravity Sensor', 'Satellite', 'Orbit', 3.00),

-- Misiunea 11
(11, 'Thermal Sensor', 'Planet', 'Planet', 11.00),
(11, 'Stellar Camera', 'Star', 'Star', 60.00),
(11, 'Cosmic Spectrometer', 'Satellite', 'Orbit', 120.00),
(11, 'Moon Lander', 'Moon', 'Moon', 150.00),

-- Misiunea 12
(12, 'Planetary Camera', 'Planet', 'Planet', 80.00),
(12, 'Observation Telescope', 'Star', 'Star', 200.00),
(12, 'Comms Satellite J', 'Satellite', 'Orbit', 480.00),
(12, 'Moon Rover', 'Moon', 'Moon', 130.00);


INSERT INTO Components (rocket_id, component_name, component_type, material, weight_kg, stage, power_kw, thermal_resistance_degC, thrust_kn, sensor_type, quantity) VALUES
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
(2, 'Body Tube', 'Structural', 'Aluminum', 400000, 1, NULL, NULL, NULL, NULL, 1),
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
(3, 'Body Tube', 'Structural', 'Aluminum', 3500, 1, NULL, NULL, NULL, NULL, 1),
(3, 'Fins', 'Structural', 'Aluminum', 50, 1, NULL, NULL, NULL, NULL, 4),
(3, 'Main Engine', 'Propulsion', 'Steel', 4000, 1, NULL, 7800, 7800, NULL, 1),
(3, 'Thrusters', 'Propulsion', 'Titanium', 300, 2, NULL, NULL, 420, NULL, 4),
(3, 'Flight Computer', 'Guidance', 'Silicon', 50, 1, 5, NULL, NULL, 'Inertial', 1),
(3, 'Communication System', 'Avionics', 'Copper/Plastic', 30, 1, 3, NULL, NULL, 'Radio', 1),
(3, 'Thermal Tiles', 'Thermal', 'Ceramic', 200, 2, NULL, 2000, NULL, NULL, 50),
(3, 'Solar Panels', 'Power', 'Silicon', 100, 2, 10, NULL, NULL, NULL, 2),
(3, 'Satellite Payload', 'Payload', 'Composite', 2000, 2, NULL, NULL, NULL, 'Camera', 1),
(3, 'Parachute', 'Recovery', 'Nylon', 100, 2, NULL, NULL, NULL, NULL, 1),
(3, 'Battery Pack', 'Power', 'Lithium', 50, 1, 15, NULL, NULL, NULL, 2),
(3, 'Fuel Tank', 'FuelSystem', 'Titanium', 4500, 1, NULL, NULL, NULL, NULL, 2),
(4, 'Body Tube', 'Structural', 'Aluminum', 4000, 1, NULL, NULL, NULL, NULL, 1),
(4, 'Fins', 'Structural', 'Aluminum', 50, 1, NULL, NULL, NULL, NULL, 4),
(4, 'Main Engine', 'Propulsion', 'Steel', 4000, 1, NULL, 5000, NULL, NULL, 1),
(4, 'Thrusters', 'Propulsion', 'Titanium', 150, 2, NULL, NULL, 100, NULL, 4),
(4, 'Payload', 'Payload', 'Composite', 5000, 2, NULL, NULL, NULL, 'Camera', 1),
(5, 'Body Tube', 'Structural', 'Aluminum', 200000, 1, NULL, NULL, NULL, NULL, 1),
(5, 'Main Engine', 'Propulsion', 'Steel', 400000, 1, NULL, 7000, NULL, NULL, 1),
(5, 'Fuel Tank', 'FuelSystem', 'Titanium', 180000, 1, NULL, NULL, NULL, NULL, 1),
(6, 'Body Tube', 'Structural', 'Aluminum', 100000, 1, NULL, NULL, NULL, NULL, 1),
(6, 'Main Engine', 'Propulsion', 'Steel', 200000, 1, NULL, 7000, NULL, NULL, 1),
(6, 'Fuel Tank', 'FuelSystem', 'Titanium', 34500, 1, NULL, NULL, NULL, NULL, 1),
(7, 'Body Tube', 'Structural', 'Aluminum', 250000, 1, NULL, NULL, NULL, NULL, 1),
(7, 'Main Engine', 'Propulsion', 'Steel', 400000, 1, NULL, 7500, NULL, NULL, 1),
(7, 'Fuel Tank', 'FuelSystem', 'Titanium', 83000, 1, NULL, NULL, NULL, NULL, 1),
(8, 'Body Tube', 'Structural', 'Aluminum', 300000, 1, NULL, NULL, NULL, NULL, 1),
(8, 'Main Engine', 'Propulsion', 'Steel', 400000, 1, NULL, 8000, NULL, NULL, 1),
(8, 'Fuel Tank', 'FuelSystem', 'Titanium', 167000, 1, NULL, NULL, NULL, NULL, 1),
(9, 'Body Tube', 'Structural', 'Aluminum', 120000, 1, NULL, NULL, NULL, NULL, 1),
(9, 'Main Engine', 'Propulsion', 'Steel', 150000, 1, NULL, 7000, NULL, NULL, 1),
(9, 'Fuel Tank', 'FuelSystem', 'Titanium', 38000, 1, NULL, NULL, NULL, NULL, 1),
(10, 'Body Tube', 'Structural', 'Aluminum', 25000, 1, NULL, NULL, NULL, NULL, 1),
(10, 'Main Engine', 'Propulsion', 'Steel', 40000, 1, NULL, 5000, NULL, NULL, 1),
(10, 'Fuel Tank', 'FuelSystem', 'Titanium', 10000, 1, NULL, NULL, NULL, NULL, 1),
(11, 'Body Tube', 'Structural', 'Aluminum', 300000, 1, NULL, NULL, NULL, NULL, 1),
(11, 'Main Engine', 'Propulsion', 'Steel', 500000, 1, NULL, 10000, NULL, NULL, 1),
(11, 'Fuel Tank', 'FuelSystem', 'Titanium', 400000, 1, NULL, NULL, NULL, NULL, 1),
(12, 'Body Tube', 'Structural', 'Aluminum', 3500, 1, NULL, NULL, NULL, NULL, 1),
(12, 'Main Engine', 'Propulsion', 'Steel', 5000, 1, NULL, 5000, NULL, NULL, 1),
(12, 'Fuel Tank', 'FuelSystem', 'Titanium', 1000, 1, NULL, NULL, NULL, NULL, 1),
(13, 'Body Tube', 'Structural', 'Aluminum', 10000, 1, NULL, NULL, NULL, NULL, 1),
(13, 'Main Engine', 'Propulsion', 'Steel', 9000, 1, NULL, 4000, NULL, NULL, 1),
(13, 'Fuel Tank', 'FuelSystem', 'Titanium', 1000, 1, NULL, NULL, NULL, NULL, 1),
(14, 'Body Tube', 'Structural', 'Aluminum', 12000, 1, NULL, NULL, NULL, NULL, 1),
(14, 'Main Engine', 'Propulsion', 'Steel', 12000, 1, NULL, 4000, NULL, NULL, 1),
(14, 'Fuel Tank', 'FuelSystem', 'Titanium', 1000, 1, NULL, NULL, NULL, NULL, 1),
(15, 'Body Tube', 'Structural', 'Aluminum', 15000, 1, NULL, NULL, NULL, NULL, 1),
(15, 'Main Engine', 'Propulsion', 'Steel', 19000, 1, NULL, 4000, NULL, NULL, 1),
(15, 'Fuel Tank', 'FuelSystem', 'Titanium', 1000, 1, NULL, NULL, NULL, NULL, 1);


INSERT INTO Astronauts (rocket_id, first_name, last_name, age, gender, nationality, profession, mission_role)
VALUES
(1, 'Ion', 'Popescu', 42, 'M', 'România', 'Inginer aerospațial', 'Commander'),
(1, 'Maria', 'Ciobanu', 38, 'F', 'Moldova', 'Medic specialist', 'Flight Engineer'),
(1, 'Andrei', 'Rusu', 35, 'M', 'România', 'Pilot militar', 'Pilot'),
(1, 'Elena', 'Sârbu', 33, 'F', 'Moldova', 'Astrobiolog', 'Mission Specialist'),
(1, 'Michael', 'Anderson', 40, 'M', 'SUA', 'Astronaut NASA', 'Mission Specialist'),
(1, 'Yuki', 'Tanaka', 38, 'F', 'Japonia', 'Inginer robotică JAXA', 'Flight Engineer'),

-- Soyuz (rocket_id = 9)

(9, 'Vasile', 'Lungu', 41, 'M', 'Moldova', 'Pilot cosmonaut', 'Commander'),
(9, 'Irina', 'Marin', 34, 'F', 'România', 'Chimist', 'Mission Specialist'),
(9, 'Petru', 'Stoica', 36, 'M', 'România', 'Medic', 'Flight Engineer'),
(9, 'Sophie', 'Dubois', 36, 'F', 'Franța', 'Astrofizician ESA', 'Mission Specialist'),
(9, 'Sergey', 'Petrov', 45, 'M', 'Rusia', 'Cosmonaut Roscosmos', 'Flight Engineer');




