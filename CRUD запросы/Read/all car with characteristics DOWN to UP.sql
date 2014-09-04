select 
	car_mark.name as mark_name,
	car_model.name as model_name,
	car_modification.id_car_modification as modification_id,
	car_modification.name as modification_name,
	car_characteristic.name as characteristic_name,
	car_characteristic_value.value as charecteristicValue,
	store.price as price_for_each,
	store.count as count
from 
	car_modification
left join car_characteristic_value 
	on car_characteristic_value.id_car_modification = car_modification.id_car_modification
inner join car_model 
	on car_model.id_car_model = car_modification.id_car_model
inner join car_mark
	on car_model.id_car_mark = car_mark.id_car_mark
left join car_characteristic
	on car_characteristic.id_characteristic = car_characteristic_value.id_characteristic
left join store
	on store.id_car_modification = car_modification.id_car_modification
limit 0,2000
