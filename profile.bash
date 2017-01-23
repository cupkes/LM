#!/bin/bash -e
#
# Script for initializing NEO4J Server Config
# This script must be run as the neo4j user
# and must be run as super user
#################################################

#------------------------------------------------ 
# Script variables
#------------------------------------------------
# create a standard logging tag for all log entries
LOGTAG=NEO4J_SUPPORT
# specify the neo4j directory tree
NEOHOME="/opt/neo4j/neo4j-enterprise-3.1.0"
NEOBASE="/opt/neo4j"
NEOSUPP="/opt/neo4j/support"
NEOBIN="$NEOSUPP/bin"
NEOETC="$NEOSUPP/etc"
#NEOBAK="$NEOBASE/backup"

#------------------------------------------------
# Update current user (Neo4j) .bash_profile
#------------------------------------------------

# make sure the neo4j home directory exists

if [ ! -d /home/neo4j ]; then
	echo "cannot locate neo4j home directory\n"
	exit 1
fi

#
# update the profile script to include essential path values
# and helpful aliases and shell configurations
#

cat << ENDOC >> ~/.bash_profile
# NEO4J SUPPORT MODIFICATION
if [ -d "/opt/neo4j" ] ; then
	PATH=$PATH:opt/neo4j
fi
if [ -d "/opt/neo4j/support/bin" ] ; then
	PATH=$PATH:/opt/neo4j/support/bin
fi
if [ -d "/opt/neo4j/support/etc" ] ; then
	PATH=$PATH:/opt/neo4j/support/etc
fi
if [ -d "/opt/neo4j/neo4j-enterprise-3.1.0" ] ; then
	export NEO4J_HOME=/opt/neo4j/neo4j-enterprise-3.1.0
fi
set -o noclobber
unset MAILCHECK
export LANG=C
export PATH
alias df='df -h'
alias rm='rm -i'
alias h='history | tail'
alias neo='cd /opt/neo4j'
# END NEO4J SUPPORT MODIFICATION
ENDOC

logger -p local0.notice -t $LOGTAG "user $USER profile updated"