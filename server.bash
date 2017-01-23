#------------------------------------------------
# Set Neo4j Server specific os configurations
#!/bin/bash -e
#
# Script for initializing NEO4J Server Config
# This script must be run as the neo4j user
# and must be run as super user
##################################################------------------------------------------------

#
# we need to update some server configuration files
# in order for the neo4j cluster to function properly
#

cat << ENDOC >> /etc/security/limits.conf
# NEO4J SUPPORT MODIFICATION
neo4j   soft    nofile  40000
neo4j   hard    nofile  40000
# END NEO4J SUPPORT MODIFICATION
ENDOC

logger -p local0.notice -t $LOGTAG "limits.conf modified"

cat << ENDOC >> /etc/pam.d/su
# NEO4J SUPPORT MODIFICATION
session    required   pam_limits.so
# END NEO4J SUPPORT MODIFICATION
ENDOC

logger -p local0.notice -t $LOGTAG "pam.d/su modified"

# A restart is required for the settings to take effect.
# After the above procedure, the neo4j user will have a limit of 40 000 simultaneous open files.
# If you continue experiencing exceptions on Too many open files or Could not stat() directory,
# you may have to raise the limit further.

echo "required server configuration changes complete.\n"
echo "System must be restarted before changes take affect\n"
