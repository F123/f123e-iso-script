#!/bin/bash

set -e

find ./abs -name *.pkg.tar.xz -exec cp {} ./customrepo/x86_64 \;

repo-add customrepo/x86_64/customrepo.db.tar.gz customrepo/x86_64/*.pkg.tar.xz

exit 0

