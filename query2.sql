SELECT name FROM supplier WHERE end_date BETWEEN date_sub(current_date(), INTERVAL 5 DAY) AND current_date()