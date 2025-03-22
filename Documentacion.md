# Caso #1 App Assistant

## Integrantes
- Christopher Daniel Vargas Villata, 2024108443
- Andres Baldi Mora, 2024088934

### Lista de Entidades
* Tareas (Grabaciones/Imagen/etc)
* Usuarios
* Roles
* Permisos
* Pagos
* Transacciones
* Direcciones
* Suscripciones
* Monedas
* Archivos
* Empresas
* Lenguajes
* Logs (Registros)
* Traducciones

  ***

### *Justificación Diseño* 

En este caso optamos por un diseño basándonos en el listado de identidades presentado anteriormente, los cuales cumplen con los requerimientos del app assistant. Siendo esto asi intentamos establecer relaciones propias entre entidades y sus funcionalidad, por ejemplo en el caso de los usuarios nos aseguramos que estos fuesen conectados con la mayoría de identidades dado a la relevancia del usuario en la propia app, un ejemplo de esto podría el hecho de “user” estando presente tanto en la configuración del pago, pago o intento del mismo y finalmente las transacciones que incluyen todos los tipos de transacciones que se podría llegar a realizar en la app, etso incluyendo devoluciones, compras y demás. Resulta importante mencionar que tanto los roles como permisos están directamente asociados con el usuario y si el mismo pertenece a una empresa o no, es decir, una empresa puede obtener un rol de administrador “interno” mediante el cual puede decidir qué permisos tiene habilitado su empleado. Por otra parte también conectamos tanto los usuarios, empresas y transacciones con una dirección específica, esto para que se tenga constancia de donde se realizó el pago ya sea de una suscripción o algo similar dentro de la app. En el siguiente apartado mencionaremos las entidades más importantes del diseño del app asistente y el porqué de sus datos. 

#### User
En el caso de “user” optamos por un diseño simple que abarque los datos de la persona como nombre, apellido, contacto y dirección, esto ademas de campos importantes para relaciones como rol del usuario y un password con un tipo de dato VARBINARY que nos permite cifrar la contraseña de cada usuario para asegurar la seguridad del mismo. 

#### Empresas
La entidad de empresas se asegura de tener un registro o listado de las empresas asociadas con “app assistant” esto asegura tener usuarios asociados o no a diversas empresas y cual es el rol que asigna una empresa a sus empleados, esto ya sea para agregar nuevas tareas, eliminarlas, modificarlas y demás acciones. 

#### Archivos o Tareas
En el caso de archivos o tareas se presentan dos tablas para la misma entidad, una de ellas corresponde al tipo de archivo para verificar que sea permitido, como podrían ser png, mp4, mp3 y demás tipos de archivos. Posteriormente en la tabla principal de tareas los conectamos con los usuarios para que estos sean capaces de insertar y borrar archivos esto ya dependiendo de su rol. Esto además de un URL que nos permite almacenar estos archivos en un almacenamiento físico externo, asimismo añadimos un dato de “MIME” que nos permite distinguir los distintos formatos o tipos de archivos por su extensión. 

#### Roles y Permisos 
En el caso de estas dos entidades sumamente relacionadas el enfoque que tomamos para la realización de la mismas se basó en una tabla de roles en donde la PK se trate como una lista de todos los roles posibles en la app, esto junto con su nombre, descripción y una actualización en caso de que haya cambios a posterior. De la misma forma se creó una tabla de permisos con casi el mismo tipo de datos que permite listar una gran cantidad de permisos en la app, luego esto se conecta con una tabla intermedia llamada “roles_permissions” en donde se establece esta relación de los roles y que permisos posee cada rol. 

#### Transacciones y Pagos
En estos dos apartados sumamente relacionados decidimos dividirlo en diversas estructuras, primeramente teniendo métodos de pago en donde se da un listado de los posibles métodos de pago y si estos están activos, como podría ser PayPal, CashApp, Sinpe, Tarjeta o demás métodos. Por otra parte está la tabla de Data Payments, en este caso tomamos en cuenta el método de pago y usamos una masked account junto con tokens que nos permiten cifrar la cuenta del usuario y realizar dicho pago desde un tercero o una API en este caso para no almacenar datos cuentas bancarias de usuarios, es por esto mismo que no resulta necesario un apartado de balances o algo similar. Posteriormente en la tabla principal de pagos existen una diversidad de datos que incluyen: resultados, errores, autenticación, token, referencia de pago, usuario, total del pago y checksum, este último para la validación de respaldos y mayor seguridad. 
En el caso de transacciones esta es una de las tablas vitales del diseño del “App Assistant” esto dado a que toma en cuenta la mayoría de aspectos del sistema incluyendo: usuarios, pagos, métodos de pago, tipos de transacciones, moneda de pago, conversión de moneda de pago, tiempo de la transacción y demás. La unificación de esta tabla con las mencionadas anteriormente permite al usuario realizar una transacción ya sea para una devolución, pago, reclamo o demás aspectos, portando así los requerimientos para la seguridad del sistema además de su registro en logs para tener un historial organizado. 

---

#### Screenshots. 

En este apartado mostraremos una parte del esquema a diseño físico que utilizamos como borrador, esto para después ya realizar el diseño a nivel físico de workbench. Resulta importante mencionar que este esquema es meramente eso un borrador ya implementado de una mejor forma en workbench y con algunos cambios de relaciones y datos. 
