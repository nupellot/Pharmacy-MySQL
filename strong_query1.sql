SELECT drug.id_d, drug.name, SUM(order_line.amount) AS 'amount' FROM rk6_schema.order_line
JOIN rk6_schema.order ON order_line.id_a = rk6_schema.order.id_o
JOIN drug ON order_line.id_b = drug.id_d
WHERE YEAR(rk6_schema.order.date_preparation) = 2020 AND MONTH(rk6_schema.order.date_preparation) = 3
group by drug.id_d