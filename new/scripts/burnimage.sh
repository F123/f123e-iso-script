#!/bin/bash
#
# You might have to change the name of the device in this script
#

if [ ! -f ${1} ]; then
    echo "File does not exist"
    exit 1
fi

cdrecord -v -sao dev=/dev/sr0 ${1}


#growisofs -dvd-compat -Z /dev/sr0=isoimage.iso
