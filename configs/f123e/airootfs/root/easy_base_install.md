
# F123e

# `easy_base_install.sh`

This script will install the base F123e base (Arch Linux) system.

When the installation media has booted, run like this from the `root` 
directory:

	./easy_base_install.sh

You will be presented with a menu showing the choice of hard-drives 
for the installation.

The menu automatically excludes the device from which the installtion 
media has been booted, if it is booted from a USB thumb drive, or a CD 
or DVD.

The final choice on the menu is `Exit`, which will exit the script 
without continuing to install the system.

Immediately you have chosen the drive, all existing partitions and 
data on that device will be destroyed.

The script then continues to install the base system.

This does not include a graphical desktop environment at this time.

The hostname will be set to `f123e`, the root password is set to 
`root`, a user named `f123` is added, with the password `1234`.

When the script completes, remove the boot media and then type 
`reboot`.

On first reboot the system will take a little longer than normal to 
complete the boot cycle.


