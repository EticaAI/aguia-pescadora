#!/bin/bash
#===============================================================================
#
#          FILE:  bootstrap-vps.sh
#
#         USAGE:  ./bootstrap-vps.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#          TODO:  Implement parameters by file
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha(at)ieee.org>
#       COMPANY:  Etica.AI
#       VERSION:  1.0
#       CREATED:  2019-06-27 02:27 BRT
#      REVISION:  ---
#===============================================================================

function usage {
    echo "usage: VPS_PASS=PassWords `basename $0` -f"
    echo "  -f      force run script (you agree with security notices)"
    echo ""
    echo "Security notes:"
    echo " 1. This script have similar security as the use of sshpass."
    echo " 2. This script (when forcing remove know_hosts) is not recommented."
    exit 1
}

echo "VPS_PASS: $BVPS_PASS"

[ -z $1 ] && { usage; }
usage

echo 'oi oi'

exit
