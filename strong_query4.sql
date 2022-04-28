SELECT id_s, agreement_date, supplier.name, city, end_date
FROM rk6_schema.supplier
LEFT JOIN rk6_schema.order ON (id_s = rk6_schema.order.id_a)
WHERE id_o IS NULL