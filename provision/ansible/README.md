#Provisionamiento con ansible

Para provisionar con ansible es necesario instalarlo en su máquina local, puede consultar unas instrucciones de instalación de ansible y uso de este en instancias de AWS [aquí](https://github.com/AythaE/Ejercicios-CC16-17/blob/master/Gestion_de_configuraciones/Ejercicio5.md).

Hay que editar el fichero `inventory` sustituyendo la IP que en el aparece por la de la máquina remota que vaya a provisionar.

La maquina remota que se vaya a provisionar ha de tener python 2.x instalado, comprobarlo y de no ser así instalarlo con `apt-get install python`. Si se va a utilizar una máquina de AWS se recomienda usar Ubuntu 14.04.5 LTS ya que trae python 2 instalado por defecto. En cualquer caso este provisionamiento está creado para efectuarse en una máquina Ubuntu, en caso de probarlo en otros S.O. se requerirán ligeras modificaciones de los archivos (las rutas por ejemplo) y no se garantiza su funcionamiento.

Este provisionamiento crea un usuario en la maquina virtual, para poder acceder por ssh a este usuario es necesario indicarle a ansible donde está su clave publica asociada a la clave privada usada para conectarse con la máquina remota. Para generar la clave publica de una privada en formato .pem basta con ejecutar 
```
ssh-keygen -y -f mykey.pem > mykey.pub
``` 
tras esto hay que indicarle a ansible la ruta de esa clave en el fichero `organizadoresPlaybook.yml` modificando el valor de la variable `pubKey`
```
- hosts: DeFesti
  remote_user: ubuntu
  become: yes
  become_method: sudo

  vars:
    pubKey: /home/aythae/.ssh/awsPAythae.pub
    
  tasks:
  ...
```

Una vez arrancada la instancia remota y realizado los pasos previos para provisionar el microservicio Organizadores basta con ejecutar: 
```
ansible-playbook -i inventory organizadoresPlaybook.yml --key-file=[rutaClavePrivada]
``` 
donde la rutaClavePrivada es la ubicación de la clave privada usada para conectarse por ssh con su maquina remota a provisionar. El resultado de dicho provisionamiento será algo parecido a lo siguiente:

![Imagen ejecución ansible]( "Ejecución ansible")