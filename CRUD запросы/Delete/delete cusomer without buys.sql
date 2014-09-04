delete from customer 
where customer.id_customer not in (
	select id_customer 
	from sales
	where sale_date>SUBDATE(CURDATE(),365)
);