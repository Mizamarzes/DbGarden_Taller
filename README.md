# DbGarden - Taller - Juan Diego Contreras Melendez

Los comandos de DDL y DML osea ESTRUCTURA y INSERCIONES se encuentran en el archivo estructura_y_insercion.sql

Las consultas se encuentran en el archivo consultas.sql

## DIAGRAMA ER - gardenDb

![gardendbER](https://github.com/Mizamarzes/DbGarden_Taller/blob/master/gardendbER.png)

## Tablas

```
+---------------------+
| Tables_in_gardendb  |
+---------------------+
| ciudad              |
| cliente             |
| contacto            |
| detalle_pedido      |
| direccion_cliente   |
| direccion_oficina   |
| direccion_proveedor |
| empleado            |
| estado_pedido       |
| forma_pago          |
| gama_producto       |
| oficina             |
| pago                |
| pais                |
| pedido              |
| precio              |
| producto            |
| proveedor           |
| puesto              |
| region              |
| telefono_cliente    |
| telefono_oficina    |
| telefono_proveedor  |
| tipo_pago           |
| tipo_telefono       |
+---------------------+
```

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
  
  +------------+-----------+-----------+---------------------+
  | nombre     | apellido1 | apellido2 | email               |
  +------------+-----------+-----------+---------------------+
  | PocaJontas | Diaz      | Pacheco   | cacatatua@gmail.com |
  +------------+-----------+-----------+---------------------+
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
    
        ```mysql
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
         +-----------------+-------------+---------------------+
        | empleado_nombre | jefe_nombre | jefe_de_jefe_nombre |
        +-----------------+-------------+---------------------+
        | Juan            | NULL        | NULL                |
        | María           | Juan        | NULL                |
        | Carlos          | Juan        | NULL                |
        | Laura           | María       | Juan                |
        | Pedro           | María       | Juan                |
        | Ana             | Carlos      | Juan                |
        | Diego           | Carlos      | Juan                |
        | Sofía           | Laura       | María               |
        | Luis            | Laura       | María               |
        | Elena           | Pedro       | María               |
        | Juan            | Juan        | NULL                |
        | Daniel          | NULL        | NULL                |
        +-----------------+-------------+---------------------+   
        ```
    
     10. Devuelve el nombre de los clientes a los que no se les ha entregado a  tiempo un pedido.  
    
         ```mysql
         SELECT
          c.nombre,
          p.fecha_esperada,
          p.fecha_entrega
         FROM cliente AS c
         JOIN pedido AS p ON p.cliente_id = c.id
         WHERE p.fecha_esperada < p.fecha_entrega;
         +-------------------------------------+----------------+---------------+
         | nombre                              | fecha_esperada | fecha_entrega |
         +-------------------------------------+----------------+---------------+
         | El Carajo Ltda.                     | 2015-04-28     | 2016-04-30    |
         | Floristería Primavera Eterna Ltda.  | 2010-02-01     | 2010-02-03    |
         | Floristería Primavera Eterna Ltda.  | 2010-01-14     | 2010-01-16    |
         | Jardines Verdes Ltda.               | 2008-01-14     | 2008-01-16    |
         +-------------------------------------+----------------+---------------+
         
         ```
    
     11. Devuelve un listado de las diferentes gamas de producto que ha comprado  cada cliente.
    
         ```mysql
         SELECT
          c.nombre,
          gp.descripcion_texto
         FROM cliente AS c
         JOIN pedido AS p ON p.cliente_id = c.id
         JOIN detalle_pedido AS dp ON dp.pedido_id = p.id
         JOIN producto AS pro ON pro.id = dp.producto_id
         JOIN gama_producto AS gp ON gp.id = pro.gama_id;
         +-------------------------------------+--------------------------------------------------------------------+
         | nombre                              | descripcion_texto                                                  |
         +-------------------------------------+--------------------------------------------------------------------+
         | Jardines Verdes Ltda.               | Herramienta manual para jardinería, ideal para trabajos precisos.  |
         | Jardines Verdes Ltda.               | Tijeras de podar con mango ergonómico.                             |
         | Floristería Bella Flor Inc.         | Manguera de jardín de 20 metros, resistente y flexible.            |
         | Plantas y Flores S.A.               | Herramienta manual para jardinería, ideal para trabajos precisos.  |
         | Jardinería Naturaleza Viva Ltda.    | Tijeras de podar con mango ergonómico.                             |
         | Jardinería Naturaleza Viva Ltda.    | Manguera de jardín de 20 metros, resistente y flexible.            |
         | Horticultura Verde y Fresca S.A.    | Herramienta manual para jardinería, ideal para trabajos precisos.  |
         | Horticultura Verde y Fresca S.A.    | Tijeras de podar con mango ergonómico.                             |
         | Verdor Jardines y Flores S.R.L.     | Manguera de jardín de 20 metros, resistente y flexible.            |
         | Floristería Primavera Eterna Ltda.  | Herramienta manual para jardinería, ideal para trabajos precisos.  |
         +-------------------------------------+--------------------------------------------------------------------+
         ```
    
     ## Consultas multitabla (Composición externa)
    
     ### Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURALLEFT JOIN y NATURAL RIGHT JOIN.
    
     1. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 
    
        ```mysql
        SELECT
          c.nombre
        FROM cliente AS c
        LEFT JOIN pago AS p ON p.cliente_id = c.id
        WHERE p.cliente_id IS NULL;
        +---------------------+
        | nombre              |
        +---------------------+
        | Riot Games          |
        | Cliente Fuenlabrada |
        +---------------------+
        ```
    
     2. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pedido.
    
        ```mysql
        SELECT
          c.nombre
        FROM cliente AS c
        LEFT JOIN pedido AS p ON p.cliente_id = c.id
        WHERE p.cliente_id IS NULL;
        +---------------------+
        | nombre              |
        +---------------------+
        | Walmart             |
        | Riot Games          |
        | Cliente Fuenlabrada |
        +---------------------+
        ```
    
     3. Devuelve un listado que muestre los clientes que no han realizado ningún  pago y los que no han realizado ningún pedido.
    
        ```mysql
        SELECT
          c.nombre
        FROM cliente AS c
        LEFT JOIN pedido AS pe ON pe.cliente_id = c.id
        LEFT JOIN pago AS p ON p.cliente_id = c.id
        WHERE p.cliente_id IS NULL AND pe.cliente_id IS NULL;
        +---------------------+
        | nombre              |
        +---------------------+
        | Riot Games          |
        | Cliente Fuenlabrada |
        +---------------------+
        ```
    
     4. Devuelve un listado que muestre solamente los empleados que no tienen  una oficina asociada.
    
        ```mysql
        SELECT
          e.id,
          e.nombre
        FROM empleado AS e
        LEFT JOIN oficina AS o ON o.id = e.oficina_id
        WHERE o.id IS NULL;
        +----+--------+
        | id | nombre |
        +----+--------+
        | 13 | Camilo |
        +----+--------+
        ```
    
     5. Devuelve un listado que muestre solamente los empleados que no tienen un  cliente asociado.
    
        ```mysql
        SELECT
          e.nombre AS empleado
        FROM cliente AS c
        RIGHT JOIN empleado AS e ON e.id = c.empleado_id
        LEFT JOIN oficina AS o ON o.id = e.oficina_id
        WHERE c.empleado_id IS NULL;
        +----------+
        | empleado |
        +----------+
        | Camilo   |
        | Pedro    |
        +----------+
        ```
    
     6. Devuelve un listado que muestre solamente los empleados que no tienen un  cliente asociado junto con los datos de la oficina donde trabajan.
    
        ```mysql
        SELECT
          e.nombre AS empleado,
          o.nombre AS oficina
        FROM cliente AS c
        RIGHT JOIN empleado AS e ON e.id = c.empleado_id
        LEFT JOIN oficina AS o ON o.id = e.oficina_id
        WHERE c.empleado_id IS NULL;
        +----------+---------+
        | empleado | oficina |
        +----------+---------+
        | Camilo   | NULL    |
        | Pedro    | NULL    |
        +----------+---------+
        ```
    
     7. Devuelve un listado que muestre los empleados que no tienen una oficina  asociada y los que no tienen un cliente asociado.  
    
        ```mysql
        SELECT
          e.nombre AS empleado
        FROM cliente AS c
        RIGHT JOIN empleado AS e ON e.id = c.empleado_id
        LEFT JOIN oficina AS o ON o.id = e.oficina_id
        WHERE c.empleado_id IS NULL AND e.oficina_id IS NULL;
        +----------+
        | empleado |
        +----------+
        | Camilo   |
        | Pedro    |
        +----------+
        ```
    
     8. Devuelve un listado de los productos que nunca han aparecido en un  pedido.
    
        ```mysql
        SELECT
          p.nombre
        FROM producto AS p
        LEFT JOIN detalle_pedido AS dp ON dp.producto_id=p.id
        WHERE dp.pedido_id IS NULL;
        +------------------+
        | nombre           |
        +------------------+
        | Cesped Tapizante |
        | Trepadora        |
        | Maraca           |
        | Liana            |
        +------------------+
        ```
    
     9. Devuelve un listado de los productos que nunca han aparecido en un  pedido. El resultado debe mostrar el nombre, la descripción y la imagen del  producto. 
    
        ```mysql
        SELECT
          p.nombre,
          p.descripcion,
          gp.imagen
        FROM producto AS p
        LEFT JOIN detalle_pedido AS dp ON dp.producto_id=p.id
        JOIN gama_producto AS gp ON gp.id = p.gama_id
        WHERE dp.pedido_id IS NULL;
        +------------------+-------------------+---------------------------+
        | nombre           | descripcion       | imagen                    |
        +------------------+-------------------+---------------------------+
        | Cesped Tapizante | Cesped GOD        | herramienta_manual.jpg    |
        | Trepadora        | LA TREPADORA      | tijeras_podar.jpg         |
        | Maraca           | Wakanda           | ornamental_accesorios.jpg |
        | Liana            | League of legends | ornamental_accesorios.jpg |
        +------------------+-------------------+---------------------------+
        
        ```
    
     10. Devuelve las oficinas donde no trabajan ninguno de los empleados que  hayan sido los representantes de ventas de algún cliente que haya realizado  la compra de algún producto de la gama Frutales. 
    
         ```mysql
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
         +---------------------------+
         | oficina                   |
         +---------------------------+
         | Oficina principal         |
         | Sucursal A                |
         | Sucursal B                |
         | Sucursal C                |
         | Sucursal D                |
         | Sucursal E                |
         | Sucursal F                |
         | Sucursal G                |
         | Sucursal H                |
         | Sucursal I                |
         | Oficina Central Sevilla   |
         | Oficina Central Barcelona |
         | Oficina Central Madrid    |
         | Oficina Central Valencia  |
         | Oficina Fuenlabrada       |
         +---------------------------+
         ```
    
     11. Devuelve un listado con los clientes que han realizado algún pedido pero no  han realizado ningún pago.
    
         ```mysql
         SELECT 
          c.nombre
         FROM cliente AS c
         RIGHT JOIN pedido AS p ON p.cliente_id = c.id
         LEFT JOIN pago AS pag ON pag.cliente_id = c.id
         WHERE pag.cliente_id IS NULL;
         +------------+
         | nombre     |
         +------------+
         | La Marimba |
         +------------+
         ```
    
     12. Devuelve un listado con los datos de los empleados que no tienen clientes  asociados y el nombre de su jefe asociado.
    
         ```mysql
         SELECT 
          e1.nombre AS empleado,
          e1.apellido1 AS apellido,
          e2.nombre AS jefe
         FROM empleado AS e1
         LEFT JOIN empleado AS e2 ON e1.jefe_id = e2.id
         LEFT JOIN cliente AS c ON c.empleado_id = e1.id
         WHERE c.empleado_id IS NULL;
         +----------+-----------+------+
         | empleado | apellido  | jefe |
         +----------+-----------+------+
         | Camilo   | Rodriguez | Juan |
         | Pedro    | Pascal    | Juan |
         +----------+-----------+------+
         ```
    
          
    
     ## Consultas resumen
    
     1. ¿Cuántos empleados hay en la compañía?
    
        ```mysql
        SELECT 
        	COUNT(id) AS Cantidad_empleados
        FROM empleado;
        +--------------------+
        | Cantidad_empleados |
        +--------------------+
        |                 14 |
        +--------------------+
        ```
    
     2. ¿Cuántos clientes tiene cada país?
    
        ```mysql
        SELECT
        	p.nombre AS pais,
        	COUNT(dc.cliente_id) AS cantidad_clientes
        FROM direccion_cliente AS dc
        JOIN pais AS p ON p.id = dc.pais_id
        GROUP BY p.nombre;
        +-----------+-------------------+
        | pais      | cantidad_clientes |
        +-----------+-------------------+
        | Argentina |                 1 |
        | Brasil    |                 1 |
        | Chile     |                 1 |
        | Colombia  |                 1 |
        | Ecuador   |                 1 |
        | México    |                 1 |
        | Perú      |                 1 |
        | Uruguay   |                 1 |
        | Venezuela |                 1 |
        | Paraguay  |                 1 |
        | España    |                 4 |
        +-----------+-------------------+
        ```
    
     3. ¿Cuál fue el pago medio en 2009?
    
        ```mysql
        SELECT
        	AVG(total) AS Pago_Promedio_Total
        FROM pago
        WHERE YEAR(fecha_pago) = '2009';
        +---------------------+
        | Pago_Promedio_Total |
        +---------------------+
        |          500.000000 |
        +---------------------+
        ```
    
     4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma  descendente por el número de pedidos.
    
        ```mysql
        SELECT
        	ep.estado AS estado,
        	COUNT(p.estado_pedido_id) AS cantidad_pedidos	
        FROM pedido AS p
        JOIN estado_pedido AS ep ON ep.id = p.estado_pedido_id
        GROUP BY estado
        ORDER BY cantidad_pedidos DESC;
        +------------+------------------+
        | estado     | cantidad_pedidos |
        +------------+------------------+
        | Pendiente  |                7 |
        | Procesando |                5 |
        | Entregado  |                5 |
        | Rechazado  |                1 |
        +------------+------------------+
        ```
    
     5. Calcula el precio de venta del producto más caro y más barato en una  misma consulta.
    
        ```mysql
        SELECT
        	MAX(precio_venta) AS MAX,
        	MIN(precio_venta) AS MIN	
        FROM precio;
        +--------+------+
        | MAX    | MIN  |
        +--------+------+
        | 399.99 | 8.99 |
        +--------+------+
        ```
    
     6. Calcula el número de clientes que tiene la empresa. 
    
        ```mysql
        SELECT 
        	COUNT(id) AS Cantidad_clientes
        FROM cliente;
        +-------------------+
        | Cantidad_clientes |
        +-------------------+
        |                15 |
        +-------------------+
        ```
    
     7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?  
    
        ```mysql
        SELECT
        	cc.nombre AS Ciudad,
        	COUNT(dc.cliente_id) AS cantidad_clientes
        FROM direccion_cliente AS dc
        JOIN ciudad AS cc ON cc.id = dc.ciudad_id
        WHERE cc.nombre = 'Madrid'
        GROUP BY cc.nombre;
        +--------+-------------------+
        | Ciudad | cantidad_clientes |
        +--------+-------------------+
        | Madrid |                 2 |
        +--------+-------------------+
        ```
    
     8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan  por M?
    
        ```mysql
        SELECT
        	cc.nombre AS Ciudad,
        	COUNT(dc.cliente_id) AS cantidad_clientes
        FROM direccion_cliente AS dc
        JOIN ciudad AS cc ON cc.id = dc.ciudad_id
        WHERE cc.nombre LIKE 'M%'
        GROUP BY cc.nombre;
        +------------+-------------------+
        | Ciudad     | cantidad_clientes |
        +------------+-------------------+
        | Montevideo |                 1 |
        | Madrid     |                 2 |
        +------------+-------------------+
        ```
    
     9. Devuelve el nombre de los representantes de ventas y el número de clientes  al que atiende cada uno. 
    
        ```mysql
        SELECT
        	e.nombre AS nombre_empleado,
        	e.apellido1 AS apellido_empleado,
        	COUNT(c.id) AS cantidad_clientes
        FROM cliente AS c
        JOIN empleado AS e ON e.id = c.empleado_id
        GROUP BY e.id;
        +-----------------+-------------------+-------------------+
        | nombre_empleado | apellido_empleado | cantidad_clientes |
        +-----------------+-------------------+-------------------+
        | Juan            | García            |                 1 |
        | María           | López             |                 1 |
        | Carlos          | Martínez          |                 1 |
        | Laura           | Rodríguez         |                 1 |
        | Pedro           | Hernández         |                 1 |
        | Ana             | González          |                 1 |
        | Diego           | Sánchez           |                 1 |
        | Sofía           | Pérez             |                 1 |
        | Luis            | Fernández         |                 1 |
        | Elena           | Vázquez           |                 1 |
        | Juan            | Contreras         |                 3 |
        | Daniel          | Navas             |                 1 |
        +-----------------+-------------------+-------------------+
        ```
    
     10. Calcula el número de clientes que no tiene asignado representante de  ventas. 
    
         ```mysql
         SELECT 
         	COUNT(id) AS cantidad_sin_representante
         FROM cliente
         WHERE empleado_id IS NULL;
         +----------------------------+
         | cantidad_sin_representante |
         +----------------------------+
         |                          1 |
         +----------------------------+
         ```
    
     11. Calcula la fecha del primer y último pago realizado por cada uno de los  clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.  
    
         ```mysql
         SELECT
         	c.nombre,
         	MIN(p.fecha_pago) AS primer_pago,
         	MAX(p.fecha_pago) AS ultimo_pago	
         FROM pago AS p
         JOIN cliente AS c ON c.id = p.cliente_id
         GROUP BY c.nombre;
         +------------------------------------+-------------+-------------+
         | nombre                             | primer_pago | ultimo_pago |
         +------------------------------------+-------------+-------------+
         | Jardines Verdes Ltda.              | 2024-05-01  | 2024-05-01  |
         | Floristería Bella Flor Inc.        | 2024-05-02  | 2024-05-02  |
         | Plantas y Flores S.A.              | 2024-05-03  | 2024-05-03  |
         | Jardinería Naturaleza Viva Ltda.   | 2024-05-04  | 2024-05-04  |
         | Horticultura Verde y Fresca S.A.   | 2020-04-21  | 2024-05-05  |
         | Verdor Jardines y Flores S.R.L.    | 2024-05-06  | 2024-05-06  |
         | Floristería Primavera Eterna Ltda. | 2010-01-11  | 2024-05-07  |
         | Plantas Tropicales y Exóticas S.A. | 2024-05-08  | 2024-05-08  |
         | Jardín del Sol y la Luna Ltda.     | 2024-05-09  | 2024-05-09  |
         | Flores del Paraíso S.A.            | 2024-05-10  | 2024-05-10  |
         | El Carajo Ltda.                    | 2008-01-11  | 2024-10-11  |
         | Walmart                            | 2008-04-25  | 2009-04-01  |
         | Riot Games                         | 2009-05-01  | 2009-05-01  |
         +------------------------------------+-------------+-------------+
         ```
    
     12. Calcula el número de productos diferentes que hay en cada uno de los  pedidos.  
    
         ```mysql
         SELECT DISTINCT
         	COUNT(producto_id) AS total_productosDiferentes_pedidos
         FROM detalle_pedido;
         +-----------------------------------+
         | total_productosDiferentes_pedidos |
         +-----------------------------------+
         |                                12 |
         +-----------------------------------+
         ```
    
     13. Calcula la suma de la cantidad total de todos los productos que aparecen en  cada uno de los pedidos. 
    
         ```mysql
         SELECT
         	COUNT(producto_id) AS cantidad_total_productos
         FROM detalle_pedido;
         +--------------------------+
         | cantidad_total_productos |
         +--------------------------+
         |                       12 |
         +--------------------------+
         ```
    
     14. Devuelve un listado de los 20 productos más vendidos y el número total de  unidades que se han vendido de cada uno. El listado deberá estar ordenado  por el número total de unidades vendidas. 
    
         ```mysql
         
         SELECT
             p.nombre,
             COUNT(dp.pedido_id) AS unidades_vendidas
         FROM detalle_pedido AS dp
         JOIN producto AS p ON p.id = dp.producto_id
         GROUP BY p.nombre
         ORDER BY unidades_vendidas DESC
         LIMIT 20;
         +------------------+-------------------+
         | nombre           | unidades_vendidas |
         +------------------+-------------------+
         | Rosa Roja        |                 1 |
         | Cactus Esmeralda |                 1 |
         | Geranio Blanco   |                 1 |
         | Lirio Amarillo   |                 1 |
         | Orquídea Púrpura |                 1 |
         | Margarita Blanca |                 1 |
         | Tulipán Rojo     |                 1 |
         | Helecho Verde    |                 1 |
         | Camelia Rosada   |                 1 |
         | Bonsái de Pino   |                 1 |
         | Manzana          |                 1 |
         | Naranja          |                 1 |
         +------------------+-------------------+
         ```
    
     15. La facturación que ha tenido la empresa en toda la historia, indicando la  base imponible, el IVA y el total facturado. La base imponible se calcula  sumando el coste del producto por el número de unidades vendidas de la  tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la  suma de los dos campos anteriores.
    
         ```mysql
         SELECT
             SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
             SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
             SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
         FROM detalle_pedido AS dp
         JOIN precio AS pe ON dp.producto_id = pe.producto_id;
         +----------------+---------+-----------------+
         | base_imponible | IVA     | total_facturado |
         +----------------+---------+-----------------+
         |         428.65 | 90.0165 |        518.6665 |
         +----------------+---------+-----------------+
         ```
    
     16. La misma información que en la pregunta anterior, pero agrupada por  código de producto. 
    
         ```mysql
         SELECT
         	dp.producto_id,
             SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
             SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
             SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
         FROM detalle_pedido AS dp
         left JOIN precio AS pe ON dp.producto_id = pe.producto_id
         GROUP BY dp.producto_id;
         +-------------+----------------+---------+-----------------+
         | producto_id | base_imponible | IVA     | total_facturado |
         +-------------+----------------+---------+-----------------+
         |           1 |         102.50 | 21.5250 |        124.0250 |
         |           2 |          36.90 |  7.7490 |         44.6490 |
         |           3 |          51.50 | 10.8150 |         62.3150 |
         |           4 |          61.00 | 12.8100 |         73.8100 |
         |           5 |          10.00 |  2.1000 |         12.1000 |
         |           6 |          13.50 |  2.8350 |         16.3350 |
         |           7 |          46.50 |  9.7650 |         56.2650 |
         |           8 |          37.50 |  7.8750 |         45.3750 |
         |           9 |           9.25 |  1.9425 |         11.1925 |
         |          10 |          60.00 | 12.6000 |         72.6000 |
         |          15 |           NULL |    NULL |            NULL |
         |          16 |           NULL |    NULL |            NULL |
         +-------------+----------------+---------+-----------------+
         ```
    
     17. La misma información que en la pregunta anterior, pero agrupada por  código de producto filtrada por los códigos que empiecen por OR.
    
         ```mysql
         SELECT
         	dp.producto_id,
             SUM(dp.cantidad * pe.precio_proveedor) AS base_imponible,
             SUM(dp.cantidad * pe.precio_proveedor) * 0.21 AS IVA,
             SUM(dp.cantidad * pe.precio_proveedor) * 1.21 AS total_facturado
         FROM detalle_pedido AS dp
         LEFT JOIN precio AS pe ON dp.producto_id = pe.producto_id
         WHERE dp.producto_id LIKE 'OR%'
         GROUP BY dp.producto_id;
         
         Empty set (0.00 sec)
         ```
    
     18. Lista las ventas totales de los productos que hayan facturado más de 3000  euros. Se mostrará el nombre, unidades vendidas, total facturado y total  facturado con impuestos (21% IVA). 
    
         ```mysql
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
         
         Empty set (0.00 sec)
         ```
    
     19. Muestre la suma total de todos los pagos que se realizaron para cada uno  de los años que aparecen en la tabla pagos.
    
         ```mysql
         SELECT
             YEAR(fecha_pago) AS Year,
             SUM(total) AS Total_Payments
         FROM pago
         GROUP BY YEAR(fecha_pago);
         +------+----------------+
         | Year | Total_Payments |
         +------+----------------+
         | 2024 |        5700.00 |
         | 2008 |        3950.00 |
         | 2020 |         850.00 |
         | 2010 |        5900.00 |
         | 2009 |        1000.00 |
         +------+----------------+
         ```
    
         
    
     ## Subconsultas
    
     ### Con operadores básicos de comparación
    
     1. Devuelve el nombre del cliente con mayor límite de crédito.
    
        ```mysql
        SELECT
        	nombre
        FROM cliente
        WHERE limite_credito = (
        	SELECT
        		MAX(limite_credito)
        	FROM cliente
        );
        +------------------------------------+
        | nombre                             |
        +------------------------------------+
        | Floristería Primavera Eterna Ltda. |
        +------------------------------------+
        ```
    
     2. Devuelve el nombre del producto que tenga el precio de venta más caro.
    
        ```mysql
        SELECT
        	nombre
        FROM producto p
        JOIN precio AS pre ON pre.producto_id = p.id
        WHERE pre.precio_venta = (
        	SELECT
        		MAX(precio_venta)
        	FROM precio
        );
        +--------+
        | nombre |
        +--------+
        | Liana  |
        +--------+
        ```
    
        
    
     3. Devuelve el nombre del producto del que se han vendido más unidades.  (Tenga en cuenta que tendrá que calcular cuál es el número total de  unidades que se han vendido de cada producto a partir de los datos de la  tabla detalle_pedido)
    
        ```mysql
        SELECT p.nombre
        FROM producto AS p
        WHERE p.id = (
            SELECT dp.producto_id
            FROM detalle_pedido AS dp
            GROUP BY dp.producto_id
            ORDER BY SUM(dp.cantidad) DESC
            LIMIT 1
        );
        +---------+
        | nombre  |
        +---------+
        | Naranja |
        +---------+
        ```
    
     4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya  realizado. (Sin utilizar INNER JOIN).
    
        ```mysql
        SELECT
        	c.nombre
        FROM cliente AS c
        WHERE c.limite_credito > (
        	SELECT
        		COALESCE(SUM(p.total), 0)
        	FROM pago AS p
        	WHERE p.cliente_id = c.id
        );
        +------------------------------------+
        | nombre                             |
        +------------------------------------+
        | Jardines Verdes Ltda.              |
        | Floristería Bella Flor Inc.        |
        | Plantas y Flores S.A.              |
        | Jardinería Naturaleza Viva Ltda.   |
        | Horticultura Verde y Fresca S.A.   |
        | Verdor Jardines y Flores S.R.L.    |
        | Floristería Primavera Eterna Ltda. |
        | Plantas Tropicales y Exóticas S.A. |
        | Jardín del Sol y la Luna Ltda.     |
        | Flores del Paraíso S.A.            |
        | El Carajo Ltda.                    |
        | Walmart                            |
        | Riot Games                         |
        | Cliente Fuenlabrada                |
        | La Marimba                         |
        +------------------------------------+
        ```
    
     5. Devuelve el producto que más unidades tiene en stock. 
    
        ```mysql
        SELECT
        	nombre
        FROM producto AS p
        WHERE p.cantidad_en_stock = (
        	SELECT
        		MAX(p.cantidad_en_stock)
        	FROM producto AS p
        );
        +--------+
        | nombre |
        +--------+
        | Borojo |
        +--------+
        ```
    
     6. Devuelve el producto que menos unidades tiene en stock.
    
        ```mysql
        SELECT
        	nombre
        FROM producto AS p
        WHERE p.cantidad_en_stock = (
        	SELECT
        		MIN(p.cantidad_en_stock)
        	FROM producto AS p
        );
        +---------------+
        | nombre        |
        +---------------+
        | Helecho Verde |
        +---------------+
        ```
    
     7. Devuelve el nombre, los apellidos y el email de los empleados que están a  cargo de Alberto Soria.
    
        ```mysql
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
        +-----------+-----------+
        | nombre    | apellido1 |
        +-----------+-----------+
        | Guasimodo | Lutaturo  |
        +-----------+-----------+
        ```
    
        
    
     ###   Subconsultas con ALL y ANY
    
     8. Devuelve el nombre del cliente con mayor límite de crédito. 
    
        ```mysql
        SELECT 
            nombre
        FROM 
            cliente
        WHERE 
            limite_credito >= ANY (SELECT limite_credito FROM cliente)
        ORDER BY 
            limite_credito DESC
        LIMIT 1;
        +------------------------------------+
        | nombre                             |
        +------------------------------------+
        | Floristería Primavera Eterna Ltda. |
        +------------------------------------+
        ```
    
     9. Devuelve el nombre del producto que tenga el precio de venta más caro.
    
        ```mysql
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
        +--------+
        | nombre |
        +--------+
        | Liana  |
        +--------+
        ```
    
     10. Devuelve el producto que menos unidades tiene en stock. 
    
         ```mysql
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
         +---------------+
         | nombre        |
         +---------------+
         | Helecho Verde |
         +---------------+
         ```
    
     ### Subconsultas con IN y NOT IN
    
     11. Devuelve el nombre, apellido1 y cargo de los empleados que no  representen a ningún cliente.
    
         ```mysql
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
         +-----------+-----------+-----------------------------+
         | nombre    | apellido1 | puesto                      |
         +-----------+-----------+-----------------------------+
         | Pedro     | Pascal    | Gerente de Ventas           |
         | Alberto   | Soria     | Gerente de Ventas           |
         | Camilo    | Rodriguez | Gerente de Recursos Humanos |
         | Guasimodo | Lutaturo  | Jefe de Logística           |
         +-----------+-----------+-----------------------------+
         ```
    
     12. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 
    
         ```mysql
         
         SELECT
         	c.nombre
         FROM cliente AS c
         WHERE c.id NOT IN(
         	SELECT
         		p.cliente_id
         	FROM pago AS p
         	WHERE c.id = p.cliente_id
         );
         +---------------------+
         | nombre              |
         +---------------------+
         | Cliente Fuenlabrada |
         | La Marimba          |
         +---------------------+
         ```
    
     13. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago. 
    
         ```
         SELECT
         	c.nombre
         FROM cliente AS c
         WHERE c.id IN(
         	SELECT
         		p.cliente_id
         	FROM pago AS p
         	WHERE c.id = p.cliente_id
         );
         +------------------------------------+
         | nombre                             |
         +------------------------------------+
         | Jardines Verdes Ltda.              |
         | Floristería Bella Flor Inc.        |
         | Plantas y Flores S.A.              |
         | Jardinería Naturaleza Viva Ltda.   |
         | Horticultura Verde y Fresca S.A.   |
         | Verdor Jardines y Flores S.R.L.    |
         | Floristería Primavera Eterna Ltda. |
         | Plantas Tropicales y Exóticas S.A. |
         | Jardín del Sol y la Luna Ltda.     |
         | Flores del Paraíso S.A.            |
         | El Carajo Ltda.                    |
         | Walmart                            |
         | Riot Games                         |
         +------------------------------------+
         ```
    
     14. Devuelve un listado de los productos que nunca han aparecido en un  pedido.  
    
         ```mysql
         SELECT
         	p.nombre
         FROM producto AS p
         WHERE p.id NOT IN(
         	SELECT
         		dp.producto_id
         	FROM detalle_pedido AS dp
         	WHERE p.id = dp.producto_id
         );
         +------------------+
         | nombre           |
         +------------------+
         | Cesped Tapizante |
         | Trepadora        |
         | Maraca           |
         | Liana            |
         | Borojo           |
         +------------------+
         ```
    
         
    
     15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente.
    
         ```mysql
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
         +-----------+-----------+-----------+-----------------------------+
         | nombre    | apellido1 | apellido2 | puesto                      |
         +-----------+-----------+-----------+-----------------------------+
         | Pedro     | Pascal    | LOLO      | Gerente de Ventas           |
         | Alberto   | Soria     | Rojas     | Gerente de Ventas           |
         | Camilo    | Rodriguez | Pérez     | Gerente de Recursos Humanos |
         | Guasimodo | Lutaturo  | aaaaaa    | Jefe de Logística           |
         +-----------+-----------+-----------+-----------------------------+
         ```
    
         
    
     16. Devuelve las oficinas donde no trabajan ninguno de los empleados que  hayan sido los representantes de ventas de algún cliente que haya realizado  la compra de algún producto de la gama Frutales. 
    
         ```mysql
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
         +---------------------------+
         | nombre_oficina            |
         +---------------------------+
         | Oficina principal         |
         | Sucursal A                |
         | Sucursal B                |
         | Sucursal C                |
         | Sucursal D                |
         | Sucursal E                |
         | Sucursal F                |
         | Sucursal G                |
         | Sucursal H                |
         | Sucursal I                |
         | Oficina Central Barcelona |
         +---------------------------+
         ```
    
         
    
     17. Devuelve un listado con los clientes que han realizado algún pedido pero no  han realizado ningún pago.
    
         ```mysql
         
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
         +------------+
         | nombre     |
         +------------+
         | La Marimba |
         +------------+
         ```
    
         
    
     ### Subconsultas con EXISTS y NOT EXISTS
    
     18. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago.
    
         ```mysql
         SELECT
         	c.nombre
         FROM cliente AS c
         WHERE NOT EXISTS(
         	SELECT
         		p.cliente_id
         	FROM pago AS p
         	WHERE p.cliente_id = c.id
         );
         +---------------------+
         | nombre              |
         +---------------------+
         | Cliente Fuenlabrada |
         | La Marimba          |
         +---------------------+
         ```
    
     19. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago.
    
         ```mysql
         SELECT
         	c.nombre
         FROM cliente AS c
         WHERE EXISTS(
         	SELECT
         		p.cliente_id
         	FROM pago AS p
         	WHERE p.cliente_id = c.id
         );
         +------------------------------------+
         | nombre                             |
         +------------------------------------+
         | Jardines Verdes Ltda.              |
         | Floristería Bella Flor Inc.        |
         | Plantas y Flores S.A.              |
         | Jardinería Naturaleza Viva Ltda.   |
         | Horticultura Verde y Fresca S.A.   |
         | Verdor Jardines y Flores S.R.L.    |
         | Floristería Primavera Eterna Ltda. |
         | Plantas Tropicales y Exóticas S.A. |
         | Jardín del Sol y la Luna Ltda.     |
         | Flores del Paraíso S.A.            |
         | El Carajo Ltda.                    |
         | Walmart                            |
         | Riot Games                         |
         +------------------------------------+
         ```
    
     20. Devuelve un listado de los productos que nunca han aparecido en un  pedido. 
    
         ```mysql
         SELECT
         	p.nombre
         FROM producto AS p
         WHERE NOT EXISTS(
         	SELECT
         		dp.producto_id
         	FROM detalle_pedido AS dp
         	WHERE dp.producto_id = p.id
         );
         +------------------+
         | nombre           |
         +------------------+
         | Cesped Tapizante |
         | Trepadora        |
         | Maraca           |
         | Liana            |
         | Borojo           |
         +------------------+
         ```
    
     21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
    
         ```mysql
         SELECT
         	p.nombre
         FROM producto AS p
         WHERE EXISTS(
         	SELECT
         		dp.producto_id
         	FROM detalle_pedido AS dp
         	WHERE dp.producto_id = p.id
         );
         +------------------+
         | nombre           |
         +------------------+
         | Rosa Roja        |
         | Cactus Esmeralda |
         | Geranio Blanco   |
         | Lirio Amarillo   |
         | Orquídea Púrpura |
         | Margarita Blanca |
         | Tulipán Rojo     |
         | Helecho Verde    |
         | Camelia Rosada   |
         | Bonsái de Pino   |
         | Manzana          |
         | Naranja          |
         +------------------+
         ```
    
     ### Subconsultas correlacionadas
    
     ## Consultas variadas
    
     1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos  pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no  han realizado ningún pedido.
    
        ```mysql
        SELECT
        	c.nombre AS cliente,
        	COALESCE(COUNT(p.cliente_id), 0) AS cantidad_pedidos
        FROM cliente AS c
        JOIN pedido AS p ON p.cliente_id = c.id
        GROUP BY c.id
        ORDER BY cantidad_pedidos DESC;
        +------------------------------------+------------------+
        | cliente                            | cantidad_pedidos |
        +------------------------------------+------------------+
        | Horticultura Verde y Fresca S.A.   |                3 |
        | Floristería Primavera Eterna Ltda. |                3 |
        | Jardines Verdes Ltda.              |                2 |
        | La Marimba                         |                2 |
        | Floristería Bella Flor Inc.        |                1 |
        | Plantas y Flores S.A.              |                1 |
        | Jardinería Naturaleza Viva Ltda.   |                1 |
        | Verdor Jardines y Flores S.R.L.    |                1 |
        | Plantas Tropicales y Exóticas S.A. |                1 |
        | Jardín del Sol y la Luna Ltda.     |                1 |
        | Flores del Paraíso S.A.            |                1 |
        | El Carajo Ltda.                    |                1 |
        +------------------------------------+------------------+
        ```
    
     2. Devuelve un listado con los nombres de los clientes y el total pagado por  cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han  realizado ningún pago. 
    
        ```mysql
        SELECT
        	c.nombre AS cliente,
        	COALESCE(SUM(p.total), 0) AS total_pago
        FROM cliente AS c
        JOIN pago AS p ON p.cliente_id = c.id
        GROUP BY c.id
        ORDER BY total_pago DESC;
        +------------------------------------+------------+
        | cliente                            | total_pago |
        +------------------------------------+------------+
        | Floristería Primavera Eterna Ltda. |    6600.00 |
        | El Carajo Ltda.                    |    3600.00 |
        | Horticultura Verde y Fresca S.A.   |    1350.00 |
        | Flores del Paraíso S.A.            |    1000.00 |
        | Walmart                            |    1000.00 |
        | Jardín del Sol y la Luna Ltda.     |     900.00 |
        | Plantas Tropicales y Exóticas S.A. |     800.00 |
        | Verdor Jardines y Flores S.R.L.    |     600.00 |
        | Riot Games                         |     500.00 |
        | Jardinería Naturaleza Viva Ltda.   |     400.00 |
        | Plantas y Flores S.A.              |     300.00 |
        | Floristería Bella Flor Inc.        |     200.00 |
        | Jardines Verdes Ltda.              |     150.00 |
        +------------------------------------+------------+
        ```
    
     3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008  ordenados alfabéticamente de menor a mayor. 
    
        ```mysql
        SELECT
        	c.nombre AS cliente
        FROM cliente AS c
        JOIN pedido AS p ON p.cliente_id = c.id
        WHERE YEAR(fecha_pedido) = '2008'
        GROUP BY c.id
        ORDER BY c.nombre ASC;
        +-----------------------+
        | cliente               |
        +-----------------------+
        | Jardines Verdes Ltda. |
        +-----------------------+
        ```
    
     4. Devuelve el nombre del cliente, el nombre y primer apellido de su  representante de ventas y el número de teléfono de la oficina del  representante de ventas, de aquellos clientes que no hayan realizado ningún  pago.
    
        ```mysql
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
        +---------------------+--------+-----------+
        | cliente             | nombre | apellido1 |
        +---------------------+--------+-----------+
        | Cliente Fuenlabrada | Daniel | Navas     |
        +---------------------+--------+-----------+
        ```
    
     5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el  nombre y primer apellido de su representante de ventas y la ciudad donde  está su oficina. 
    
        ```mysql
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
        +------------------------------------+-------------------------------+------------------+
        | nombre_cliente                     | nombre_apellido_representante | ciudad_oficina   |
        +------------------------------------+-------------------------------+------------------+
        | Jardines Verdes Ltda.              | Juan García                   | Buenos Aires     |
        | Floristería Bella Flor Inc.        | María López                   | São Paulo        |
        | Plantas y Flores S.A.              | Carlos Martínez               | Santiago         |
        | Jardinería Naturaleza Viva Ltda.   | Laura Rodríguez               | Bogotá           |
        | Horticultura Verde y Fresca S.A.   | Pedro Hernández               | Quito            |
        | Verdor Jardines y Flores S.R.L.    | Ana González                  | Ciudad de México |
        | Floristería Primavera Eterna Ltda. | Diego Sánchez                 | Lima             |
        | Plantas Tropicales y Exóticas S.A. | Sofía Pérez                   | Montevideo       |
        | Jardín del Sol y la Luna Ltda.     | Luis Fernández                | Caracas          |
        | Flores del Paraíso S.A.            | Elena Vázquez                 | Asunción         |
        | El Carajo Ltda.                    | Juan Contreras                | Barcelona        |
        | Walmart                            | Juan Contreras                | Barcelona        |
        | Riot Games                         | Juan Contreras                | Barcelona        |
        | Cliente Fuenlabrada                | Daniel Navas                  | Fuenlabrada      |
        +------------------------------------+-------------------------------+------------------+
        ```
    
     6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente.
    
        ```mysql
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
        +-----------+-----------+-----------+-------------------+------------+
        | nombre    | apellido1 | apellido2 | puesto            | numero     |
        +-----------+-----------+-----------+-------------------+------------+
        | Alberto   | Soria     | Rojas     | Gerente de Ventas | 3333333333 |
        | Guasimodo | Lutaturo  | aaaaaa    | Jefe de Logística | 3333333333 |
        +-----------+-----------+-----------+-------------------+------------+
        ```
    
     7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el  número de empleados que tiene. 
    
        ```mysql
        SELECT
        	cc.nombre AS ciudad,
        	COUNT(e.id) AS cantidad_empleados
        FROM ciudad AS cc
        JOIN direccion_oficina AS do ON do.ciudad_id = cc.id
        JOIN oficina AS o ON o.id = do.oficina_id
        JOIN empleado AS e ON e.oficina_id = o.id
        GROUP BY cc.nombre;
        +------------------+--------------------+
        | ciudad           | cantidad_empleados |
        +------------------+--------------------+
        | Buenos Aires     |                  1 |
        | São Paulo        |                  1 |
        | Santiago         |                  1 |
        | Bogotá           |                  1 |
        | Quito            |                  3 |
        | Ciudad de México |                  1 |
        | Lima             |                  1 |
        | Montevideo       |                  1 |
        | Caracas          |                  1 |
        | Asunción         |                  1 |
        | Barcelona        |                  1 |
        | Fuenlabrada      |                  1 |
        +------------------+--------------------+
        ```
    
        