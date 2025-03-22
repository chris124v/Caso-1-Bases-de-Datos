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

  ***

### *Justificación Diseño* 

En este caso optamos por un diseño basándonos en el listado de identidades presentado anteriormente, los cuales cumplen con los requerimientos del app assistant. Siendo esto asi intentamos establecer relaciones propias entre entidades y sus funcionalidad, por ejemplo en el caso de los usuarios nos aseguramos que estos fuesen conectados con la mayoría de identidades dado a la relevancia del usuario en la propia app, un ejemplo de esto podría el hecho de “users” estando presente tanto en la configuración del pago, pago o intento del mismo y finalmente las transacciones que incluyen todos los tipos de transacciones que se podría llegar a realizar en la app, etso incluyendo devoluciones, compras y demás. Resulta importante mencionar que tanto los roles como permisos están directamente asociados con el usuario. En el siguiente apartado mencionaremos las entidades más importantes del diseño del app asistente y el porqué de sus datos. 

#### Users
En el caso de “user” optamos por un diseño simple que abarque los datos de la persona como nombre, apellido, contacto y dirección, esto ademas de campos importantes para relaciones como rol del usuario y un password con un tipo de dato VARBINARY que nos permite cifrar la contraseña de cada usuario para asegurar la seguridad del mismo. 

#### Files
En el caso de archivos o tareas se presentan dos tablas para la misma entidad, una de ellas corresponde al tipo de archivo para verificar que sea permitido, como podrían ser png, mp4, mp3 y demás tipos de archivos. Posteriormente en la tabla principal de tareas los conectamos con los usuarios para que estos sean capaces de insertar y borrar archivos esto ya dependiendo de su rol. Esto además de un URL que nos permite almacenar estos archivos en un almacenamiento físico externo, asimismo añadimos un dato de “MIME” que nos permite distinguir los distintos formatos o tipos de archivos por su extensión. 

#### Roles & Permissions
En el caso de estas dos entidades sumamente relacionadas tomamos un enfoque que fuese desde lo mas pequeño a los mas grande, esto por ejemplo con la tabla de "permissions" en donde se encuentra un listado general de todo lo que se puede hacer en la app incluyendo permisos tanto de admin como de cualquier otra persona o usuario. Posteriormente este listado se disminuye estableciendo una tabla intermedia llamada "RolePermissions" en donde se asigna el permiso especifico a cada rol existente, esto claramente ya exitiendo la tabla "Roles" que define el listado de roles posibles en la app, esto permite una distribucion adecuada y pertinente segun cada rol. Asimismo para asignar uno o mas roles por usuario se define la tabla de "RolesPerUser" permitiendonos asi definir varios roles para varios usuarios o simplemente distribuirlos de una forma mas eficiente. 

#### Transactions and Payments
En estos dos apartados sumamente relacionados decidimos dividirlo en diversas estructuras, primeramente teniendo métodos de pago en donde se da un listado de los posibles métodos de pago y si estos están activos, como podría ser PayPal, CashApp, Sinpe, Tarjeta o demás métodos. Por otra parte está la tabla de Data Payments, en este caso tomamos en cuenta el método de pago y usamos una masked account junto con tokens que nos permiten cifrar la cuenta del usuario y realizar dicho pago desde un tercero o una API en este caso para no almacenar datos cuentas bancarias de usuarios, es por esto mismo que no resulta necesario un apartado de balances o algo similar. Posteriormente en la tabla principal de pagos existen una diversidad de datos que incluyen: resultados, errores, autenticación, token, referencia de pago, usuario, total del pago y checksum, este último para la validación de respaldos y mayor seguridad. 
En el caso de transacciones esta es una de las tablas vitales del diseño del “App Assistant” esto dado a que toma en cuenta la mayoría de aspectos del sistema incluyendo: usuarios, pagos, métodos de pago, tipos de transacciones, moneda de pago, conversión de moneda de pago, tiempo de la transacción y demás. La unificación de esta tabla con las mencionadas anteriormente permite al usuario realizar una transacción ya sea para una devolución, pago, reclamo o demás aspectos, portando así los requerimientos para la seguridad del sistema además de su registro en logs para tener un historial organizado. 

---

#### Screenshots. 

En este apartado mostraremos una parte del esquema a diseño físico que utilizamos como borrador, esto para después ya realizar el diseño a nivel físico de workbench. Resulta importante mencionar que este esquema es meramente eso un borrador ya implementado de una mejor forma en workbench y con algunos cambios de relaciones y datos. 
