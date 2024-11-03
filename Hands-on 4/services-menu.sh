#!/bin/bash

#Menu
show_menu() {
	echo "Selecciona una opcion:"
	echo "1) Listar el contenido de un fichero (carpeta)"
	echo "2) Crear un archivo de texto con una linea de texto"
	echo "3) Comparar dos archivos de texto"
	echo "4) Mostrar el uso de AWK"
	echo "5) Mostrar el uso de GREP"
	echo "6) Salir"
}

#Listar contenido de un fichero
list_directory() {
	read -p "Ingrese la ruta absoluta al directorio: " dir
	if [ -d "$dir" ]; then
		echo "Contenido de $dir:"
		ls -l "$dir"
	else
		echo "La ruta proporcionada no es un directorio valido"
	fi
}

#crear archivo con texto
create_text_file() {
	read -p "Ingresa el nombre del archivo a crear: " filename
	read -p "Ingresa el texto que deseas escribir en el archivos: " text
	echo "$text" > "$filename"
	echo "Archivo '$filename' creado con su texto"
}

#Comparar dos archivos de texto
compare_files() {
	read -p "Ingresa la ruta del primer archivo: " file1
	read -p "Ingresa la ruta del segundo archivo: " file2
	if [ -f "$file1" ] && [ -f "$file2" ]; then
		diff "$file1" "$file2" > /dev/null
		if [ $? -eq 0 ]; then
			echo "Los archivos son iguales"
		else
			echo "Los archivos son diferentes"
		fi
	else
		echo "Uno o ambos archivos no existen"
	fi
}

#Mostrar el uso de AWK
show_awk_example() {
	echo "Ejemplo de uso de AWK"
	echo "Sirve para procesar archivos de texto, como extraer la primer columna de un archivo"
	read -p "Ingresa la ruta de un archivo de texto: " file
	if [ -f "$file" ]; then
		awk '{print $1}' "$file"
	else
		echo "El archivo no exite"
	fi
}

#Mostrar el uso de GREP
show_grep_example() {
	echo "Ejemplo de uso de GREP"
	echo "Sirve para buscar coincidencia de patrones en archivos de texto"
	read -p "Ingresa la palabra o patron a buscar: " pattern
	read -p "Ingresa la ruta del archivo de texto: " file
	if [ -f "$file" ]; then
		grep "$pattern" "$file"
	else
		echo "El archivo no existe"
	fi
}


#Funcion del menu
while true; do
	show_menu
	read -p "Seleccione una opcion: " option
	case $option in
		1) list_directory ;;
		2) create_text_file ;;
		3) compare_files ;;
		4) show_awk_example ;;
		5) show_grep_example ;;
		6) echo "Saliendo del script"; break ;;
	esac
done
