--   ──────────────────────────
-- BodegaTech — Script de Inventario
-- Autor: Yamila Moran
-- Fecha: 05/07/2026
--  ──────────────────────────


-- ── SECCIÓN DDL ──────────────────────────
DROP TABLE IF EXISTS inventario;


CREATE TABLE inventario(
id_producto INT PRIMARY KEY,       -- Identificador único en formato entero
nombre_producto VARCHAR(100),      -- Texto hasta 100 caracteres para limitar la descripcion de producto
categoria VARCHAR (50),            -- Texto hasta 100 caracteres, lleva menos caracteres 
precio_unitario decimal(10,2),     -- para evitar errores de precision en los valores
stock_actual INT,                  -- INT porque el stock son cantidades enteras
stock_minimo INT,                  --  INT para definir umbral mínimo de reposición
fecha_ingreso DATE,                -- para registrar la Fecha de ingreso al inventario
activo TINYINT NOT NULL DEFAULT (1) -- para determinar si esta activo o no 1 = disponible, 0 = descontinuado
);





-- ── SECCIÓN DML ──────────────────────────
-- INSERT INTO
insert into inventario(
id_producto, nombre_producto, categoria, precio_unitario,stock_actual, stock_minimo, fecha_ingreso, activo
)
values
(1, 'Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
(2, 'Mouse Inalámbrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
(3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
(4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
(5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
(6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
(7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
(8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
(9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
(10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);


-- UPDATE ventas del día
update inventario
set stock_actual - 3
where id_producto=1;

update inventario
set stock_actual - 12
where id_producto=2;

update inventario
set stock_actual - 5
where id_producto=6;


-- UPDATE producto descontinuado

update inventario
set activo=0
where id_producto=8;

-- SELECT validaciones

-- Ver inventario completo ordenado por categoria
SELECT * FROM inventario
ORDER BY categoria, nombre_producto;


-- Ver productos con stock por debajo del mínimo
SELECT id_producto, nombre_producto, stock_actual, stock_minimo
FROM inventario
WHERE stock_actual <= stock_minimo AND activo = 1;

-- Ver valor total del inventario activo por categoria
SELECT
    categoria,
    COUNT(*) AS cantidad_productos,
    SUM(stock_actual * precio_unitario) AS valor_total_stock
FROM inventario
WHERE activo = 1
GROUP BY categoria
ORDER BY valor_total_stock DESC;
