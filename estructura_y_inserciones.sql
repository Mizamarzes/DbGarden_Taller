-- #############################################
-- ######### ESTRUCTURA BASE DE DATOS ##########
-- #############################################
-- Estructura de una base de datos para productos de jardineria
-- Con su servicio de inventario, pedidos, clientes, empleados y demas
-- Basado en el documento DbGarden.pdf

-- Creacion de la base de datos
CREATE DATABASE gardenDb;

-- Seleccion de la base de datos
USE gardenDb;

-- Creacion tabla gama_producto
CREATE TABLE gama_producto (
	id INT(7) AUTO_INCREMENT,
	descripcion_texto TEXT NULL,
	descripcion_html TEXT NULL,
	imagen VARCHAR(256) NULL,
	CONSTRAINT PK_GamaProducto_Id PRIMARY KEY(id)
);

-- Creacion tabla pais
CREATE TABLE pais (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Pais_Id PRIMARY KEY(id)
);

-- Creacion tabla region
CREATE TABLE region (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Region_Id PRIMARY KEY(id)
);

-- Creacion tabla ciudad
CREATE TABLE ciudad (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	codigo_postal VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Ciudad_Id PRIMARY KEY(id)
);

-- Creacion tabla puesto
CREATE TABLE puesto (
	id INT(7) AUTO_INCREMENT,
	puesto VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Puesto_Id PRIMARY KEY(id)
);

-- Creacion tabla estado_pedido
CREATE TABLE estado_pedido (
	id INT(7) AUTO_INCREMENT,
	estado VARCHAR(50) NOT NULL,
	CONSTRAINT PK_EstadoPedido_Id PRIMARY KEY(id)
);

-- Creacion tabla tipo_pago
CREATE TABLE tipo_pago (
	id INT(7) AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TipoPago_Id PRIMARY KEY(id)
);

-- Creacion tabla tipo_telefono
CREATE TABLE tipo_telefono (
	id INT(7) AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TipoTelefono_Id PRIMARY KEY(id)
);

-- Creacion tabla forma_pago
CREATE TABLE forma_pago (
	id INT(7) AUTO_INCREMENT,
	forma VARCHAR(50) NOT NULL,
	CONSTRAINT PK_FormaPago_Id PRIMARY KEY(id)
);

-- Creacion tabla oficina
CREATE TABLE oficina (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50),
	CONSTRAINT PK_Oficina_Id PRIMARY KEY(id)
);

-- Creacion tabla telefono_oficina
CREATE TABLE telefono_oficina (
	id INT(7) AUTO_INCREMENT,
	oficina_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50),
	CONSTRAINT PK_TelefonoOficina_Id PRIMARY KEY(id),
	CONSTRAINT FK_TipoTelefono_TelefonoOficina_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id),
	CONSTRAINT FK_Oficina_TelefonoOficina_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id)
);

-- Creacion tabla direccion_oficina
CREATE TABLE direccion_oficina (
	id INT(7) AUTO_INCREMENT,
	oficina_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionOficina_Id PRIMARY KEY(id),
	CONSTRAINT FK_Oficina_DireccionOficina_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id),
	CONSTRAINT FK_Pais_DireccionOficina_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionOficina_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionOficina_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

-- Creacion tabla empleado
CREATE TABLE empleado (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	extension VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	oficina_id INT(7),
	jefe_id INT(7) NULL,
	puesto_id INT(7),
	CONSTRAINT PK_Empleado_Id PRIMARY KEY(id),
	CONSTRAINT FK_Oficina_Empleado_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id), 
	CONSTRAINT FK_Jefe_Empleado_Id FOREIGN KEY (jefe_id) REFERENCES empleado(id),
	CONSTRAINT FK_Puesto_Empleado_Id FOREIGN KEY(puesto_id) REFERENCES puesto(id)
);

-- Creacion tabla contacto
CREATE TABLE contacto (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Contacto_Id PRIMARY KEY(id)
);

-- Creacion tabla cliente
CREATE TABLE cliente (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	contacto_id INT(7),
	empleado_id INT(7),
	limite_credito DECIMAL(15,2) NULL,
	CONSTRAINT PK_Cliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Contacto_Cliente_Id FOREIGN KEY (contacto_id) REFERENCES contacto(id), 
	CONSTRAINT FK_Empleado_Cliente_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id)
);

-- Creacion tabla pago
CREATE TABLE pago (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	forma_pago_id INT(7),
	tipo_pago_id INT(7),
	fecha_pago DATE NOT NULL,
	total DECIMAL (15,2) NOT NULL,
	CONSTRAINT PK_Transaccion_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_Pago_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_FormaPago_Pago_Id FOREIGN KEY (forma_pago_id) REFERENCES forma_pago(id),
	CONSTRAINT FK_TipoPago_Pago_Id FOREIGN KEY (tipo_pago_id) REFERENCES tipo_pago(id)
);

-- Creacion tabla telefono_cliente
CREATE TABLE telefono_cliente (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50),
	CONSTRAINT PK_TelefonoCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_TelefonoCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_TipoTelefono_TelefonoCliente_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

-- Creacion tabla direccion_cliente
CREATE TABLE direccion_cliente (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_DireccionCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Pais_DireccionCliente_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionCliente_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionCliente_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

-- Creacion tabla producto
CREATE TABLE producto (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	gama_id INT(7),
	dimensiones VARCHAR(25) NULL,
	descripcion TEXT NULL,
	cantidad_en_stock SMALLINT(6) NOT NULL,
	CONSTRAINT PK_Producto_Id PRIMARY KEY(id),
	CONSTRAINT FK_GamaProducto_Producto_Id FOREIGN KEY(gama_id) REFERENCES gama_producto(id)
);

-- Creacion tabla proveedor
CREATE TABLE proveedor(
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(70) NOT NULL,
	CONSTRAINT PK_Proveedor_Id PRIMARY KEY(id)
);

-- Creacion tabla telefono_proveedor
CREATE TABLE telefono_proveedor(
	id INT(7) AUTO_INCREMENT,
	proveedor_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50),
	CONSTRAINT PK_TelefonoProveedor_Id PRIMARY KEY(id),
	CONSTRAINT FK_proveedor_TelefonoProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_TipoTelefono_TelefonoProveedor_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

-- Creacion tabla direccion_proveedor
CREATE TABLE direccion_proveedor (
	id INT(7) AUTO_INCREMENT,
	proveedor_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionProveedor_Id PRIMARY KEY(id),
	CONSTRAINT FK_Proveedor_DireccionProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_Pais_DireccionProveedor_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionProveedor_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionProveedor_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

-- Creacion tabla precio
CREATE TABLE precio (
	producto_id INT(7),
	precio_venta DECIMAL(15, 2) NOT NULL,
	proveedor_id INT(7),
	precio_proveedor DECIMAL(15, 2) NOT NULL,
	CONSTRAINT PK_precio_Id PRIMARY KEY(producto_id, proveedor_id),
	CONSTRAINT FK_Producto_Precio_Id FOREIGN KEY(producto_id) REFERENCES producto(id),
	CONSTRAINT FK_Proveedor_Precio_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id)
);

-- Creacion tabla pedido
CREATE TABLE pedido (
	id INT(7) AUTO_INCREMENT,
	fecha_pedido DATE NOT NULL,
	fecha_esperada DATE NOT NULL,
	fecha_entrega DATE NOT NULL,
	estado_pedido_id INT(7),
	cliente_id INT(7),
	pago_id INT(7),
	comentarios TEXT NULL,
	CONSTRAINT PK_Pedido_Id PRIMARY KEY(id),
	CONSTRAINT FK_EstadoPedido_Pedido_Id FOREIGN KEY (estado_pedido_id) REFERENCES estado_pedido(id),
	CONSTRAINT FK_Cliente_Pedido_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Pago_Pedido_Id FOREIGN KEY (pago_id) REFERENCES pago(id)
);

-- Creacion tabla detalle_pedido
CREATE TABLE detalle_pedido (
	producto_id INT(7),
	pedido_id INT(7),
	cantidad INT(10) NOT NULL,
	numero_linea SMALLINT(6) NOT NULL,
	CONSTRAINT PK_DetallePedido_Id PRIMARY KEY(producto_id, pedido_id),
	CONSTRAINT FK_Producto_Pedido_Id FOREIGN KEY (producto_id) REFERENCES producto(id),
	CONSTRAINT FK_Pedido_Pedido_Id FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

-- ####################################################
-- ######### INSERCIONES A LA BASE DE DATOS ###########
-- ####################################################
-- Basado en el archivo DbGarden.pdf

-- ################################# INSERCIONES INICIALES ############################################################

-- Inserciones a la tabla gama_producto
INSERT INTO gama_producto (descripcion_texto, descripcion_html, imagen) VALUES 
    ('Herramienta manual para jardinería, ideal para trabajos precisos.', '<p>Herramienta manual para jardinería, ideal para trabajos precisos.</p>', 'herramienta_manual.jpg'),
    ('Tijeras de podar con mango ergonómico.', '<p>Tijeras de podar con mango <strong>ergonómico</strong>.</p>', 'tijeras_podar.jpg'),
    ('Manguera de jardín de 20 metros, resistente y flexible.', '<p>Manguera de jardín de 20 metros, <em>resistente y flexible</em>.</p>', 'manguera_jardin.jpg'),
    ('Fertilizante orgánico para todo tipo de plantas.', '<p>Fertilizante <strong>orgánico</strong> para todo tipo de plantas.</p>', 'fertilizante_organico.jpg'),
    ('Maceta de cerámica, diseño clásico y elegante.', '<p>Maceta de cerámica, diseño <em>clásico y elegante</em>.</p>', 'maceta_ceramica.jpg'),
    ('Guantes de jardinería, protección y comodidad.', '<p>Guantes de jardinería, protección y comodidad.</p>', 'guantes_jardineria.jpg'),
    ('Regadera de plástico, capacidad de 5 litros.', '<p>Regadera de plástico, capacidad de 5 litros.</p>', 'regadera_plastico.jpg'),
    ('Kit de riego automático, fácil de instalar.', '<p>Kit de riego automático, fácil de instalar.</p>', 'kit_riego_automatico.jpg'),
    ('Abono orgánico en pellets, mejora la salud del suelo.', '<p>Abono orgánico en pellets, mejora la salud del suelo.</p>', 'abono_organico.jpg'),
    ('Cortacésped eléctrico, bajo consumo de energía.', '<p>Cortacésped eléctrico, <strong>bajo consumo de energía</strong>.</p>', 'cortacesped_electrico.jpg');

-- Inserciones a la tabla pais
INSERT INTO pais (nombre) VALUES 
    ('Argentina'),
    ('Brasil'),
    ('Chile'),
    ('Colombia'),
    ('Ecuador'),
    ('México'),
    ('Perú'),
    ('Uruguay'),
    ('Venezuela'),
    ('Paraguay');

-- Inserciones a la tabla region
INSERT INTO region (nombre) VALUES 
    ('Norte'),
    ('Sur'),
    ('Este'),
    ('Oeste'),
    ('Centro'),
    ('Noreste'),
    ('Noroeste'),
    ('Sureste'),
    ('Suroeste'),
    ('Interior');

-- Inserciones a la tabla ciudad
INSERT INTO ciudad (nombre, codigo_postal) VALUES 
    ('Buenos Aires', 'C1000'),
    ('São Paulo', '01000-000'),
    ('Santiago', '8320000'),
    ('Bogotá', '110111'),
    ('Quito', '170104'),
    ('Ciudad de México', '01000'),
    ('Lima', '15001'),
    ('Montevideo', '11000'),
    ('Caracas', '1010'),
    ('Asunción', '1209');

-- Inserciones a la tabla puesto
INSERT INTO puesto (puesto) VALUES 
    ('Gerente General'),
    ('Gerente de Ventas'),
    ('Gerente de Marketing'),
    ('Gerente de Finanzas'),
    ('Gerente de Recursos Humanos'),
    ('Jefe de Operaciones'),
    ('Jefe de Logística'),
    ('Jefe de Compras'),
    ('Asistente Administrativo'),
    ('Asistente de Ventas');

-- Inserciones a la tabla estado_pedido
INSERT INTO estado_pedido (estado) VALUES 
    ('Pendiente'),
    ('Procesando'),
    ('Enviado'),
    ('Entregado'),
    ('Cancelado'),
    ('Devuelto'),
    ('En espera'),
    ('Preparando envío'),
    ('En tránsito'),
    ('Completado');

-- Inserciones a la tabla tipo_pago
INSERT INTO tipo_pago (tipo) VALUES 
    ('Tarjeta de crédito'),
    ('Tarjeta de débito'),
    ('Transferencia bancaria'),
    ('PayPal'),
    ('Efectivo'),
    ('Cheque'),
    ('Crédito a 30 días'),
    ('Crédito a 60 días'),
    ('Crédito a 90 días'),
    ('Criptomoneda');

-- Inserciones a la tabla tipo_telefono
INSERT INTO tipo_telefono (tipo) VALUES 
    ('Móvil personal'),
    ('Móvil trabajo'),
    ('Fijo personal'),
    ('Fijo trabajo'),
    ('Fax personal'),
    ('Fax trabajo'),
    ('VoIP personal'),
    ('VoIP trabajo'),
    ('Teléfono emergencia'),
    ('Otro');

-- Inserciones a la tabla forma_pago
INSERT INTO forma_pago (forma) VALUES 
    ('Efectivo'),
    ('Tarjeta de crédito'),
    ('Tarjeta de débito'),
    ('Transferencia bancaria'),
    ('Cheque'),
    ('PayPal'),
    ('Bitcoin'),
    ('Criptomoneda'),
    ('Apple Pay'),
    ('Google Pay');

-- Inserciones a la tabla oficina
INSERT INTO oficina (nombre) VALUES 
    ('Oficina principal'),
    ('Sucursal A'),
    ('Sucursal B'),
    ('Sucursal C'),
    ('Sucursal D'),
    ('Sucursal E'),
    ('Sucursal F'),
    ('Sucursal G'),
    ('Sucursal H'),
    ('Sucursal I');

-- Inserciones a la tabla telefono_oficina
INSERT INTO telefono_oficina (oficina_id, tipo_id, numero) VALUES 
    (1, 1, '1234567890'),   -- Móvil personal en Oficina principal
    (2, 3, '9876543210'),   -- Fijo personal en Sucursal A
    (3, 5, '5555555555'),   -- Fax personal en Sucursal B
    (4, 2, '4444444444'),   -- Móvil trabajo en Sucursal C
    (5, 4, '3333333333'),   -- Fijo trabajo en Sucursal D
    (6, 6, '2222222222'),   -- Fax trabajo en Sucursal E
    (7, 7, '1111111111'),   -- VoIP personal en Sucursal F
    (8, 8, '9999999999'),   -- VoIP trabajo en Sucursal G
    (9, 9, '8888888888'),   -- Teléfono emergencia en Sucursal H
    (10, 10, '7777777777'); -- Otro en Sucursal I

-- Inserciones a la tabla direccion_oficina
INSERT INTO direccion_oficina (oficina_id, pais_id, region_id, ciudad_id, detalle) VALUES 
    (1, 1, 1, 1, 'Avenida Principal #123, Ciudad Capital, País Principal'),  -- Oficina principal en Argentina, Buenos Aires, Buenos Aires
    (2, 2, 2, 2, 'Rua Principal #456, Ciudad Capital, País Secundario'),     -- Sucursal A en Brasil, São Paulo, São Paulo
    (3, 3, 3, 3, 'Calle Principal #789, Ciudad Capital, País Tercero'),       -- Sucursal B en Chile, Santiago, Santiago
    (4, 4, 4, 4, 'Carrera Principal #101, Ciudad Capital, País Cuarto'),       -- Sucursal C en Colombia, Bogotá, Bogotá
    (5, 5, 5, 5, 'Avenida Principal #202, Ciudad Capital, País Quinto'),      -- Sucursal D en Ecuador, Quito, Quito
    (6, 6, 6, 6, 'Calle Principal #303, Ciudad Capital, País Sexto'),         -- Sucursal E en México, Ciudad de México, Ciudad de México
    (7, 7, 7, 7, 'Avenida Principal #404, Ciudad Capital, País Séptimo'),     -- Sucursal F en Perú, Lima, Lima
    (8, 8, 8, 8, 'Carrera Principal #505, Ciudad Capital, País Octavo'),      -- Sucursal G en Uruguay, Montevideo, Montevideo
    (9, 9, 9, 9, 'Calle Principal #606, Ciudad Capital, País Noveno'),        -- Sucursal H en Venezuela, Caracas, Caracas
    (10, 10, 10, 10, 'Rua Principal #707, Ciudad Capital, País Décimo');      -- Sucursal I en Paraguay, Asunción, Asunción

-- Inserciones a la tabla empleado
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    ('Juan', 'García', 'Pérez', '1234', 'juan@example.com', 1, NULL, 1),   -- Juan García Pérez, Oficina principal, Administrador
    ('María', 'López', 'Sánchez', '5678', 'maria@example.com', 2, 1, 2),   -- María López Sánchez, Sucursal A, Subadministrador
    ('Carlos', 'Martínez', 'Gómez', '91011', 'carlos@example.com', 3, 1, 3), -- Carlos Martínez Gómez, Sucursal B, Gerente de Ventas
    ('Laura', 'Rodríguez', 'Díaz', '121314', 'laura@example.com', 4, 2, 4), -- Laura Rodríguez Díaz, Sucursal C, Gerente de Marketing
    ('Pedro', 'Hernández', 'Fernández', '151617', 'pedro@example.com', 5, 2, 5), -- Pedro Hernández Fernández, Sucursal D, Gerente de Logística
    ('Ana', 'González', 'Vázquez', '181920', 'ana@example.com', 6, 3, 6), -- Ana González Vázquez, Sucursal E, Gerente de Recursos Humanos
    ('Diego', 'Sánchez', 'López', '212223', 'diego@example.com', 7, 3, 7), -- Diego Sánchez López, Sucursal F, Gerente de Finanzas
    ('Sofía', 'Pérez', 'Martínez', '242526', 'sofia@example.com', 8, 4, 8), -- Sofía Pérez Martínez, Sucursal G, Jefe de Almacén
    ('Luis', 'Fernández', 'González', '272829', 'luis@example.com', 9, 4, 9), -- Luis Fernández González, Sucursal H, Jefe de Producción
    ('Elena', 'Vázquez', 'Sánchez', '303132', 'elena@example.com', 10, 5, 10); -- Elena Vázquez Sánchez, Sucursal I, Jefe de Compras

-- Inserciones a la tabla contacto
INSERT INTO contacto (nombre, apellido, email) VALUES 
    ('Juan', 'Pérez', 'juan.perez@example.com'),
    ('María', 'López', 'maria.lopez@example.com'),
    ('Carlos', 'González', 'carlos.gonzalez@example.com'),
    ('Laura', 'Martínez', 'laura.martinez@example.com'),
    ('Pedro', 'Rodríguez', 'pedro.rodriguez@example.com'),
    ('Ana', 'Sánchez', 'ana.sanchez@example.com'),
    ('Diego', 'Fernández', 'diego.fernandez@example.com'),
    ('Sofía', 'Gómez', 'sofia.gomez@example.com'),
    ('Luis', 'Díaz', 'luis.diaz@example.com'),
    ('Elena', 'Vázquez', 'elena.vazquez@example.com');

-- Inserciones a la tabla cliente
INSERT INTO cliente (nombre, contacto_id, empleado_id, limite_credito) VALUES 
    ('Jardines Verdes Ltda.', 1, 1, 5000.00),     -- Cliente A con contacto Juan Pérez y empleado Juan García Pérez
    ('Floristería Bella Flor Inc.', 2, 2, 7000.00), -- Cliente B con contacto María López y empleado María López Sánchez
    ('Plantas y Flores S.A.', 3, 3, 10000.00), -- Cliente C con contacto Carlos González y empleado Carlos Martínez Gómez
    ('Jardinería Naturaleza Viva Ltda.', 4, 4, 8000.00), -- Cliente D con contacto Laura Martínez y empleado Laura Rodríguez Díaz
    ('Horticultura Verde y Fresca S.A.', 5, 5, 12000.00), -- Cliente E con contacto Pedro Rodríguez y empleado Pedro Hernández Fernández
    ('Verdor Jardines y Flores S.R.L.', 6, 6, 9000.00),   -- Cliente F con contacto Ana Sánchez y empleado Ana González Vázquez
    ('Floristería Primavera Eterna Ltda.', 7, 7, 15000.00),    -- Cliente G con contacto Diego Fernández y empleado Diego Sánchez López
    ('Plantas Tropicales y Exóticas S.A.', 8, 8, 6000.00), -- Cliente H con contacto Sofía Gómez y empleado Sofía Pérez Martínez
    ('Jardín del Sol y la Luna Ltda.', 9, 9, 11000.00), -- Cliente I con contacto Luis Díaz y empleado Luis Fernández González
    ('Flores del Paraíso S.A.', 10, 10, 8500.00); -- Cliente J con contacto Elena Vázquez y empleado Elena Vázquez Sánchez

-- Inserciones a la tabla pago
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (1, 1, 1, '2024-05-01', 150.00),   -- Pago del cliente A con forma de pago Tarjeta de crédito y tipo de pago Débito automático
    (2, 2, 2, '2024-05-02', 200.00),   -- Pago del cliente B con forma de pago Transferencia bancaria y tipo de pago Efectivo
    (3, 3, 3, '2024-05-03', 300.00),   -- Pago del cliente C con forma de pago Cheque and tipo de pago Tarjeta de crédito
    (4, 4, 4, '2024-05-04', 400.00),   -- Pago del cliente D con forma de pago Efectivo and tipo de pago Transferencia bancaria
    (5, 5, 5, '2024-05-05', 500.00),   -- Pago del cliente E con forma de pago Tarjeta de crédito and tipo de pago Cheque
    (6, 6, 1, '2024-05-06', 600.00),   -- Pago del cliente F con forma de pago Tarjeta de crédito and tipo de pago Débito automático
    (7, 7, 2, '2024-05-07', 700.00),   -- Pago del cliente G con forma de pago Transferencia bancaria and tipo de pago Efectivo
    (8, 8, 3, '2024-05-08', 800.00),   -- Pago del cliente H con forma de pago Cheque and tipo de pago Tarjeta de crédito
    (9, 9, 4, '2024-05-09', 900.00),   -- Pago del cliente I con forma de pago Efectivo and tipo de pago Transferencia bancaria
    (10, 10, 5, '2024-05-10', 1000.00);   -- Pago del cliente J con forma de pago Tarjeta de crédito and tipo de pago Cheque

-- Inserciones a la tabla telefono_cliente
INSERT INTO telefono_cliente (cliente_id, tipo_id, numero) VALUES 
    (1, 1, '+123456789'),   -- Teléfono del cliente A (Jardines Verdes Ltda.) con tipo Celular
    (2, 2, '+0000054321'),   -- Teléfono del cliente B (Floristería Bella Flor Inc.) con tipo Fijo
    (3, 3, '+1991234455'),  -- Teléfono del cliente C (Plantas y Flores S.A.) con tipo Fax
    (4, 1, '+4215606655'),  -- Teléfono del cliente D (Jardinería Naturaleza Viva Ltda.) con tipo Celular
    (5, 2, '+4499216749'),  -- Teléfono del cliente E (Horticultura Verde y Fresca S.A.) con tipo Fijo
    (6, 3, '+1111126655'),  -- Teléfono del cliente F (Verdor Jardines y Flores S.R.L.) con tipo Fax
    (7, 1, '+4622309570'),  -- Teléfono del cliente G (Floristería Primavera Eterna Ltda.) con tipo Celular
    (8, 2, '+2211576655'),  -- Teléfono del cliente H (Plantas Tropicales y Exóticas S.A.) con tipo Fijo
    (9, 3, '+4520004465'),  -- Teléfono del cliente I (Jardín del Sol y la Luna Ltda.) con tipo Fax
    (10, 1, '+777756655'); -- Teléfono del cliente J (Flores del Paraíso S.A.) con tipo Celular

-- Inserciones a la tabla direccion_cliente
INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES 
    (1, 1, 1, 1, 'Calle Principal #123'),   -- Dirección del cliente A (Jardines Verdes Ltda.) en Argentina, Región 1, Ciudad 1
    (2, 2, 2, 2, 'Avenida Central #456'),  -- Dirección del cliente B (Floristería Bella Flor Inc.) en Brasil, Región 2, Ciudad 2
    (3, 3, 3, 3, 'Carrera Principal #789'),  -- Dirección del cliente C (Plantas y Flores S.A.) en Chile, Región 3, Ciudad 3
    (4, 4, 4, 4, 'Boulevard Central #101'),   -- Dirección del cliente D (Jardinería Naturaleza Viva Ltda.) en Colombia, Región 4, Ciudad 4
    (5, 5, 5, 5, 'Calle Principal #202'),   -- Dirección del cliente E (Horticultura Verde y Fresca S.A.) en Ecuador, Región 5, Ciudad 5
    (6, 6, 6, 6, 'Avenida Principal #303'),   -- Dirección del cliente F (Verdor Jardines y Flores S.R.L.) en México, Región 6, Ciudad 6
    (7, 7, 7, 7, 'Calle Central #404'),   -- Dirección del cliente G (Floristería Primavera Eterna Ltda.) en Perú, Región 7, Ciudad 7
    (8, 8, 8, 8, 'Carrera Principal #505'),   -- Dirección del cliente H (Plantas Tropicales y Exóticas S.A.) en Uruguay, Región 8, Ciudad 8
    (9, 9, 9, 9, 'Boulevard Central #606'),   -- Dirección del cliente I (Jardín del Sol y la Luna Ltda.) en Venezuela, Región 9, Ciudad 9
    (10, 10, 10, 10, 'Calle Principal #707');   -- Dirección del cliente J (Flores del Paraíso S.A.) en Paraguay, Región 10, Ciudad 10

-- Inserciones a la tabla producto
INSERT INTO producto (nombre, gama_id, dimensiones, descripcion, cantidad_en_stock) VALUES 
    ('Rosa Roja', 1, '10x10x20 cm', 'Rosa roja de alta calidad', 100),   -- Producto 1 perteneciente a la gama de productos 1
    ('Cactus Esmeralda', 2, '15x15x30 cm', 'Cactus esmeralda de tamaño mediano', 50),   -- Producto 2 perteneciente a la gama de productos 2
    ('Geranio Blanco', 3, '12x12x25 cm', 'Geranio blanco ideal para interiores', 80),   -- Producto 3 perteneciente a la gama de productos 3
    ('Lirio Amarillo', 1, '8x8x18 cm', 'Lirio amarillo con fragancia dulce', 70),   -- Producto 4 perteneciente a la gama de productos 1
    ('Orquídea Púrpura', 2, '20x20x40 cm', 'Orquídea púrpura de larga duración', 90),   -- Producto 5 perteneciente a la gama de productos 2
    ('Margarita Blanca', 3, '10x10x20 cm', 'Margarita blanca fresca y hermosa', 60),   -- Producto 6 perteneciente a la gama de productos 3
    ('Tulipán Rojo', 1, '8x8x18 cm', 'Tulipán rojo vibrante para arreglos florales', 120),   -- Producto 7 perteneciente a la gama de productos 1
    ('Helecho Verde', 2, '18x18x35 cm', 'Helecho verde con hojas frondosas', 40),   -- Producto 8 perteneciente a la gama de productos 2
    ('Camelia Rosada', 3, '15x15x30 cm', 'Camelia rosada de gran belleza', 75),   -- Producto 9 perteneciente a la gama de productos 3
    ('Bonsái de Pino', 1, '20x20x40 cm', 'Bonsái de pino de estilo japonés', 55);   -- Producto 10 perteneciente a la gama de productos 1

-- Inserciones a la tabla proveedor
INSERT INTO proveedor (nombre) VALUES 
    ('Jardinería La Rosa Verde'),
    ('Vivero El Edén'),
    ('Floristería Flores del Sol'),
    ('Plantas Tropicales y Exóticas S.A.'),
    ('Horticultura Verde y Fresca S.A.'),
    ('Semillas y Plantas El Paraíso'),
    ('Vivero El Jardín Encantado'),
    ('Plantas y Flores Naturales'),
    ('Jardinería Naturaleza Viva Ltda.'),
    ('Semillas y Plantas de América');

-- Inserciones a la tabla telefono_proveedor
INSERT INTO telefono_proveedor (proveedor_id, tipo_id, numero) VALUES 
    (1, 1, '+1234567890'),   -- Teléfono del proveedor 1 (Jardinería La Rosa Verde) con tipo Celular
    (2, 2, '+9876543210'),   -- Teléfono del proveedor 2 (Vivero El Edén) con tipo Fijo
    (3, 3, '+1166677421'),  -- Teléfono del proveedor 3 (Floristería Flores del Sol) con tipo Fax
    (4, 1, '+9666776655'),  -- Teléfono del proveedor 4 (Plantas Tropicales y Exóticas S.A.) con tipo Celular
    (5, 2, '+1100004455'),  -- Teléfono del proveedor 5 (Horticultura Verde y Fresca S.A.) con tipo Fijo
    (6, 3, '+9977770095'),  -- Teléfono del proveedor 6 (Semillas y Plantas El Paraíso) con tipo Fax
    (7, 1, '+1138804455'),  -- Teléfono del proveedor 7 (Vivero El Jardín Encantado) con tipo Celular
    (8, 2, '+290070655'),  -- Teléfono del proveedor 8 (Plantas y Flores Naturales) con tipo Fijo
    (9, 3, '+6122639995'),  -- Teléfono del proveedor 9 (Jardinería Naturaleza Viva Ltda.) con tipo Fax
    (10, 1, '+2982772600'); -- Teléfono del proveedor 10 (Semillas y Plantas de América) con tipo Celular

-- Inserciones a la tabla direccion_proveedor
INSERT INTO direccion_proveedor (proveedor_id, pais_id, region_id, ciudad_id, detalle) VALUES 
    (1, 1, 1, 1, 'Calle Principal #123, Ciudad Capital'),   -- Dirección del proveedor 1 (Jardinería La Rosa Verde) en Argentina, Región 1, Ciudad 1
    (2, 2, 2, 2, 'Avenida Central #456, Centro'),   -- Dirección del proveedor 2 (Vivero El Edén) en Brasil, Región 2, Ciudad 2
    (3, 3, 3, 3, 'Carrera Principal #789, Zona Norte'),   -- Dirección del proveedor 3 (Floristería Flores del Sol) en Chile, Región 3, Ciudad 3
    (4, 4, 4, 4, 'Boulevard Central #101, Centro'),   -- Dirección del proveedor 4 (Plantas Tropicales y Exóticas S.A.) en Colombia, Región 4, Ciudad 4
    (5, 5, 5, 5, 'Calle Principal #202, Sector Sur'),   -- Dirección del proveedor 5 (Horticultura Verde y Fresca S.A.) en Ecuador, Región 5, Ciudad 5
    (6, 6, 6, 6, 'Avenida Principal #303, Zona Este'),   -- Dirección del proveedor 6 (Semillas y Plantas El Paraíso) en México, Región 6, Ciudad 6
    (7, 7, 7, 7, 'Calle Central #404, Sector Oeste'),   -- Dirección del proveedor 7 (Vivero El Jardín Encantado) en Perú, Región 7, Ciudad 7
    (8, 8, 8, 8, 'Carrera Principal #505, Zona Centro'),   -- Dirección del proveedor 8 (Plantas y Flores Naturales) en Uruguay, Región 8, Ciudad 8
    (9, 9, 9, 9, 'Boulevard Central #606, Centro'),   -- Dirección del proveedor 9 (Jardinería Naturaleza Viva Ltda.) en Venezuela, Región 9, Ciudad 9
    (10, 10, 10, 10, 'Calle Principal #707, Distrito Industrial');   -- Dirección del proveedor 10 (Semillas y Plantas de América) en Paraguay, Región 10, Ciudad 10

-- Inserciones a la tabla precio
INSERT INTO precio (producto_id, precio_venta, proveedor_id, precio_proveedor) VALUES 
    (1, 25.99, 1, 20.50),   -- Precio del producto 1 para el proveedor 1
    (2, 15.75, 2, 12.30),   -- Precio del producto 2 para el proveedor 2
    (3, 30.50, 3, 25.75),   -- Precio del producto 3 para el proveedor 3
    (4, 18.99, 4, 15.25),   -- Precio del producto 4 para el proveedor 4
    (5, 12.50, 5, 10.00),   -- Precio del producto 5 para el proveedor 5
    (6, 8.99, 6, 6.75),     -- Precio del producto 6 para el proveedor 6
    (7, 19.99, 7, 15.50),   -- Precio del producto 7 para el proveedor 7
    (8, 22.50, 8, 18.75),   -- Precio del producto 8 para el proveedor 8
    (9, 10.99, 9, 9.25),    -- Precio del producto 9 para el proveedor 9
    (10, 14.75, 10, 12.00); -- Precio del producto 10 para el proveedor 10


-- Inserciones a la tabla pedido
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2024-05-01', '2024-05-05', '2024-05-04', 1, 1, 1, 'Pedido urgente para jardín principal'),   -- Pedido 1
    ('2024-05-02', '2024-05-07', '2024-05-06', 2, 2, 2, 'Pedido regular para mantenimiento del jardín'),   -- Pedido 2
    ('2024-05-03', '2024-05-09', '2024-05-08', 1, 3, 3, 'Pedido urgente para evento de jardinería'),   -- Pedido 3
    ('2024-05-04', '2024-05-11', '2024-05-10', 2, 4, 4, 'Pedido regular para decoración de jardín exterior'),   -- Pedido 4
    ('2024-05-05', '2024-05-13', '2024-05-12', 1, 5, 5, 'Pedido urgente para evento de paisajismo'),   -- Pedido 5
    ('2024-05-06', '2024-05-15', '2024-05-14', 2, 6, 6, 'Pedido regular para renovación de jardín residencial'),   -- Pedido 6
    ('2024-05-07', '2024-05-17', '2024-05-16', 1, 7, 7, 'Pedido urgente para proyecto de jardinería comunitaria'),   -- Pedido 7
    ('2024-05-08', '2024-05-19', '2024-05-18', 2, 8, 8, 'Pedido regular para mantenimiento de parques públicos'),   -- Pedido 8
    ('2024-05-09', '2024-05-21', '2024-05-20', 1, 9, 9, 'Pedido urgente para proyecto de reforestación'),   -- Pedido 9
    ('2024-05-10', '2024-05-23', '2024-05-22', 2, 10, 10, 'Pedido regular para diseño de jardín botánico');   -- Pedido 10

-- Inserciones a la tabla detalle_pedido
INSERT INTO detalle_pedido (producto_id, pedido_id, cantidad, numero_linea) VALUES 
    (1, 1, 5, 1),   -- 5 unidades del producto 1 en el pedido 1
    (2, 1, 3, 2),   -- 3 unidades del producto 2 en el pedido 1
    (3, 2, 2, 1),   -- 2 unidades del producto 3 en el pedido 2
    (4, 3, 4, 1),   -- 4 unidades del producto 4 en el pedido 3
    (5, 4, 1, 1),   -- 1 unidad del producto 5 en el pedido 4
    (6, 4, 2, 2),   -- 2 unidades del producto 6 en el pedido 4
    (7, 5, 3, 1),   -- 3 unidades del producto 7 en el pedido 5
    (8, 5, 2, 2),   -- 2 unidades del producto 8 en el pedido 5
    (9, 6, 1, 1),   -- 1 unidad del producto 9 en el pedido 6
    (10, 7, 5, 1);  -- 5 unidades del producto 10 en el pedido 7

-- ######################################### INSERCIONES ADICIONALES #################################################################################

-- Estas inserciones se realizaron a base de cumplir las necesidades de las consultas
-- Se realizara por numero de consulta mientras sea necesario

-- ################ INSERCIONES PARA CONSULTAS SOBRE UNA TABLA ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

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
(11, 11, 11, 11, 'Calle Falsa 123, Sevilla'),
(12, 11, 11, 12, 'Avenida Real 456, Barcelona'),
(13, 11, 11, 13, 'Plaza Mayor 789, Madrid'),
(14, 11, 11, 14, 'Calle de la Paz 101, Valencia');

-- Insert data into telefono_oficina
INSERT INTO telefono_oficina (oficina_id, tipo_id, numero) VALUES 
(11, 5, '955123456'),
(12, 1, '933123456'),
(13, 7, '915123456'),
(14, 10, '961123456');

-- 3.



-- 4.

-- 5.
INSERT INTO puesto(puesto) VALUES
('Representante de Ventas');

INSERT INTO empleado(nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id)
VALUES ('Juan', 'Contreras', 'Melendez', '1278', 'mizamarzes@gmail.com', 12, 1, 11);

-- 6.
INSERT INTO cliente (nombre, contacto_id, empleado_id, limite_credito) VALUES 
('El Carajo Ltda.', 5, 11, 6000.00),
('Walmart', 10,11,10000.00);

INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES 
    (11, 11, 13, 13, 'Calle Secundaria #333'),
	(12, 11, 12, 14, 'Calle Loco#623');

-- 7.

-- 8.
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (11, 8, 1, '2024-10-11', 150.00),
    (12, 7,1,'2008-04-25', 500.00 );

-- 9.
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2015-04-21', '2015-04-28', '2016-04-30', 4, 11, 12, 'Masapan');

-- 10.
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (5, 1, 1, '2020-04-21', 850.00);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2020-05-20', '2020-05-28', '2020-05-25', 4, 5, 13, 'Aguapanela');

-- 11.
INSERT INTO estado_pedido (estado) VALUES 
    ('Rechazado');

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2009-05-01', '2009-05-01', '2009-05-01', 11, 5, NULL, 'Guanabana');

-- 12.
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (7, 4, 2, '2010-01-11', 2450.00);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2010-01-11', '2010-02-01', '2010-02-03', 4, 7, 14, 'Yuca');

INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (7, 4, 2, '2010-01-11', 3450.00);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2010-01-11', '2010-01-14', '2010-01-16', 4, 7, 15, 'Papa con Flores');

-- 13.
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (11, 6, 4, '2008-01-11', 3450.00);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES 
    ('2008-01-11', '2008-01-14', '2008-01-16', 4, 1, 16, 'Fertilizante la juanita');

-- 14.

-- 15.
INSERT INTO gama_producto (descripcion_texto, descripcion_html, imagen) VALUES 
    ('Ornamentales', '<p>decoracion.</p>', 'ornamental_accesorios.jpg');

INSERT INTO producto (nombre, gama_id, dimensiones, descripcion, cantidad_en_stock) VALUES 
    ('Cesped Tapizante', 1, '50x50x50 cm', 'Cesped GOD', 150),  
    ('Trepadora', 2, '45x35x10 cm', 'LA TREPADORA', 120);

INSERT INTO precio (producto_id, precio_venta, proveedor_id, precio_proveedor) VALUES 
    (11, 25.99, 7, 14.50),
    (12, 35.99, 7, 25.50);

INSERT INTO producto (nombre, gama_id, dimensiones, descripcion, cantidad_en_stock) VALUES 
    ('Maraca', 11, '20x20x20 cm', 'Wakanda', 170),  
    ('Liana', 11, '45x15x10 cm', 'League of legends', 220);

INSERT INTO precio (producto_id, precio_venta, proveedor_id, precio_proveedor) VALUES 
    (13, 35.99, 4, 20.50),
    (14, 399.99, 4, 235.50);

-- 16.
INSERT INTO cliente (nombre, contacto_id, empleado_id, limite_credito) VALUES 
    ('Riot Games', 5, 11, 10000.00);

INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES 
    (13, 11, 13, 13, 'Calle Mayorca #333');

-- ################ INSERCIONES PARA CONSULTAS MULTITABLA ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.
INSERT INTO ciudad (nombre, codigo_postal) VALUES ('Fuenlabrada', '28940');

INSERT INTO oficina (nombre) VALUES ('Oficina Fuenlabrada');

INSERT INTO direccion_oficina (oficina_id, pais_id, region_id, ciudad_id, detalle)
VALUES (15, 11, 11, 15, 'Calle Fuenlambrada, 4');

INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, oficina_id, puesto_id)
VALUES ('Daniel', 'Navas', 'Gomez', '9904', 'Daniel_navas@example.com', 15, 5);

INSERT INTO cliente (nombre, contacto_id, empleado_id, limite_credito)
VALUES ('Cliente Fuenlabrada', 7, 12, 6720.00);

INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle)
VALUES (14, 11, 11, 15, 'Avenida de la Muerte, 65');

-- 7.

-- 8.

-- 9.

-- 10.

-- 11.

-- ################ INSERCIONES PARA CONSULTAS MULTITABLA(Composicion Externa) ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    ('Camilo', 'Rodriguez', 'Pérez', '4330', 'cccold@example.com', NULL, 1, 5);

-- 5.
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    ('Pedro', 'Pascal', 'LOLO', '2710', 'ateteKAKA@example.com', NULL, 1, 2);

INSERT INTO cliente (nombre, contacto_id, empleado_id, limite_credito) VALUES 
    ('La Marimba', NULL, NULL, 1000.00);

-- 6.

-- 7.

-- 8.

-- 9.

-- 10.
INSERT INTO gama_producto (descripcion_texto) VALUES
('Frutales');

INSERT INTO producto (nombre, gama_id, dimensiones, descripcion, cantidad_en_stock) VALUES
('Manzana', 12, '10x10x10', 'Producto de gama Frutales', 200),
('Naranja', 12, '15x15x15', 'Producto de gama Frutales', 150),
('Borojo', 12, '5x5x5', 'Producto de gama Frutales', 300);

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES
('2024-01-01', '2024-01-05', '2024-01-03', 1, 15, NULL, 'Primera compra'),
('2024-02-01', '2024-02-05', '2024-02-03', 1, 15, NULL, 'Segunda compra');

INSERT INTO detalle_pedido (producto_id, pedido_id, cantidad, numero_linea) VALUES
(15, 17, 17, 1),
(16, 18, 18, 2);

-- 11.

-- 12.

-- ################ INSERCIONES PARA CONSULTAS RESUMEN ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES 
    (13, 2, 2, '2009-05-01', 500.00),
    (12, 1, 5, '2009-04-01', 500.00); 

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

-- ################ INSERCIONES PARA SUBCONSULTAS ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    ('Alberto', 'Soria', 'Rojas', '32377', 'mondacon@example.com', 5, NULL, 2),
('Guasimodo', 'Lutaturo', 'aaaaaa', '11117', 'cacanuez@example.com', 5,15, 7);

-- INSERCIONES PARA SUBCONSULTAS CON ALL Y ANY ------------------
-- 8.

-- 9.

-- 10.

-- INSERCIONES PARA SUBCONSULTAS CON IN Y NOT IN ------------------
-- 11.

-- 12.

-- 13.

-- 14.

-- 15.

-- 16.

-- 17.

-- INSERCIONES PARA SUBCONSULTAS CON EXITS Y NOT EXITS ------------------
-- 18.

-- 19.

-- 20.

-- 21.

-- ################ INSERCIONES PARA CONSULTAS VARIADAS ###############
-- Esta enumeracion de INSERCIONES esta basado en DbGarden.pdf

-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

