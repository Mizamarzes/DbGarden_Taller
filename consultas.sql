-- ################################################
-- ######### CONSULTAS A LA BASE DE DATOS #########
-- ################################################
-- Basado en el archivo DbGarden.pdf

-- ################ CONSULTAS SOBRE UNA TABLA ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

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
SELECT
	nombre,
	apellido1,
	apellido2,
	email
FROM empleado
WHERE jefe_id = 7;

-- 4.
SELECT
	p.puesto,
	e.nombre,
	e.apellido1,
	e.apellido2,
	e.email
FROM empleado AS e
JOIN puesto AS p ON e.puesto_id = p.id
WHERE jefe_id IS NULL;

-- 5.
SELECT	
	e.nombre,
	e.apellido1,
	e.apellido2,
	p.puesto AS puesto
FROM empleado AS e
JOIN puesto AS p ON e.puesto_id = p.id
WHERE p.puesto != 'Representante de Ventas';

-- 6.
SELECT
	c.nombre AS cliente,
	p.nombre AS pais 
FROM cliente AS c
JOIN direccion_cliente AS dc ON dc.cliente_id = c.id
JOIN pais AS p ON p.id = dc.pais_id
WHERE p.nombre = 'España';

-- 7.
SELECT DISTINCT
	id,
	estado
FROM estado_pedido;

-- 8.
SELECT 
	id AS cliente_id,
	fecha_pago
FROM pago
WHERE YEAR(fecha_pago) = '2008';

SELECT 
	id AS cliente_id,
	fecha_pago
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

SELECT 
	id AS cliente_id,
	fecha_pago
FROM pago
WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

-- 9.
SELECT
	id AS codigo_pedido,
	id AS codigo_cliente,
	fecha_esperada,
	fecha_entrega
FROM pedido
WHERE fecha_entrega>fecha_esperada;

-- 10.
SELECT
	id AS codigo_pedido,
	id AS codigo_cliente,
	fecha_esperada,
	fecha_entrega
FROM pedido
WHERE ADDDATE(fecha_esperada, INTERVAL -2 DAY) >= fecha_entrega;

SELECT
	id AS codigo_pedido,
	id AS codigo_cliente,
	fecha_esperada,
	fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

SELECT
	id AS codigo_pedido,
	id AS codigo_cliente,
	fecha_esperada,
	fecha_entrega
FROM pedido
WHERE fecha_entrega <= (fecha_esperada - INTERVAL 2 DAY);

-- 11.
SELECT
	p.id,
	p.comentarios AS pedido,
	p.fecha_pedido,
	ep.estado AS estado_pedido
FROM pedido AS p
JOIN estado_pedido AS ep ON p.estado_pedido_id = ep.id
WHERE YEAR(fecha_pedido) = '2009' AND ep.estado = 'Rechazado';

-- 12.
SELECT
	p.id,
	p.comentarios AS pedido,
	p.fecha_entrega,
	ep.estado AS estado_pedido
FROM pedido AS p
JOIN estado_pedido AS ep ON p.estado_pedido_id = ep.id
WHERE DATE_FORMAT(fecha_entrega, '%M') = 'January' AND ep.estado = 'Entregado';

-- 13.
SELECT
	p.id,
	p.fecha_pago,
	fp.forma AS forma_pago
FROM pago AS p
JOIN forma_pago AS fp ON p.forma_pago_id = fp.id
WHERE YEAR(p.fecha_pago) = '2008' AND fp.forma = 'Paypal';

-- 14.
SELECT DISTINCT
	fp.forma AS forma_pago
FROM forma_pago AS fp
JOIN pago AS p ON p.forma_pago_id = fp.id;

-- 15.

-- 16.

-- ################ CONSULTAS MULTITABLA(Composicion Interna) ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

-- 8.

-- 9.

-- 10.

-- 11.

-- ################ CONSULTAS MULTITABLA(Composicion Externa) ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.

-- 2.

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

-- ################ CONSULTAS RESUMEN ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.

-- 2.

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

-- ################ SUBCONSULTAS ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

-- SUBCONSULTAS CON ALL Y ANY ------------------
-- 8.

-- 9.

-- 10.

-- SUBCONSULTAS CON IN Y NOT IN ------------------
-- 11.

-- 12.

-- 13.

-- 14.

-- 15.

-- 16.

-- 17.

-- SUBCONSULTAS CON EXITS Y NOT EXITS ------------------
-- 18.

-- 19.

-- 20.

-- 21.

-- ################ CONSULTAS VARIADAS ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

