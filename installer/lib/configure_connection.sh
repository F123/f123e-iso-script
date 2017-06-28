#!/bin/bash
###############################################################
### Arch Linux Anywhere Install Script
### configure_connection.sh
###
### Copyright (C) 2017 Dylan Schacht
###
### By: Dylan Schacht (deadhead)
### Email: deadhead3492@gmail.com
### Webpage: http://arch-anywhere.org
###
### Any questions, comments, or bug reports may be sent to above
### email address. Enjoy, and keep on using Arch.
###
### License: GPL v2.0
###############################################################

update_mirrors() {

	op_title="$welcome_op_msg"
	if ! (dialog --yes-button "$yes" --no-button "$no" --yesno "\n$intro_msg" 10 60) then
		reset ; exit
	fi

	## Until connected loop
	until wget -q --spider github.com &>/dev/null
	  do
		if [ -n "$wifi_network" ]; then
			if (dialog --yes-button "$yes" --no-button "$no" --yesno "\n$wifi_msg0" 10 60) then
				wifi-menu
				if [ "$?" -gt "0" ]; then
					dialog --ok-button "$ok" --msgbox "\n$wifi_msg1" 10 60
					echo "$(date -u "+%F %H:%M") : Failed to connect to wifi: Exit 1" >> "$log"
					setterm -background black -store ; reset ; echo "$connect_err1" | sed 's/\\Z1//;s/\\Zn//' ; exit 1
				else
					echo "$(date -u "+%F %H:%M") : Connected to: $wifi_network" >> "$log"
				fi
			else
				unset wifi_network
			fi
		else
			dialog --ok-button "$ok" --msgbox "\n$connect_err0" 10 60
			echo "$(date -u "+%F %H:%M") : Failed to connect to network: Exit 1" >> "$log"
			setterm -background black -store ; reset ; echo -e "$connect_err1" | sed 's/\\Z1//;s/\\Zn//' ;  exit 1
		fi
	done

	if ! (</etc/pacman.d/mirrorlist grep "rankmirrors" &>/dev/null); then
		op_title="$mirror_op_msg"
		code=$(dialog --nocancel --ok-button "$ok" --menu "$mirror_msg1" 17 60 10 \
			"$default" "->" \
			$countries 3>&1 1>&2 2>&3)

		case "$code" in
			"$default")
				mirror_url="https://www.archlinux.org/mirrorlist/all/"
			;;
			"AS")	## All https mirrors
				mirror_url="https://www.archlinux.org/mirrorlist/all/https/"
			;;
			*)	## User selected country
				mirror_url="https://www.archlinux.org/mirrorlist/?country=$code"
			;;
		esac

		if [ "$code" == "$default" ]; then
			curl -s "$mirror_url" | sed '10,1000d;s/#//' >/etc/pacman.d/mirrorlist.bak &
		else
			curl -s "$mirror_url" >/etc/pacman.d/mirrorlist.bak &
		fi
		pid=$! pri=0.1 msg="\n$mirror_load0 \n\n \Z1> \Z2curl $mirror_url\Zn" load

		if (grep "Server" /etc/pacman.d/mirrorlist.bak &>/dev/null); then
			echo "$(date -u "+%F %H:%M") : Updated Mirrors From: $code" >> "$log"
			sed -i 's/#//' /etc/pacman.d/mirrorlist.bak
			rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist &
		 	pid=$! pri=0.8 msg="\n$mirror_load1 \n\n \Z1> \Z2rankmirrors -n 6 /etc/pacman.d/mirrorlist\Zn" load
		else
			dialog --ok-button "$ok" --msgbox "\n$connect_err0" 10 60
			echo "$(date -u "+%F %H:%M") : Failed to connect to wifi: Exit 1" >> "$log"
			setterm -background black -store ; reset ; echo -e "$connect_err1" | sed 's/\\Z1//;s/\\Zn//' ;  exit 1
		fi
	fi

}

check_connection() {

	op_title="$connection_op_msg"
	(test_mirror=$(</etc/pacman.d/mirrorlist grep "^Server" | awk 'NR==1{print $3}' | sed 's/$.*//')
	test_pkg=$(curl -s https://www.archlinux.org/packages/extra/i686/bluez-utils/ | grep "<title>" | awk '{print $4"-"$5}')
	test_link="${test_mirror}extra/os/i686/${test_pkg}-i686.pkg.tar.xz"
	wget -4 --no-check-certificate --append-output=/tmp/wget.log -O /dev/null "${test_link}") &
	pid=$! pri=0.3 msg="\n$connection_load \n\n \Z1> \Z2wget -O /dev/null test_link/test1Mb.db\Zn" load

	sed -i 's/\,/\./' /tmp/wget.log
	connection_speed=$(tail /tmp/wget.log | grep -oP '(?<=\().*(?=\))' | awk '{print $1}')
	connection_rate=$(tail /tmp/wget.log | grep -oP '(?<=\().*(?=\))' | awk '{print $2}')

	if (lscpu | grep "max MHz" &>/dev/null); then
		cpu_mhz=$(lscpu | grep "CPU max MHz" | awk '{print $4}' | sed 's/\..*//')
	else
		cpu_mhz=$(lscpu | grep "CPU MHz" | awk '{print $3}' | sed 's/\..*//')
	fi

	case "$cpu_mhz" in
		[0-9][0-9][0-9])
			cpu_sleep=4.5
		;;
		[1][0-9][0-9][0-9])
			cpu_sleep=4
		;;
		[2][0-9][0-9][0-9])
			cpu_sleep=3.5
		;;
		*)
			cpu_sleep=2.5
		;;
	esac

	export connection_speed connection_rate cpu_sleep
	echo "$(date -u "+%F %H:%M") : Ranked connection speed: $connection_speed $connection_rate" >> "$log"
	echo "$(date -u "+%F %H:%M") : Clocked CPU MHz: $cpu_mhz" >> "$log"
	rm /tmp/wget.log &> /dev/null

}
