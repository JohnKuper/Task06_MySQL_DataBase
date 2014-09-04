create database if not exists auto_show;

use auto_show;

create table if not exists car_mark (
	id_car_mark	 int(4) auto_increment primary key,
	name varchar(100) not null,
	deleted bit default 0,
	unique key mark_unique_key (name)
);

create table if not exists car_model (
	id_car_model int(7) auto_increment primary key,
	id_car_mark int(4) not null,
	name varchar(100) not null,
	deleted bit default 0,
	unique key model_unique_key  (id_car_mark,name),
	foreign key fk_car_mark(id_car_mark) references car_mark(id_car_mark)
	on delete cascade
);


create table if not exists car_modification (
	id_car_modification int(11) auto_increment primary key,
	id_car_model int(7) not null,
	name varchar(100) not null,
	key modification_key(name),
	deleted bit default 0,
	foreign key fk_car_model(id_car_model) references car_model(id_car_model)
	on delete cascade
);

create table if not exists car_characteristic(
	id_characteristic int(4) auto_increment primary key,
	name varchar(100) not null,
	id_parent int(4),
	key characteristic_key(name),
	foreign key fk_parent(id_parent) references car_characteristic(id_characteristic)
	on delete cascade
);

create table if not exists car_characteristic_value(
	id_car_characteristic_value int(11) auto_increment primary key,
	value varchar(100) not null,
	unit varchar(8),
	id_characteristic int(4) not null,
	id_car_modification int(11) not null,
	unique unique_characteristic_value(id_characteristic,id_car_modification),
	foreign key fk_characteristic(id_characteristic) references car_characteristic(id_characteristic)
	on delete cascade,
	foreign key fk_modification(id_car_modification) references car_modification(id_car_modification)
	on delete cascade
);

create table if not exists merchant(
	id_merchant int(3) auto_increment primary key,
	name varchar(100),
	surname varchar(100),
	patronic varchar(100),
	deleted bit default 0
);

create table if not exists customer(
	id_customer int(7) auto_increment primary key,
	name varchar(100),
	surname varchar(100),
	patronic varchar(100),
	passport_series char(4),
	passport_number char(6),
	birthdate date,
	unique unique_passport(passport_series,passport_number),
	key customer_surname_key (surname)
);

create table if not exists sales(
	id_sale int(11) auto_increment primary key,
	id_car_modification int(11),
	id_customer int(7),
	id_merchant int(3) not null,
	price decimal(11,2) ,
	sale_date timestamp not null default current_timestamp(),
	foreign key fk_modification(id_car_modification) references car_modification(id_car_modification)
	on delete set null,
	foreign key fk_customer(id_customer) references customer(id_customer)
	on delete set NULL,
	foreign key fk_merchant(id_merchant) references merchant(id_merchant)
	on delete restrict
);


create table if not exists store(
	id_store int(11) auto_increment primary key,
	id_car_modification int(11),
	count int(3) unsigned,
	price decimal(11,2),
	testdrive_avaible bit default 0,
	unique unique_car_modification(id_car_modification),
	foreign key fk_modification(id_car_modification) references car_modification(id_car_modification)
	on delete cascade
);

drop trigger if exists after_sales_insert;
drop trigger if exists before_sales_insert;

delimiter $$
create trigger before_sales_insert
	before insert on sales
	for each row begin
	
	set new.price = (select price from store where store.id_car_modification = new.id_car_modification);
END$$

create trigger after_sales_insert
	after insert on sales
	for each row begin
	
	update store set count = count - 1
	where store.id_car_modification = new.id_car_modification;
END$$


delimiter ;

-- add users and grant  privileges
-- drop user motorshowuser@'%';
-- drop user motorshowadmin@'%';

create user motorshowuser@'%' identified by 'motorshow';
create user motorshowadmin@'%' identified by 'motoradmin';

grant ALL on auto_show.* to 'motorshowadmin'@'%';
grant update, insert, select on auto_show.* to 'motorshowuser'@'%';
