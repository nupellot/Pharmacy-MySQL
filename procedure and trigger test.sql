USE rk6_schema;
SET SQL_SAFE_UPDATES = 0;  # Разрешаем использовать UPDATE без WHERE

# Разработать процедуру, которая будет принимать на вход дату. В процедуре реализовать вычисление и занесение в БД стоимости всех заказов, составленных в этот день.
DROP TABLE report;  # Таблица, которая будет хранить стомости заказов.
CREATE TABLE report(summ INT, dat DATE);
SELECT * FROM report;
drop PROCEDURE daily_cost;
CALL daily_cost("2022-04-01");

delimiter //
CREATE PROCEDURE daily_cost(d DATE)
BEGIN
	DECLARE suma INT;
    DECLARE flag INT;
    
    /*проверяем, были ли уже записи для этой даты*/
    SELECT COUNT(*)  
    FROM report 
    WHERE dat = d 
    INTO flag; 
    
    SELECT SUM(price) FROM `order` /*суммируем суммы заказов*/
    WHERE DATE_preparation = d  /*сделанных в нужный день*/
    INTO suma; /* и заносим в переменную*/
    
    IF (flag <> 0)  /*если запись за этот день уже была*/
    THEN /*тогда*/
		UPDATE report  
        SET summ = suma /*обновляем отчет*/
        WHERE dat = d;
	END IF;
    IF (flag = 0) /*если записи не было*/
    THEN
		INSERT INTO report values (SUMa, d); /*то создаем ее*/
	END IF;
END
//

# Реализовать триггер, который будет срабатывать при добавлении новой строки заказа. В триггере реализовать увеличение общей стоимости соответствующего заказа нарастающим образом.
DROP TRIGGER trigg;
delimiter \\ 
CREATE TRIGGER trigg AFTER INSERT on order_line FOR EACH ROW
BEGIN
    UPDATE `order`
    SET price = price + new.price*new.amount
    WHERE id_o=new.id_a;
END
\\