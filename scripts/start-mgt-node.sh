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
        '-gsc' | '--gsc-count')
            gsc_count="$2"
            shift 2 ;;
        '--gsm-options')
            gsm_options="$2"
            shift 2 ;;
        '--gsc-options')
            gsc_options="$2"
            shift 2 ;;
        *)
        esac
    done
}
main() {
    parse_input "$@"

    docker build -t gigaspaces/xap:12.1.0 .
    local cmd="docker run --name $name -d --net=host " 
    #if [[ $locators ]]; then cmd+=" -e XAP_LOOKUP_LOCATORS=$locators"; fi   # No need for locators using UGM
    if [[ $gsm_options ]]; then cmd+=" -e XAP_GSM_OPTIONS=$gsm_options"; fi
    if [[ $gsc_options ]]; then cmd+=" -e XAP_GSC_OPTIONS=$gsc_options"; fi
    cmd+=" gigaspaces/xap:12.1.0 --manager gsa.gsc ${gsc_count=0}"
    $cmd
}
main "$@"
