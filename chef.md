---
layout: index
---
# Provisionamiento con chef


La maquina remota que se ha usado para crear y testear este provisionamiento es una máquina de AWS con Ubuntu 14.04.5 LTS. En caso de probarlo en otros S.O. se requerirán ligeras modificaciones de los archivos (las rutas por ejemplo) y no se garantiza su funcionamiento.

Para provisionar con chef-solo es necesario instalarlo en la máquina remota a provisionar, un modo rápido de hacer eso es conectarte a la máquina por ssh y ejecutar el comando:

```
curl -L https://www.opscode.com/chef/install.sh | sudo bash
```

Tras esto hay que descargar este repositorio en su máquina remota, para ello tras la conexion por ssh hay que instalar `git` y clonar el repositorio con:

```
sudo apt-get install git
git clone https://github.com/AythaE/DeFesti.git
```

Este provisionamiento crea un usuario `defesti` en la maquina virtual, para poder acceder por ssh a este usuario es necesario indicarle a chef donde está su clave publica asociada a la clave privada usada para conectarse con la máquina remota. Para generar la clave publica de una privada en formato .pem basta con ejecutar

```
ssh-keygen -y -f mykey.pem > mykey.pub
```

tras esto hay que enviarle la clave publica al servidor remoto usando sftp:
![Envio clave por sftp](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/images/envioClavePorSFTP.png "Envio clave por SFTP")
A continuacion es necesario renombrar la nueva clave a authorized_keys para sustituir la clave por defecto ya que es el nombre que chef espera encontrar.
![Renombrar clave publica](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/images/RenombrarClave.png "Renombrar clave publica")


Una vez realizados los pasos previos para provisionar el microservicio Organizadores basta con ejecutar:

```
sudo chef-solo -c ~/DeFesti/provision/chef/solo.rb
```

El resultado de dicho provisionamiento será algo parecido a lo siguiente:

![Imagen ejecución chef](https://raw.githubusercontent.com/AythaE/DeFesti/gh-pages/images/EjecucionChef.png "Ejecución chef")

Volver a la [página principal](index)