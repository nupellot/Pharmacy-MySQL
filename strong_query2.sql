SELECT supplier.id_s, supplier.name, SUM(rk6_schema.order.price) as 'price'
FROM rk6_schema.order JOIN supplier ON supplier.id_s = rk6_schema.order.id_a
WHERE YEAR(rk6_schema.order.date_preparation) = 2020 AND MONTH(rk6_schema.order.date_preparation) = 3

