#!/bin/bash
main(){
    echo "ADMIN CONTROL PANNEL "
    echo ""
    echo "Votre choix :  "
    echo ""
    echo "1 = /var/log/auth.log   : AUTORISQATION INFORMATION SYSTEM"
    echo "2 = /var/log/syslog     : ALL MESSAGE "
    echo "3 = /var/log/dpkg.log   : PACKET LOG"
    echo "4 = /var/log/dmesg      : KERNEL LOG ( Does not work on all machines )"
    echo ""

}



LOGFILE=${1:-/var/log/auth.log}
LOGFILE2=${1:-/var/log/syslog}
LOGFILE3=${1:-/var/log/messages}
LOGFILE4=${1:-/var/log/dmesg}

message(){

PARSER='{font=""; color="#FFFFFF"}; \
/kernel/ {font="italic"}; \
/warn/ {color="#FFF4B8"}; \
/error/ {color="#FFD0D8"}; \
OFS="\n" {print $1 " " $2, $3, $4, substr($5,0,index($5,":")-1), \
substr($0,index($0,$6)), font, color; fflush()}'

tail -f $LOGFILE3 | awk "$PARSER" | \
yad --title="Administration Log Pannel" --window-icon=logviewer \
    --geometry 1600x750 \
    --list --text="Log de $LOGFILE3" \
    --column Date --column Time --column Host \
    --column Tag --column Message:TIP \
    --column @font@ --column @back@ \
    --button="Système log:0"  --button="Message log:1"  --button="Auth log:2" --button="Log Noyau:3" --button=gtk-close 
    	case $? in 
		0) 
			syslog;; 
		1)  
			message;; 
		2)
			authlog;;
        3)
            noyau;;
        esac

}


syslog(){
    
PARSER='{font=""; color="#FFFFFF"}; \
/kernel/ {font="italic"}; \
/warn/ {color="#FFF4B8"}; \
/error/ {color="#FFD0D8"}; \
OFS="\n" {print $1 " " $2, $3, $4, substr($5,0,index($5,":")-1), \
substr($0,index($0,$6)), font, color; fflush()}'

tail -f $LOGFILE2 | awk "$PARSER" | \
yad --title="Administration Log Pannel" --window-icon=logviewer \
    --geometry 1600x750 \
    --list --text="Log de $LOGFILE2" \
    --column Date --column Time --column Host \
    --column Tag --column Message:TIP \
    --column @font@ --column @back@ \
    --button="Système log:0"  --button="Message log:1"  --button="Auth log:2" --button="Log Noyau:3" --button=gtk-close 
    	case $? in 
		0) 
			syslog;;
		1)  
			message;; 
		2)
			authlog;;
        3)
            noyau;;
        esac
        

}

authlog(){

PARSER='{font=""; color="#FFFFFF"}; \
/kernel/ {font="italic"}; \
/warn/ {color="#FFF4B8"}; \
/error/ {color="#FFD0D8"}; \
OFS="\n" {print $1 " " $2, $3, $4, substr($5,0,index($5,":")-1), \
substr($0,index($0,$6)), font, color; fflush()}'

tail -f $LOGFILE | awk "$PARSER" | \
yad --title="Administration Log Pannel" --window-icon=logviewer \
    --geometry 1600x750 \
    --list --text="Log de $LOGFILE" \
    --column Date --column Time --column Host \
    --column Tag --column Message:TIP \
    --column @font@ --column @back@ \
    --button="Système log:0"  --button="Message log:1"  --button="Auth log:2" --button="Log Noyau:3" --button=gtk-close 
    	case $? in 
		0) 
			syslog;; 
		1)  
			message;; 
		2)
			authlog;;
        3)
            noyau;;
        esac

}


noyau(){
    
PARSER='{font=""; color="#FFFFFF"}; \
/kernel/ {font="italic"}; \
/warn/ {color="#FFF4B8"}; \
/error/ {color="#FFD0D8"}; \
OFS="\n" {print $1 " " $2, $3, $4, substr($5,0,index($5,":")-1), \
substr($0,index($0,$6)), font, color; fflush()}'

tail -f $LOGFILE4 | awk "$PARSER" | \
yad --title="Administration Log Pannel" --window-icon=logviewer \
    --geometry 1600x750 \
    --list --text="Log de $LOGFILE" \
    --column Date --column Time --column Host \
    --column Tag --column Message:TIP \
    --column @font@ --column @back@ \
    --button="Système log:0"  --button="Message log:1"  --button="Auth log:2" --button="Log Noyau:3" --button=gtk-close 
    	case $? in 
		0) 
			syslog;; 
		1)  
			message;; 
		2)
			authlog;;
        3)
            noyau;;
        esac

}


main




read -p "Entrez votre choix : " user

echo "Votre choix est $user"

if [ $user == "1" ]
then

    authlog



elif [ $user == "2" ]
then

    syslog


elif [ $user == "3" ]
then

    message

elif [ $user == "4" ]
then
    noyau


else
    echo "choix indisponible"

fi




