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
	car_mark
inner join car_model 
	on car_model.id_car_mark = car_mark.id_car_mark
inner join car_modification
	on car_modification.id_car_model = car_model.id_car_model
left join car_characteristic_value 
	on car_characteristic_value.id_car_modification = car_modification.id_car_modification
left join car_characteristic
	on car_characteristic.id_characteristic = car_characteristic_value.id_characteristic
left join store
	on store.id_car_modification = car_modification.id_car_modification
where car_mark.deleted=0 and car_model.deleted=0 and car_modification.deleted = 0
order by mark_name,model_name,modification_name,car_characteristic.id_characteristic
limit 0,2000