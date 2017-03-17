#!/bin/bash
set -e

echo $WORKDIR

# Removed XAP License key for early access version
#if [[ -z "$XAP_LICENSE_KEY" ]]; then
#	echo "Please set 'XAP_LICENSE_KEY' environment variable"; exit 2
#fi

readonly first_param=${1#\"}
if [[ "${first_param:0:1}" = '-' || "${first_param:0:3}" = 'gsa' ]]; then
	set -- ./bin/gs-agent.sh "$@"
fi

: ${XAP_LOOKUP_LOCATORS="$(hostname --ip-address):4174"}

exec env EXT_JAVA_OPTIONS="$EXT_JAVA_OPTIONS" XAP_WEBUI_OPTIONS="$XAP_WEBUI_OPTIONS" XAP_MANAGER_SERVERS="$XAP_MANAGER_SERVERS" "$@"

