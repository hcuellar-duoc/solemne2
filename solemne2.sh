#!/bin/bash

#########################################################
#				*** COMIENZO ***
#########################################################

function ejecutar(){

	modulo_principal

}

#########################################################
#		*** Funcion Menú Principal ***
#########################################################

function modulo_principal(){

	clear

	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " PSY4101 - Evaluacion 2"
	echo " Programación de Scripting"
	echo ""
	echo " Profesor: Luis Díaz"
	echo " Alumno : Hugo Cuellar"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingresar número para ir hasta la sección"
	echo ""
	echo " [ 1 ] Parte uno de la prueba."
	echo " [ 2 ] Parte dos de la prueba."
	echo " [ 3 ] Parte tres de la prueba."
	echo " [ 4 ] Salir de la prueba."
	echo ""
	echo "----------------------------------------------"
	echo ""

	read -r opcion

	if [ "$opcion" = 1 ];
		then modulo_parte1
	fi

	if [ "$opcion" = 2 ];
		then modulo_parte2
	fi

	if [ "$opcion" = 3 ];
		then modulo_parte3
	fi

	if [ "$opcion" = 4 ];
		then modulo_salir
	fi

}

#########################################################
#				*** Funcion Parte 1 ***
#########################################################

function modulo_parte1(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " [ Procesos del Sistema ]"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingresar número de la opción para operar"
	echo ""
	echo " [ 1 ] Conteo de procesos totales ejecutándose"
	echo " [ 2 ] Mostrar todos los procesos de un usuario"
	echo " [ 3 ] Eliminar un proceso por nombre"
	echo " [ 4 ] Volver al menú principal"
	echo " [ 5 ] Salir"
	echo ""
	echo "----------------------------------------------"
	echo ""

	read -r opcion

	if [ "$opcion" = 1 ];
		then modulo_procesos_conteo
	fi

	if [ "$opcion" = 2 ];
		then modulo_procesos_usuarios
	fi

	if [ "$opcion" = 3 ];
		then modulo_procesos_terminar
	fi

	if [ "$opcion" = 4 ];
		then modulo_principal
	fi

	if [ "$opcion" = 5 ];
		then modulo_salir
	fi

}

#########################################################
#				*** Funcion Parte 2 ***
#########################################################

function modulo_parte2(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " [ Script Reporte ]"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Esta seccion contiene un script que generará"
	echo " un reporte cuyos datos son extraídos desde"
	echo " archivos de configuración del sistema."
	echo ""
	echo " El reporte se escribira en el archivo:"
	echo ""
	echo "	[ reportescript.log ]"
	echo ""
	echo " con los siguientes datos:"
	echo ""
	echo " | Servidor:"
	echo " | Nombre del servidor:"
	echo " | Configuracion de SElinux:"
	echo " | Nivel de ejecucion por defecto:"
	echo ""
	echo " | Habilitado usuario root:"
	echo " | Protocolo utilizado:"
	echo " | Tiempo de gracia:"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " ¿Desea ejecutar el script? [Y/n]"
	echo ""
	echo "----------------------------------------------"
	echo ""

	read -r ejecutar

	if [ "$ejecutar" = Y ];
		then clear
		modulo_reporte_script
	fi

	if [ "$ejecutar" = n ];
		then modulo_principal
	fi
}

#########################################################
#			*** Función Parte 3 ***
#########################################################

function modulo_parte3(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " [ Administración de Usuarios y Grupos ]"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingresar número de la opción para operar"
	echo ""
	echo " [ 1 ] Crear usuarios y grupos."
	echo " [ 2 ] Añadir usuario a grupo."
	echo " [ 3 ] Volver al menú principal"
	echo " [ 4 ] Salir"
	echo ""
	echo "----------------------------------------------"
	echo ""

	read -r opcion

	if [ "$opcion" = 1 ];
		then modulo_usuarios
	fi

	if [ "$opcion" = 2 ];
		then modulo_grupos
	fi

	if [ "$opcion" = 3 ];
		then modulo_principal
	fi

	if [ "$opcion" = 4 ];
		then modulo_salir
	fi

}

#########################################################
#			*** Función Procesos Conteo ***
#########################################################

function modulo_procesos_conteo(){

	clear

	echo ""
	echo " Conteo de procesos totales ejecutándose:"
	echo ""

	ps ax | wc -l

	echo ""
	read -rsp $' Presiona cualquier tecla para volver.\n' -n 1 key
	echo ""

	modulo_parte1

}

#########################################################
#			*** Función Procesos Usuarios ***
#########################################################

function modulo_procesos_usuarios(){

	clear

	echo ""
	echo " Ingrese el nombre de usuario para listar procesos:"
	echo ""

	read -r usuario

	echo ""
	echo " Se listará los procesos de $usuario"
	echo ""
	echo " ¿Confirmar? [Y/n]"
	echo ""

	read -r confirmar

	if [ "$confirmar" = Y ];
		then clear

		ps -U "$usuario" -u "$usuario" -o pid,uid,tty,%cpu,%mem,bsdstart,bsdtime,comm,cmd

		echo ""
		read -rsp $' Presiona cualquier tecla para volver.\n' -n 1 key
		echo ""

		modulo_parte1

	fi

	if [ "$confirmar" = n ];
		then modulo_procesos_usuarios
	fi

}

#########################################################
#			*** Función Procesos Terminar ***
#########################################################

function modulo_procesos_terminar(){

	clear

	echo ""
	echo " Ingrese nombre del proceso a terminar"
	echo ""

	read -r proceso

	echo " Los siguientes procesos tienen el nombre $proceso:"

	ps aux | grep "$proceso"

	echo ""
	echo " ¿Terminar el proceso $proceso? [Y/n]"
	echo ""

	read -r terminar

	if [ "$terminar" = Y ];
		then clear

		killall "$proceso"
		
		clear

		echo ""
		echo " Se terminó todos los procesos con el nombre asociado:"
		echo ""
		echo " $proceso"
		echo ""
		read -rsp $' Presiona cualquier tecla para volver.\n' -n 1 key
		echo ""

		modulo_parte1

	fi

}

#########################################################
#			*** Funciones Reporte Script ***
#########################################################

reporte=""

function linea(){

	reporte="$reporte$1\n"

}

function cfg_server(){

	nombre=$(cat /etc/hostname)
	linea "Nombre Servidor: $nombre"

}

function cfg_selinux(){

	linea ""
	linea "----------------------------------------------"
	linea " [ Configuración SElinux ]"
	linea "----------------------------------------------"
	while read -r l; do linea "$l"; done < /etc/selinux/config
	nivel=$(runlevel)
	linea "Nivel de ejecución: $nivel"
	linea ""

}

function cfg_ssh() {

	linea "----------------------------------------------"
	linea " [ Configuración SSH ] "
	linea "----------------------------------------------"
	linea ""
	root_habilitado=$(cat /etc/ssh/sshd_config | grep -i ^PermitRootLogin | cut -f2 -d" ")
	linea "Habilitado usuario root: ${root_habilitado:-no}"
	protocolo=$(cat /etc/ssh/sshd_config | grep Protocol | cut -f2 -d" ")
	linea "Protocolo utilizado: ${protocolo:-2,1}"
	tiempo_gracia=$(cat /etc/ssh/sshd_config | grep LoginGraceTime | cut -f5 -d" ")
	linea "Tiempo de gracia: ${tiempo_gracia:-5m}"

}

function modulo_reporte_script(){

	clear

	echo "----------------------------------------------"
	echo " Información de reportescript.log"
	echo "----------------------------------------------"
	echo ""

	cfg_server
	cfg_selinux
	cfg_ssh

	echo -e "$reporte" > reportescripts.log

	cat reportescripts.log
	
	echo ""
	read -rsp "El proceso se realizó, presione cualquier tecla para continuar..." -n 1 key
	echo ""

	modulo_principal

}

#########################################################
#			*** Función Usuarios ***
#########################################################

function modulo_usuarios(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " [ Creación usuarios y grupos ]"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingresar nombre de usuario a crear:"
	echo ""

	read -r usuario

	if id -u "$usuario" >/dev/null 2>&1;
		then clear
		
		echo ""
		echo "El nombre $usuario ya existe. Inténtelo con otro nombre."
		echo ""
		read -rsp "Presione cualquier tecla para volver." -n 1 key	
		echo ""
		
		modulo_usuarios
		
		else useradd "$usuario"
		
		clear
		
		echo ""
		echo "Se procedió a crear el usuario $usuario"
		echo ""
		
		read -rsp "Presione cualquier tecla para procesar" -n 1 key		
		
		modulo_dir

	fi

}

#########################################################
#			*** Función Usuarios Directorio ***
#########################################################

function modulo_dir(){

	clear
	
	echo ""
	echo " (Opcional) ¿Desea agregar un directorio personalizado? [Y/n]"
	echo ""
	
	read -r confirmar
	
	if [ "$confirmar" = Y ];
		then clear

		modulo_dir_check

	fi

	if [ "$confirmar" = n ];
		then modulo_grupos
	fi
}

#########################################################
#			*** Función Usuarios Directorio ***
#########################################################

function modulo_dir_check(){

	echo ""
	echo " Ingrese nombre de directorio nuevo:"
	echo ""
	
	read -r directorio

	if [ -d "~$directorio" ] 
		then clear

		echo ""
		echo " ~$directorio ya existe." 
		echo ""
		
		modulo_dir_check

		else
		echo mkdir "~$directorio"
		cat "~$directorio"/bienvenido.txt

		clear
		
		echo ""
		echo " Se creó el directorio en:"
		sudo tree /home/"$directorio"
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key	

		modulo_grupos

	fi

}

#########################################################
#			*** Función Grupos Parte 1 ***
#########################################################

function modulo_grupos(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " [ Creación grupos ] Atención:"
	echo ""
	echo " En esta parte del modulo, usted ingresará un"
	echo " usuario, y primero se verificará si existe,"
	echo " de no existir se derivará al modulo de creación"
	echo " de usuarios, por el contrario si ya existe el"
	echo " usuario, podrá continuar para poder agregarlo"
	echo " a un grupo ya existente. Nota: también se"
	echo " verificará más adelante si los grupos existen."
	echo " como requisito para llegar al final del script."
	echo " y derivará al modulo de creación de grupos de"
	echo " ser necesario."
	echo "----------------------------------------------"
	echo ""
	echo " Ingresar nombre de usuario para agregar a un grupo:"
	echo ""

	read -r usuario

	if id -u "$usuario" >/dev/null 2>&1;
		then clear
		
		echo ""
		echo "El nombre $usuario ya existe y se agregará a la configuración."
		echo ""
		read -rsp "Presione cualquier tecla para proceder al siguiente paso." -n 1 key	
		echo ""
		
		modulo_grupos_p2
		
		else clear
		
		echo ""
		echo "El usuario $usuario no existe, se derivará al modulo creación de usuarios."
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar." -n 1 key		
		
		modulo_usuarios

	fi
	
}
	
#########################################################
#			*** Función Grupos Parte 2 ***
#########################################################

function modulo_grupos_p2(){

	clear

	echo ""
	echo " Ingrese nombre de grupo secundario al cual desea afiliar al usuario."
	echo ""

	read -r secundario
	
	if grep -q "$secundario" /etc/group
		then clear

		echo ""
		echo "El grupo $secundario existe y se agregará a la configuración."
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_grupos_p3

		else clear

		echo ""
		echo "El grupo $secundario no existe, se derivará al modulo creación grupo secundario."
		echo ""

		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_gsecundario

	fi
	
}
	

#########################################################
#			*** Función Grupos Parte 3 ***
#########################################################

function modulo_grupos_p3(){

	clear

	echo ""
	echo " Ingrese nombre de grupo primario al cual desea afiliar al usuario."
	echo ""

	read -r primario
	
	if grep -q "$primario" /etc/group
		then clear

		echo ""
		echo "El grupo $primario existe y se agregará a la configuración."
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_grupos_p4

		else clear

		echo ""
		echo "El grupo $primario no existe, se derivará al modulo creación grupos primario."
		echo ""

		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_gprimario

	fi
	
}

#########################################################
#			*** Función Grupos Parte 4 ***
#########################################################

function modulo_grupos_p4(){

	clear

	echo ""
	echo " El nombre de usuario es $usuario"
	echo ""
	echo " El nombre de grupo secundario es $secundario"
	echo " El nombre de grupo primario es $primario"
	echo ""
	echo " ¿Agregar el usuario a los grupos designados? [Y/n]"
	echo ""

	read -r confirmar

	if [ "$confirmar" = Y ];
		then clear

		useradd "$usuario" -G "$primario" -g "$secundario"
		
		clear

		echo ""
		echo " Se completó la operacion"
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key

		modulo_principal

	fi
	
	if [ "$confirmar" = n ];
	then clear
	
	modulo_parte3
	
	fi

}

#########################################################
#			*** Función Grupo Primario ***
#########################################################

function modulo_gprimario(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " Modulo creación Grupo Primario"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingrese nuevamente el nombre del grupo primario:"
	echo ""

	read -r primario
	
	if grep -q "$primario" /etc/group
		then clear

		echo ""
		echo "El grupo $primario ya existe, favor inténtelo de nuevo."
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_gprimario
		
		else

		echo ""
		echo " El nombre del grupo está disponible ¿Desea crear el grupo $primario? [Y/n]"
		echo ""

		read -r confirmar

		if [ "$confirmar" = Y ];
			then groupadd "$primario"
		

			echo ""
			echo " El grupo $primario ha sido creado."
			echo " Se derivará a la sección de agregar usuario a grupo."
			echo ""
		
			read -rsp "Presione cualquier tecla para continuar" -n 1 key

			modulo_grupos

		fi

		if [ "$confirmar" = n ];
			then modulo_grupos

		fi

	fi

}

#########################################################
#			*** Función Grupo Secundario ***
#########################################################

function modulo_gsecundario(){

	clear

	echo "----------------------------------------------"
	echo ""
	echo " Modulo creación Grupo Secundario"
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo " Ingrese nuevamente el nombre del grupo secundario:"
	echo ""

	read -r secundario
	
	if grep -q "$secundario" /etc/group
		then clear

		echo ""
		echo "El grupo $secundario ya existe, favor inténtelo de nuevo."
		echo ""
		
		read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
		modulo_gsecundario
		
		else

		echo ""
		echo " El nombre del grupo está disponible ¿Desea crear el grupo $secundario? [Y/n]"
		echo ""

		read -r confirmar

		if [ "$confirmar" = Y ];
			then groupadd "$secundario"
		
			echo ""
			echo " El grupo $secundario ha sido creado."
			echo " Se derivará a la sección de agregar usuario a grupo."
			echo ""
			
			read -rsp "Presione cualquier tecla para continuar" -n 1 key
		
			modulo_grupos

		fi

		if [ "$confirmar" = n ];
			then modulo_grupos

		fi

	fi

}

#########################################################
#				*** Función Salir ***
#########################################################

function modulo_salir(){

	clear

	exit 0

}

#########################################################
#					*** FIN ***
#########################################################

ejecutar
