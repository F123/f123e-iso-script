
# Custom Repository

Currently a custom repository is created on the development machine so stuff 
from the AUR and from custom code can be installed on the installation CD.

This fragment is at the bottom of the pacman.conf which is used by the process 
which generates the ISO:


	[f123elivecd]
	SigLevel = Optional TrustAll
	Server = file:///opt/pacman/x86_64/f123elivecd

It can be seen from this fragment where the custom repository is and what it 
should be called.

Use all the PKGBUILD files in the abs directory in this repository to create 
packages, put them in the right place and then:

	repo-add f123elivecd.db.tar.gz *.xz


See the Arch Wiki for more stuff about custom repos and the use of both repo-add 
and repo-remove.

## Check which Packages are Used

Check which packages you need to include in the custom repo by looking in:

	./configs/f123e/packages.x86_64



