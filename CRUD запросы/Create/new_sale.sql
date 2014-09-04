-- add customer
insert into customer(name,surname,patronic,passport_series,passport_number,birthdate) 
values('Николай','Шишкин','Олегович','5702','456712',cast('1975-10-25' as date));
-- add new sale
insert into sales(id_car_modification,id_merchant,id_customer)
values(2,1,1);
