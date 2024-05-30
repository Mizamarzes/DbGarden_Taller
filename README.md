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
   +----------------+---------------+
   | codigo_oficina | nombre_ciudad |
   +----------------+---------------+
   |              1 | Sevilla       |
   |              2 | Barcelona     |
   |              3 | Madrid        |
   |              4 | Valencia      |
   +----------------+---------------+
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
  
  ```

  

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
  empresa.

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
  empleados que no sean representantes de ventas.

6. Devuelve un listado con el nombre de los todos los clientes españoles.

7. Devuelve un listado con los distintos estados por los que puede pasar un
  pedido.

8. Devuelve un listado con el código de cliente de aquellos clientes que
  realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
  aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

  

  - Utilizando la función YEAR de MySQL.

  - Utilizando la función DATE_FORMAT de MySQL.

  - Sin utilizar ninguna de las funciones anteriores.

    

9. Devuelve un listado con el código de pedido, código de cliente, fecha
  esperada y fecha de entrega de los pedidos que no han sido entregados a
  tiempo.

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.
    •
    •
    •
    Utilizando la función ADDDATE de MySQL.
    Utilizando la función DATEDIFF de MySQL.
    ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

12. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

13. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

14. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

15. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.
    Consultas multitabla (Composición interna)
    Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
    sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

16. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
   representante de ventas.

17. Muestra el nombre de los clientes que hayan realizado pagos junto con el
   nombre de sus representantes de ventas.

18. Muestra el nombre de los clientes que no hayan realizado pagos junto con
   el nombre de sus representantes de ventas.

19. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
   representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

20. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
   de sus representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

21. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

22. Devuelve el nombre de los clientes y el nombre de sus representantes junto
   con la ciudad de la oficina a la que pertenece el representante.8. Devuelve un listado con el nombre de los empleados junto con el nombre
   de sus jefes.

23. Devuelve un listado que muestre el nombre de cada empleados, el nombre
   de su jefe y el nombre del jefe de sus jefe.

24. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

25. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.
    Consultas multitabla (Composición externa)
    Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
    LEFT JOIN y NATURAL RIGHT JOIN.

26. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pago.

27. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pedido.

28. Devuelve un listado que muestre los clientes que no han realizado ningún
   pago y los que no han realizado ningún pedido.

29. Devuelve un listado que muestre solamente los empleados que no tienen
   una oficina asociada.

30. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado.

31. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado junto con los datos de la oficina donde trabajan.

32. Devuelve un listado que muestre los empleados que no tienen una oficina
   asociada y los que no tienen un cliente asociado.

33. Devuelve un listado de los productos que nunca han aparecido en un
   pedido.9. Devuelve un listado de los productos que nunca han aparecido en un
   pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
   producto.

34. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

35. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

36. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.
    Consultas resumen

37. ¿Cuántos empleados hay en la compañía?

38. ¿Cuántos clientes tiene cada país?

39. ¿Cuál fue el pago medio en 2009?

40. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
   descendente por el número de pedidos.

41. Calcula el precio de venta del producto más caro y más barato en una
   misma consulta.

42. Calcula el número de clientes que tiene la empresa.

43. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

44. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
   por M?

45. Devuelve el nombre de los representantes de ventas y el número de clientes
   al que atiende cada uno.

46. Calcula el número de clientes que no tiene asignado representante de
    ventas.

47. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

48. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

49. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

50. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

51. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

52. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

53. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

54. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.
    Subconsultas
    Con operadores básicos de comparación

55. Devuelve el nombre del cliente con mayor límite de crédito.

56. Devuelve el nombre del producto que tenga el precio de venta más caro.

57. Devuelve el nombre del producto del que se han vendido más unidades.
   (Tenga en cuenta que tendrá que calcular cuál es el número total de
   unidades que se han vendido de cada producto a partir de los datos de la
   tabla detalle_pedido)4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
   realizado. (Sin utilizar INNER JOIN).

58. Devuelve el producto que más unidades tiene en stock.

59. Devuelve el producto que menos unidades tiene en stock.

60. Devuelve el nombre, los apellidos y el email de los empleados que están a
   cargo de Alberto Soria.
   Subconsultas con ALL y ANY

61. Devuelve el nombre del cliente con mayor límite de crédito.

62. Devuelve el nombre del producto que tenga el precio de venta más caro.

63. Devuelve el producto que menos unidades tiene en stock.
    Subconsultas con IN y NOT IN

64. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

65. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

66. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

67. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

68. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

69. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

70. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.
    18.Subconsultas con EXISTS y NOT EXISTS

71. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

72. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

73. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

74. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.
    Subconsultas correlacionadas
    Consultas variadas

75. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
   pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
   han realizado ningún pedido.

76. Devuelve un listado con los nombres de los clientes y el total pagado por
   cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
   realizado ningún pago.

77. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
   ordenados alfabéticamente de menor a mayor.

78. Devuelve el nombre del cliente, el nombre y primer apellido de su
   representante de ventas y el número de teléfono de la oficina del
   representante de ventas, de aquellos clientes que no hayan realizado ningún
   pago.

79. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
   nombre y primer apellido de su representante de ventas y la ciudad donde
   está su oficina.

80. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
   empleados que no sean representante de ventas de ningún cliente.7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
   número de empleados que tiene.