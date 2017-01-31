# DeFesti

Actualizado a 31/01/2017

Repositorio para el proyecto de la asignatura Cloud Computing 1 del Máster Ingeniería Informática UGR.

## Descripción del proyecto

### El problema
Hoy en día son cada vez más populares los festivales de música, estos eventos mueven a miles de personas con el objetivo de pasar unos cuantos días fuera de la rutina, conociendo mucha gente nueva y disfrutando con sus amigos de la música. Los grandes festivales tienen asegurado un público que acude a ellos año tras año, pero cada vez se estan creando más festivales pequeños, sin muchos recursos para publicitarse y en muchos casos autogestionados por artistas incluso llegando a ser gratuitos. El problema de estos festivales es darse a conocer ya que su público objetivo suele ser mucho mayor que la gente que los conoce.

Por todo ello sería interesante algún sistema para descubrir festivales, un intermediario que pusiera a la gente en contacto con los festivales.

### Análisis de mercado
Aunque existen algunas opciones similares no hay ninguna que sea realmente conocida o empleada habitualmente por los fans de los festivales. Si introducimos festivales de música en los buscadores más conocidos de internet se encuentran diversas páginas como:

- [festivales.com](http://www.festivales.com/festivales-de/musica) en la que el administrador de la web va creando el contenido fijandose en las páginas de festivales. Esto tiene el problema de que si no se esta activo rapidamente se queda obsoleto el contenido.

- [ticketea](https://www.ticketea.com/festivales/), tiene información muy actualizada pero no deja de ser una plataforma de venta de entradas en la que los pequeños festivales no tienen cabida.

- [fanmusicfest](http://fanmusicfest.com/lista-festivales), al igual que la primera el contenido es creado por los administradores aunque está bastante más actualizado que festivales.com, el problema es que no se promocionan festivales pequeños y los editores tendrán sus propios criterios para elegir unos festivales u otros.



### La solución
Sería más interesante un sistema de festivales en el que fueran los propios organizadores de los festivales los encargados de crear y mantener el contenido sobre los festivales, entradas, artistas,... Ofreciendo la posibilidad de registrarse a cualquier organizador se lograría que cualquiera que organice un festival ya sea pequeño o grande sea capaz de publicitarse en una plataforma de modo gratuito.

### El proyecto
Se creará una aplicación web desplegable en la nube en la que los organizadores podran registrarse y logearse, crear festivales dando datos de estos tales como perfiles sociales, pagina web del festival o enlaces a la venta de entradas on-line. También seran los organizadores los que crearan artistas para añadir a sus festivales. Una vez que un artista sea creado por un organizador estará disponible para su inclusión en otros festivales sin tener que volver a crearlo.

Los usuarios anónimos (los que no sean organizadores registrados en el sistema) podran ver una página principal con los festivales más populares, las páginas de los festivales y las de los artistas.

Para este proyecto se seguirá una arquitectura basada en microservicios como se puede ver en el siguiente diagrama:

![alt text](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/diagrams/Arquitectura%20microservicios.png "Arquitectura proyecto")

- La API Rest se creara utilizando [Express.js](http://expressjs.com/)
- El servicio Organizadores se encargará de gestionar las cuentas de los organizadores, login, control de sesiones, etc. Como almacen de datos empleará una base de datos NoSQL orientada a documentos.
- El servicio de Festivales se encargará de gestionar la información sobre los festivales incluyendo las operaciones tipicas CRUD. También empleará una base de datos orientada a documentos.
- El servicio de Artistas se encargará de gestionar la información sobre los artistas incluyendo las operaciones típicas CRUD.También empleará una base de datos orientada a documentos.
- También se planea introducir un servicio de logger para registrar las interacciones con la aplicación web y poder extraer información de estos datos como los festivales más populares o recuperar las bases de datos de los microservicios en caso de error. Los mensajes logs generados se almacenarán en una base de datos.

## Provisionamiento
Se han elegido 2 sistemas de provisionamiento para el proyecto, actualmente se ofrece el provisionamiento del servicio organizadores aunque aún no esté implementado. Ambos sistemas están pensados para provisionar una instancia de AWS con una imagen de Ubuntu 14.04.5 LTS aunque podrían funcionar para otros sistemas se requerirían ciertas modificaciones por lo que se recomienda usar esa imagen.

### Ansible
Se ha elegido este sistema por su gran flexibilidad y extenso número de opciones, puede encontrar unas instrucciones detalladas en este [enlace](ansible.md).

### Chef
Se ha elegido este sistema por su extendido uso en entornos reales, puede encontrar unas instrucciones detalladas en este [enlace](chef.md).

### Correcciones de otros compañeros
Se han probado los sistemas de provisionamiento de otros dos compañeros, [@flupi](https://github.com/fblupi) y [@joseangeldiazg](https://github.com/joseangeldiazg). Los resultados de estas pruebas se pueden consultar [aquí](prueba_provisionamiento_companieros.md)

## Orquestación
Se facilita los ficheros necesarios para orquestar este proyecto usando [Vagrant](https://www.vagrantup.com/) y ansible como provisionador. Puede consultar las instrucciones detalladas en este [enlace](vagrant.md).

### Correcciones de otros compañeros
Se ha probado el sistemas de orquestación de otro compañero, [@flupi](https://github.com/fblupi). Los resultados de estas pruebas se pueden consultar [aquí](prueba_orquestacion_companieros.md).


## Contenedores
Se ha usado Docker como plataforma para crear un entorno de pruebas usando contenedores. Se pueden consultar [aquí](docker.md) las instrucciones para descargar Docker y descargar el contenedor de [DockerHub](https://hub.docker.com/r/aythae/defesti/).

### Correcciones de otros compañeros
Se ha probado el sistema de contenedores de otro compañero, [@flupi](https://github.com/fblupi). Los resultados de estas pruebas se pueden consultar [aquí](prueba_contenedores_companieros.md).

## Despliegue final
Se ha realizado un despliegue combinando las tecnologias usadas previamente, usando orquestación con Vagrant de tres máquinas (una por microservicio) provisionadas con Ansible y usando contenedores con Docker para facilitar el despliegue y hacerlo independiente de la máquina donde se realice. Dichos contenedores se encuentran en DockerHub en las siguientes ubicaciones: [defesti-organizadores](https://hub.docker.com/r/aythae/defesti-organizadores/), [defesti-festivales](https://hub.docker.com/r/aythae/defesti-festivales/) y [defesti-artistas](https://hub.docker.com/r/aythae/defesti-artistas/).

Para consultar las instrucciones concretas de despliegue haga click [aquí](despliegue_final.md).

## Licencia
Este proyecto tiene una licencia GPL v3.0, para información detallada vease [LICENSE](https://github.com/AythaE/DeFesti/blob/master/LICENSE)
