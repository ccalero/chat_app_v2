#!/bin/sh
# deploy.sh
# Authors:
# ---------------------------------------------
# Carlos Calero
# https://github.com/ccalero/
# ---------------------------------------------
#
# ---------------------------------------------
# Usage:
# ---------------------------------------------
# To deploy, run:
# sh deploy.sh

CMD_UPDATE="sudo apt-get update"
CMD_INSTALL_GIT="sudo apt-get -y install git"

echo "\n"
echo "#############################"
echo   Despliegue de Chat App
echo "#############################"

echo "\n"
echo "Se necesita instalar git, se ejecutara:"
echo "$CMD_INSTALL_GIT"
read -p "Deseas instalar git? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando git...
    echo "--------------------------------"
    $CMD_UPDATE;$CMD_INSTALL_GIT
    echo "--------------------------------"
else
    echo Omitimos Git
fi

CMD_INSTALL_RBENV="sudo apt-get -y install rbenv"
CMD_CLONE_RUBY_BUILD="git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build"

echo "\n"
echo "Se necesita instalar rbenv, se ejecutara:"
echo "$CMD_INSTALL_RBENV"
echo "$CMD_CLONE_RUBY_BUILD"
read -p "Deseas instalar rbenv? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando rbenv...
    echo "--------------------------------"
    $CMD_UPDATE
    $CMD_INSTALL_RBENV
    $CMD_CLONE_RUBY_BUILD
    if [ $? -ne 0 ]; then
       echo "[ERROR] Un error ha ocurrido al ejecutar:"
       echo "$CMD_CLONE_RUBY_BUILD"
       echo "Pruebe a copiar el comando y a continuar con la instalacion"
       exit 3
    fi
    echo "--------------------------------"
else
    echo Omitimos rbenv
fi


CMD_INSTALL_RUBY="rbenv install 2.5.0"
CMD_RUBY_REHASH="rbenv rehash"
CMD_RUBY_GLOBAL="rbenv global 2.5.0"

echo "\n"
echo "Se necesita instalar ruby 2.5.0, se ejecutara:"
echo "$CMD_INSTALL_RUBY"
echo "$CMD_RUBY_REHASH"
echo "$CMD_RUBY_GLOBAL"
read -p "Deseas instalar ruby? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando ruby...
    echo "--------------------------------"
    $CMD_INSTALL_RUBY
    $CMD_RUBY_REHASH
    $CMD_RUBY_GLOBAL
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    echo "--------------------------------"
else
    echo Omitimos ruby
fi

CMD_INSTALL_RAILS="gem install rails -v 5.2"

echo "\n"
echo "Se necesita instalar rails 5.2, se ejecutara:"
echo "$CMD_INSTALL_RAILS"
echo "$CMD_SET_PATH_RBENV"
read -p "Deseas instalar rails? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando rails...
    echo "--------------------------------"
    $CMD_INSTALL_RAILS
    if [ $? -ne 0 ]; then
       echo "[ERROR] Un error ha ocurrido al ejecutar:"
       echo "$CMD_INSTALL_RAILS"
       echo "Pruebe a copiar el comando y a continuar con la instalacion"
       exit 3
    fi
    $CMD_SET_PATH_RBENV
    if [ $? -ne 0 ]; then
       echo "[ERROR] Un error ha ocurrido al ejecutar:"
       echo "$CMD_SET_PATH_RBENV"
       echo "Pruebe a copiar el comando y a continuar con la instalacion"
       exit 3
    fi
    echo "--------------------------------"
else
    echo Omitimos rails
fi

CMD_INSTALL_REDIS="sudo apt-get install -y redis-server"
CMD_INSTALL_JWT="gem install jwt"

echo "\n"
echo "Se necesita instalar jwt y sus dependencias, se ejecutara:"
echo "$CMD_INSTALL_REDIS"
echo "$CMD_INSTALL_JWT"
read -p "Deseas instalar jwt? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando jwt...
    echo "--------------------------------"
    $CMD_UPDATE
    $CMD_INSTALL_REDIS
    $CMD_INSTALL_JWT
    if [ $? -ne 0 ]; then
       echo "[ERROR] Un error ha ocurrido al ejecutar:"
       echo "$CMD_INSTALL_JWT"
       echo "Pruebe a copiar el comando y a continuar con la instalacion"
       exit 3
    fi
    echo "--------------------------------"
else
    echo Omitimos jwt
fi

CMD_INSTALL_MONGODB="sudo apt-get install -y mongodb-org"
CMD_INIT_SERVICE_MONGODB="sudo service mongod start"

echo "\n"
echo "Se necesita instalar mongodb, se ejecutara:"
echo "$CMD_INSTALL_MONGODB"
echo "$CMD_INIT_SERVICE_MONGODB"
read -p "Deseas instalar mongodb? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
    echo "ADVERTENCIA"
    echo "Se necesitan actualizar los repositorios, si su distribucion"
    echo "no es Debian 9 y sigue la instrucciones de su distribucion en:"
    echo "https://docs.mongodb.com/manual/administration/install-on-linux/"
    read -p "Su distribucion es Debian? (s,n) " install
    if echo "$install" | grep -iq "^s" ;then
      echo Instalando mongodb...
      echo "--------------------------------"
      echo 'deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
      $CMD_UPDATE
      $CMD_INSTALL_MONGODB;$CMD_INIT_SERVICE_MONGODB
      echo "--------------------------------"
    fi
else
    echo Omitimos mongodb
fi

CMD_INSTALL_YARN="sudo apt-get install -y yarn"

echo "\n"
echo "Se necesita instalar yarn, se ejecutara:"
echo "$CMD_INSTALL_YARN"
read -p "Deseas instalar yarn? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
  echo Instalando yarn...
  echo "--------------------------------"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  $CMD_UPDATE
  $CMD_INSTALL_YARN
  if [ $? -ne 0 ]; then
     echo "[ERROR] Un error ha ocurrido al ejecutar:"
     echo "$CMD_INSTALL_YARN"
     echo "Pruebe a copiar el comando y a continuar con la instalacion"
     exit 3
  fi
  echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.bashrc
else
    echo Omitimos yarn
fi

CMD_INSTALL_GEM="./bin/bundle install"
CMD_UPDATE_GEM="./bin/bundle update"

echo "\n"
echo "Se necesita instalar las gemas y las dependencias de vuejs, se ejecutara:"
echo "$CMD_INSTALL_GEM"
echo "$CMD_UPDATE_GEM"
read -p "Deseas instalar las gemas? (s,n) " install
if echo "$install" | grep -iq "^s" ;then
  echo Instalamos Gemas del proyecto...
  echo "--------------------------------"
  $CMD_INSTALL_GEM
  $CMD_UPDATE_GEM
  echo Descargando dependencias vuejs...
  echo "--------------------------------"
  cd app-front
  yarn install
fi

echo "Se ha instalado todo correctamente."
echo "Inicia los servidores:"
echo "--------------------------------"
echo "- Backend (RoR)"
echo "    rails s"
echo " El servidor estara corriendo en: http://localhost:3000"

echo "- Front (VueJS)"
echo "    cd app-front"
echo "    yarn dev"
echo " El servidor estara corriendo en: http://localhost:8080"
