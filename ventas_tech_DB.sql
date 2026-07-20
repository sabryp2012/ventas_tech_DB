DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

create table categorias (
	id_categoria integer PRIMARY KEY,
	nombre_categoria VARCHAR (50) NOT NULL, 
	descripcion VARCHAR (200)
);

Create table clientes (
	id_cliente integer PRIMARY KEY,
	nombre varchar (100) NOT NULL, 
	email varchar (100) UNIQUE,
	ciudad varchar (50),
	fechar_registro DATE NOT NULL
);

create table productos (
	id_producto INTEGER PRIMARY KEY,
	nombre_producto VARCHAR (100) NOT NULL,
	id_categoria INTEGER,
	precio DECIMAL (10,2) NOT NULL,
	stock INTEGER DEFAULT 0,
	activo BOOLEAN DEFAULT TRUE,

CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

create table ventas (
	id_venta INTEGER PRIMARY KEY,
	id_cliente INTEGER,
	id_producto INTEGER,
	cantidad INTEGER NOT NULL,
	precio_unitario DECIMAL (10,2) NOT NULL,
	fecha_venta DATE NOT NULL,

CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto)	
);

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

ALTER TABLE productos 
ALTER COLUMN activo TYPE INTEGER USING (CASE WHEN activo = TRUE THEN 1 ELSE 0 END);

ALTER TABLE productos 
ALTER COLUMN activo SET DEFAULT 1;

ALTER TABLE productos DROP COLUMN activo;
ALTER TABLE productos ADD COLUMN activo INTEGER DEFAULT 1;

INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;