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
	e.nombre AS empleado
FROM cliente AS c
RIGHT JOIN empleado AS e ON e.id = c.empleado_id
LEFT JOIN oficina AS o ON o.id = e.oficina_id
WHERE c.empleado_id IS NULL;

-- 6.
SELECT
	e.nombre AS empleado,
	o.nombre AS oficina
FROM cliente AS c
RIGHT JOIN empleado AS e ON e.id = c.empleado_id
LEFT JOIN oficina AS o ON o.id = e.oficina_id
WHERE c.empleado_id IS NULL;

-- 7.
SELECT
	e.nombre AS empleado
FROM cliente AS c
RIGHT JOIN empleado AS e ON e.id = c.empleado_id
LEFT JOIN oficina AS o ON o.id = e.oficina_id
WHERE c.empleado_id IS NULL AND e.oficina_id IS NULL;

-- 8.
SELECT
	p.nombre
FROM producto AS p
LEFT JOIN detalle_pedido AS dp ON dp.producto_id=p.id
WHERE dp.pedido_id IS NULL;

-- 9.
SELECT
	p.nombre,
	p.descripcion,
	gp.imagen
FROM producto AS p
LEFT JOIN detalle_pedido AS dp ON dp.producto_id=p.id
JOIN gama_producto AS gp ON gp.id = p.gama_id
WHERE dp.pedido_id IS NULL;

-- 10.
SELECT 
	o.nombre AS oficina
FROM oficina AS o
LEFT JOIN (
    SELECT DISTINCT e.oficina_id
    FROM empleado AS e
    JOIN cliente AS c ON e.id = c.empleado_id
    JOIN pedido AS p ON c.id = p.cliente_id
    JOIN detalle_pedido AS dp ON p.id = dp.pedido_id
    JOIN producto AS pro ON dp.producto_id = pro.id
    JOIN gama_producto AS gp ON pro.gama_id = gp.id
    WHERE gp.descripcion_texto = 'Frutales'
) AS subquery ON o.id = subquery.oficina_id
WHERE subquery.oficina_id IS NULL;

-- 11.
SELECT 
	c.nombre
FROM cliente AS c
RIGHT JOIN pedido AS p ON p.cliente_id = c.id
LEFT JOIN pago AS pag ON pag.cliente_id = c.id
WHERE pag.cliente_id IS NULL;

-- 12.
SELECT 
	e1.nombre AS empleado,
	e1.apellido1 AS apellido,
	e2.nombre AS jefe
FROM empleado AS e1
LEFT JOIN empleado AS e2 ON e1.jefe_id = e2.id
LEFT JOIN cliente AS c ON c.empleado_id = e1.id
WHERE c.empleado_id IS NULL;

-- ################ CONSULTAS RESUMEN ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.
SELECT 
	COUNT(id) AS Cantidad_empleados
FROM empleado;

-- 2.
SELECT
	p.nombre AS pais,
	COUNT(dc.cliente_id) AS cantidad_clientes
FROM direccion_cliente AS dc
JOIN pais AS p ON p.id = dc.pais_id
GROUP BY p.nombre;

-- 3.
SELECT
	AVG(total) AS Pago_Promedio_Total
FROM pago
WHERE YEAR(fecha_pago) = '2009';

-- 4.
SELECT
	ep.estado AS estado,
	COUNT(p.estado_pedido_id) AS cantidad_pedidos	
FROM pedido AS p
JOIN estado_pedido AS ep ON ep.id = p.estado_pedido_id
GROUP BY estado
ORDER BY cantidad_pedidos DESC;

-- 5.
SELECT
	MAX(precio_venta) AS MAX,
	MIN(precio_venta) AS MIN	
FROM precio;

-- 6.
SELECT 
	COUNT(id) AS Cantidad_clientes
FROM cliente;

-- 7.
SELECT
	cc.nombre AS Ciudad,
	COUNT(dc.cliente_id) AS cantidad_clientes
FROM direccion_cliente AS dc
JOIN ciudad AS cc ON cc.id = dc.ciudad_id
WHERE cc.nombre = 'Madrid'
GROUP BY cc.nombre;

-- 8.
SELECT
	cc.nombre AS Ciudad,
	COUNT(dc.cliente_id) AS cantidad_clientes
FROM direccion_cliente AS dc
JOIN ciudad AS cc ON cc.id = dc.ciudad_id
WHERE cc.nombre LIKE 'M%'
GROUP BY cc.nombre;

-- 9.
SELECT
	e.nombre AS nombre_empleado,
	e.apellido1 AS apellido_empleado,
	COUNT(c.id) AS cantidad_clientes
FROM cliente AS c
JOIN empleado AS e ON e.id = c.empleado_id
GROUP BY e.id;

-- 10.
SELECT 
	COUNT(id) AS cantidad_sin_representante
FROM cliente
WHERE empleado_id IS NULL;

-- 11.
SELECT
	c.nombre,
	MIN(p.fecha_pago) AS primer_pago,
	MAX(p.fecha_pago) AS ultimo_pago	
FROM pago AS p
JOIN cliente AS c ON c.id = p.cliente_id
GROUP BY c.nombre;

-- 12.
SELECT DISTINCT
	COUNT(producto_id) AS total_productosDiferentes_pedidos
FROM detalle_pedido;

-- 13.
SELECT
	COUNT(producto_id) AS cantidad_total_productos
FROM detalle_pedido;

-- 14.
SELECT
    p.nombre,
    COUNT(dp.pedido_id) AS unidades_vendidas
FROM detalle_pedido AS dp
JOIN producto AS p ON p.id = dp.producto_id
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;

-- 15.
SELECT
    SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
    SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
    SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
FROM detalle_pedido AS dp
JOIN precio AS pe ON dp.producto_id = pe.producto_id;

-- 16.
SELECT
	dp.producto_id,
    SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
    SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
    SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
FROM detalle_pedido AS dp
left JOIN precio AS pe ON dp.producto_id = pe.producto_id
GROUP BY dp.producto_id;

-- 17.
SELECT
	dp.producto_id,
    SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
    SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
    SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
FROM detalle_pedido AS dp
LEFT JOIN precio AS pe ON dp.producto_id = pe.producto_id
WHERE dp.producto_id LIKE 'OR%'
GROUP BY dp.producto_id;

-- 18.
SELECT
    p.nombre,
    COUNT(dp.pedido_id) AS unidades_vendidas,
    SUM(dp.cantidad * pe.precio_venta) AS total_facturado,
    SUM(dp.cantidad * pe.precio_venta) * 0.21 AS total_facturado_IVA
FROM detalle_pedido AS dp
LEFT JOIN precio AS pe ON dp.producto_id = pe.producto_id
JOIN producto AS p ON p.id = dp.producto_id
GROUP BY dp.producto_id
HAVING total_facturado > 3000;

-- 19.
SELECT
    YEAR(fecha_pago) AS Year,
    SUM(total) AS Total_Payments
FROM pago
GROUP BY YEAR(fecha_pago);

-- ################ SUBCONSULTAS ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.
SELECT
	nombre
FROM cliente
WHERE limite_credito = (
	SELECT
		MAX(limite_credito)
	FROM cliente
);

-- 2.
SELECT
	nombre
FROM producto p
JOIN precio AS pre ON pre.producto_id = p.id
WHERE pre.precio_venta = (
	SELECT
		MAX(precio_venta)
	FROM precio
);

-- 3.
SELECT p.nombre
FROM producto AS p
WHERE p.id = (
    SELECT dp.producto_id
    FROM detalle_pedido AS dp
    GROUP BY dp.producto_id
    ORDER BY SUM(dp.cantidad) DESC
    LIMIT 1
);

-- 4.
SELECT
	c.nombre
FROM cliente AS c
WHERE c.limite_credito > (
	SELECT
		COALESCE(SUM(p.total), 0)
	FROM pago AS p
	WHERE p.cliente_id = c.id
);

-- 5.
SELECT
	nombre
FROM producto AS p
WHERE p.cantidad_en_stock = (
	SELECT
		MAX(p.cantidad_en_stock)
	FROM producto AS p
);

-- 6.
SELECT
	nombre
FROM producto AS p
WHERE p.cantidad_en_stock = (
	SELECT
		MIN(p.cantidad_en_stock)
	FROM producto AS p
);

-- 7.
SELECT 
	nombre,
	apellido1
FROM empleado AS e
WHERE e.jefe_id = (
	SELECT 
		e1.id
	FROM empleado AS e1
	WHERE e1.nombre = 'Alberto' AND e1.apellido1 = 'Soria'
);

-- SUBCONSULTAS CON ALL Y ANY ------------------
-- 8.
SELECT 
    nombre
FROM 
    cliente
WHERE 
    limite_credito >= ANY (SELECT limite_credito FROM cliente)
ORDER BY 
    limite_credito DESC
LIMIT 1;

-- 9.
SELECT
	p.nombre
FROM precio AS pre
JOIN producto AS p ON p.id = pre.producto_id
WHERE pre.precio_venta >= ANY(
	SELECT
		pre. precio_venta
	FROM precio AS pre
)
ORDER BY pre.precio_venta DESC
LIMIT 1;

-- 10.
SELECT
	nombre
FROM producto
WHERE cantidad_en_stock <= ALL(
	SELECT 
		cantidad_en_stock
	FROM producto
)
ORDER BY cantidad_en_stock ASC
LIMIT 1; 

-- SUBCONSULTAS CON IN Y NOT IN ------------------
-- 11.
SELECT
	e.nombre,
	e.apellido1,
	p.puesto
FROM empleado AS e
JOIN puesto AS p ON p.id = e.puesto_id
WHERE e.id NOT IN(
	SELECT
		c.empleado_id
	FROM cliente AS c
	WHERE c.empleado_id = e.id
);

-- 12.
SELECT
	c.nombre
FROM cliente AS c
WHERE c.id NOT IN(
	SELECT
		p.cliente_id
	FROM pago AS p
	WHERE c.id = p.cliente_id
);

-- 13.
SELECT
	c.nombre
FROM cliente AS c
WHERE c.id IN(
	SELECT
		p.cliente_id
	FROM pago AS p
	WHERE c.id = p.cliente_id
);

-- 14.
SELECT
	p.nombre
FROM producto AS p
WHERE p.id NOT IN(
	SELECT
		dp.producto_id
	FROM detalle_pedido AS dp
	WHERE p.id = dp.producto_id
);

-- 15.
SELECT
	e.nombre,
	e.apellido1,
	e.apellido2,
	p.puesto
FROM empleado AS e
JOIN puesto AS p ON p.id = e.puesto_id
WHERE e.id NOT IN(
	SELECT
		c.empleado_id
	FROM cliente AS c
	WHERE c.empleado_id = e.id
);

-- 16.
SELECT
    DISTINCT o.nombre AS nombre_oficina
FROM
    oficina AS o
WHERE
    o.id NOT IN (
        SELECT
            e.oficina_id
        FROM
            empleado AS e
        JOIN
            cliente AS c ON e.id = c.empleado_id
        JOIN
            pedido AS p ON c.id = p.cliente_id
        JOIN
            detalle_pedido AS dp ON p.id = dp.pedido_id
        JOIN
            producto AS pro ON dp.producto_id = pro.id
        JOIN
            gama_producto AS gp ON pro.gama_id = gp.id
        WHERE
            gp.descripcion_texto = 'Frutales'
    )
AND
    o.id IN (
        SELECT
            e2.oficina_id
        FROM
            empleado AS e2
        JOIN
            cliente AS c2 ON e2.id = c2.empleado_id
        WHERE
            c2.id IN (
                SELECT
                    cliente_id
                FROM
                    pago
            )
    );

-- 17.
SELECT 
	c.nombre
FROM cliente AS c
WHERE c.id IN(
	SELECT
		cliente_id
	FROM pedido AS p
)
AND
         c.id NOT IN(
	SELECT
		cliente_id
	FROM pago 
);

-- SUBCONSULTAS CON EXITS Y NOT EXITS ------------------
-- 18.
SELECT
	c.nombre
FROM cliente AS c
WHERE NOT EXISTS(
	SELECT
		p.cliente_id
	FROM pago AS p
	WHERE p.cliente_id = c.id
);

-- 19.
SELECT
	c.nombre
FROM cliente AS c
WHERE EXISTS(
	SELECT
		p.cliente_id
	FROM pago AS p
	WHERE p.cliente_id = c.id
);

-- 20.
SELECT
	p.nombre
FROM producto AS p
WHERE NOT EXISTS(
	SELECT
		dp.producto_id
	FROM detalle_pedido AS dp
	WHERE dp.producto_id = p.id
);

-- 21.
SELECT
	p.nombre
FROM producto AS p
WHERE EXISTS(
	SELECT
		dp.producto_id
	FROM detalle_pedido AS dp
	WHERE dp.producto_id = p.id
);

-- ################ CONSULTAS VARIADAS ###############
-- Esta enumeracion de consultas esta basado en DbGarden.pdf

-- 1.
SELECT
	c.nombre AS cliente,
	COALESCE(COUNT(p.cliente_id), 0) AS cantidad_pedidos
FROM cliente AS c
JOIN pedido AS p ON p.cliente_id = c.id
GROUP BY c.id
ORDER BY cantidad_pedidos DESC;

-- 2.
SELECT
	c.nombre AS cliente,
	COALESCE(SUM(p.total), 0) AS total_pago
FROM cliente AS c
JOIN pago AS p ON p.cliente_id = c.id
GROUP BY c.id
ORDER BY total_pago DESC;

-- 3.
SELECT
	c.nombre AS cliente
FROM cliente AS c
JOIN pedido AS p ON p.cliente_id = c.id
WHERE YEAR(fecha_pedido) = '2008'
GROUP BY c.id
ORDER BY c.nombre ASC;

-- 4.
SELECT
	c.nombre AS cliente,
	e.nombre,
	e.apellido1
FROM cliente AS c
JOIN empleado AS e ON e.id = c.empleado_id
WHERE c.id NOT IN(
	SELECT
		p.cliente_id
	FROM pago AS p
	WHERE p.cliente_id = c.id
);

-- 5.
SELECT
    c.nombre AS nombre_cliente,
    CONCAT(e.nombre, ' ', e.apellido1) AS nombre_apellido_representante,
    ci.nombre AS ciudad_oficina
FROM
    cliente AS c
JOIN
    empleado AS e ON c.empleado_id = e.id
JOIN
    oficina AS o ON e.oficina_id = o.id
JOIN
    direccion_oficina AS do ON o.id = do.oficina_id
JOIN
    ciudad AS ci ON do.ciudad_id = ci.id;

-- 6.
SELECT
    e.nombre,
    e.apellido1,
    e.apellido2,
    p.puesto,
    tof.numero
FROM
    empleado AS e
JOIN
    puesto AS p ON e.puesto_id = p.id
JOIN
    oficina AS o ON e.oficina_id = o.id
JOIN
    telefono_oficina AS tof ON o.id = tof.oficina_id
WHERE
    e.id NOT IN (
        SELECT
            empleado_id
        FROM
            cliente
	WHERE empleado_id = e.id
    );

-- 7.
SELECT
	cc.nombre AS ciudad,
	COUNT(e.id) AS cantidad_empleados
FROM ciudad AS cc
JOIN direccion_oficina AS do ON do.ciudad_id = cc.id
JOIN oficina AS o ON o.id = do.oficina_id
JOIN empleado AS e ON e.oficina_id = o.id
GROUP BY cc.nombre;

