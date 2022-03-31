#!/bin/bash

# The default seems to be 0022
# We need user (genie.orbit) and group (tools.orbit) to match
umask 0002

. ${scriptDir}/cpp2c-jiro.sh

ORBIT_ROOT=/home/data/httpd/download.eclipse.org/tools/orbit

mkdir -p ${SRC_LOCATION} ${DST_LOCATION}
pushd ${SRC_LOCATION}
scp -r genie.orbit@projects-storage.eclipse.org:${ORBIT_ROOT}/${SRC_LOCATION}/* .
popd
cpp2c ${SRC_LOCATION} ${DST_LOCATION} ${NEW_NAME}
scp -r ${DST_LOCATION}/* genie.orbit@projects-storage.eclipse.org:${ORBIT_ROOT}/${DST_LOCATION}
