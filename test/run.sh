#!/bin/bash

if test $# -lt 2 ; then
    echo "Usage: $0 <port> <site>"
    exit 0
fi

_listen=$1
_site=$2

echo "## ${_site}"

_host=${_site%%/*}
_path=${_site#*/}
_cmd="curl http://localhost:${_listen}/${_path} -i -H \"Host:${_host}\""

echo ${_cmd}
eval ${_cmd}
echo

# EOF
