#!/bin/bash

set -e

find ./abs -name *.pkg.tar.xz -exec cp {} /opt/customrepo/x86_64 \;

repo-add /opt/customrepo/x86_64/customrepo.db.tar.gz /opt/customrepo/x86_64/*.pkg.tar.xz

exit 0

