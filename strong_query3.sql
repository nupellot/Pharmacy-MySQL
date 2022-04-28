SELECT id_s, agreement_date, supplier.name, city, end_date
FROM supplier
JOIN rk6_schema.order ON id_s = rk6_schema.order.id_a
JOIN  (
		SELECT id_a, id_b, MAX(price)
		FROM order_line
        WHERE id_b = 1
) AS price_xxx ON (price_xxx.id_a = rk6_schema.order.id_o)
