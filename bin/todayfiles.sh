#!/bin/bash

# This script show file modified "today", starting from midnight (00:00:00)
# - without argument work in current directory
# - with arguments work in given directory

# 13-10-2021 [v. 0.1.0] - First release

WORKDIR=.

if [ $# -gt 0 ]; then
  WORKDIR=$@
fi

find $WORKDIR -type f -daystart -mtime -1 | xargs ls -lh --color=always

exit 0

