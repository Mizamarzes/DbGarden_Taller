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
SELECT 
     p.id,
     p.nombre,
     gp.descripcion_texto AS gama,
     pe.precio_venta AS precio,
     p.cantidad_en_stock  AS cantidad_en_stock
FROM producto AS p
JOIN gama_producto AS gp ON p.gama_id = gp.id
JOIN precio AS pe ON pe.producto_id = p.id 
WHERE p.cantidad_en_stock > 100 
     AND gp.descripcion_texto = 'Ornamentales'
ORDER BY pe.precio_venta DESC;

-- 16.
SELECT
     c.nombre AS cliente,
     cc.nombre AS ciudad,
     c.empleado_id AS codigo_empleado
FROM ciudad AS cc
JOIN direccion_cliente AS dc ON dc.ciudad_id = cc.id
JOIN cliente AS c ON c.id = dc.id
WHERE cc.nombre = 'Madrid' AND c.empleado_id = 11 OR c.empleado_id = 30;

-- ################ CONSULTAS MULTITABLA(Composicion Interna) ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.
SELECT
	c.nombre AS cliente,
	e.nombre AS representante_ventas,
	e.apellido1 AS apellido
FROM cliente AS c
JOIN empleado AS e ON c.empleado_id = e.id;

-- 2.
SELECT
	c.nombre AS cliente,
	e.nombre AS representante_ventas
FROM pago AS p
JOIN cliente AS c ON p.cliente_id = c.id
JOIN empleado AS e ON e.id = c.empleado_id;

-- 3.
SELECT
    c.nombre AS cliente,
    e.nombre AS representante_ventas
FROM cliente AS c
JOIN empleado AS e ON c.empleado_id = e.id
WHERE c.id NOT IN (
    SELECT DISTINCT p.cliente_id
    FROM pago AS p
);

-- 4.
SELECT DISTINCT
	c.nombre AS cliente,
	e.nombre AS representante_ventas,
	o.nombre AS oficina
FROM cliente AS c
JOIN empleado AS e ON e.id = c.empleado_id
JOIN oficina AS o ON e.oficina_id = o.id
JOIN pago AS p ON p.cliente_id = c.id; 

-- 5.
SELECT
    c.nombre AS cliente,
    e.nombre AS representante_ventas,
    cc.nombre AS ciudad_oficina
FROM cliente AS c
JOIN empleado AS e ON c.empleado_id = e.id
JOIN oficina AS o ON e.oficina_id = o.id
JOIN direccion_oficina AS do ON do.oficina_id = o.id
JOIN ciudad AS cc ON do.ciudad_id = cc.id
WHERE c.id NOT IN (
    SELECT DISTINCT p.cliente_id
    FROM pago AS p
);

-- 6.
SELECT
	o.nombre AS nombre_oficina,
	cc.nombre AS Ciudad
FROM ciudad AS cc
JOIN direccion_oficina AS do ON cc.id = do.ciudad_id
JOIN oficina AS o ON o.id = do.oficina_id
JOIN empleado AS e ON e.oficina_id = o.id
WHERE cc.nombre = 'FuenLabrada';

-- 7.
SELECT
	c.nombre AS cliente,
	e.nombre AS nombre_representante,
	cc.nombre AS ciudad_oficina
FROM cliente AS c
JOIN empleado AS e ON e.id = c.empleado_id
JOIN oficina AS o ON o.id = e.oficina_id
JOIN direccion_oficina AS do ON do.oficina_id = o.id
JOIN ciudad AS cc ON cc.id = do.ciudad_id;

-- 8.
SELECT 
    e1.nombre AS empleado_nombre,
    e2.nombre AS jefe_nombre
FROM 
    empleado e1
LEFT JOIN 
    empleado e2 ON e1.jefe_id = e2.id;

-- 9.
SELECT 
    e1.nombre AS empleado_nombre,
    e2.nombre AS jefe_nombre,
    e3.nombre AS jefe_de_jefe_nombre
FROM 
    empleado e1
LEFT JOIN 
    empleado e2 ON e1.jefe_id = e2.id
LEFT JOIN 
    empleado e3 ON e2.jefe_id = e3.id;

-- 10.
SELECT
	c.nombre,
	p.fecha_esperada,
	p.fecha_entrega
FROM cliente AS c
JOIN pedido AS p ON p.cliente_id = c.id
WHERE p.fecha_esperada < p.fecha_entrega;

-- 11.
SELECT
	c.nombre,
	gp.descripcion_texto
FROM cliente AS c
JOIN pedido AS p ON p.cliente_id = c.id
JOIN detalle_pedido AS dp ON dp.pedido_id = p.id
JOIN producto AS pro ON pro.id = dp.producto_id
JOIN gama_producto AS gp ON gp.id = pro.gama_id;

-- ################ CONSULTAS MULTITABLA(Composicion Externa) ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.
SELECT
	c.nombre
FROM cliente AS c
LEFT JOIN pago AS p ON p.cliente_id = c.id
WHERE p.cliente_id IS NULL;

-- 2.
SELECT
	c.nombre
FROM cliente AS c
LEFT JOIN pedido AS p ON p.cliente_id = c.id
WHERE p.cliente_id IS NULL;

-- 3.
SELECT
	c.nombre
FROM cliente AS c
LEFT JOIN pedido AS pe ON pe.cliente_id = c.id
LEFT JOIN pago AS p ON p.cliente_id = c.id
WHERE p.cliente_id IS NULL AND pe.cliente_id IS NULL;

-- 4.
SELECT
	e.id,
	e.nombre
FROM empleado AS e
LEFT JOIN oficina AS o ON o.id = e.oficina_id
WHERE o.id IS NULL;

-- 5.
SELECT
	c.nombre AS cliente,
	e.nombre AS empleado
FROM cliente AS c
LEFT JOIN empleado AS e ON e.id = c.empleado_id
WHERE c.empleado_id IS NULL;

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

