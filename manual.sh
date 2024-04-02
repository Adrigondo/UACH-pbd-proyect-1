#!/bin/bash

selectedOpt=""
selectedSection=""
selectedSectionName=""

while getopts ":at" selectedOpt; do
  case ${selectedOpt} in
    a )
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
    t )
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
      ;;
    : )
      echo "La opción -$OPTARG requiere un argumento."
      ;;
  esac
done
echo "La opción seleccionada fue ${selectedSectionName}"