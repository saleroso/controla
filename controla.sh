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
date="`ls -la | grep controla*.sh | cut -c30-36`"
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
  echo -e $okegreen"     \__.' .|-' /   $white"[$okegreen--$white] $cyan"     Creado por:  $red"S4l3r0s0"             $white[$okegreen--$white] "
  echo -e $okegreen"     L   /|o'--'\   $white"[$okegreen--$white] $cyan"          Fecha: $red"$date"-2017          $white[$okegreen--$white]"
  echo -e $okegreen"     |  /\/\/\   \  $white"[$okegreen--$white] $cyan"        Versión:  $red"$version"                $white[$okegreen--$white]"
  echo -e $okegreen"     J /      \.__\ $white"[$okegreen--$white] $cyan"        Sígueme: $red"No me busques"         $white[$okegreen--$white]"
  echo -e $okegreen"     |/         /   $white"[$okegreen--$white] $cyan"                                       $white[$okegreen--$white]"
}
mensaje_banner(){
echo -e $red""
cat << "EOT"
              _\|/_                                              _\|/_
              (o o)                                              (o o)
      +----oOO-{_}-OOo----------------------------------------oOO-{_}-OOo----+
      |                         AVISO IMPORTANTE!!!                          |
      |                                                                      |
      |   PARA EL USO DE ESTE SCRIPT ES NECESARIO TENER CONEXIÓN A INTERNET  |
      |  SCRIPT CREADO CON EL FIN DE PRACTICAR CON PROGRAMACION BASH, NO ME  |
      |  HAGO RESPONSABLE DEL MAL USO QUE SE HAGA DEL MISMO.                 |
      +----------------------------------------------------------------------+
EOT
echo -e $okegreen""
}

banner
sleep 1
echo ""
mensaje_banner
sleep 2
echo -e "Actualizando script..."
rm program.sh 2> /dev/null
git clone https://www.github.com/saleroso/controla 2> /dev/null
cd controla 2> /dev/null
rm controla.sh 2> /dev/null 
mv program.sh ../
mv README.md ../
cd ../
rm -r controla 2> /dev/null
down="`find program.sh`"
chmod +x $down
sleep 2
echo -e  "Script actualizado a la versión más reciente."
echo -e "Iniciando script..."
sleep 1
./$down
