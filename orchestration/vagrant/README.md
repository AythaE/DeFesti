# Provisionamiento usando Vagrant

## Provisionamiento de instancias EC2 de AWS

Es necesario exportar las siguientes siguientes variables de entorno con sus propios valores que Vagrant consultará para desplegar la maquina virtual a provisionar en AWS EC2.

```
export AWS_ACCESS_KEY_ID=[AccessKey]
export AWS_SECRET_ACCESS_KEY=[SecretKey]
export AWS_SECURITY_GROUP_NAME=[SGName]
export AWS_KEY_PAIR_NAME=[keyPairName]
export AWS_PRIVATE_KEY_PATH=[Path to your private key]
```

Si no sabe lo que son la access key id o la secret access key consulte el apartado [To get your access key ID and secret access key](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#cli-signup). Si no sabe lo que son los grupos de seguridad consulte [Creating a Security Group](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html#creating-security-group). Si no sabe cual es su key pair name o su ruta consulte [Creating Your Key Pair Using Amazon EC2](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair), la ruta de su clave privada es donde descarge el fichero .pem generado al crear su clave. Puede encontrar un [shell script](setUpAWS_Credentials.sh) para no tener que exportar estas variables cada vez y que basté con rellenar el script y ejecutarlo antes de desplegar la instancia con vagrant usando el comando

```
source setUpAWS_Credentials.sh
```

Es necesario instalar el plugin [vagrant-aws](https://github.com/mitchellh/vagrant-aws) para poder usar vagrant con instancias EC2 de AWS. Se han encontrado problemas con las versiones más nuevas de vagrant así que se recomienda usar vagrant 1.8.7.

Una vez hecho eso y siguiendo las [instrucciones oficiales](https://github.com/mitchellh/vagrant-aws#quick-start) del repositorio del plugin es necesario añadir un box a vagrant cuyo proveedor sea aws, en este caso se añade un box dummy que configuraremos con los parametros que queramos en el Vagrantfile. Para añadir ese box ejecute:
```
 vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```

En el directorio que desee crear la maquina virtual sitúe el fichero [Vagrantfile](Vagrantfile) que se adjunta en esta carpeta y ejecute el siguiente comando para iniciar dos maquinas virtuales en AWS llamadas **organizadores** y **festivales**:

```
vagrant up --provider=aws
```

Esto automáticamente creara dos instancias y la provisionará, cuando finalice puede acceder a ellas por ssh el siguiente comando desde el directorio donde se encuentre el Vagrantfile:

```
vagrant ssh [organizadores|festivales]
```

Alternativamente tambien puede acceder a su instancia con el siguiente comando:

```
ssh -i [rutaClavePrivada (.pem)] [usuario]@[IP pública asignada]
```
Puede consultar la IP pública de la instancia creada en la [consola de gestion de AWS](https://console.aws.amazon.com/) seleccionando el servicio EC2 y allí Running instances. Se mostrará entonces un listado de las maquina virtuales creadas en AWS, seleccione las recién creadas que tendrán como nombre "DeFesti vagrant EC2 Instance" y copie su IP pública. El usuario creado por defecto en las instancias Ubuntu es "ubuntu".


Para destruir las instancias cuando haya terminado de utilizarlas ejecute el siguiente comando desde el directorio donde se encuentre el Vagrantfile:

```
vagrant destroy
```

En las siguientes imáganes se puede ver un ejemplo de ejecución de `vagrant up`:

![Imagen Vagrant Up 1](https://raw.githubusercontent.com/AythaE/DeFesti/96c1008b9946e414ef61abae0b98f931dbd385a4/images/Vagrant1.png "Imagen Vagrant Up 1")

![Imagen Vagrant Up 2](https://raw.githubusercontent.com/AythaE/DeFesti/96c1008b9946e414ef61abae0b98f931dbd385a4/images/Vagrant2.png "Imagen Vagrant Up 2")
