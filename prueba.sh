#! /bin/bash
clear
DEL="\\x08\\x08\\x08\\x08\\x08\\x08\\x08\\x08\\x08\\x08"
DEL8="\\x08\\x08\\x08\\x08\\x08\\x08"
SPEED=1

#Colores
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'

#Algunas variables
date="`ls -la | grep controla.sh | cut -c30-35`"
version="1.0.0"
mac=
interfaces="`ifconfig | cut -c 1-4 | grep eth[0-9]` `ifconfig | cut -c 1-5 | grep wlan*` Volver"
menu4nonimizer="Ocultar IP Cambiar_IP Cambiar_región Actualizar Reinstalar Volver"
aplicaciones="4nonimizer bettercap macchanger nmap"

#banner
function banner() {
echo -e $okegreen""
  echo -e $okegreen"         ____                                                       "
  echo -e $okegreen"        |    |       $okegreen _____  _____  _   _  _____ ______  _____  _       ___"                                        
  echo -e $okegreen"        |____|      $okegreen /  __ \|  _  || \ | ||_   _|| ___ \|  _  || |     / _ \ "
  echo -e $okegreen"       _|____|_     $okegreen | /  \/| | | ||  \| |  | |  | |_/ /| | | || |    / /_\ \ "
  echo -e $okegreen"        /  $white"ee"\_$okegreen      | |    | | | ||  . \`|  | |  |    / | | | || |    |  _  | "
  echo -e $okegreen"      .<     __O     $okegreen| \__/\\ \_/ /| \  | |  | |  |  \ \ \ \_/ /| |____| | | | "
  echo -e $okegreen"     /\ \.-.' \      $okegreen \____/ \___/ \_| \_/  \_/  \_| \_| \___/ \_____/\_| |_/ "
  echo -e $okegreen"    J  \.|'.\/ \                                            "
  echo -e $okegreen"    | |_.|. | | |   $white"[$okegreen--$white] $cyan " $white""      Control de red local           $white[$okegreen--$white]"
  echo -e $okegreen"     \__.' .|-' /   $white"[$okegreen--$white] $cyan"     Creado por: $red"Raúl Lucena"           $white[$okegreen--$white] "
  echo -e $okegreen"     L   /|o'--'\   $white"[$okegreen--$white] $cyan"          Fecha: $red"$date"-2017           $white[$okegreen--$white]"
  echo -e $okegreen"     |  /\/\/\   \  $white"[$okegreen--$white] $cyan"        Versión:  $red"$version"                $white[$okegreen--$white]"
  echo -e $okegreen"     J /      \.__\ $white"[$okegreen--$white] $cyan"        Sígueme: $red"No me busques"         $white[$okegreen--$white]"
  echo -e $okegreen"     |/         /   $white"[$okegreen--$white] $cyan"                                       $white[$okegreen--$white]"
}

trap ctrl_c INT
ctrl_c() {
clear
echo -e $red"[*] (Ctrl + C ) Detectado, Saliendo del Script..."
sleep 1
echo "" 
echo -e $red"[*] Parando servicios iniciados, espere ..."
sleep 1
4nonimizer stop > /dev/null
echo ""
rm lista.txt 2> /dev/null
rm -r 4nonimizer 2> /dev/null
echo -e $red"[*] Eliminando archivos temporales creados, espere ..."
sleep 1
echo ""
echo -e $yellow"[*] Gracias por utilizar CONTROLA  =)."
exit
}

#Función progreso
function progreso() {
echo ""
PID="`ps -a | grep nmap | cut -f1 -d" "`"
while [ -d /proc/$PID ];
do
    echo -en "E---------" && sleep $SPEED && echo -en $DEL
    echo -en "Es--------" && sleep $SPEED && echo -en $DEL
    echo -en "Esc-------" && sleep $SPEED && echo -en $DEL
    echo -en "Esca------" && sleep $SPEED && echo -en $DEL
    echo -en "Escan-----" && sleep $SPEED && echo -en $DEL
    echo -en "Escane----" && sleep $SPEED && echo -en $DEL
    echo -en "Escanea---" && sleep $SPEED && echo -en $DEL
    echo -en "Escanean--" && sleep $SPEED && echo -en $DEL
    echo -en "Escaneand-" && sleep $SPEED && echo -en $DEL
    echo -en "Escaneando" && sleep $SPEED && echo -en $DEL
    echo -en "----------" && sleep $SPEED && echo -en $DEL
done
echo -en $DEL"          "$DEL
}

#Comprobamos si 4nonimizer está instalado
function instalado4nonimizer() {
aux2=$(ls /opt | grep "4no*")
if `echo "$aux2" | grep "4no*" >/dev/null`
then
return 1
else
return 0
fi
}

#Comprobamos si bettercap está instalado
function instaladobetter() {
aux=$(aptitude show bettercap | grep "Estado: instalado")
if `echo "$aux" | grep "Estado: instalado" >/dev/null`
then
return 1
else
return 0
fi
}

#Menú 4nonimizer
function func4nonimizer() {
clear
banner
menulista="7"
echo -e $cyan" "
while [ $menulista -ne 6 ]
do
echo -e $cyan"1) Ocultar IP"
echo -e $cyan"2) Cambiar IP"
echo -e $cyan"3) Actualizar 4nonimizer"
echo -e $cyan"4) Reinstalar 4nonimizer"
echo -e $cyan"5) Desactivar 4nonimizer"
echo -e $cyan"6) Volver"
echo -e $cyan" "
echo -e $okegreen" Elige una opción: "$cyan
read menulista
case $menulista in
1) 4nonimizer start ; func4nonimizer ;;
2) 4nonimizer change_ip ; func4nonimizer ;;
3) 4nonimizer update_app &> /dev/null && echo " " ; echo -e $white"Aplicación actualizada "$white ; echo " " ;;
4) 4nonimizer reinstall ;;
5) 4nonimizer stop ;;
6) menuprincipal ;;
*) echo -e $red"Elige una opción valida del menú"$cyan ; func4nonimizer ;;
esac
done
echo -e ""$okegreen
}


#Cambiar MAC
function cambiarmac() {
echo " "
select menumac in ${interfaces[@]}
do
if [[ $menumac = "Volver" ]]
then
break
else
sudo ifconfig $menumac down
echo -e $BlueF"La interfaz de red $menumac ha cambiado su mac"$okegreen
sudo macchanger -r $menumac -p
sudo ifconfig $menumac up
echo " "
break
fi
done
}

#Introducir IP a escanear
function scannernmap() {
echo ""
read -p "Introduce la puerta de enlace: " penlace
if [ -f lista.txt ];
then
echo ""
echo -e $okegreen"Analizando la red local..."
else
echo ""
echo -e $okegreen"Analizando la red local..."
touch lista.txt
fi
nmap -f -sP $penlace/24 > lista.txt&
progreso
echo "-----------------------------------------"
echo " "
#Menú bettercap
lista="`grep -o 192.* lista.txt` Volver"
PS3="Selecciona una opción: "
select e in ${lista[@]}
do
if [[ $e = "Volver" ]]
then
echo " "
menuprincipal
else
gnome-terminal -e "bettercap -X -T $e --gateway $penlace -O capturas.txt"
fi
done
}

#Comprobar e instalar 4nonimizer
function comp4nonimizer() {
instalado4nonimizer $1 &> /dev/null
if [ "$?" = "1" ]
then
echo -e $BlueF"[✔] 4nonimizer ya está instalado. "$okegreen 
sleep 1
else
echo el paquete 4nonimizer no está instalado, descargando e instalando.
echo espere...
git clone https://github.com/Hackplayers/4nonimizer
cd 4nonimizer
chmod +x 4nonimizer
echo "Para continuar espera que finalice el proceso de instalación de 4nonimizer"
sleep 0.05
gnome-terminal -e "./4nonimizer install"
echo "[✔] 4nonimizer ha sido instalado. "
fi
echo " "
}

#Funcion comprobar e instalar bettercap
function compbetter() { 
instaladobetter $1 &> /dev/null
if [ "$?" = "1" ]
then
echo -e $BlueF"[✔] bettercap ya está instalado. "
sleep 1
else
echo el paquete no está instalado, descargando e instalando.
echo espere...
apt-get install bettercap
echo "[✔] bettercap ha sido instalado. "
sleep 1
fi
}

#Menú WPscan
function menuwpscan() {
clear
banner
echo -e $okegreen""
opcioneswp="0"
while [ $opcioneswp -ne 6 ]
do
echo -e " Menú WPSCAN"
echo ""
echo -e "1) Analizar sitio y listar usuarios"
echo -e "2) Por definir"
echo -e "3) Actualizar WPscan"
echo -e "4) Manual WPscan"
echo -e "5) Volver"
echo ""
read -p " Elige una opción del menú: " opcioneswp
case $opcioneswp in
1) read -p "Introduce IP o url: " url ; gnome-terminal -e "wpscan --url $url -e [u,vp,vt] " ;;
2) menuwpscan ;;
3) wpscan --update &> /dev/null ; echo "" ;echo -e "WPscan ha sido actualizado! " ; echo "" ; menuwpscan ;;
4) wpscan --help ;;
5) externo ;;
*) echo -e $red"Introduzca una opción válida..." ; menuwpscan ;;
esac
done
}


#Externo
function externo() {
clear
banner
echo -e $okegreen""
opcionesext="0"
while [ $opcionesext -ne 6 ]
do
echo -e "MENÚ EXTERNO"
echo ""
echo -e "1) WPscan"
echo -e "2) RED HAWK (Escaner VPS)"
echo -e "3) WPSeku"
echo -e "4) Volver"
echo ""
read -p " Elige una opción del menú: " opcionesext
case $opcionesext in
1) menuwpscan ;;
2) git clone https://github.com/Tuhinshubhra/RED_HAWK 2> /dev/null ; cd RED_HAWK ; chmod +x rhawk.php ; php rhawk.php ; cd .. ;;
3) git clone https://github.com/m4ll0k/WPSeku 2> /dev/null ; cd WPSeku ; chmod +x wpseku.py ; read -p " Introduce la url a escanear: " urlseku ; gnome-terminal -e "./wpseku.py -u $urlseku -p [x,l,s]" ; cd .. ;;
4) menuprincipal ;;
*) echo -e $red"Introduzca una opción válida..." ; externo ;;
esac
done
}


#Menú principal
function  menuprincipal() {
clear
banner
echo -e $okegreen""
opciones="0" 
while [ $opciones -ne 6 ]
do
echo -e "MENÚ PRINCIPAl"
echo ""
echo -e "1) Cambiar MAC"
echo -e "2) Ocultar IP (Necesario instalar o tener instalado 4nonimizer)"
echo -e "3) Analizar red (Necesario instalar o tener instalado bettercap)"
echo -e "4) Análisis externo"
echo -e "5) Salir"
echo ""
read -p " Elige una opción del menú: " opciones
echo ""
case $opciones in 
1) cambiarmac ;;
2) comp4nonimizer ; func4nonimizer ;;
3) compbetter ; scannernmap ;;
4) externo ;;
5) rm lista.txt 2> /dev/null ;  rm -r 4nonimizer 2> /dev/null ;echo -e $red"Eliminando archivos creados..."$white ; gnome-terminal -e "4nonimizer stop" &> /dev/null ;  echo -e "[*] Gracias por utilizar CONTROLA " ; exit ;;
*) echo -e $red"Introduce una opción correcta del menú."$white ; menuprincipal ;;
esac
done
}

#script
menuprincipal
