#!/bin/bash

set -o errexit

parse_input() {
    while [[ $# > 0 ]]; do
        case $1 in
        '-lic' | '--xap-license')
            license="$2"
            shift 2 ;;
        '-n' | '--name')  
            name="$2"
            shift 2 ;;
        '-l' | '--lookup-locators')
            locators="$2"
            shift 2 ;;
        *)
        esac
    done
}
main() {
    parse_input "$@"

    docker build -t gigaspaces/xap:12.1.0 .
    local cmd="docker run --name $name -d --net=host" 
    #if [[ $locators ]]; then cmd+=" -e XAP_LOOKUP_LOCATORS=$locators"; fi
    cmd+=" gigaspaces/xap:12.1.0 ./bin/gs-webui.sh"
    $cmd
}
main "$@"
