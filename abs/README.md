
# Custom Local Repository

## Arch Build System (`abs`)

Each of the directories in this directory contains a 	PKGBUILD	 and associated files 
downloaded with `yaourt`.

I have done this in order to create a custom local repository on the Cd so that packages from the 
`AUR` can be installed non-interactively, for the benefit of inexperienced Linux users.

Some of the packages needed in F123e have complex dependencies, such as Emacspeak which needs tclx 
and tcl.

The custome local repository resides in:

	/opt/pacman/x86_64/f123elivecd

On the development machine.

### Build the Repository

First clear out old contents in `/opt/pacman/x86_64/f123elivecd, and then go into each directory and 
run:

	makepkg

Copy the *.pkg.tar.xz to /opt/pacman/x86_64/f123elivecd.

When all the packages you want in the custom repo are in the right place run:

	cd /opt/pacman/x86_64/f123elivecd
	sudo repo-add f123elivecd.db.tar.gz *.pkg.tar.xz

Now add this to the bottom of the `pacman.conf` in `configs/f123e`:

	[f123elivecd]
	SigLevel = Optional TrustAll
	Server = file:///opt/pacman/x86_64/f123elivecd

Then the bootable Cd will contain this repository which can be used to install packages it contains 
with `pacman`.

For example:

	pacman -S tclx

Which can be incorporated into the install scripts to save some complexity for inexperienced users.


