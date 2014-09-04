
start transaction;
DELIMITER $$
 DROP PROCEDURE IF EXISTS fillDataBase$$
 CREATE PROCEDURE fillDataBase()
	BEGIN
		DECLARE markCount  INT;
		DECLARE mark  varchar(255);
		DECLARE model varchar(255);
		DECLARE modif varchar(255);
		DECLARE modelCount INT;
		DECLARE testDriveAvaibleValue BIT;
		DECLARE modifCount INT;
		DECLARE charCount INT;
		DECLARE maxCharCount INT;
		SET markCount = 1;
		SET mark = 'Mark ';
		SET model = 'Model';
		SET modif = 'Modif';
		SET maxCharCount = (select count(*) from car_characteristic);
			
		
		
		
		WHILE markCount  <= 5 DO
			-- add car mark
			insert into car_mark(name) 
			values(CONCAT(mark,markCount));

			SET markCount = markCount + 1;
			
			SET @new_mark_id = LAST_INSERT_ID(); 
			SET modelCount = 1;

			WHILE modelCount <= 5 DO
				-- Add new model for Audi 
				insert into car_model(id_car_mark,name)
				values(@new_mark_id,CONCAT(model,modelCount));

				SET modelCount = modelCount + 1;
				
				SET @new_model_id = LAST_INSERT_ID(); 
				
				SET modifCount = 1;
				WHILE modifCount <= 5 DO
					-- add modification
					insert into car_modification(id_car_model,name)
					values(@new_model_id,CONCAT(modif,modifCount));

					SET @new_modif_id = LAST_INSERT_ID();
					
					IF modifCount < 2 
						THEN SET testDriveAvaibleValue = 1;
						ELSE SET testDriveAvaibleValue = 0;
					END IF;
					
					insert into store(id_car_modification,count,price,testdrive_avaible)
					values(@new_modif_id,2,1231231.2,testDriveAvaibleValue);
					
					SET modifCount = modifCount + 1;
					
					SET charCount = 1;
					WHILE charCount <= maxCharCount DO
						insert into car_characteristic_value(value,unit,id_characteristic,id_car_modification)
						values(CONCAT('Charect ',charCount),NULL,charCount,@new_modif_id);
						SET charCount = charCount + 1;
					END WHILE;
				END WHILE;
			END WHILE;
		END WHILE;
	END$$
DELIMITER ;    



DELIMITER $$
 DROP PROCEDURE IF EXISTS fillDataBaseCustomer$$
 CREATE PROCEDURE fillDataBaseCustomer()
	BEGIN
		DECLARE customerCount INT;
		set customerCount = 100;
		
		WHILE customerCount  <= 200 DO
			insert into customer(name,surname,patronic,passport_series,passport_number,birthdate)
			values(CONCAT('Name ',customerCount),CONCAT('SurName ',customerCount),CONCAT('Patronic ',customerCount),concat('9',cast(customerCount as char(3))),concat(cast(customerCount as char(3)),cast(customerCount as char(3))),curdate());
			set customerCount = customerCount + 1;
		END WHILE;
	END$$
DELIMITER ;    



DELIMITER $$
 DROP PROCEDURE IF EXISTS fillDataBaseSales$$
 CREATE PROCEDURE fillDataBaseSales()
	BEGIN
		DECLARE step INT;
		DECLARE customerRnd INT;
		DECLARE merchantRnd INT;
		DECLARE modifRnd INT;
		DECLARE modifCount INT;

		set step = 1;
		set modifCount = (select count(*) from car_modification);

		WHILE step  <= 100 DO
			
			set customerRnd = ROUND(RAND()*100) ;
			set merchantRnd = ROUND(RAND())+1;
			set modifRnd = ROUND(RAND()*125)+1;


			insert into sales(id_car_modification,id_merchant,id_customer)
			values(modifRnd,merchantRnd,customerRnd);



			set step = step + 1;
		END WHILE;
	END$$
DELIMITER ;    
commit;


start transaction;
	call fillDataBase();
	call fillDataBaseCustomer();
	call fillDataBaseSales();
commit;