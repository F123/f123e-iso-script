#!/bin/bash

set -e

ABS=./abs
REPO="/opt/pacman/x86_64/customrepo"
NAME=repo.db.tar.gz

find ${ABS} -name *.pkg.tar.xz -exec cp {} ${REPO} \;

repo-add ${REPO}/${NAME} ${REPO}/*.pkg.tar.xz

exit 0

