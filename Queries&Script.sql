use caso1db;

-- --------------------------- Llenado de tabla de CurrencyTypes --------------------------- 
select * from AppAssistantCurrencyTypes;

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (1, 'Dolar', 'USD','$');

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (2, 'Euro', 'EUR','€');

insert into `caso1db`.`AppAssistantCurrencyTypes`  values (3, 'Colon', 'CRC','₡');


-- --------------------------- Llenado de tabla de Countries --------------------------- 

select * from AppAssistantCountries;

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

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionsId, CurrencyTypeId)  
values (0.99, '2023-01-01 00:00:00', '2026-01-01 00:00:00', '2025-01-02 00:00:00', 1, 3);

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionsId, CurrencyTypeId)  
values (4.99, '2023-01-01 00:00:00', '2026-01-01 00:00:00', '2025-01-02 00:00:00', 2, 3);

insert into `caso1db`.`AppAssitantSuscriptionPrices` (`amount`, `postTime`, `endDate` , `update`, SuscriptionsId, CurrencyTypeId)  
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
        
		SET @UserId = FLOOR(1 + RAND() * 50); -- Genera un numero aleatorio entre 81 y 130;
        SET @SuscriptionPricesId = FLOOR(1 + RAND() * 3);
        SET @`Enable` = FLOOR(RAND() * 2);
        
        
		INSERT INTO AppAssitantSuscriptionUser(UserId, SuscriptionPricesId, `enable`, startDate, endDate)
		VALUES (@UserId, @SuscriptionPricesId, @`Enable`, @startDate, @endDate);
		
        
		SET @SuscriptionCounter = @SuscriptionCounter - 1;
	END WHILE ;
END //

DELIMITER ;

call FillSuscriptionUser();

select * from AppAssitantSuscriptionUser;

------------------------ Llenado de Currency Exchanges ------------------------------------

select * from AppAssitantCurrencyExchanges;

insert into `caso1db`.`AppAssitantCurrencyExchanges` 
(`startDate`, `endDate`, `exchangeRate`, `enable`, `currentExchangeRate`, `CurrencyTypeId`) 
VALUES 
('2024-01-01 00:00:00', '2024-04-01 00:00:00', 540.25, 1, 1, 1),
('2024-04-02 00:00:00', '2024-07-01 00:00:00', 545.75, 1, 0, 1),
('2024-07-02 00:00:00', '2024-12-31 23:59:59', 550.50, 1, 0, 1);

insert into `caso1db`.`AppAssitantCurrencyExchanges` 
(`startDate`, `endDate`, `exchangeRate`, `enable`, `currentExchangeRate`, `CurrencyTypeId`) 
VALUES 
('2024-01-01 00:00:00', '2024-04-01 00:00:00', 585.35, 1, 1, 2),
('2024-04-02 00:00:00', '2024-07-01 00:00:00', 590.80, 1, 0, 2),
('2024-07-02 00:00:00', '2024-12-31 23:59:59', 595.40, 1, 0, 2);

insert into `caso1db`.`AppAssitantCurrencyExchanges` 
(`startDate`, `endDate`, `exchangeRate`, `enable`, `currentExchangeRate`, `CurrencyTypeId`) 
VALUES 
('2024-01-01 00:00:00', '2024-12-31 23:59:59', 1.00, 1, 1, 3);

-- -------------- 4.1 Listado de Usuarios con Cantidad Pagada ----------------------

SELECT firstname, lastname, email, name AS country_name,  SUM(amount * exchangeRate) AS total_paid_in_colones
FROM  AppAssistantUsers
INNER JOIN AppAssistantCountries ON AppAssistantUsers.CountryId = AppAssistantCountries.CountryId
INNER JOIN AppAssitantSuscriptionUser ON AppAssistantUsers.UserId = AppAssitantSuscriptionUser.UserId
INNER JOIN AppAssitantSuscriptionPrices ON AppAssitantSuscriptionUser.SuscriptionPricesId = AppAssitantSuscriptionPrices.SuscriptionPricesId
INNER JOIN AppAssitantCurrencyExchanges ON AppAssitantCurrencyExchanges.CurrencyTypeId = AppAssitantSuscriptionPrices.CurrencyTypeId 
AND AppAssitantCurrencyExchanges.currentExchangeRate = 1
WHERE AppAssitantSuscriptionUser.enable = 1 AND AppAssitantSuscriptionUser.startDate BETWEEN '2024-01-01' AND NOW()
GROUP BY firstname, lastname, email, name
ORDER BY total_paid_in_colones DESC;

-- ---------------------------------------------------------------------------------- 

-- ---------------- 4.2 Listado Personas a 15 dias de pagar -------------------------

SELECT AppAssistantUsers.firstname, AppAssistantUsers.lastname, 
	   AppAssistantUsers.email, AppAssitantSuscriptionUser.endDate AS fecha_vencimiento,
	   DATEDIFF(AppAssitantSuscriptionUser.endDate, NOW()) AS dias_restantes
FROM AppAssistantUsers
INNER JOIN AppAssitantSuscriptionUser ON AppAssistantUsers.UserId = AppAssitantSuscriptionUser.UserId
WHERE AppAssitantSuscriptionUser.enable = 1 AND DATEDIFF(AppAssitantSuscriptionUser.endDate, NOW()) BETWEEN 0 AND 15
ORDER BY dias_restantes ASC;

-- ---------------------------------------------------------------------------------- 

-- ------------------ Llenado tablas de Logs Externas ---------------------------

select * from AppAssistantLogSeverities;

insert into `caso1db`. `AppAssistantLogSeverities`  VALUES (1, 'Debug'), (2, 'Information'), (3, 'Warning'), (4, 'Error'), (5, 'Critical'), (6, 'Fatal');

select * from AppAssistantLogTypes;

insert into `caso1db`. `AppAssistantLogTypes` VALUES (1, 'Login'), (2, 'Logout'), (3, 'Data Access'), (4, 'System Error'), (5, 'User Action'), (6,'Configuration Change');

select * from AppAssitantLogSources;

insert into `caso1db`. `AppAssitantLogSources` VALUES (1, 'Web App'), (2, 'Mobile App'), (3, 'Databse');

-- -------------------- Procedure Tabla Logs --------------------------------------------

DROP PROCEDURE FillLogs;
DELIMITER //

CREATE PROCEDURE FillLogs()
BEGIN

    SET @countLogs = 250; 
    
    WHILE @countLogs > 0 DO
        SET @postTime = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY); -- Logs de los últimos 180 días
        SET @postTime = DATE_ADD(@postTime, INTERVAL FLOOR(RAND() * 24) HOUR);
        SET @postTime = DATE_ADD(@postTime, INTERVAL FLOOR(RAND() * 60) MINUTE);
        SET @postTime = DATE_ADD(@postTime, INTERVAL FLOOR(RAND() * 60) SECOND);
        
        -- Generar una descripción aleatoria
        SELECT ELT(FLOOR(1 + RAND() * 10), 'Usuario inicio sesion', 'Usuario cerro sesion', 'Intento fallido de inicio de sesion', 
            'Cambio de configuracion', 'Archivo subido', 'Nueva suscripcion activada', 
            'Error al procesar pago', 'Usuario modificó su perfil', 
            'Conversación con IA iniciada', 
            'Tarea finalizada') INTO @`description`;
        
        -- Valores aleatorios para otros campos
        SET @computer = CONCAT('PC-', FLOOR(100 + RAND() * 900)); -- Nombre aleatorio de computadora
        SELECT ELT(FLOOR(1 + RAND() * 7), 'admin', 'sistema', 'app', 'api', 'cliente', 'web', 'movil') INTO @userName;
        SET @trace = CONCAT('trace-', UUID());
        SET @referenceId1 = FLOOR(1 + RAND() * 1000);
        SET @referenceId2 = FLOOR(1 + RAND() * 1000);
        SELECT ELT(FLOOR(1 + RAND() * 5), 'success', 'pending', 'processing', 'completed', 'failed') INTO @value1;
        SELECT ELT(FLOOR(1 + RAND() * 5), 'high', 'medium', 'low', 'normal', 'urgent') INTO @value2;
        SET @`checkSum` = CONCAT('checksum-', UUID());
        
        SET @LogTypeId = FLOOR(1 + RAND() * 6); -- Asumiendo que tienes 6 tipos
        SET @LogSourceId = FLOOR(1 + RAND() * 3); -- Asumiendo que tienes 6 fuentes
        SET @LogSeverityId = FLOOR(1 + RAND() * 6); -- Asumiendo que tienes 6 severidades
        SET @TransactionId = NULL; -- Un valor fijo para evitar problemas con claves foráneas
        SET @UserId = FLOOR(1 + RAND() * 50); -- Asumiendo que tienes 50 usuarios
        
        INSERT INTO AppAssistantLogs(`description`, postTime, computer, userName, trace, referenceId1, referenceId2, 
							value1, value2, `checkSum`, LogTypeId, LogSourceId, LogSeverityId, TransactionId, UserId) 
		VALUES (@`description`, @postTime,  @computer, @userName, @trace, @referenceId1, @referenceId2, @value1, @value2, 
            @`checkSum`, @LogTypeId, @LogSourceId, @LogSeverityId, @TransactionId, @UserId);
        
        SET @countLogs = @countLogs - 1;
        
    END WHILE;
END //

DELIMITER ;

call FillLogs();

select * from AppAssistantLogs;

-- ---------------------- 4.3.1 Ranking Top 15 Usuarios de Mas Uso -----------------------------------------------

(SELECT AppAssistantUsers.UserId, AppAssistantUsers.firstname, AppAssistantUsers.lastname, AppAssistantUsers.email,
		COUNT(AppAssistantLogs.LogId) AS total_logs
FROM AppAssistantUsers
INNER JOIN AppAssistantLogs ON AppAssistantUsers.UserId = AppAssistantLogs.UserId
WHERE AppAssistantUsers.enabled = 1
GROUP BY  AppAssistantUsers.UserId, AppAssistantUsers.firstname, AppAssistantUsers.lastname, AppAssistantUsers.email
ORDER BY total_logs DESC
LIMIT 15);

-- ---------------------- 4.3.2 Ranking Top 15 Usuarios de Menos Uso -----------------------------------------------

(SELECT AppAssistantUsers.UserId, AppAssistantUsers.firstname, AppAssistantUsers.lastname, AppAssistantUsers.email,
		COUNT(AppAssistantLogs.LogId) AS total_logs
FROM AppAssistantUsers
INNER JOIN AppAssistantLogs ON AppAssistantUsers.UserId = AppAssistantLogs.UserId
WHERE AppAssistantUsers.enabled = 1
GROUP BY  AppAssistantUsers.UserId, AppAssistantUsers.firstname, AppAssistantUsers.lastname, AppAssistantUsers.email
ORDER BY total_logs ASC
LIMIT 15);



-- Inserciones a AppAssistantFileTypes
INSERT INTO AppAssistantFileTypes (`name`, mimeType, icon, enabled)
VALUES ('MP4 File', 'mp4', 'mp4-icon.png', 1),
	   ('MP3 File', 'mp3', 'mp3-icon.png', 1),
       ('WAV File', 'wav', 'wav-icon.png', 1),
       ('WebM Video', 'webm', 'WebM-icon.png', 1);
       
-- Inserciones a AppAssistantFiles mediante procedimiento
DROP PROCEDURE FillAppAssistantFiles;
DELIMITER //

CREATE PROCEDURE FillAppAssistantFiles()
BEGIN
	SET @FileCounter = 200;

	WHILE @FileCounter > 0 DO
        
        SET @UserId = FLOOR(81 + RAND() * 50);
        SET @FileTypeId = FLOOR(1 + RAND() * 4);
        SET @fileName = NULL;
        SET @userName = CONCAT(
		(SELECT firstname FROM AppAssistantUsers WHERE UserId = @UserId),'_',
		(SELECT lastname FROM AppAssistantUsers WHERE UserId = @UserId));
        
        SET @fileName = CONCAT(@userName, 'File');
        
        SET @`description` = concat('This is the file of the user: ',@userName);
        SET @fileURL = concat('https://AppAssistantFiles/Files/User/',@userName, '/', @fileName);
        
        -- Generar una fecha y hora aleatoria dentro del rango especificado
		set @creationDate = DATE_ADD('2023-01-01 00:00:00', INTERVAL floor(rand() * 2) YEAR);
        set @creationDate = DATE_ADD(@creationDate, INTERVAL floor(1 + rand() * 12) month);
		set @creationDate = DATE_ADD(@creationDate, INTERVAL floor(1 + rand() * DAY(LAST_DAY(@creationDate))) day);
		set @creationDate = DATE_ADD(@creationDate, INTERVAL floor(rand() * 24) hour);
		set @creationDate = DATE_ADD(@creationDate, INTERVAL floor(rand() * 60) minute);
		set @creationDate = DATE_ADD(@creationDate, INTERVAL floor(rand() * 60) second);
        
        SET @mimeType = NULL;
        SELECT mimeType INTO @mimeType FROM AppAssistantFileTypes WHERE FileTypeId = @FileTypeId;
        
        SET @fileSize = FLOOR(100000 + RAND() * 100000000);
        
		INSERT INTO AppAssistantFiles (fileName, `description`, fileURL, deleted, lastupdated, creation, fileSize, mimeType, UserId, FileTypeId)
		VALUES (@fileName, @`description`, @fileURL, 0, @creationDate , @creationDate, @fileSize, @mimeType, @UserId, @FileTypeId);
		
        
		SET @FileCounter = @FileCounter - 1;
	END WHILE ;
END //

DELIMITER ;

call FillAppAssistantFiles();

select * from AppAssistantFiles;


-- Inserciones a AppAssistantWebHookEventTypes

insert into AppAssistantWebHookEventTypes values (1, 'recording.started'), 
(2, 'recording.completed'), 
(3, 'recording.processed'), 
(4, 'recording.failed');

-- Inserciones a AppAssistantFiles mediante procedimiento

DROP PROCEDURE FillWebHookEventData;
DELIMITER //

CREATE PROCEDURE FillWebHookEventData()
BEGIN
	SET @WebHookCounter = 300;

	WHILE @WebHookCounter > 0 DO
        
        SET @TeamId = FLOOR(1000000 + RAND() * 100000000);
        SET @FileId = FLOOR(1 + RAND() * 200);
        SET @fileName = CONCAT(
		(SELECT filename FROM AppAssistantFiles WHERE FileId = @FileId));
        
        SET @Duration = FLOOR(1 + RAND() * 3600);
        SET @fileURL = concat('https://screenapp.io/recording/',@fileName);
        SET @`status` = null;
        SELECT ELT(FLOOR(1 + RAND() * 3), 'Successful', 'Failed', 'Pending') INTO @`status`;
		
        SET @WebHookEventTypeId = FLOOR(1 + rand() * 4);
        
        
		INSERT INTO AppAssistantWebHookEventsData (teamId, url, duration, `status`, WebHookEventTypeId, FileId)
		VALUES (@TeamId, @fileURL, @Duration, @`status`, @WebHookEventTypeId, @FileId);
		
        
		SET @WebHookCounter = @WebHookCounter - 1;
	END WHILE ;
END //

DELIMITER ;

call FillWebHookEventData();

select * from AppAssistantWebHookEventsData;


DELIMITER ;
