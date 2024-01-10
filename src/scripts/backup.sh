#!/usr/bin/env bash

# S3 Backup & Restore 

# @author    Jonas Kaninda
# @license   MIT License <https://opensource.org/licenses/MIT>
# @link      https://github.com/jkaninda/toolkit
#
set -e

TIME=$(date +%Y%m%d_%H%M%S)
arg0=$(basename "$0" .sh)
blnk=$(echo "$arg0" | sed 's/./ /g')
export OPERATION=backup
export S3_PATH=/mysql-bkup
export TIMEOUT=60
export EXECUTION_MODE="default"
export SCHEDULE_PERIOD="0 1 * * *"
export FILE_COMPRESION=true
usage_info()
{
    echo "Usage: \\"

}
version_info()
{
   echo "Version: $VERSION"
   exit 0
}
usage()
{
    exec 1>2   # Send standard output to standard error
    usage_info
    exit 0
}

error()
{
    echo "$arg0: $*" >&2
    exit 0
}
info() {
    { set +x; } 2> /dev/null
    echo 'toolkit:' '[INFO] ' "$@"
    #set -x
}
warning() {
    { set +x; } 2> /dev/null
    echo 'toolkit:' '[WARNING] ' "$@"
}
fatal() {
    { set +x; } 2> /dev/null
    echo 'toolkit:' '[ERROR] ' "$@" >&2
    exit 1
}

help()
{
    echo
    echo "  -o |--operation         -- Set operation (default: backup)"
    echo "     |--path              -- Set s3 path, without file name"
    echo "  -t |--timeout           -- Set timeout (default: 120s)"
    echo "  -h |--help              -- Print this help message and exit"
    echo "  -V |--version           -- Print version information and exit"
    exit 0
}

flags()
{
    while test $# -gt 0
    do
        case "$1" in
        (-o|--operation)
            shift
            [ $# = 0 ] && error "No operation specified - restore or backup"
            export OPERATION="$1"
            shift;;
        (--enable-compresion)
            shift
            [ $# = 0 ] && error "No enable-compresion specified "
            export FILE_COMPRESION="$1"
            shift;;
        (-m|--mode)
            shift
            [ $# = 0 ] && error "No execution mode specified"
            export EXECUTION_MODE="$1"
            shift;;
        (-t|--timeout)
            shift
            [ $# = 0 ] && error "No timeout specified"
            export TIMEOUT="$1"
            shift;;   
        (-h|--help)
            help;;
        (-V|--version)
           version_info;;
        (--)
           help;;
        (*) usage;;
        esac
    done
}