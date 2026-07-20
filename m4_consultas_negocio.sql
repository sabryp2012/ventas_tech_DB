
--Base de datos: ventas_tech_DB1
--Archivo: m4_consultas_negocio.sql
--Trabajo sobre tabla: ventas

SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta)
ORDER BY 
    mes ASC;

SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM 
    ventas
GROUP BY 
    id_producto
ORDER BY 
    total_generado DESC
LIMIT 5;

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM 
    ventas
GROUP BY 
    id_cliente
HAVING 
    COUNT(*) > 1
ORDER BY 
    cantidad_pedidos DESC, total_gastado DESC;

SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT EXTRACT(MONTH FROM fecha_venta)) 
            FROM ventas
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_vs_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta)
ORDER BY 
    mes ASC;

--Comentarios:
	El producto 2 representa el 50% de las ventas del mes,
	Las ventas quedaron por debajo de la facturacion mensual,
	El 70% de las ventas pertenecen a accesorios tech;
	
	