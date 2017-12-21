
# ISO Custom Repository

In order to be able to install custom packages, and packages from the AUR when 
running install operations from the booted ISO, a custom repository is created 
in the directory in the development tree which will be copied to the ISO.

It is found in:

	f123e-iso-script/configs/f123e/airootfs/opt/pacman/x86_64/f123elivecd

Read `build_machine_custom_repository.md` in this directory for more information 
about building this custom repository.

Unlike the custom repository which is contained in the `/opt` directory of the 
build machine, it should only contain packages which it is intended to install 
from the booted ISO onto the target machine.


Use selected PKGBUILD files in the abs directory in this repository to create 
packages, put them in the right place and then:

	repo-add f123elivecd.db.tar.gz *.xz


See the Arch Wiki for more stuff about custom repos and the use of both repo-add 
and repo-remove.

## Check which Packages are Used

Check which packages you need to include in the custom repo by looking in:
	
f123e-iso-script/configs/f123e/airootfs/root/package_lists/f123e.base.pkglist

The above file is a package list which is read by the `easy_base_install.sh` 
script which can be found in the `/root` directory when the ISO is booted.





