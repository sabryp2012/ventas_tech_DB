SELECT 
    v.fecha_venta AS fecha,
    c.nombre AS cliente,                       
    c.ciudad,                              
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,          
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM 
    ventas v
INNER JOIN 
    clientes c ON v.id_cliente = c.id_cliente
INNER JOIN 
    productos p ON v.id_producto = p.id_producto
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria;

SELECT 
    c.nombre AS cliente,
    c.email,
    c.fecha_registro AS fecha_registro
FROM 
    clientes c
LEFT JOIN 
    ventas v ON c.id_cliente = v.id_cliente
WHERE 
    v.id_venta IS NULL;

SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM 
    productos p
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN 
    ventas v ON p.id_producto = v.id_producto
WHERE 
    v.id_venta IS NULL;

SELECT 
    sub.canal,
    COUNT(*) AS total_transacciones,
    SUM(sub.cantidad) AS unidades_vendidas,
    SUM(sub.cantidad * sub.precio_unitario) AS total_facturado
FROM (
    SELECT 
        'Online' AS canal,
        cantidad,
        precio_unitario
    FROM 
        ventas
    WHERE 
        MOD(id_venta, 2) = 0

    UNION ALL

    SELECT 
        'Presencial' AS canal,
        cantidad,
        precio_unitario
    FROM 
        ventas
    WHERE 
        MOD(id_venta, 2) <> 0
) AS sub
GROUP BY 
    sub.canal;