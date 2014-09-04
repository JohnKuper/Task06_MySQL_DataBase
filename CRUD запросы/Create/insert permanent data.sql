-- init car characreristic
-- Кузов
insert into car_characteristic(name,id_parent)
values ('Кузов',NULL);
set @char_id = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Тип кузова',@char_id);
set @base_type = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Длина',@char_id);
set @base_length = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Ширина',@char_id);
set @base_width = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Цвет',@char_id);
set @base_color = last_insert_id();
-- Двигатель
insert into car_characteristic(name,id_parent)
values ('Двигатель',NULL);
set @char_id = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Мощность',@char_id);
insert into car_characteristic(name,id_parent)
values ('Крутящий момент',@char_id);
insert into car_characteristic(name,id_parent)
values ('Топливо',@char_id);
-- Трансмиссия
insert into car_characteristic(name,id_parent)
values ('Трансмиссия',NULL);
set @char_id = last_insert_id();
insert into car_characteristic(name,id_parent)
values ('Тип КПП',@char_id);
insert into car_characteristic(name,id_parent)
values ('Кол-во передач',@char_id);
insert into car_characteristic(name,id_parent)
values ('Привод',@char_id);




-- add merchant
insert into merchant(name,surname,patronic)
values('Василий','Пупкин','Сидорович');
-- add merchant
insert into merchant(name,surname,patronic)
values('Анатолий','Вассерман','Александрович');



-- add car mark Audi
insert into car_mark(name) values('Audi');

	set @new_mark_id = last_insert_id();
-- Add new model for Audi 
	insert into car_model(id_car_mark,name)
	values(@new_mark_id,'R8');

	set @new_model_id = last_insert_id();
		
-- add modification
		insert into car_modification(id_car_model,name)
		values(@new_model_id,'6.2 MT (442 hs)');
		

		set @new_modif_id = last_insert_id();
-- add characteristic
			insert into `car_characteristic_value`(value,unit,id_characteristic,id_car_modification)
			values('Седан',NULL,@base_type,@new_modif_id);
			insert into `car_characteristic_value`(value,unit,id_characteristic,id_car_modification)
			values('Зеленый',NULL,@base_color,@new_modif_id);
-- add car to store
			insert into store(id_car_modification,count,price)
			values(@new_modif_id,2,1231231.2);

-- add modification
		insert into car_modification(id_car_model,name)
		values(@new_model_id,'2.9 MT (200 hs)');

		set @new_modif_id = last_insert_id();
-- add characteristic
			insert into `car_characteristic_value`(value,unit,id_characteristic,id_car_modification)
			values('Кабриолет',NULL,@base_type,@new_modif_id);
			insert into `car_characteristic_value`(value,unit,id_characteristic,id_car_modification)
			values('Красный',NULL,@base_color,@new_modif_id);

-- add car to store
			insert into store(id_car_modification,count,price)
			values(@new_modif_id,3,222222.2);