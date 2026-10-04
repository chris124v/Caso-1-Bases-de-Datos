# Caso #1 App Assistant

## Integrantes
- Christopher Daniel Vargas Villata, 2024108443
- Andres Baldi Mora, 2024088934

### Lista de Entidades
Importante mencionar que en el modelo relacional o en este caso fisico de nuestra base de datos, usaremos un titulo para cada entidad que es AppAssistant.

1. Users
2. Permissions
3. Roles
    1. RolePerUser
    2. RolePermissions
4. Payments
    1. PaymentErrors
    2. DataPayments
    3. PaymentMethods
5. Address
    1.UserAddress
6. Files
7. FileType
8. Transactions
    1. TransactionTypes
    2. TransactionsSubTypes
9. CurrencyTypes
    1.CurrencyExchanges
10. Countries
11. Cities
12. States
13. Languages
    1.LanguagesPerCountry
15. RolesPermissions
16. Logs
    1. LogTypes 
    2. LogSeverities 
    3. LogSources
17. Subscriptions
    1. SuscriptionPrices
    2. FeaturesPerPlan
    3. PlanFeatures
    4. SuscriptionUser
    5. SuscriptionSchedules
18. Translations
19. Schedules
    1. ScheduleDetails

### Entidades Tablas IA

1. WebHookEventTypes
    1. WebHookEventsData
3. Prompts
4. MediaAnalysisOptions
5. TranscriptSegments
6. FileUploadAPIRequests
7. FileUploadApiResponses
8. APIRequests
9. APIResponses
10. Tasks
    1. TaskSteps
12. ScreenRecordings
13. ScreenRecordingMouse
14. MouseEvents
15. LiveChatSession
    1. LiveChatSteps
16. AIConversation
17. AIMessages
18. VoiceCommands

  ***

### *Justificación Diseño* 

En este caso optamos por un diseño basándonos en el listado de identidades presentado anteriormente, los cuales cumplen con los requerimientos del app assistant. Siendo esto asi intentamos establecer relaciones propias entre entidades y sus funcionalidad, por ejemplo en el caso de los usuarios nos aseguramos que estos fuesen conectados con la mayoría de identidades dado a la relevancia del usuario en la propia app, un ejemplo de esto podría el hecho de “users” estando presente tanto en la configuración del pago, pago o intento del mismo y finalmente las transacciones que incluyen todos los tipos de transacciones que se podría llegar a realizar en la app, etso incluyendo devoluciones, compras y demás. Resulta importante mencionar que tanto los roles como permisos están directamente asociados con el usuario. En el siguiente apartado mencionaremos las entidades más importantes del diseño del app asistente y el porqué de sus datos. 

#### Users
En el caso de “user” optamos por un diseño simple que abarque los datos de la persona como nombre, apellido, contacto y dirección, esto ademas de campos importantes para relaciones como rol del usuario y un password con un tipo de dato VARBINARY que nos permite cifrar la contraseña de cada usuario para asegurar la seguridad del mismo. Importante mencionar la relacion con las suscripciones mediante una tabla llamada "SuscriptionUser" que nos permite definir el plan del usuario, fecha de adquisicion, monto a pagar y demas aspectos.

#### Files
En el caso de archivos o tareas se presentan dos tablas para la misma entidad, una de ellas corresponde al tipo de archivo para verificar que sea permitido, como podrían ser png, mp4, mp3 y demás tipos de archivos. Posteriormente en la tabla principal de tareas los conectamos con los usuarios para que estos sean capaces de insertar y borrar archivos esto ya dependiendo de su rol. Esto además de un URL que nos permite almacenar estos archivos en un almacenamiento físico externo, asimismo añadimos un dato de “MIME” que nos permite distinguir los distintos formatos o tipos de archivos por su extensión. 

#### Roles & Permissions
En el caso de estas dos entidades sumamente relacionadas tomamos un enfoque que fuese desde lo mas pequeño a los mas grande, esto por ejemplo con la tabla de "permissions" en donde se encuentra un listado general de todo lo que se puede hacer en la app incluyendo permisos tanto de admin como de cualquier otra persona o usuario. Posteriormente este listado se disminuye estableciendo una tabla intermedia llamada "RolePermissions" en donde se asigna el permiso especifico a cada rol existente, esto claramente ya exitiendo la tabla "Roles" que define el listado de roles posibles en la app, esto permite una distribucion adecuada y pertinente segun cada rol. Asimismo para asignar uno o mas roles por usuario se define la tabla de "RolesPerUser" permitiendonos asi definir varios roles para varios usuarios o simplemente distribuirlos de una forma mas eficiente. 

#### Transactions and Payments
En estos dos apartados sumamente relacionados decidimos dividirlo en diversas estructuras, primeramente teniendo métodos de pago en donde se da un listado de los posibles métodos de pago y si estos están activos, como podría ser PayPal, CashApp, Sinpe, Tarjeta o demás métodos. Por otra parte está la tabla de Data Payments, en este caso tomamos en cuenta el método de pago y usamos una masked account junto con tokens que nos permiten cifrar la cuenta del usuario y realizar dicho pago desde un tercero o una API en este caso para no almacenar datos cuentas bancarias de usuarios, es por esto mismo que no resulta necesario un apartado de balances o algo similar. Posteriormente en la tabla principal de pagos existen una diversidad de datos que incluyen: resultados, errores, autenticación, token, referencia de pago, usuario, total del pago y checksum, este último para la validación de respaldos y mayor seguridad. 
En el caso de transacciones esta es una de las tablas vitales del diseño del “App Assistant” esto dado a que toma en cuenta la mayoría de aspectos del sistema incluyendo: usuarios, pagos, métodos de pago, tipos de transacciones, moneda de pago, conversión de moneda de pago, tiempo de la transacción y demás. La unificación de esta tabla con las mencionadas anteriormente permite al usuario realizar una transacción ya sea para una devolución, pago, reclamo o demás aspectos, portando así los requerimientos para la seguridad del sistema además de su registro en logs para tener un historial organizado. 

#### Schedules & Suscriptions
En este apartado suscriptions ofrece un total de 3 planes, cada uno de ellos con sus propios features, basicamente para obtener una buena subdivision del apartado de suscriptions existen 3 tablas: FeaturePerPlan, PlanFeatures, SuscriptionPrices. La de PlanFeatures lo que hace es un listado de todos los beneficios que existen independientemente del plan, para esta parte se encarga FeaturePerPlan la cual logra establecer o dividir cada uno de los beneficios entre los planes existentes. Posteriormente la tabla de SuscriptionPrices establece el precio a pagar por cada plan en una moneda en espeficio y lo relaciona a la tabla principal de suscriptions con una llave foranea para asi establecer un precio a cada plan. 
En lo que se refiere a schedules implementamos dos tablas, una que establece el nombre de lo que se va a calendarizar junto con la repeticion que tiene que suceder y un endType, luego la otra tabla de ScheduleDetails como el mismo nombre lo dice tiene aspectos mas especificos como podria ser el dia de ejecucion, un dato deleted en caso de que se tenga de desactivar y finalmente un dia base del dia que se creo el calendario como tal. Schedules tambien permite establecer una conexion efectiva con suscriptions en la tabla llamada "SuscriptionSchedules" que calendariza los pago de los planes y definir si estan activos o no dependiendo de si se han pagado o no.

#### Logs 
Este apartado de Logs lo que permite es llevar un registro de todo lo que sucede en nuestra app, esto siendo desde inicios de sesion, procesos completados, archivos subidos y demas. Para complementar esta tabla de Logs hay tres tablas externas que permiten establecer cuales son los procesos a registrar. Primeramente "LogTypes" establece como lo dice su nombre los tipos de procesos como mencione anteriormente: inicios de sesion, log outs, archivos subidos y demas. Posteriormente tenemos LogSources que define de donde vienen dichos registros, esto podria ser desde la app, base de datos, admin, web. Y finalmente LogSeverities que define el nivel de importancia del registro, como si fuese un pago que es algo importante o si es solo el cambio de algo pequeño se establece como "information". Al poseer todos estos datos mediante logs se puede determinar de donde viene el registro, el usuario, un valor referencial, un value que dicta lo que logro y un trace que define que se hizo. 

---

## Queries & Script

En este apartado se realizara una explicacion de los queries realizados, abarcando del punto 4.1 al 4.4. En este caso nos enfocaremos en simplemente poner el script del query y posteriormente una tabla con los datos pertinentes de la consulta. Importante mencionar que el llenado de tablas anterior a los queries se encuentra en el archivo "Queries&Script.sql", aqui simplemente esta el script de las consultas.

#### 4.1  Listar todos los usuarios de la plataforma que esten activos con su nombre completo, email, país de procedencia, y el total de cuánto han pagado en subscripciones desde el 2024 hasta el día de hoy, dicho monto debe ser en colones (20+ registros)

#### Consulta
```sql
SELECT firstname, lastname, email, name AS country_name, SUM(amount * exchangeRate) AS total_paid_in_colones
FROM AppAssistantUsers
INNER JOIN AppAssistantCountries ON AppAssistantUsers.CountryId = AppAssistantCountries.CountryId
INNER JOIN AppAssitantSuscriptionUser ON AppAssistantUsers.UserId = AppAssitantSuscriptionUser.UserId
INNER JOIN AppAssitantSuscriptionPrices ON AppAssitantSuscriptionUser.SuscriptionPricesId = 
    AppAssitantSuscriptionPrices.SuscriptionPricesId
INNER JOIN AppAssitantCurrencyExchanges ON AppAssitantCurrencyExchanges.CurrencyTypeId = 
    AppAssitantSuscriptionPrices.CurrencyTypeId
AND AppAssitantCurrencyExchanges.currentExchangeRate = 1
WHERE AppAssitantSuscriptionUser.enable = 1 AND AppAssitantSuscriptionUser.startDate BETWEEN '2024-01-01' AND NOW()
GROUP BY firstname, lastname, email, name
ORDER BY total_paid_in_colones DESC;
```
Lo que logra esta consulta es reunir los datos principales de un usuario junto con su pago de suscripciones en un lapso de tiempo especifico, este siendo de 2024 en adelante. Los puntos mas importantes son los ultimos dos inner join que permiten tanto relacionar la suscripcion activa del usuario con lo que se paga y luego hacer el cambio de moneda de dolares a colones.

#### Tabla
| firstname | lastname   | email                              | country_name  | total_paid_in_colones |
|-----------|------------|------------------------------------|---------------|----------------------:|
| Andres    | Hernandez  | andres.hernandez626743@yahoo.es   | France        | 21599.1950            |
| Juan      | Vargas     | juan.vargas116346@yahoo.es        | Costa Rica    | 11334.4450            |
| Jose      | Venegas    | jose.venegas686999@outlook.com    | United States | 10799.5975            |
| Adrian    | Mora       | adrian.mora718645@hotmail.com     | France        | 10799.5975            |
| Juan      | Castillo   | juan.castillo171620@gmail.com     | Costa Rica    | 10799.5975            |
| Luis      | Castillo   | luis.castillo193773@gmail.com     | United States | 10799.5975            |
| Carlos    | Castillo   | carlos.castillo129300@outlook.com | France        | 5991.6950             |
| Carlos    | Abarca     | carlos.abarca510338@outlook.es    | France        | 3230.6950             |
| Andres    | Baldi      | andres.baldi156339@gmail.com      | France        | 3230.6950             |
| Juan      | Rodriguez  | juan.rodriguez86838@outlook.es    | France        | 3230.6950             |
| Diego     | Castillo   | diego.castillo815324@hotmail.com  | Costa Rica    | 2695.8475             |
| Diego     | Hernandez  | diego.hernandez875135@gmail.com   | France        | 2695.8475             |
| Jose      | Rodriguez  | jose.rodriguez423433@hotmail.com  | France        | 2695.8475             |
| Luis      | Hernandez  | luis.hernandez681460@outlook.com  | France        | 2695.8475             |
| Jose      | Abarca     | luis.abarca2268456@outlook.com    | Costa Rica    | 2695.8475             |
| Rodrigo   | Rodriguez  | rodrigo.rodriguez87866@gmail.com  | France        | 1069.6950             |
| Rodrigo   | Hernandez  | rodrigo.hernandez268423@gmail.com | Costa Rica    | 538.4475              |
| Adrian    | Cespedes   | adrian.cespedes891645@yahoo.es    | United States | 534.8475              |
| Jose      | Abarca     | jose.abarca632610@hotmail.com     | Costa Rica    | 534.8475              |
| Jose      | Baldi      | jose.baldi137303@gmail.com        | United States | 534.8475              |
| Andres    | Mora       | andres.mora954977@outlook.es      | United States | 534.8475              |

#### 4.2 Listar todas las personas con su nombre completo e email, los cuales le queden menos de 15 días para tener que volver a pagar una nueva subscripción (13+ registros)

#### Consulta
```sql
SELECT AppAssistantUsers.firstname, AppAssistantUsers.lastname, 
	   AppAssistantUsers.email, AppAssitantSuscriptionUser.endDate AS fecha_vencimiento,
	   DATEDIFF(AppAssitantSuscriptionUser.endDate, NOW()) AS dias_restantes
FROM AppAssistantUsers
INNER JOIN AppAssitantSuscriptionUser ON AppAssistantUsers.UserId = AppAssitantSuscriptionUser.UserId
WHERE AppAssitantSuscriptionUser.enable = 1 AND DATEDIFF(AppAssitantSuscriptionUser.endDate, NOW()) BETWEEN 0 AND 15
ORDER BY dias_restantes ASC;
```
En esta segunda consulta lo que se realiza es nuevamente pedir todos los datos del usuario mas el endDate de la tabla de SuscriptionUser, esto basicamente define el dia en que se acaba la suscripcion de la persona y mediante un DATEDIFF se calculan los dias restantes basandose en el dia actual, finalmente se establece que los dias restantes tienen que ir de 0 a 15. 

#### Tabla 
| firstname | lastname  | email                              | fecha_vencimiento   | dias_restantes |
|-----------|-----------|------------------------------------|--------------------|----------------|
| Carlos    | Abarca    | carlos.abarca510338@outlook.es     | 2025-03-28 22:09:00 | 3              |
| Rodrigo   | Rodriguez | rodrigo.rodriguez87866@gmail.com   | 2025-04-05 02:11:00 | 11             |

#### 4.3 Un ranking del top 15 de usuarios que más uso le dan a la aplicación y el top 15 que menos uso le dan a la aplicación (15 y 15 registros)

#### Consultas 
```sql
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
```
En este apartado para definir los usuarios que mas le dan uso a la app lo logramos mediante el apartado de logs. Entre mas entries de logs esten relacionados con el usuario mas va a subir el count de los logs por usuario. Establecemos un limite de 15 para ambos casos y para obtener los que mas uso le dan a la app usamos "DESC" y para los que menos "ASC". 

#### Tablas 

#### Mas Uso de la App
| UserId | firstname  | lastname   | email                               | total_logs |
|--------|------------|------------|------------------------------------|------------|
| 49     | Carlos     | Sanches    | carlos.sanches549175@outlook.es     | 12         |
| 25     | Christopher| Vargas     | christopher.vargas186385@outlook.com| 9          |
| 3      | Jose       | Rodriguez  | jose.rodriguez423433@hotmail.com    | 9          |
| 6      | Carlos     | Castillo   | carlos.castillo129300@outlook.com   | 9          |
| 5      | Andres     | Mora       | andres.mora229497@hotmail.com       | 9          |
| 13     | Jose       | Baldi      | jose.baldi137303@gmail.com          | 9          |
| 39     | Diego      | Hernandez  | diego.hernandez875135@gmail.com     | 7          |
| 45     | Andres     | Hernandez  | andres.hernandez626743@yahoo.es     | 7          |
| 10     | Jose       | Venegas    | jose.venegas118702@outlook.com      | 7          |
| 22     | Rodrigo    | Hernandez  | rodrigo.hernandez268423@gmail.com   | 7          |
| 15     | Luis       | Castillo   | luis.castillo193773@gmail.com       | 7          |
| 37     | Luis       | Cespedes   | luis.cespedes623601@hotmail.com     | 7          |
| 7      | Christopher| Mora       | christopher.mora923634@gmail.com    | 6          |
| 26     | Adrian     | Mora       | adrian.mora718645@hotmail.com       | 6          |
| 41     | Luis       | Hernandez  | luis.hernandez681460@outlook.com    | 6          |

#### Menos Uso de la App
| UserId | firstname | lastname   | email                              | total_logs |
|--------|-----------|-----------|-----------------------------------|------------|
| 30     | Rodrigo   | Baldi     | rodrigo.baldi474797@yahoo.es      | 2           |
| 18     | Andres    | Abarca    | andres.abarca368566@yahoo.es      | 2          |
| 36     | Rodrigo   | Castillo  | rodrigo.castillo193792@hotmail.com| 2          |
| 8      | Jose      | Abarca    | jose.abarca632610@hotmail.com     | 2          |
| 21     | Juan      | Venegas   | juan.venegas563421@hotmail.com    | 2          |
| 14     | Andres    | Mora      | andres.mora954977@outlook.es      | 2          |
| 2      | Andres    | Baldi     | andres.baldi156339@gmail.com      | 3          |
| 32     | Jose      | Hernandez | jose.hernandez492155@outlook.es   | 3          |
| 10     | Jose      | Venegas   | jose.venegas118702@outlook.com    | 3          |
| 37     | Luis      | Hernandez | luis.hernandez681460@outlook.com  | 3          |
| 23     | Rodrigo   | Rodriguez | rodrigo.rodriguez87866@gmail.com  | 3          |
| 34     | Diego     | Abarca    | diego.abarca772844@hotmail.com    | 4          |
| 24     | Luis      | Abarca    | luis.abarca226845@outlook.com     | 4          |
| 6      | Carlos    | Abarca    | carlos.abarca510338@outlook.es    | 4          |
| 12     | Adrian    | Cespedes  | adrian.cespedes891645@yahoo.es    | 4          |

#### 4.4 Determinar cuáles son los análisis donde más está fallando la AI, encontrar los casos, situaciones, interpretaciones, halucinaciones o errores donde el usuario está teniendo más problemas en hacer que la AI determine correctamente lo que se desea hacer, rankeando cada problema de mayor a menor cantidad de ocurrencias entre un rango de fechas (30+ registros)

En este apartado primero resulta importante explicar el modelo o las tablas de IA, esto dado a que nos permite enetender la logica para realizar las posteriores consultas. (Para la visualizacion del diseño fisico este se encuentra en el pdf de todas las tablas). Primeramente mediante de las tablas de la API y los responses nos conectamos con un tercero que nos permite relacionar los "files" y mandarlos a la API esto para tener un transcript especifico de la task que envia el usuario. Una vez tenemos esta validacion de que los archivos se pasaron a la IA podemos iniciar con una "LiveChatSession", esta permite hablar en tiempo real con la persona y notificar los pasos que debe seguir para completar una tarea, esto tambien incluye comandos de voz que puede identificar y ejecutar. En este caso llenamos la mayoria de tablas de IA en el script, se puede encontrar en el archivo "Queries&Script.sql". 
