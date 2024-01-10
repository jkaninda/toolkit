#!/usr/bin/env bash

# S3 Backup & Restore 

# @author    Jonas Kaninda
# @license   MIT License <https://opensource.org/licenses/MIT>
# @link      https://github.com/jkaninda/toolkit
#
set -e

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
    echo "  -h |--help              -- Print this help message and exit"
    echo "  -V |--version           -- Print version information and exit"
    exit 0
}

flags()
{
    while test $# -gt 0
    do
        case "$1" in
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
mount_s3()
{
if [[ -z $ACCESS_KEY ]] ||  [[ -z $SECRET_KEY ]]; then
info "Please make sure all environment variables are set "
else
    echo "$ACCESS_KEY:$SECRET_KEY" | tee /etc/passwd-s3fs
    chmod 600 /etc/passwd-s3fs
    info "Mounting Object storage in /s3mnt .... "
    if [ -z "$(ls -A /s3mnt)" ]; then
       s3fs $BUCKETNAME /s3mnt -o passwd_file=/etc/passwd-s3fs -o use_cache=/tmp/s3cache -o allow_other -o url=$S3_ENDPOINT -o use_path_request_style
       if [ ! -d "/s3mnt" ]; then
           mkdir -p /s3mnt
        fi 
    else
     info "Object storage already mounted in /s3mnt"
    fi
fi
}
flags "$@"
mount_s3