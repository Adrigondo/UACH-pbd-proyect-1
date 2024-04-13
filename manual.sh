#!/bin/bash

# Creación de directorio de información y documentos .inf
infoFolder="./info"
infoFileNames=("./info/scrum.inf" "./info/xp.inf" "./info/kanban.inf" "./info/crystal.inf" "./info/cascade.inf" "./info/spiral.inf" "./info/vmodel.inf")

mkdir -p ${infoFolder}

for ((i = 0; i < ${#infoFileNames[@]}; i++)); do
  touch ${infoFileNames[i]}
done

# - - - - -

selectedOption=""
selectedFlag=""
selectedSection=""
selectedSectionName=""
selectedOperation=""
selectedInfoFile=0
currentMenu=0
entryMenu=0

flagsReceived=false

while getopts ":at" selectedOption; do
  flagsReceived=true
  case ${selectedOption} in
  'a')
    currentMenu=1
    entryMenu=1
    break
    ;;
  't')
    currentMenu=2
    entryMenu=2
    break
    ;;
  \?)
    echo "Opción inválida: -$OPTARG"
    echo "  -a Revisar manual de Agile"
    echo "  -t Revisar manual de metodologías tradicionales"
    exit 1
    ;;
  esac
done

if ! $flagsReceived; then
  echo "Falta un argumento:"
  echo "  -a Revisar manual de Agile"
  echo "  -t Revisar manual de metodologías tradicionales"
  exit 2
fi

while true; do
  case $currentMenu in
  1)
    selectedSection=0
    echo "Bienvenido a la guía rápida de Agile."
    while [ $selectedSection -eq 0 ]; do
      echo "Seleccione un tema."
      echo "1) SCRUM"
      echo "2) X.P."
      echo "3) Kanban"
      echo "4) Crystal"
      read -p "Seleccione una opción (1-4): " selectedSection
      case $selectedSection in
      1)
        selectedInfoFile=${infoFileNames[0]}
        selectedSectionName="SCRUM"
        ;;
      2)
        selectedInfoFile=${infoFileNames[1]}
        selectedSectionName="X.P."
        ;;
      3)
        selectedInfoFile=${infoFileNames[2]}
        selectedSectionName="Kanban"
        ;;
      4)
        selectedInfoFile=${infoFileNames[3]}
        selectedSectionName="Crystal"
        ;;
      *)
        echo "Selección inválida. Por favor, seleccione una opción del 1 al 4."
        selectedSection=0
        ;;
      esac
    done
    echo $selectedSection
    currentMenu=3
    ;;
  2)
    selectedSection=0
    echo "Bienvenido a la guía rapida de metodologías tradicionales"
    while [ $selectedSection -eq 0 ]; do
      echo "Seleccione un tema."
      echo "1) Cascada"
      echo "2) Espiral"
      echo "3) Modelo V"
      read -p "Seleccione una opción (1-3): " selectedSection

      case $selectedSection in
      1)
        selectedInfoFile=${infoFileNames[4]}
        selectedSectionName="Cascada"
        ;;
      2)
        selectedInfoFile=${infoFileNames[5]}
        selectedSectionName="Espiral"
        ;;
      3)
        selectedInfoFile=${infoFileNames[6]}
        selectedSectionName="Modelo V"
        ;;
      *)
        selectedSection=0
        echo "Selección inválida. Por favor, seleccione una opción del 1 al 3."
        ;;
      esac
    done
    currentMenu=3
    ;;
  esac

  if [ $currentMenu -eq 3 ]; then
    echo "Usted esta en la sección ${selectedSectionName}."
    selectedOperation=0
    while [ $selectedOperation -eq 0 ]; do
      echo "Seleccione la opción que desea utilizar."
      echo "1) Agregar información"
      echo "2) Buscar"
      echo "3) Eliminar información"
      echo "4) Leer base de información."
      read -p "Seleccione una opción (1-4): " selectedOperation

      case $selectedOperation in
      1)
        echo "> Agregar información"
        concept=""
        definition=""
        read -p "Ingresa el nombre del concepto: " concept
        read -p "Ingresa la definición del concepto: " definition

        # Todo
        # Validate user input

        echo -e "${concept} .- ${definition}\n" >>${selectedInfoFile}
        echo "Concepto y definición agregados con éxito."
        ;;
      2)
        echo "> Buscar"
        concept=""
        read -p "Ingresa el concepto a buscar: " concept

        # Encuentra todas las líneas donde se cumpla la condición:
        # concept .-
        regexLinesFoundStr=$(grep -inw "${concept} .-" ${selectedInfoFile} | cut -d: -f1)

        # Si el concepto no existe (regexLinesFoundStr es nulo), salta mensaje de error.
        if [ -z "$regexLinesFoundStr" ]; then
          echo "Concepto inválido: ${concept}"
        else
          regexLinesFoundArr=()
          while read -r lineNumber; do
            regexLinesFoundArr+=("$lineNumber")
          done <<<"$regexLinesFoundStr"

          sed -n "${regexLinesFoundArr[0]}p" "${selectedInfoFile}" | sed 's/.*\.- //'
        fi
        ;;
      3)
        echo "> Eliminar información"
        concept=""
        read -p "Ingresa el concepto que desea eliminar: " concept

        # Encuentra todas las líneas donde se cumpla la condición:
        # concept .-
        regexLinesFoundStr=$(grep -inw "${concept} .-" ${selectedInfoFile} | cut -d: -f1)
        regexLinesFoundArr=()

        # Saca losa opcións de líneas para volverlos numeros individuales con posiciones propias.
        # (La operación anterior devuelve un solo string con numeros separados por espacios, por eso se hace este paso).
        while read -r lineNumber; do
          regexLinesFoundArr+=("$lineNumber")
        done <<<"$regexLinesFoundStr"

        definitionLocation=${regexLinesFoundArr[0]}

        # Borra la línea donde se encuentra la definición que nos interesa.
        # Antes de ello, borra la línea que le sigue a donde se encuentra la definición (el espacio que separa las distintas definiciones).
        # Se hace en este orden para evitar perder la estructura del archivo de texto.
        if [ -z "$definitionLocation" ]; then
          echo "Concepto inválido: ${concept}"
        else
          sed -i "$((definitionLocation + 1))d" ${selectedInfoFile}
          sed -i "${definitionLocation}d" ${selectedInfoFile}
          echo "Concepto borrado con éxito."
        fi
        ;;
      4)
        # selectedOperation=$((selectedOperation - 1))
        echo "> Leer base de información."

        # Todo
        # If the file doesn't exists or it is empty, display an error message

        cat ${selectedInfoFile}
        ;;
      *)
        echo "Selección inválida. Por favor, seleccione una opción del 1 al 4."
        selectedOperation=0
        ;;
      esac
    done

    choice=0
    echo "¿Qué desea hacer ahora?"
    while [ $choice -eq 0 ]; do
      echo "1. Volver al menú anterior"
      echo "2. Realizar otra operación"
      echo "3. Salir de la aplicación: "
      read -p "Seleccione una opción (1-3): " choice

      case $choice in
      1)
        currentMenu=$entryMenu
        ;;
      2)
        currentMenu=3
        ;;
      3)
        exit
        ;;
      *)
        echo "Selección inválida. Por favor, seleccione una opción del 1 al 3."
        choice=0
        ;;
      esac
    done
  else

    choice=0
    while [ $choice -eq 0 ]; do
      echo "¿Qué desea hacer ahora?"
      echo "1. Seleccionar otra sección"
      echo "2. Salir de la aplicación: "
      read -p "Seleccione una opción (1-2): " choice

      case $choice in
      1)
        currentMenu=$entryMenu
        ;;
      2)
        exit
        ;;
      *)
        echo "Selección inválida. Por favor, seleccione una opción del 1 al 2."
        choice=0
        ;;
      esac
    done
  fi
done


