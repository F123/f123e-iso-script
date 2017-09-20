#!/bin/bash

set -e

ABS=../abs
ARCH=x86_64
REPO="/opt/pacman/${ARCH}/f123elivecd"
NAME=f123elivecd.db.tar.gz

find ${ABS} -name *.pkg.tar.xz -exec cp {} ${REPO} \;

repo-add ${REPO}/${NAME} ${REPO}/*.pkg.tar.xz

exit 0

