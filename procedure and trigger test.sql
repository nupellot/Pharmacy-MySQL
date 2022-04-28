use rk6_schema;

# Разработать процедуру, которая будет принимать на вход дату. В процедуре реализовать вычисление и занесение в БД стоимости всех заказов, составленных в этот день.
drop table report;
create table report(summ int, dat date);
select * from report;
drop procedure daily_cost;
call daily_cost("2022-04-01");
delimiter //
create procedure daily_cost(d date)
begin
	declare suma int; /*переменная*/
    declare flag int; /*тоже переменная*/
    
    select count(*) /*проверяем, были ли уже записи для этой даты*/
    from report 
    where dat = d 
    into flag; 
    
    select sum(price) from `order` /*суммируем суммы заказов*/
    where date_preparation = d  /*сделанных в нужный день*/
    into suma; /* и заносим переменную*/
    
    if flag<>0  /*если запись за этот день уже была*/
    then /*тогда*/
		update report  
        set summ = suma /*обновляем отчет*/
        where dat = d;
	end if;
    if flag = 0 /*если записи не было*/
    then
		insert into report values (suma, d); /*то создаем ее*/
	end if;
end//

# Реализовать триггер, который будет срабатывать при добавлении новой строки заказа. В триггере реализовать увеличение общей стоимости соответствующего заказа нарастающим образом.
delimiter \\ 
create trigger trigg AFTER insert on order_line  for each row
begin
    /*declare earn int;/*переменная для стоимости строки*/
    /*select now_in_store.price from now_on_store /*выбираем цену лекарства*/
    /*where now_in_store.id_b = new.id_b into earn; /*которое было добавлено со строкой*/
    /*update `order`  /*обновляем стоимость заказа*/
    /*set price = price + earn*new.amount прибавляем стоимость строки к заказу*/
    /*where id_o=new.id_a; /*в который была внесена строка*/
    update `order`
    set price = price + new.price*new.amount
    where id_o=new.id_a;
end
\\
drop trigger trigg;