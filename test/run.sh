#!/bin/bash

_listen=$1
shift

for _site in $*
do
    echo "## ${_site}"
    curl localhost:${_listen}/ -i -H "Host:${_site}"
    echo
done

# EOF
