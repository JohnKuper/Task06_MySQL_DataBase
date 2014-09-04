/* Delete all cars with 'deleted' equals '1' and which are not included in 'store' and 'sales' */

delete from car_mark 
where deleted = 1 and id_car_mark in (
	select distinct id_car_mark
	from car_model
	inner join car_modification	
		on car_modification.id_car_model = car_model.id_car_model
	left join sales	
		on sales.id_car_modification = car_modification.id_car_modification
	left join store	
		on store.id_car_modification = car_modification.id_car_modification
	where sales.id_sale is null and store.id_store is null
)