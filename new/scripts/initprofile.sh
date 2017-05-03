#!/bin/bash

PROFILE=releng
WORKDIR=./alpha1

set -e

mkdir -p ${WORKDIR}

cp -r /usr/share/archiso/configs/${PROFILE}/* ${WORKDIR}

exit 0

