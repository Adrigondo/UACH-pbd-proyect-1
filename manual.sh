#!/bin/bash

selectedOption=""
selectedSection=""
selectedSectionName=""
selectedOperation=""
currentMenu=""

while getopts ":at" selectedOption; do
  case ${selectedOption} in
    'a' )
        echo "Bienvenido a la guía rápida de Agile, para continuar seleccione un tema:"
        echo "1) SCRUM"
        echo "2) X.P."
        echo "3) Kanban"
        echo "4) Crystal"
        read -p "Seleccione una opción (1-4): " selectedSection
        case $selectedSection in
        1 )
            selectedSectionName="SCRUM"
          ;;
        2 )
            selectedSectionName="X.P."
          ;;
        3 )
            selectedSectionName="Kanban"
          ;;
        4 )
            selectedSectionName="Crystal"
          ;;
        * )
          echo "Selección inválida. Por favor, seleccione un número del 1 al 4."
          ;;
      esac
      ;;
    't' )
        echo "Bienvenido a la guía rápida de metodologías tradicionales, para continuar seleccione un tema:"
        echo "1) Cascada"
        echo "2) Espiral"
        echo "3) Modelo V"
        read -p "Seleccione una opción (1-3): " selectedSection

        case $selectedSection in
        1 )
            selectedSectionName="Cascada"
          ;;
        2 )
            selectedSectionName="Espiral"
          ;;
        3 )
            selectedSectionName="Modelo V"
          ;;
        * )
          echo "Selección inválida. Por favor, seleccione un número del 1 al 3."
          ;;
      esac
      ;;
    \? )
        echo "Opción inválida: -$OPTARG"
        echo "  -a Revisar manual de Agile"
        echo "  -t Revisar manual de metodologías tradicionales"
        exit 2
      ;;
  esac
done
if [[ ${selectedOption} == '?' ]]; then
  echo "Falta un argumento:"
  echo "  -a Revisar manual de Agile"
  echo "  -t Revisar manual de metodologías tradicionales"
  exit 1
fi


echo "Usted esta en la sección ${selectedSectionName}, seleccione la opción que desea utilizar."
echo "1) Agregar información"
echo "2) Buscar"
echo "3) Eliminar información"
echo "4) Leer base de información."
read -p "Seleccione una opción (1-4): " selectedOperation

case $selectedOperation in
1 )
    echo "> Agregar información"
    concept=""
    definition=""
    read -p "Ingresa el nombre del concepto: " concept
    read -p "Ingresa la definición del concepto: " definition

    # Todo: Save concept and definition into file.
  ;;
2 )
    echo "> Buscar"
    concept=""
    read -p "Ingresa el concepto a buscar: " concept

    # Todo
    # Search concept using REGEX from the file with the selectedSectionName name
    # If the concept doesn't exists display an error message.
    # If the concept exists, display the definition of the concept
  ;;
3 )
    echo "> Eliminar información"
    concept=""
    read -p "Ingresa el concepto que desea eliminar: " concept

    # Todo
    # Delete the concept from the file with the selectedSectionName name
    # Check if the concept extists, if not, display an error message
  ;;
4 )
    echo "> Leer base de información."

    # Todo
    # Show all the information of the file with the selectedSectionName name
    # If the file doesn't exists or it is empty, display an error message
  ;;
* )
    echo "Selección inválida. Por favor, seleccione un número del 1 al 3."
  ;;


