-- Ejercicio 1

SELECT 
    c.first_name,
    c.last_name,
    c.birthdate,
    COUNT(o.id_order) AS cantidad_ventas
FROM customer c JOIN order o ON c.id_customer = o.id_seller
WHERE MONTH(c.birthdate) = MONTH(CURDATE())
	AND DAY(c.birthdate) = DAY(CURDATE())
	AND YEAR(o.order_date) = 2020
	AND MONTH(o.order_date) = 1
GROUP BY c.first_name, c.last_name, c.birthdate
HAVING COUNT(o.id_order) > 1500;

-- Ejercicio 2

WITH VentasCelulares AS (
    SELECT 
        MONTH(o.order_date) AS mes,
        YEAR(o.order_date) AS año,
        v.first_name AS nombre_vendedor,
        v.last_name AS apellido_vendedor,
        COUNT(o.id_order) AS cantidad_ventas,
        SUM(o.quantity) AS cantidad_productos_vendidos,
        SUM(o.price) AS monto_total_transaccionado,
        ROW_NUMBER() OVER (PARTITION BY MONTH(o.order_date), YEAR(o.order_date) ORDER BY SUM(o.price) DESC) AS ranking
    FROM order o
    INNER JOIN item i ON o.id_item = i.id_item
    INNER JOIN category c ON i.id_category = c.id_category
    INNER JOIN customer v ON o.id_seller = v.id_customer
    WHERE YEAR(o.order_date) = 2020
    AND c.name = 'Celulares y Smartphones'
    GROUP BY MONTH(o.order_date), YEAR(o.order_date), v.first_name, v.last_name
)
SELECT mes, año, nombre_vendedor, apellido_vendedor, cantidad_ventas, cantidad_productos_vendidos, monto_total_transaccionado
FROM VentasCelulares
WHERE ranking <= 5
ORDER BY año, mes, monto_total_transaccionado DESC;

-- Ejercicio 3

DELIMITER //
CREATE PROCEDURE populate_item_price_history()
BEGIN
    INSERT INTO item_price_history (id_item, price, status)
    SELECT id_item, price, status
    FROM item;
END//
DELIMITER ;