#!/bin/bash

while getopts ":a:t" opt; do
  case ${opt} in
    a )
      echo "Opción -a recibida. Esta opción realiza la acción A."
      ;;
    t )
      echo "Opción -t recibida. Esta opción realiza la acción T."
      ;;
    \? )
      echo "Opción inválida: -$OPTARG"
      ;;
    : )
      echo "La opción -$OPTARG requiere un argumento."
      ;;
  esac
done