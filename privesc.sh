#!/bin/bash

#list of binary for suid (thanks https://gtfobins.github.io/)
binarylist='aria2c\|arp\|ash\|base32\|base64\|bash\|busybox\|capsh\|cat\|chmod\|chown\|chroot\|cp\|csh\|curl\|cut\|dash\|date\|dd\|dialog\|diff\|dmsetup\|docker\|emacs\|env\|eqn\|expand\|expect\|file\|find\|flock\|fmt\|fold\|gdb\|gimp\|grep\|gtester\|hd\|head\|hexdump\|highlight\|iconv\|ionice\|ip\|jjs\|jq\|jrunscript\|ksh\|ksshell\|ld.so\|less\|logsave\|look\|lwp-download\|lwp-request\|make\|more\|mv\|nano\|nice\|nl\|node\|nohup\|od\|openssl\|perl\|pg\|php\|pico\|python\|readelf\|restic\|rlwrap\|rpm\|rpmquery\|rsync\|run-parts\|rview\|rvim\|sed\|setarch\|shuf\|soelim\|sort\|start-stop-daemon\|stdbuf\|strace\|strings\|sysctl\|systemctl\|tac\|tail\|taskset\|tclsh\|tee\|tftp\|time\|timeout\|ul\|unexpand\|uniq\|unshare\|update-alternatives\|uudecode\|uuencode\|view\|vim\|watch\|wget\|xargs\|xxd\|xz\|zsh\|zsoelim'


clear
tput setaf 5
echo "@@@@@@@   @@@@@@@   @@@  @@@  @@@  @@@@@@@@   @@@@@@    @@@@@@@  "
echo "@@@@@@@@  @@@@@@@@  @@@  @@@  @@@  @@@@@@@@  @@@@@@@   @@@@@@@@  "
echo "@@!  @@@  @@!  @@@  @@!  @@!  @@@  @@!       !@@       !@@       "
echo "!@!  @!@  !@!  @!@  !@!  !@!  @!@  !@!       !@!       !@!       "
echo "@!@@!@!   @!@!!@!   !!@  @!@  !@!  @!!!:!    !!@@!!    !@!       "
echo "!!@!!!    !!@!@!    !!!  !@!  !!!  !!!!!:     !!@!!!   !!!       "
echo "!!:       !!: :!!   !!:  :!:  !!:  !!:            !:!  :!!       "
echo ":!:       :!:  !:!  :!:   ::!!:!   :!:           !:!   :!:       "
echo " ::       ::   :::   ::    ::::     :: ::::  :::: ::    ::: :::  "
echo " :         :   : :  :       :      : :: ::   :: : :     :: :: :  "
printf "\n \t \t \t \t \t \t BY:Arwynsharma \n"
echo ""
 
echo "Usage information"
echo "Script does not require any argument"
sleep 1
echo -n "Please pay special attention to the line written in ";tput setaf 1;echo -n "red color";tput setaf 5;echo  " Below these."
sleep 1
echo "Script is all about automation some information is only gained by manual approach."
sleep 2

tput setaf 2;echo "------------------------Device Detail-------------------------";tput setaf 7
echo "=>Hostname:$HOSTNAME"
echo "=>IP:`ifconfig | grep "inet " | cut -d " " -f10 | grep -v 127.0.0.*`"
echo "=>Logged in as:`whoami`"
echo "=>Linux Distrubution:`cat /etc/*release | grep '^ID=' | cut -d "=" -f2`"
echo "=>Linux Distrubution version:`cat /etc/*release | grep '_ID=' | cut -d "=" -f2`"
echo "=>Kernal Details:`uname -a`"
echo "=>Home Folder:$HOME"
sleep 1 

tput setaf 2;echo "------------------------LOGGED IN USERS-----------------------";tput setaf 7
w | awk '{print "=>"$1}' | tail -n+3 | sort -u
sleep 1 

tput setaf 2;echo "-------------------/etc/passwd information--------------------";tput setaf 7
tput setaf 3;echo "=> User with root power";tput setaf 7
cat /etc/passwd | awk -F: '{if($3 == 0){print "===>"$1}}'

tput setaf 3;echo "=> Normal users available with id";tput setaf 7
cat /etc/passwd | awk -F ":" '{if ($3>=1000 && $3 <=2000){print "===>"$1 "\t" $3}}'

tput setaf 3;echo "=> Hashes present in passwd(user:hash:id)";tput setaf 7
grep -v '^[^:]*:[x]' /etc/passwd | awk -F: '{print "===>"$1":"$2":"$3}'
sleep 1 

tput setaf 2;echo "----------Permission on sensitive files and location----------";tput setaf 7
for FILES in /etc/passwd /etc/group /etc/sudoers /etc/crontab
do
tput setaf 3;echo "=> $FILES information";tput setaf 1
if [[ -f $FILES ]]; then 

	if [[ -w $FILES ]];then 
		echo "===> you can write $FILES file"
	elif [[ -r $FILES ]]; then 
		tput setaf 7
		echo "===> you can only read $FILES"
	else
		tput setaf 7 
		echo "===> you can do nothing with $FILES file"
	fi
else 
	tput setaf 7
	echo "===> I don't know what's happening with this machine. But $FILES is not present." 
fi
done

for SFILES in /etc/shadow /etc/gshadow
do
tput setaf 3;echo "=> $SFILES information";tput setaf 1
if [[ -f $SFILES ]]; then

	if [[ -w $SFILES ]];then
		echo "===> you can write $SFILES file"
	elif [[ -r $SFILES ]]; then
		echo "===> you can read $SFILES file"
	else 
		tput setaf 7
		echo "you can do nothing with $SFILES file"
	fi
else
	tput setaf 7
	echo "===> I don't know what's happening with this machine. But $SFILES is not present."
fi
done


tput setaf 3;echo "=>/home/ information";tput setaf 7
if [[ -d /home/ ]]; then
	echo "==>home folder contains following directories."
		DIR=$(ls -l /home/ | grep '^d' | awk '{print $9}')
		COUNT=$(ls -l /home/ | grep '^d' | wc -l)
		for (( C=1;C<=$COUNT;C++ ))
		do
			RDIR=$(echo $DIR | cut -d " " -f$C)
			
			if [[ -w /home/$RDIR ]]; then
					if [[ $RDIR == `whoami` ]]; then
						echo "$RDIR (Directory of present user)"
					else
						echo "$RDIR `tput setaf 1`(You can write to $RDIR)`tput setaf 7`"
					fi
			else
				echo $RDIR
			fi
		done

else
	tput setaf 7
	echo "===> I don't know what's happening with this machine. But /home/ is not present."
fi

tput setaf 2;echo "-----------------------.bash_history-----------------------";tput setaf 7
foldername=(`find /home -name .bash_history -printf '%h\n' 2>/dev/null | cut -d"/" -f3`)
filename=(`find /home -name .bash_history -exec echo {}  \; 2>/dev/null`)
echo "=>Content of bash_history file of all user is created in following manner."
echo "==>USER_NAME.txt"
if [[ -w `pwd` ]];then
	for (( i=0; i<=${#foldername[@]}-1; i++ ))
	do
		if [[ -r ${filename[$i]} ]];then
			if [[ -f  ./${foldername[$i]}.txt ]]; then
				echo "file exist"
			else
				cat ${filename[$i]} > ${foldername[$i]}.txt
			fi
		fi	
	done
else
		echo "not writable"  
fi

tput setaf 2;echo "-----------------------Running Services-----------------------";tput setaf 7

tput setaf 3;echo "=> Services running on localhost";tput setaf 7
boolcom=`which netstat`
if [ "$boolcom" ];then
	localport=`netstat -nltu | grep -v Active | grep -v Proto | grep LISTEN | awk '{print $4}' | grep 127.0.0.1 | awk -F: '{print "===>"$2}' | sort -u`   
else
	localport=`ss -nltu | grep -v Netid | grep LISTEN | awk '{print $5}' | awk -F: '{print "===>"$2}' | sort -u`
fi

if [ "$localport" ];then
	echo "$localport"
else
	echo "===>No service running on localhost"
fi

tput setaf 3;echo "=> Services running for every host";tput setaf 7
if [ "$boolcom" ];then
	allhostport=`netstat -nltu | grep -v Active | grep -v Proto | grep LISTEN | awk '{print ""$4}' | grep -v 127.0.0.1 | awk -F: '{print "===>"$NF}' | sort -u | grep -v " "`
else
	allhostport=`ss -nltu | grep -v Netid | grep LISTEN | awk '{print $5}' | grep -v 127.0.0.1 | awk -F: '{print "===>"$NF}' | sort -u`
fi

if [ "$allhostport" ];then
	echo "$allhostport"
else
	echo "===>No service running for every host"
fi
#netstat -nltu | grep -v Active | grep -v Proto | grep LISTEN | awk '{print ""$4}' | grep -v 127.0.0.1 | awk -F: '{print "===>"$NF}' | sort -u | grep -v " "
#ss -nltu | grep -v Netid | grep LISTEN | awk '{print $5}' | grep -v 127.0.0.1 | awk -F: '{print "===>"$NF}' | sort -u


tput setaf 2;echo "-------------------Process running by root--------------------";tput setaf 7
ps -aux | grep root | awk '{print "=>"$1 "\t" $7 "\t" $11}' | grep -v "?"

tput setaf 2;echo "-------------------------All SUID Files------------------------";tput setaf 7
find / -perm -4000 -exec echo "=>" {} \; 2> /dev/null

tput setaf 2;echo "-------------------------Interesting SUID Files------------------------";tput setaf 7
suid=`find / -perm -4000 -type f 2>/dev/null`
intersuid=`find $suid -perm -4000 -type f -exec ls -la {} \; 2>/dev/null | grep -w $binarylist 2>/dev/null`
if [ "$intersuid" ];then
	tput setaf 1;echo "$intersuid";tput setaf 7
else
	echo "=>Noting interesting found you should check manually once"
fi

tput setaf 2;echo "--------------------------SGID Files--------------------------";tput setaf 7
sgid=find / -perm -2000 -type f -exec echo "=>" {} \; 2>/dev/null

if [ "$sgid" ];then
	tput setaf 1;echo "$sgid";tput setaf 7
else
	echo "=>No SGID files found"
fi

tput setaf 2;echo "-------------------Files with capabilities--------------------";tput setaf 7
cap=getcap -r / 2>/dev/null | awk '{print "=>"$0}'|| /sbin/getcap -r / | awk '{print "=>"$0}'2>/dev/null

if [ "$cap" ];then
	tput setaf 1;echo "$cap";tput setaf 7
else
	echo "=>No files with capabilities found"
fi

tput setaf 2;echo "--------------------World writable files----------------------";tput setaf 7
wwf=find / ! -path "*/proc/*" ! -path "/sys/*" -perm -2 -type f -exec ls -la {} 2>/dev/null \;

if [ "$wwf" ];then
	tput setaf 1;echo "$wwf";tput setaf 7
else
	echo "=>No world writable file found"
fi

tput setaf 2;echo "--------------------SSH Private Key files---------------------";tput setaf 7
ssh_key=`grep -rl "PRIVATE KEY-----" /home 2>/dev/null | awk '{print "=>"$0}'  `

if [ "$ssh_key" ];then
	tput setaf 1;echo "$ssh_key";tput setaf 7
else
	echo "=>No ssh key found"
fi




#world writable files after removing proc sys 
#find / ! -path "*/proc/*" ! -path "/sys/*" -perm -2 -type f -exec ls -la {} 2>/dev/null \;
