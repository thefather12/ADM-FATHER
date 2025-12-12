#!/bin/bash

# Función de traducción (fun_trans)
# Simplemente devuelve el texto ya que no hay un motor de traducción real.
fun_trans() {
  echo "$1"
}

# Función de mensajes (msg)
msg() {
  case $1 in
    -bar)
      # Barra separadora
      echo -e "\033[1;36m-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\033[0m"
      ;;
    -tit)
      # Título con fondo azul
      echo -e "\033[1;44m                                                                \033[0m"
      ;;
    -ama)
      # Mensaje amarillo
      echo -e "\033[1;33m$2\033[0m"
      ;;
    -verm2)
      # Mensaje rojo
      echo -e "\033[1;31m$2\033[0m"
      ;;
    *)
      # Mensaje por defecto
      echo -e "$1"
      ;;
  esac
}

# Declaración de colores (Ya está en tu script, pero es bueno tenerla aquí también)
# declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
