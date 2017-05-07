#!/bin/bash

set -e

ABS=./abs
REPO="/opt/pacman/x86_64/customrepo"
NAME=repo



#find ${ABS} -name *.pkg.tar.xz -exec cp {} ${REPO} \;
ls "${ABS}/*.pkg.tar.xz"

#repo-add /opt/pacman/x86_64/customrepo/repo.tar.gz 

#repo-add /opt/customrepo/x86_64/customrepo.db.tar.gz /opt/customrepo/x86_64/*.pkg.tar.xz

exit 0

