#!/bin/bash

# Simple date info
DAY=`date +%d`
MONTH=`date +%m`
YEAR=`date +%Y`
TIME=`date +%H.%M.%S`

# Set directory and names
FILENAME="backup-$YEAR-$MONTH-$DAY-$TIME.tar.gz"
SRCDIR="/web_apps/Invictus_Site"
BKDIR="/web_apps/backups/$YEAR"

# Make the dir if needed
if [ ! -d "$BKDIR" ]; then
  mkdir -p $BKDIR
fi

# Tar the files and copy
tar -cpzf $BKDIR/$FILENAME $SRCDIR