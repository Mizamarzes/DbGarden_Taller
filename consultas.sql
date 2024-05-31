-- ################################################
-- ######### CONSULTAS A LA BASE DE DATOS #########
-- ################################################
-- Basado en el archivo DbGarden.pdf

-- 1. 
SELECT
	o.id as codigo_oficina,
	c.nombre as nombre_ciudad
FROM oficina AS o 
INNER JOIN direccion_oficina AS do ON o.id = do.oficina_id
INNER JOIN ciudad AS c ON do.ciudad_id = c.id
ORDER BY o.id;

-- 2.
SELECT 
 c.nombre AS ciudad, 
 t.numero AS telefono
FROM telefono_oficina t
JOIN oficina o ON t.oficina_id = o.id
JOIN direccion_oficina d ON o.id = d.oficina_id
JOIN ciudad c ON d.ciudad_id = c.id
JOIN pais p ON d.pais_id = p.id
WHERE p.nombre = 'España';

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























