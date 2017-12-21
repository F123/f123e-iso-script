#!/bin/bash



device_menu() {
	exclude=$(df -h | grep "/run/archiso/bootmnt" | sed 's|/dev/\(.\{3\}\).|\1|' | cut -f1 -d' ')
	[ -z ${exclude} ] && exclude=/dev/xxx
	devicelist=$(ls /dev/sd? | grep -v ${exclude})
	PS3='Hard-disk for installation of F123? > '

	until [ "${device}" == "Exit" ]
	do
		printf "%b" "\a\n\nSelect a directory to process:\n" >&2
		select device in ${devicelist} Exit
		do
			if [ "${device}" == "Exit" ]; then
				REPLY=0
				break
			elif [ -n "${device}" ]; then
				# Do something here
				break 2
			else
				echo "Invalid selection!"
			fi
		done
	done
}


#-- main code

hostname=f123e
rootpwd=root
user=f123
userpwd=1234

region=Europe
city=London
keymap=uk
locale="en_GB"

set -e

device_menu

if [ "${REPLY}" == "0" ]; then
	# exited from device menu without selecting a device
	echo "Exited"
	exit 0
fi


echo "Wiping the ${device} device of all partitions..."
dd bs=1M count=2 if=/dev/zero of=${device}

echo "Makeing a new primary partition on device ${device}..."
fdisk "${device}" <<EOF
n
p
1


w
EOF

partition="${device}1"

echo "Making an ext4 file-system on partition ${partition}..."
mkfs.ext4 "${partition}"


echo "Mounting the disk partition..."
mount "${partition}" /mnt

echo "Pacstrapping the new system in what will be the chroot..."
pacstrap /mnt --needed --noprogressbar - < ./package_lists/f123e.base.pkglist

echo "Setting up fstab..."
genfstab -U -p /mnt >> /mnt/etc/fstab

sync

#
# Write a 'here' script into the chroot before we chroot
#
cat <<EOF > /mnt/root/easy_install_chroot.sh
#!/bin/bash

set -e

echo "Setting up localisation stuff..."
sed -i "s:#${locale}.UTF-8 UTF-8:${locale}.UTF-8 UTF-8:" /etc/locale.gen
echo "LANG=${locale}.UTF-8" > /etc/locale.conf
export LANG="${locale}.UTF-8"
locale-gen

echo "Removing /etc/localtime if it exists before replacing it..."
[ -f /etc/localtime ] && rm /etc/localtime
ln -s /usr/share/zoneinfo/${region}/${city} /etc/localtime

echo "Setting up keymap..."
echo "KEYMAP=${keymap}" > /etc/vconsole.conf

echo "Setting the hardware clock..."
hwclock --systohc --utc

echo "Setting the hostname..."
echo "${hostname}" > /etc/hostname

echo "Setting the root password..."
echo -e "${rootpwd}\n${rootpwd}\n" | passwd root

echo "Adding an ordinary user..."
useradd -m -g users -G wheel,storage,power,audio -s /bin/bash "${user}"
echo -e "${userpwd}\n${userpwd}\n" | passwd "${user}"

echo "Editing /etc/sudoers to grant the usual privileges..."
sed -i 's:# %wheel ALL=(ALL) ALL: %wheel ALL=(ALL) ALL:' /etc/sudoers

echo "Installing grub..."
pacman -S --noconfirm --noprogress grub-bios

echo "Setting up grub..."
grub-install --target=i386-pc --recheck "${device}"
grub-mkconfig -o /boot/grub/grub.cfg

echo "Setting some stuff in /etc/hosts.allow..."
echo "SSHD: ALL" >> /etc/hosts.allow

echo "Enabling the sshd service..."
systemctl enable sshd.service

echo "Enabling the dhcpcd service..."
systemctl enable dhcpcd.service

echo "Enabling the espeakup service..."
systemctl enable espeakup.service

echo "Enabling the ntpd service..."
systemctl enable ntpd.service

EOF


# Mark the created here script executable
chmod +x /mnt/root/easy_install_chroot.sh


arch-chroot /mnt /root/easy_install_chroot.sh

sync

rm /mnt/root/easy_install_chroot.sh
umount /mnt



echo "All done"

exit 0
