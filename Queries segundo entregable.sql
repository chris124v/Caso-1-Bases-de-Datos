use caso1db;

show tables;

-- --------------------------- Llenado de tabla de CurrencyTypes --------------------------- 
select * from AppAssistantCurrencyTypes;

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (1, 'Dolar', 'USD','$');

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (2, 'Euro', 'EUR','€');

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (3, 'Colon', 'CRC','₡');

select * from AppAssistantCountries;

-- --------------------------- Llenado de tabla de Countries --------------------------- 

insert into `caso1db`.`AppAssistantCountries`  values (1, 'Costa Rica', 'ES', 3),
													  (2, 'United States', 'EN', 1),
                                                      (3, 'France', 'FR', 2);

-- --------------------------- Llenado de tabla de Users mediante procedimiento --------------------------- 

DROP PROCEDURE FillUsers;
DELIMITER //

CREATE PROCEDURE FillUsers()
BEGIN
	SET @countUsers = 50;

	WHILE @countUsers > 0 DO

		-- Declarar la variable para almacenar la fecha aleatoria
		SET @birthdate = NULL;
		-- Generar una fecha y hora aleatoria dentro del rango especificado
		SET @birthdate = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 40) YEAR); -- Fecha aleatoria en los últimos 40 años



		SET @nombre = NULL;
		SET @lastname = NULL;
        SET @email = NULL;
        SET @countryId = NULL;
		SET @typeEmail= NULL;
        SET @pass_word = FLOOR(1 + RAND() * 1000000);
        SET @countryId = FLOOR(1 + RAND() * 3);
		SELECT ELT(FLOOR(1 + RAND() * 10), 'Andres', 'Christopher', 'Carlos', 'Ariel', 'Diego', 'Rodrigo', 'Luis', 'Jose', 'Adrian', 'Juan') INTO @nombre;
		SELECT ELT(FLOOR(1 + RAND() * 10), 'Baldi', 'Mora', 'Venegas', 'Rodriguez', 'Vargas', 'Abarca', 'Cespedes', 'Castillo', 'Sanches', 'Hernandez','Benavides') INTO @lastname;
		SELECT ELT(FLOOR(1 + RAND() * 5), '@gmail.com', '@hotmail.com', '@yahoo.es', '@outlook.es', 'outlook.com') INTO @typeEmail;
		
        SET @email = CONCAT(LOWER(@nombre), '.', LOWER(@lastname), @pass_word,  @typeEmail);
        
        
		INSERT INTO AppAssistantUsers(email, firstname, lastname, birthdate, `role`, `password`, `enabled`, CountryId)
		VALUES (@email, @nombre, @lastname, @birthdate, 1, @pass_word, 1, @countryId);
		
        
		SET @countUsers = @countUsers - 1;
	END WHILE ;
END //

DELIMITER ;

call FillUsers();

select * from AppAssistantUsers;

-- --------------------------- Llenado de tabla de Suscriptions --------------------------- 

insert into `caso1db`.`AppAssistantSuscriptions` (`name`, `description`, `enable`)  
values ('Basic', 'Este es el plan básico, solamente se puede hacer una grabación de una tarea. Se pueden visualizar diferentes tareas ya cargadas. Acceso limitado a la inteligencia artificial.', 1);

insert into `caso1db`.`AppAssistantSuscriptions` (`name`, `description`, `enable`)  
values ('Extra', 'Conversación limitada a 60 minutos con la IA. Capacidad de grabación de 10 tareas.', 1);

insert into `caso1db`.`AppAssistantSuscriptions` (`name`, `description`, `enable`)  
values ('Premium', 'Plan ilimitado para grabación de tareas y conversación con la IA. ', 1);

select * from AppAssistantSuscriptions;

-- --------------------------- Llenado de tabla de SuscriptionPrices --------------------------- 

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionId, CurrencyTypeId)  
values (0.99, '2023-01-01 00:00:00', '2026-01-01 00:00:00', '2025-01-02 00:00:00', 1, 3);

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionId, CurrencyTypeId)  
values (4.99, '2023-01-01 00:00:00', '2026-01-01 00:00:00', '2025-01-02 00:00:00', 2, 3);

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionId, CurrencyTypeId)  
values (19.99, '2023-01-01 00:00:00', '2026-01-01 00:00:00', '2025-01-02 00:00:00', 3, 3);

select * from AppAssitantSuscriptionPrices;

-- --------------------------- Llenado de tabla de PlanFeatures --------------------------- 

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (1, 'Una grabacion', 1, 'Tareas');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (2, 'Una sola interaccion con la IA', 1, 'Interacciones IA');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (3, 'Se pueden ver todas las tareas', 1, 'Tareas');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (4, '20 grabaciones', 1, 'Tareas');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (5, '60 minutos de interaccion con IA', 1, 'Interacciones IA');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (6, 'Acceso ilimitado a grabacion de tareas', 1, 'Tareas');

insert into `caso1db`.`AppAssitantPlanFeatures` 
values (7, 'Acceso ilimitado a la IA', 1, 'Interacciones IA');

select * from AppAssitantPlanFeatures;


-- --------------------------- Llenado de tabla de FeaturePerPlan --------------------------- 

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (1, '500MB de grabaciones', 1, 1, 1);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (2, '1 token', 1, 2, 1);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (3, 'Acceso ilimitado tareas', 1, 3, 1);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (4, '10GB de grabaciones', 1, 4, 2);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (5, 'Tokens ilimitados durante 1 hora', 1, 5, 2);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (6, '1TB de grabaciones', 1, 6, 3);

insert into `caso1db`.`AppAssitantFeaturePerPlan` 
values (7, 'Tokens ilimitados', 1, 7, 3);

select * from AppAssitantFeaturePerPlan;


-- --------------------------- Llenado de tabla de SuscriptionUser mediante procedimiento --------------------------- 

DROP PROCEDURE FillSuscriptionUser;
DELIMITER //

CREATE PROCEDURE FillSuscriptionUser()
BEGIN
	SET @SuscriptionCounter = 150;

	WHILE @SuscriptionCounter > 0 DO

		-- Generar una fecha y hora aleatoria dentro del rango especificado
		set @startDate = DATE_ADD('2023-01-01 00:00:00', INTERVAL floor(rand() * 3) YEAR);
        set @startDate = DATE_ADD(@startDate, INTERVAL floor(1 + rand() * 12) month);
		set @startDate = DATE_ADD(@startDate, INTERVAL floor(1 + rand() * DAY(LAST_DAY(@startDate))) day);
		set @startDate = DATE_ADD(@startDate, INTERVAL floor(rand() * 24) hour);
		set @startDate = DATE_ADD(@startDate, INTERVAL floor(rand() * 60) minute);
		set @startDate = DATE_ADD(@startDate, INTERVAL floor(rand() * 60) second);
        
		set @endDate = DATE_ADD(@startDate, INTERVAL floor(1 + rand() * 12) month);
		set @endDate = DATE_ADD(@endDate, INTERVAL floor(1 + rand() * DAY(LAST_DAY(@endDate))) day);
		set @endDate = DATE_ADD(@endDate, INTERVAL floor(rand() * 24) hour);
		set @endDate = DATE_ADD(@endDate, INTERVAL floor(rand() * 60) minute);
		set @endDate = DATE_ADD(@endDate, INTERVAL floor(rand() * 60) second);
        
		SET @UserId = FLOOR(81 + RAND() * 50); -- Genera un numero aleatorio entre 81 y 130;
        SET @SuscriptionPricesId = FLOOR(4 + RAND() * 3);
        SET @`Enable` = FLOOR(RAND() * 2);
        
        
		INSERT INTO AppAssitantSuscriptionUser(UserId, SuscriptionPricesId, `enable`, startDate, endDate)
		VALUES (@UserId, @SuscriptionPricesId, @`Enable`, @startDate, @endDate);
		
        
		SET @SuscriptionCounter = @SuscriptionCounter - 1;
	END WHILE ;
END //

DELIMITER ;

call FillSuscriptionUser();

select * from AppAssitantSuscriptionUser;
-- ----------------------------------------------------------------------------------------------------------------
-- listar todos los usuarios de la plataforma que esten activos con su nombre completo, email, país de procedencia, 
-- y el total de cuánto han pagado en subscripciones desde el 2024 hasta el día de hoy, 
-- dicho monto debe ser en colones (20+ registros)

-- Hay que actualizar dos nombres de tablas que estan mal escritos para evitar problemas a futuro
-- Hay que llenar las tablas de currency exchange para realizar el tipo de cambio dependiendo del pais

select firstname, lastname, email, AppAssistantCountries.`name`, amount
from AppAssistantUsers, AppAssitantSuscriptionUser, AppAssitantSuscriptionPrices, AppAssistantCountries
inner join AppAssistantCountries on AppAssistantUsers.CountryId = AppAssistantCountries.CountryId
where AppAssitantSuscriptionUser.`enable` = 1 and AppAssitantSuscriptionUser.startDate between '2024-01-01' and now();







