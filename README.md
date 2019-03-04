# README

## Chat App v2

Aplicación Chat donde se han utilizado las herramientas:

* Ruby on Rails 5.2
* Action Cable
* Vuejs 2.5
* Rspec
* Mongoid 7.0

La aplicación tiene un frontend (desarrollado con VueJS) y un backend (desarrollado en RoR). La comunicación se realiza mediante API JSON REST

## Despliegue automático

Para esta versión se ha incorporado un asistente que irá preguntando si se quiere instalar los distintos componentes.

Se situa en la carpeta raiz "deploy.sh" (solo disponible para linux)

    $ sh deploy.sh

Nota: Ejecutar en la carpeta del proyecto

## Despliegue manual

### Instalamos dependencias git, rbenv y ruby-build

    $ sudo apt-get install git
    $ sudo apt-get install rbenv
    $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

Comprobamos que rbenv se ha instalado correctamente

    $ type rbenv

### Instalación Ruby

Vamos a instalar la versión 2.5.0

    $ rbenv install 2.5.0

Una vez instalado, le decimos al sistema que use esta versión por defecto

    $ rbenv rehash
    $ rbenv global 2.5.0

### Instalación Rails

Para instalar, utilizamos el comando *gem*, instalaremos la version 5.1.6

    $ gem install rails -v 5.2

### Incluir ~/.rbenv/bin en $PATH:

    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    $ source ~/.bashrc

### Instalación JWT

JWT depende del servicio redis-server, para instalarlo:

	$ sudo apt-get install -y redis-server

Despues instalamos JWT con gem

    $ gem install jwt

### Preparamos los servicios (MongoDB)

La aplicación está preparada para trabajar con la base de datos de MongoDB.

Instalamos MongoDB en el sistema,

Esto dependerá del sistema que utilices, en mi caso, el sistema que se ha utilizado es Debian 9 64 bits.
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

    echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

    sudo apt-get update

    sudo apt-get install mongodb-org

Una vez instalado, iniciamos el servicio:

    sudo service mongod start

Comprobamos el estado del servicio

    sudo service mongod status

## Clonamos repositorio

    $ git clone https://github.com/ccalero/chat_app_v2.git


## Instalamos las gemas del proyecto

    $ bundle install

Si fuera necesario actualizamos

    $ bundle update

### Instalamos las dependencias de VueJS

  	$ cd app-front/
  	$ yarn install

## Ejecutamos el servidor:

Una vez hecho todo, ya podemos ejecutar el servidor dentro del directorio "chat_app_v2"

    $ rails s

Y el servidor de vuejs dentro del directorio chat_app_v2/app-front

    $ yarn dev

## Imagenes de la Aplicación

### Página del Login

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/1_SignIn.PNG)

### Página del Registro

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/2_SignUp.PNG)

### Página del listado de salas disponibles

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/3_rooms.PNG)

### Página para crear una nueva sala

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/4_add_room.PNG)

### Página del chat

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/5_chat_room.PNG)

### Control de errores en la aplicación

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/6_control_errors.PNG)

## Demo

Aqui podemos ver, el funcionamiento del chat con dos usuarios ("usuario1" y "usuario2") en la sala "Sala Demo". Al mismo tiempo otros dos usuarios ("usuario3" y "usuario4") están en la sala "Sala 2"

En ventanas independientes que se actualizan con los nuevos mensajes sin refrescar la página

![alt text](https://github.com/ccalero/chat_app_v2/blob/master/doc/img/demo_chat.gif)
