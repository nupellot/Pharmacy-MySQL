SELECT count, agreement_date, name, city, end_date
FROM new_view
WHERE count = (SELECT MAX(count) FROM new_view)