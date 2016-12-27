# Instrucciones de uso de la plataforma de contenedores Docker

Es necesario instalar Docker, para ello vaya a las [instrucciones de instrucciones de instalación oficiales para su sistema operativo](https://www.docker.com/products/docker). Si va a usar una distribución Linux la versión del kernel tiene que ser superior a la 3.10, pero se han encontrado [problemas con versiones 4.0+](https://github.com/AythaE/Ejercicios-CC16-17/blob/master/Virtualizacion_ligera_usando_contenedores/Ejercicio4.md#ejercicio-4) en Debian 8.6.

Una vez descargado Docker para descargar el contendor de DockerHub hay que ejecutar el siguiente comando

```
sudo docker pull aythae/defesti
```

Podremos acceder al contenedor de la manera usual con el siguiente comando por ejemplo

```
sudo docker run -it aythae/defesti bash
```

Si tiene curiosidad sobre como se ha creado el contenedor puede consultar el [Dockerfile](../../Dockerfile) usado para crearlo.
