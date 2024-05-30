-- ####################################################
-- ######### INSERCIONES A LA BASE DE DATOS ###########
-- ####################################################
-- Basado en el archivo DbGarden.pdf

-- Estas inserciones se realizaron a base de cumplir las necesidades de las consultas
-- Se realizara por numero de consulta mientras sea necesario

-- 1.

-- 2. 

-- Insert data into pais
INSERT INTO pais (nombre) VALUES 
('España');

-- Insert data into region
INSERT INTO region (nombre) VALUES 
('Andalucía'),
('Cataluña'),
('Madrid'),
('Valencia');

-- Insert data into ciudad
INSERT INTO ciudad (nombre, codigo_postal) VALUES 
('Sevilla', '41001'),
('Barcelona', '08001'),
('Madrid', '28001'),
('Valencia', '46001');

-- Insert data into oficina
INSERT INTO oficina (nombre) VALUES 
('Oficina Central Sevilla'),
('Oficina Central Barcelona'),
('Oficina Central Madrid'),
('Oficina Central Valencia');

-- Insert data into direccion_oficina
INSERT INTO direccion_oficina (oficina_id, pais_id, region_id, ciudad_id, detalle) VALUES 
(1, 1, 1, 1, 'Calle Falsa 123, Sevilla'),
(2, 1, 2, 2, 'Avenida Real 456, Barcelona'),
(3, 1, 3, 3, 'Plaza Mayor 789, Madrid'),
(4, 1, 4, 4, 'Calle de la Paz 101, Valencia');

-- Insert data into tipo_telefono
INSERT INTO tipo_telefono (tipo) VALUES 
('Fijo'),
('Móvil');

-- Insert data into telefono_oficina
INSERT INTO telefono_oficina (oficina_id, tipo_id, numero) VALUES 
(1, 1, '955123456'),
(2, 1, '933123456'),
(3, 1, '915123456'),
(4, 1, '961123456');

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

-- 8.

-- 9.

-- 10.

-- 11.

-- 12.

-- 13.

-- 14.

-- 15.

-- 16.

-- 17.

-- 18.

-- 19.

-- 20.

-- 21.

-- 22.

-- 23.

-- 24.

-- 25.

-- 26.

-- 27.

-- 28.

-- 29.

-- 30.

-- 31.

-- 32.

-- 33.

-- 34.

-- 35.

-- 36.

-- 37.

-- 38.

-- 39.

-- 40.

-- 41.

-- 42.

-- 43.

-- 44.

-- 45.

-- 46.

-- 47.

-- 48.

-- 49.

-- 50.

-- 51.

-- 52.

-- 53.

-- 54.

-- 55.

-- 56.

-- 57.

-- 58.

-- 59.

-- 60.

-- 61.

-- 62.

-- 63.

-- 64.

-- 65.

-- 66.

-- 67.

-- 68.

-- 69.

-- 70.

-- 71.

-- 72.

-- 73.

-- 74.

-- 75.

-- 76.

-- 77.

-- 78.

-- 79.

-- 80.


