#!/bin/bash

# Variables
CMD_UPDATE="sudo apt-get update"
CMD_INSTALL_GIT="sudo apt-get -y install git"
CMD_INSTALL_RBENV="sudo apt-get -y install rbenv"
CMD_CLONE_RUBY_BUILD="git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build"
CMD_INSTALL_RUBY="rbenv install 2.5.0"
CMD_SET_RUBY_VERSION="rbenv rehash;rbenv global 2.5.0"
CMD_INSTALL_RAILS="gem install rails -v 5.2"
CMD_SET_PATH_RBENV="echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> ~/.bashrc; echo 'eval \"\$(rbenv init -)\"' >> ~/.bashrc;source ~/.bashrc"
CMD_INSTALL_REDIS="sudo apt-get install -y redis-server"


echo "\n"
echo "#############################"
echo   Despliegue de Chat App
echo "#############################"

echo "\n"
echo "Se necesita instalar git, se ejecutara:"
echo "$CMD_INSTALL_GIT"
read -p "Deseas instalar git? (s,n)" install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando git...
    echo "--------------------------------"
    $CMD_UPDATE;$CMD_INSTALL_GIT
    echo "--------------------------------"
else
    echo Omitimos Git
fi

echo "\n"
echo "Se necesita instalar rbenv, se ejecutara:"
echo "$CMD_INSTALL_RBENV"
read -p "Deseas instalar rbenv? (s,n)" install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando rbenv...
    echo "--------------------------------"
    $CMD_UPDATE;$CMD_INSTALL_RBENV
    echo "--------------------------------"
else
    echo Omitimos rbenv
fi

echo "\n"
echo "Se necesita instalar ruby 2.5.0, se ejecutara:"
echo "$CMD_INSTALL_RUBY"
read -p "Deseas instalar ruby? (s,n)" install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando ruby...
    echo "--------------------------------"
    $CMD_INSTALL_RBENV;$CMD_INSTALL_RUBY
    $CMD_SET_RUBY_VERSION
    echo "--------------------------------"
else
    echo Omitimos ruby
fi


echo "\n"
echo "Se necesita instalar rails 5.2, se ejecutara:"
echo "$CMD_INSTALL_RAILS"
echo "$CMD_SET_PATH_RBENV"
read -p "Deseas instalar rails? (s,n)" install
if echo "$install" | grep -iq "^s" ;then
    echo Instalando ruby...
    echo "--------------------------------"
    $CMD_INSTALL_RAILS
    $CMD_SET_PATH_RBENV
    echo "--------------------------------"
else
    echo Omitimos rails
fi

# dependencias para JWT
# echo "\n"
# echo "Se necesita instalar rails 5.2, se ejecutara:"
# echo "$CMD_INSTALL_RAILS"
# echo "$CMD_SET_PATH_RBENV"
# read -p "Deseas instalar rails? (s,n)" install
# if echo "$install" | grep -iq "^s" ;then
#     echo Instalando ruby...
#     echo "--------------------------------"
#     $CMD_INSTALL_RAILS
#     $CMD_SET_PATH_RBENV
#     echo "--------------------------------"
# else
#     echo Omitimos rails
# fi
