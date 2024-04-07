#!/bin/bash

# Creación de directorio de información y documentos .inf
infoFolder="./info"
infoFileNames=("./info/scrum.inf" "./info/xp.inf" "./info/kanban.inf" "./info/crystal.inf" "./info/cascade.inf" "./info/spiral.inf" "./info/vmodel.inf")

mkdir -p ${infoFolder}

for((i = 0; i < ${#infoFileNames[@]}; i++)); do
    touch ${infoFileNames[i]}
done

# - - - - - 

selectedOption=""
selectedSection=""
selectedSectionName=""
selectedOperation=""
selectedInfoFile=0
currentMenu=""

flagsReceived=false
while getopts ":at" selectedOption; do
  flagsReceived=true
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
            selectedInfoFile=${infoFileNames[0]}
            selectedSectionName="SCRUM"
          ;;
        2 )
            selectedInfoFile=${infoFileNames[1]}
            selectedSectionName="X.P."
          ;;
        3 )
            selectedInfoFile=${infoFileNames[2]}
            selectedSectionName="Kanban"
          ;;
        4 )
            selectedInfoFile=${infoFileNames[3]}
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
            selectedInfoFile=${infoFileNames[4]}
            selectedSectionName="Cascada"
          ;;
        2 )
            selectedInfoFile=${infoFileNames[5]}
            selectedSectionName="Espiral"
          ;;
        3 )
            selectedInfoFile=${infoFileNames[6]}
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

if ! $flagsReceived ; then
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

    # Todo
    # Validate user input

    echo -e "${concept} .- ${definition}\n" >> ${selectedInfoFile}
    echo "Concepto y definición agregados con éxito."
  ;;
2 )
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
      done <<< "$regexLinesFoundStr"

      sed -n "${regexLinesFoundArr[0]}p" "${selectedInfoFile}" | sed 's/.*\.- //'
    fi
  ;;
3 )
    echo "> Eliminar información"
    concept=""
    read -p "Ingresa el concepto que desea eliminar: " concept

    # Encuentra todas las líneas donde se cumpla la condición:
    # concept .-
    regexLinesFoundStr=$(grep -inw "${concept} .-" ${selectedInfoFile} | cut -d: -f1)
    regexLinesFoundArr=()

    # Saca los números de líneas para volverlos numeros individuales con posiciones propias.
    # (La operación anterior devuelve un solo string con numeros separados por espacios, por eso se hace este paso).
    while read -r lineNumber; do
      regexLinesFoundArr+=("$lineNumber")
    done <<< "$regexLinesFoundStr"

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
4 )
    # selectedOperation=$((selectedOperation - 1))
    echo "> Leer base de información."

    # Todo
    # If the file doesn't exists or it is empty, display an error message

    cat ${selectedInfoFile}
  ;;
* )
    echo "Selección inválida. Por favor, seleccione un número del 1 al 4."
  ;;
esac


