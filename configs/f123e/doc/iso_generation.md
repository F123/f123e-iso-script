
# F123e Arch ISO Generation

## x86_64 Only

Now that support for i686 has ceased in Arch, F123e (Arch) will only support 
x86_64.

## Origins

The build system is based on *archiso* and on Kyle's Talking Arch. With 
additions.

https://wiki.archlinux.org/index.php/archiso

To generate an ISO run the *build.sh* script in:

	f123e-iso-script/configs/f123e

This will create output in two directories, the names of which are fixed in the 
top of build.sh. Read the code.

## Persistence

If errors happen, remember to delete the work directory, for errors will persist 
if this is not removed, and if errors are caused which result in erroneous 
output here.

## ISO Boot

Currently the ISO is set up to beep, and then beep again after ten seconds and 
then boot.

A chord will be heard when booting is complete.

Read thestuff in ./configs/f123e/syslinux/ directory to learn about which 
options are available on the boot menu between the first and second beep.

I think I have set up the boot menus to be intense white on black throughout. 
But can't confirm this as I can't see at all.

## Installation System

Currently no user-friendly installation system exists but I was intending to 
create something by editing the files of the `Arch Anywhere Installer`.

## Easy Install Script

When the resulting `.iso` is written to bootable media and booted, a script 
called:

	easy_base_install.sh

Will be found in the directory `/root`.

When run it will install f123e.

See `easy_base_install.md`, also in `/root` for more information.

## Screen-readers and Multi-lingual Support

We should aim to replace speakup with fenrir as soon as possible in order to 
support languages which need Unicode UTF-8 fonts out-of-the-box.

Any multi-lingual installation system will need the console to use a font which 
supports the characters of many languages.

 



