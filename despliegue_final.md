---
layout: index
---

# Instrucciones de despliegue

Para este despliegue integrando las diversas herramientas utilizadas se ha usado instancias de AWS con una imagen Ubuntu 16.04.1.

Para orquestar todo el despliegue se ha usado la herramienta Vagrant, para saber como realizar esta orquestación véase [las instrucciones de Vagrant para este repositorio](vagrant). Como modificaciones a esas instrucciones comentar que he optado por actualizar la versión de Ubuntu a la ultima estable, a pesar de los problemas con Ansible por la falta de python 2.x. Por ello las maquinas creadas por este Vagrantfile tienen dos provisionadores, primero un shell que ejecuta el script [`installPythonUbuntu16.sh`](https://github.com/AythaE/DeFesti/blob/master/deployment/installPythonUbuntu16.sh) encargado de actualizar los paquetes de la máquina e instalar las dependencias necesarias para que funcione ansible en ella, tras ello se ejecuta el provisionador ansible con los distintos playbooks: [`organizadoresPlaybook.yml`](https://github.com/AythaE/DeFesti/blob/master/deployment/organizadoresPlaybook.yml), [`artistasPlaybook.yml`](https://github.com/AythaE/DeFesti/blob/master/deployment/artistasPlaybook.yml) y [`festivalesPlaybook.yml`](https://github.com/AythaE/DeFesti/blob/master/deployment/festivalesPlaybook.yml).

#### Modificación de las instrucciones previas
Hay que aplicar una pequeña modificación en estas instrucciones, en el paso de indicar en el playbook la ruta a la clave pública de acceso ssh, es necesario modificar la variable `pubKey` de los tres playbooks.

## Justificación de elección de despliegue

Teniendo en cuenta que los microservicios usan Express y nodeJS lo ideal sería usar un contenedor Docker como base que tuviera nodeJS instalado. [Este contenedor](https://hub.docker.com/_/node/) es lo que estaba buscando, además de traer node instalado tiene versiones que usan Alpine linux como base con lo que el contenedor es bastante ligero y eso siempre es algo recomendable. Por ello se ha usado como base para los distintos contenedores cuyos Dockerfiles son:

- [`DockerfileOrganizadores`](https://github.com/AythaE/DeFesti/blob/master/deployment/DockerfileOrganizadores)
- [`DockerfileArtistas`](https://github.com/AythaE/DeFesti/blob/master/deployment/DockerfileArtistas)
- [`DockerfileFestivales`](https://github.com/AythaE/DeFesti/blob/master/deployment/DockerfileFestivales)


Las distintas bases de datos de los distintos microservicios se han externalizado usando [mLab](https://mlab.com/), un servicio de DaaS (Database as a Service) que permite crear instancias de MongoDB en diversos proveedores de nube: AWS, Google Cloud Platform y Microsoft Azure. Tiene diversos planes en funcion de las necesidades de cada usuario pero cuenta con un plan gratuito que permite crear bases de datos en instancias compartidas de hasta 500 MB. Esta externalización de las BDs hace que se obtengan ciertas ventajas como gestión de copias de seguridad o monitorización continua por parte de mLab. Tras hacerse una cuenta gratuita habría que crear las bases de datos necesarias para los microservicios y copiar el URI de la conexión a cada una en el código del microservicio usando el driver de MongoDB **`mongoose`** (ya instalado en los contenedores).

Tambien se ha optado por externalizar los log del sistema usando el servicio [Loggly](https://www.loggly.com/), este servicio ofrece LaaS (Logging as a Service) y permite agregar logs de múltiples fuentes, entre las se encuentra node.js o docker. Permite gestionar los logs de manera uniforme en tiempo real, realizar búsquedas... Para ello habría que crear una cuenta gratuita en loggly y configurar en el código los parametros de acceso para enviar los logs generados por node.js a loggly usando las [instrucciones oficiales](https://www.loggly.com/docs/nodejs-logs/). Los módulos **`winston`** y **`winston-loggly-bulk`** necesarios ya se encuentan instalados en los contenedores.

Para ver los módulos concretos instalados en cada contenedor véase [`package.json`](https://github.com/AythaE/DeFesti/blob/master/deployment/package.json).

## Resultados del despliegue
Si se han seguido [las instrucciones de Vagrant para este repositorio](vagrant) y la [modificación](#modificacin-de-las-instrucciones-previas) comentada arriba bastaría con exportar las credenciales de AWS, añadir el box dummy (si no ha hecho ya), exportar la clave pública de AWS (indicando en los playbooks donde encontrarla) y ejecutar el comando
```
vagrant up --provider=aws
```
como se índica en esas instrucciones. En las siguientes imágenes podemos ver un ejemplo de despliegue real.

![despliegue final 1](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/images/DespliegueFinalContainers1.png "Despliegue final 1")

![despliegue final 2](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/images/DespliegueFinalContainers2.png "Despliegue final 2")


Volver a la [página principal](index).
