# GardenDb - Taller - Juan Diego Contreras

**Consultas sobre una tabla**

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```mysql
   SELECT
    o.id as codigo_oficina,
    c.nombre as nombre_ciudad
   FROM oficina AS o 
   INNER JOIN direccion_oficina AS do ON o.id = do.oficina_id
   INNER JOIN ciudad AS c ON do.ciudad_id = c.id
   ORDER BY o.id;
   +----------------+------------------+
   | codigo_oficina | nombre_ciudad    |
   +----------------+------------------+
   |              1 | Buenos Aires     |
   |              2 | São Paulo        |
   |              3 | Santiago         |
   |              4 | Bogotá           |
   |              5 | Quito            |
   |              6 | Ciudad de México |
   |              7 | Lima             |
   |              8 | Montevideo       |
   |              9 | Caracas          |
   |             10 | Asunción         |
   |             11 | Sevilla          |
   |             12 | Barcelona        |
   |             13 | Madrid           |
   |             14 | Valencia         |
   +----------------+------------------+
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```mysql
   SELECT 
    c.nombre AS ciudad, 
    t.numero AS telefono
   FROM telefono_oficina t
   JOIN oficina o ON t.oficina_id = o.id
   JOIN direccion_oficina d ON o.id = d.oficina_id
   JOIN ciudad c ON d.ciudad_id = c.id
   JOIN pais p ON d.pais_id = p.id
   WHERE p.nombre = 'España';
   +-----------+-----------+
   | ciudad    | telefono  |
   +-----------+-----------+
   | Sevilla   | 955123456 |
   | Barcelona | 933123456 |
   | Madrid    | 915123456 |
   | Valencia  | 961123456 |
   +-----------+-----------+
   ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
    jefe tiene un código de jefe igual a 7.

  ```mysql
  SELECT
     nombre,
     apellido1,
     apellido2,
     email
  FROM empleado
  WHERE jefe_id = 7;
  
  Empty set (0.00 sec)
  ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
     empresa.

     ```mysql
     SELECT
          p.puesto,
          e.nombre,
          e.apellido1,
          e.apellido2,
          e.email
     FROM empleado AS e
     JOIN puesto AS p ON e.puesto_id = p.id
     WHERE jefe_id IS NULL;
     +-----------------+--------+-----------+-----------+------------------+
     | puesto          | nombre | apellido1 | apellido2 | email            |
     +-----------------+--------+-----------+-----------+------------------+
     | Gerente General | Juan   | García    | Pérez     | juan@example.com |
     +-----------------+--------+-----------+-----------+------------------+
     ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
     empleados que no sean representantes de ventas.

     ```mysql
     SELECT    
          e.nombre,
          e.apellido1,
          e.apellido2,
          p.puesto AS puesto
     FROM empleado AS e
     JOIN puesto AS p ON e.puesto_id = p.id
     WHERE p.puesto != 'Representante de Ventas';
     +--------+-----------+-----------+-----------------------------+
     | nombre | apellido1 | apellido2 | puesto                      |
     +--------+-----------+-----------+-----------------------------+
     | Juan   | García    | Pérez     | Gerente General             |
     | María  | López     | Sánchez   | Gerente de Ventas           |
     | Carlos | Martínez  | Gómez     | Gerente de Marketing        |
     | Laura  | Rodríguez | Díaz      | Gerente de Finanzas         |
     | Pedro  | Hernández | Fernández | Gerente de Recursos Humanos |
     | Ana    | González  | Vázquez   | Jefe de Operaciones         |
     | Diego  | Sánchez   | López     | Jefe de Logística           |
     | Sofía  | Pérez     | Martínez  | Jefe de Compras             |
     | Luis   | Fernández | González  | Asistente Administrativo    |
     | Elena  | Vázquez   | Sánchez   | Asistente de Ventas         |
     +--------+-----------+-----------+-----------------------------+
     ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

     ```mysql
     SELECT
          c.nombre AS cliente,
          p.nombre AS pais 
     FROM cliente AS c
     JOIN direccion_cliente AS dc ON dc.cliente_id = c.id
     JOIN pais AS p ON p.id = dc.pais_id
     WHERE p.nombre = 'España';
     +-----------------+--------+
     | cliente         | pais   |
     +-----------------+--------+
     | El Carajo Ltda. | España |
     | Walmart         | España |
     +-----------------+--------+
     ```

7. Devuelve un listado con los distintos estados por los que puede pasar un
     pedido.

     ```mysql
     SELECT DISTINCT
          id,
          estado
     FROM estado_pedido;
     +----+------------------+
     | id | estado           |
     +----+------------------+
     |  1 | Pendiente        |
     |  2 | Procesando       |
     |  3 | Enviado          |
     |  4 | Entregado        |
     |  5 | Cancelado        |
     |  6 | Devuelto         |
     |  7 | En espera        |
     |  8 | Preparando envío |
     |  9 | En tránsito      |
     | 10 | Completado       |
     +----+------------------+
     ```

     

8. Devuelve un listado con el código de cliente de aquellos clientes que
     realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
       aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

  - Utilizando la función YEAR de MySQL.

    ```mysql
    SELECT 
     id AS cliente_id,
     fecha_pago
    FROM pago
    WHERE YEAR(fecha_pago) = '2008';
    +------------+------------+
    | cliente_id | fecha_pago |
    +------------+------------+
    |         12 | 2008-04-25 |
    +------------+------------+
    ```

  - Utilizando la función DATE_FORMAT de MySQL.

    ```mysql
    SELECT 
     id AS cliente_id,
     fecha_pago
    FROM pago
    WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';
    +------------+------------+
    | cliente_id | fecha_pago |
    +------------+------------+
    |         12 | 2008-04-25 |
    +------------+------------+
    ```

  - Sin utilizar ninguna de las funciones anteriores.

    ```mysql
    SELECT 
     id AS cliente_id,
     fecha_pago
    FROM pago
    WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
    +------------+------------+
    | cliente_id | fecha_pago |
    +------------+------------+
    |         12 | 2008-04-25 |
    +------------+------------+
    ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos que no han sido entregados a
    tiempo.

    ```mysql
    SELECT
     id AS codigo_pedido,
     id AS codigo_cliente,
     fecha_esperada,
     fecha_entrega
    FROM pedido
    WHERE fecha_entrega>fecha_esperada;
    +---------------+----------------+----------------+---------------+
    | codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
    +---------------+----------------+----------------+---------------+
    |            11 |             11 | 2015-04-28     | 2016-04-30    |
    +---------------+----------------+----------------+---------------+
    ```

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.

    - Utilizando la función ADDDATE de MySQL.

      ```mysql
      SELECT
          id AS codigo_pedido,
          id AS codigo_cliente,
          fecha_esperada,
          fecha_entrega
      FROM pedido
      WHERE ADDDATE(fecha_esperada, INTERVAL -2 DAY) >= fecha_entrega;
      +---------------+----------------+----------------+---------------+
      | codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
      +---------------+----------------+----------------+---------------+
      |            12 |             12 | 2020-05-28     | 2020-05-25    |
      +---------------+----------------+----------------+---------------+
      ```

    - Utilizando la función DATEDIFF de MySQL.

      ```mysql
      SELECT
          id AS codigo_pedido,
          id AS codigo_cliente,
          fecha_esperada,
          fecha_entrega
      FROM pedido
      WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
      +---------------+----------------+----------------+---------------+
      | codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
      +---------------+----------------+----------------+---------------+
      |            12 |             12 | 2020-05-28     | 2020-05-25    |
      +---------------+----------------+----------------+---------------+
      ```

    - ¿Sería posible resolver esta consulta utilizando el operador de suma + o
      resta -?

      ```mysql
      SELECT
          id AS codigo_pedido,
          id AS codigo_cliente,
          fecha_esperada,
          fecha_entrega
      FROM pedido
      WHERE fecha_entrega <= (fecha_esperada - INTERVAL 2 DAY);
      +---------------+----------------+----------------+---------------+
      | codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
      +---------------+----------------+----------------+---------------+
      |            12 |             12 | 2020-05-28     | 2020-05-25    |
      +---------------+----------------+----------------+---------------+
      ```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

     ```mysql
     SELECT
          p.id,
          p.comentarios AS pedido,
          p.fecha_pedido,
          ep.estado AS estado_pedido
     FROM pedido AS p
     JOIN estado_pedido AS ep ON p.estado_pedido_id = ep.id
     WHERE YEAR(fecha_pedido) = '2009' AND ep.estado = 'Rechazado';
     +----+-----------+--------------+---------------+
     | id | pedido    | fecha_pedido | estado_pedido |
     +----+-----------+--------------+---------------+
     | 14 | Guanabana | 2009-05-01   | Rechazado     |
     +----+-----------+--------------+---------------+
     ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
     mes de enero de cualquier año.

     ```mysql
     SELECT
          p.id,
          p.comentarios AS pedido,
          p.fecha_entrega,
          ep.estado AS estado_pedido
     FROM pedido AS p
     JOIN estado_pedido AS ep ON p.estado_pedido_id = ep.id
     WHERE DATE_FORMAT(fecha_entrega, '%M') = 'January' AND ep.estado = 'Entregado';
     +----+-----------------+---------------+---------------+
     | id | pedido          | fecha_entrega | estado_pedido |
     +----+-----------------+---------------+---------------+
     | 16 | Papa con Flores | 2010-01-16    | Entregado     |
     +----+-----------------+---------------+---------------+
     ```

13. Devuelve un listado con todos los pagos que se realizaron en el
     año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

     ```mysql
     SELECT
          p.id,
          p.fecha_pago,
          fp.forma AS forma_pago
     FROM pago AS p
     JOIN forma_pago AS fp ON p.forma_pago_id = fp.id
     WHERE YEAR(p.fecha_pago) = '2008' AND fp.forma = 'Paypal';
     +----+------------+------------+
     | id | fecha_pago | forma_pago |
     +----+------------+------------+
     | 16 | 2008-01-11 | PayPal     |
     +----+------------+------------+
     ```

14. Devuelve un listado con todas las formas de pago que aparecen en la
     tabla pago. Tenga en cuenta que no deben aparecer formas de pago
     repetidas.

     ```mysql
     SELECT DISTINCT
          fp.forma AS forma_pago
     FROM forma_pago AS fp
     JOIN pago AS p ON p.forma_pago_id = fp.id;
     +------------------------+
     | forma_pago             |
     +------------------------+
     | Efectivo               |
     | Tarjeta de crédito     |
     | Tarjeta de débito      |
     | Transferencia bancaria |
     | Cheque                 |
     | PayPal                 |
     | Bitcoin                |
     | Criptomoneda           |
     | Apple Pay              |
     | Google Pay             |
     +------------------------+
     ```

15. Devuelve un listado con todos los productos que pertenecen a la
     gama Ornamentales y que tienen más de 100 unidades en stock. El listado
     deberá estar ordenado por su precio de venta, mostrando en primer lugar
     los de mayor precio.

     ```mysql
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
     +----+--------+--------------+--------+-------------------+
     | id | nombre | gama         | precio | cantidad_en_stock |
     +----+--------+--------------+--------+-------------------+
     | 14 | Liana  | Ornamentales | 399.99 |               220 |
     | 13 | Maraca | Ornamentales |  35.99 |               170 |
     +----+--------+--------------+--------+-------------------+
     ```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
     cuyo representante de ventas tenga el código de empleado 11 o 30.

     ```mysql
     SELECT
          c.nombre AS cliente,
          cc.nombre AS ciudad,
          c.empleado_id AS codigo_empleado
     FROM ciudad AS cc
     JOIN direccion_cliente AS dc ON dc.ciudad_id = cc.id
     JOIN cliente AS c ON c.id = dc.id
     WHERE cc.nombre = 'Madrid' AND c.empleado_id = 11 OR c.empleado_id = 30;
     +-----------------+--------+-----------------+
     | cliente         | ciudad | codigo_empleado |
     +-----------------+--------+-----------------+
     | El Carajo Ltda. | Madrid |              11 |
     | Riot Games      | Madrid |              11 |
     +-----------------+--------+-----------------+
     ```

     

     ## Consultas multitabla (Composición interna)

     ### Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

     1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su  representante de ventas.  

        ```mysql
        SELECT
        	c.nombre AS cliente,
        	e.nombre AS representante_ventas,
        	e.apellido1 AS apellido
        FROM cliente AS c
        JOIN empleado AS e ON c.empleado_id = e.id;
        +-------------------------------------+----------------------+------------+
        | cliente                             | representante_ventas | apellido   |
        +-------------------------------------+----------------------+------------+
        | Jardines Verdes Ltda.               | Juan                 | García     |
        | Floristería Bella Flor Inc.         | María                | López      |
        | Plantas y Flores S.A.               | Carlos               | Martínez   |
        | Jardinería Naturaleza Viva Ltda.    | Laura                | Rodríguez  |
        | Horticultura Verde y Fresca S.A.    | Pedro                | Hernández  |
        | Verdor Jardines y Flores S.R.L.     | Ana                  | González   |
        | Floristería Primavera Eterna Ltda.  | Diego                | Sánchez    |
        | Plantas Tropicales y Exóticas S.A.  | Sofía                | Pérez      |
        | Jardín del Sol y la Luna Ltda.      | Luis                 | Fernández  |
        | Flores del Paraíso S.A.             | Elena                | Vázquez    |
        | El Carajo Ltda.                     | Juan                 | Contreras  |
        | Walmart                             | Juan                 | Contreras  |
        | Riot Games                          | Juan                 | Contreras  |
        +-------------------------------------+----------------------+------------+
        ```
    
     2. Muestra el nombre de los clientes que hayan realizado pagos junto con el  nombre de sus representantes de ventas. 
    
        ```mysql
        SELECT
        	c.nombre AS cliente,
        	e.nombre AS representante_ventas
        FROM pago AS p
        JOIN cliente AS c ON p.cliente_id = c.id
        JOIN empleado AS e ON e.id = c.empleado_id;
        +-------------------------------------+----------------------+
        | cliente                             | representante_ventas |
        +-------------------------------------+----------------------+
        | Jardines Verdes Ltda.               | Juan                 |
        | Floristería Bella Flor Inc.         | María                |
        | Plantas y Flores S.A.               | Carlos               |
        | Jardinería Naturaleza Viva Ltda.    | Laura                |
        | Horticultura Verde y Fresca S.A.    | Pedro                |
        | Horticultura Verde y Fresca S.A.    | Pedro                |
        | Verdor Jardines y Flores S.R.L.     | Ana                  |
        | Floristería Primavera Eterna Ltda.  | Diego                |
        | Floristería Primavera Eterna Ltda.  | Diego                |
        | Floristería Primavera Eterna Ltda.  | Diego                |
        | Plantas Tropicales y Exóticas S.A.  | Sofía                |
        | Jardín del Sol y la Luna Ltda.      | Luis                 |
        | Flores del Paraíso S.A.             | Elena                |
        | El Carajo Ltda.                     | Juan                 |
        | El Carajo Ltda.                     | Juan                 |
        | Walmart                             | Juan                 |
        +-------------------------------------+----------------------+
        ```

     3. Muestra el nombre de los clientes que no hayan realizado pagos junto con  el nombre de sus representantes de ventas. 

        ```mysql
        SELECT
            c.nombre AS cliente,
            e.nombre AS representante_ventas
        FROM cliente AS c
        JOIN empleado AS e ON c.empleado_id = e.id
        WHERE c.id NOT IN (
            SELECT DISTINCT p.cliente_id
            FROM pago AS p
        );
        +------------+----------------------+
        | cliente    | representante_ventas |
        +------------+----------------------+
        | Riot Games | Juan                 |
        +------------+----------------------+
        ```
    
     4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus  representantes junto con la ciudad de la oficina a la que pertenece el  representante. 
    
        ```mysql
        SELECT DISTINCT
        	c.nombre AS cliente,
        	e.nombre AS representante_ventas,
        	o.nombre AS oficina
        FROM cliente AS c
        JOIN empleado AS e ON e.id = c.empleado_id
        JOIN oficina AS o ON e.oficina_id = o.id
        JOIN pago AS p ON p.cliente_id = c.id; 
        +-------------------------------------+----------------------+---------------------------+
        | cliente                             | representante_ventas | oficina                   |
        +-------------------------------------+----------------------+---------------------------+
        | Jardines Verdes Ltda.               | Juan                 | Oficina principal         |
        | Floristería Bella Flor Inc.         | María                | Sucursal A                |
        | Plantas y Flores S.A.               | Carlos               | Sucursal B                |
        | Jardinería Naturaleza Viva Ltda.    | Laura                | Sucursal C                |
        | Horticultura Verde y Fresca S.A.    | Pedro                | Sucursal D                |
        | Verdor Jardines y Flores S.R.L.     | Ana                  | Sucursal E                |
        | Floristería Primavera Eterna Ltda.  | Diego                | Sucursal F                |
        | Plantas Tropicales y Exóticas S.A.  | Sofía                | Sucursal G                |
        | Jardín del Sol y la Luna Ltda.      | Luis                 | Sucursal H                |
        | Flores del Paraíso S.A.             | Elena                | Sucursal I                |
        | El Carajo Ltda.                     | Juan                 | Oficina Central Barcelona |
        | Walmart                             | Juan                 | Oficina Central Barcelona |
        +-------------------------------------+----------------------+---------------------------+
        
        ```

     5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre  de sus representantes junto con la ciudad de la oficina a la que pertenece el  representante. 

        ```mysql
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
        +------------+----------------------+----------------+
        | cliente    | representante_ventas | ciudad_oficina |
        +------------+----------------------+----------------+
        | Riot Games | Juan                 | Barcelona      |
        +------------+----------------------+----------------+
        ```
    
     6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.  
    
        ```mysql
        SELECT
        	o.nombre AS nombre_oficina,
        	cc.nombre AS Ciudad
        
        FROM ciudad AS cc
        JOIN direccion_oficina AS do ON cc.id = do.ciudad_id
        JOIN oficina AS o ON o.id = do.oficina_id
        JOIN empleado AS e ON e.oficina_id = o.id
        WHERE cc.nombre = 'FuenLabrada';
        +---------------------+-------------+
        | nombre_oficina      | Ciudad      |
        +---------------------+-------------+
        | Oficina Fuenlabrada | Fuenlabrada |
        +---------------------+-------------+
        ```
    
     7. Devuelve el nombre de los clientes y el nombre de sus representantes junto  con la ciudad de la oficina a la que pertenece el representante. 
    
        ```mysql
        SELECT
        	c.nombre AS cliente,
        	e.nombre AS nombre_representante,
        	cc.nombre AS ciudad_oficina
        FROM cliente AS c
        JOIN empleado AS e ON e.id = c.empleado_id
        JOIN oficina AS o ON o.id = e.oficina_id
        JOIN direccion_oficina AS do ON do.oficina_id = o.id
        JOIN ciudad AS cc ON cc.id = do.ciudad_id;
        +-------------------------------------+----------------------+-------------------+
        | cliente                             | nombre_representante | ciudad_oficina    |
        +-------------------------------------+----------------------+-------------------+
        | Jardines Verdes Ltda.               | Juan                 | Buenos Aires      |
        | Floristería Bella Flor Inc.         | María                | São Paulo         |
        | Plantas y Flores S.A.               | Carlos               | Santiago          |
        | Jardinería Naturaleza Viva Ltda.    | Laura                | Bogotá            |
        | Horticultura Verde y Fresca S.A.    | Pedro                | Quito             |
        | Verdor Jardines y Flores S.R.L.     | Ana                  | Ciudad de México  |
        | Floristería Primavera Eterna Ltda.  | Diego                | Lima              |
        | Plantas Tropicales y Exóticas S.A.  | Sofía                | Montevideo        |
        | Jardín del Sol y la Luna Ltda.      | Luis                 | Caracas           |
        | Flores del Paraíso S.A.             | Elena                | Asunción          |
        | El Carajo Ltda.                     | Juan                 | Barcelona         |
        | Walmart                             | Juan                 | Barcelona         |
        | Riot Games                          | Juan                 | Barcelona         |
        | Cliente Fuenlabrada                 | Daniel               | Fuenlabrada       |
        +-------------------------------------+----------------------+-------------------+
        ```
    
     8. Devuelve un listado con el nombre de los empleados junto con el nombre  de sus jefes.
    
        ```mysql
        SELECT 
            e1.nombre AS empleado_nombre,
            e2.nombre AS jefe_nombre
        FROM 
            empleado e1
        LEFT JOIN 
            empleado e2 ON e1.jefe_id = e2.id;
        +-----------------+-------------+
        | empleado_nombre | jefe_nombre |
        +-----------------+-------------+
        | Juan            | NULL        |
        | María           | Juan        |
        | Carlos          | Juan        |
        | Laura           | María       |
        | Pedro           | María       |
        | Ana             | Carlos      |
        | Diego           | Carlos      |
        | Sofía           | Laura       |
        | Luis            | Laura       |
        | Elena           | Pedro       |
        | Juan            | Juan        |
        | Daniel          | NULL        |
        +-----------------+-------------+
        ```
    
     9. Devuelve un listado que muestre el nombre de cada empleados, el nombre  de su jefe y el nombre del jefe de sus jefe.  
    
        ```
        
        ```
    
     10. Devuelve el nombre de los clientes a los que no se les ha entregado a  tiempo un pedido.  
    
         ```
         
         ```
    
     11. Devuelve un listado de las diferentes gamas de producto que ha comprado  cada cliente.
    
         ```
         
         ```
    
     ## Consultas multitabla (Composición externa)
    
     ### Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURALLEFT JOIN y NATURAL RIGHT JOIN.
    
     1. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 
     2. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pedido.
     3. Devuelve un listado que muestre los clientes que no han realizado ningún  pago y los que no han realizado ningún pedido.
     4. Devuelve un listado que muestre solamente los empleados que no tienen  una oficina asociada.
     5. Devuelve un listado que muestre solamente los empleados que no tienen un  cliente asociado.
     6. Devuelve un listado que muestre solamente los empleados que no tienen un  cliente asociado junto con los datos de la oficina donde trabajan.
     7. Devuelve un listado que muestre los empleados que no tienen una oficina  asociada y los que no tienen un cliente asociado.  
     8. Devuelve un listado de los productos que nunca han aparecido en un  pedido.
     9. Devuelve un listado de los productos que nunca han aparecido en un  pedido. El resultado debe mostrar el nombre, la descripción y la imagen del  producto. 
     10. Devuelve las oficinas donde no trabajan ninguno de los empleados que  hayan sido los representantes de ventas de algún cliente que haya realizado  la compra de algún producto de la gama Frutales. 
     11. Devuelve un listado con los clientes que han realizado algún pedido pero no  han realizado ningún pago.
     12. Devuelve un listado con los datos de los empleados que no tienen clientes  asociados y el nombre de su jefe asociado.
    
     
    
     ## Consultas resumen
    
     1. ¿Cuántos empleados hay en la compañía?
     2. ¿Cuántos clientes tiene cada país?
     3. ¿Cuál fue el pago medio en 2009?
     4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma  descendente por el número de pedidos.
     5. Calcula el precio de venta del producto más caro y más barato en una  misma consulta.
     6. Calcula el número de clientes que tiene la empresa. 
     7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?  
     8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan  por M?
     9. Devuelve el nombre de los representantes de ventas y el número de clientes  al que atiende cada uno. 
     10. Calcula el número de clientes que no tiene asignado representante de  ventas. 
     11. Calcula la fecha del primer y último pago realizado por cada uno de los  clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.  
     12. Calcula el número de productos diferentes que hay en cada uno de los  pedidos.  
     13. Calcula la suma de la cantidad total de todos los productos que aparecen en  cada uno de los pedidos. 
     14. Devuelve un listado de los 20 productos más vendidos y el número total de  unidades que se han vendido de cada uno. El listado deberá estar ordenado  por el número total de unidades vendidas. 
     15. La facturación que ha tenido la empresa en toda la historia, indicando la  base imponible, el IVA y el total facturado. La base imponible se calcula  sumando el coste del producto por el número de unidades vendidas de la  tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la  suma de los dos campos anteriores.
     16. La misma información que en la pregunta anterior, pero agrupada por  código de producto. 
     17. La misma información que en la pregunta anterior, pero agrupada por  código de producto filtrada por los códigos que empiecen por OR.
     18. Lista las ventas totales de los productos que hayan facturado más de 3000  euros. Se mostrará el nombre, unidades vendidas, total facturado y total  facturado con impuestos (21% IVA). 
     19. Muestre la suma total de todos los pagos que se realizaron para cada uno  de los años que aparecen en la tabla pagos.
    
     
    
     ## Subconsultas
    
     ### Con operadores básicos de comparación
    
     1. Devuelve el nombre del cliente con mayor límite de crédito.
     2. Devuelve el nombre del producto que tenga el precio de venta más caro.
     3. Devuelve el nombre del producto del que se han vendido más unidades.  (Tenga en cuenta que tendrá que calcular cuál es el número total de  unidades que se han vendido de cada producto a partir de los datos de la  tabla detalle_pedido)
     4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya  realizado. (Sin utilizar INNER JOIN).
     5. Devuelve el producto que más unidades tiene en stock. 
     6. Devuelve el producto que menos unidades tiene en stock.
     7. Devuelve el nombre, los apellidos y el email de los empleados que están a  cargo de Alberto Soria.
    
     
    
     ###   Subconsultas con ALL y ANY
    
     8. Devuelve el nombre del cliente con mayor límite de crédito. 
    
     9. Devuelve el nombre del producto que tenga el precio de venta más caro.
    
     10. Devuelve el producto que menos unidades tiene en stock. 
    
         
    
     ### Subconsultas con IN y NOT IN
    
     11. Devuelve el nombre, apellido1 y cargo de los empleados que no  representen a ningún cliente. 
     12. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 
     13. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago. 
     14. Devuelve un listado de los productos que nunca han aparecido en un  pedido.  
     15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente.
     16. Devuelve las oficinas donde no trabajan ninguno de los empleados que  hayan sido los representantes de ventas de algún cliente que haya realizado  la compra de algún producto de la gama Frutales. 
     17. Devuelve un listado con los clientes que han realizado algún pedido pero no  han realizado ningún pago.
    
     
    
     ### Subconsultas con EXISTS y NOT EXISTS
    
     18. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 
     19. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago.
     20. Devuelve un listado de los productos que nunca han aparecido en un  pedido. 
     21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
    
     
    
     ### Subconsultas correlacionadas
    
     ## Consultas variadas
    
     1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos  pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no  han realizado ningún pedido. 
     2. Devuelve un listado con los nombres de los clientes y el total pagado por  cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han  realizado ningún pago. 
     3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008  ordenados alfabéticamente de menor a mayor. 
     4. Devuelve el nombre del cliente, el nombre y primer apellido de su  representante de ventas y el número de teléfono de la oficina del  representante de ventas, de aquellos clientes que no hayan realizado ningún  pago.
     5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el  nombre y primer apellido de su representante de ventas y la ciudad donde  está su oficina. 
     6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente.
     7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el  número de empleados que tiene. 