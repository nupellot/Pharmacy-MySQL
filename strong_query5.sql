SELECT * FROM supplier
WHERE id_s NOT IN (
SELECT id_s
FROM rk6_schema.supplier
LEFT JOIN rk6_schema.order ON (id_s = rk6_schema.order.id_a)
WHERE YEAR(date_preparation) = 2020 AND MONTH(date_preparation) = 3
)