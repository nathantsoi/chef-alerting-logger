#!/bin/bash
LOGFILE=$1
THISDIR=$(readlink -f $(dirname "$0"))
HOSTNAME=$(hostname)

if [ -s "$LOGFILE" ]
then
  echo "file has content"
else
  /bin/bash ${THISDIR}/notify.sh "${LOGFILE} on ${HOSTNAME} is empty"
fi

