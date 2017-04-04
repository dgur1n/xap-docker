#!/bin/bash
set -e

echo $WORKDIR

if [[ -z "$XAP_LICENSE_KEY" ]]; then
    echo "Please set 'XAP_LICENSE_KEY' environment variable"; exit 2
fi

echo "[DEBUG] Version: 10"

readonly first_param=${1#\"}
echo "[DEBUG] All params: $@"
echo "[DEBUG] First param: $first_param"
if [[ "${first_param:0:1}" = '-' || "${first_param:0:3}" = 'gsa' ]]; then
    set -- ./bin/gs-agent.sh "$@"
    echo "[DEBUG] Added gs-agent to the params"
    echo "[DEBUG] All params: $@"
fi

export EXT_JAVA_OPTIONS="$EXT_JAVA_OPTIONS -Dcom.gs.licensekey=$XAP_LICENSE_KEY"
export XAP_WEBUI_OPTIONS="$XAP_WEBUI_OPTIONS -Dcom.gs.licensekey=$XAP_LICENSE_KEY"
echo "[DEBUG] env: " && env && echo ""

exec env EXT_JAVA_OPTIONS="$EXT_JAVA_OPTIONS" XAP_WEBUI_OPTIONS="$XAP_WEBUI_OPTIONS" XAP_MANAGER_SERVERS="$XAP_MANAGER_SERVERS" "$@"