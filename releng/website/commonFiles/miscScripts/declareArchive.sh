#!/usr/bin/env bash
echo $1

declaredDir=$1

# So that this script can be ran "from anywhere", it uses
#    $HOME/downloads
# but that depends on having a symbolic link defined under
# your HOME directory. Nearly all committers do, but in case
# you do not, at the time of this writing, that link
# is defined as
#    downloads -> /home/data/httpd/download.eclipse.org/

FROMDIR=$HOME/downloads/tools/orbit/committers/drops
TODIR=$HOME/archives/tools/orbit/downloads/drops
echo  "declaring build ${declaredDir}"
echo  "   into ${TODIR}"
echo  "   using the build from ${FROMDIR}"

. rsync-retry.sh
rsync-retry ${FROMDIR}/${declaredDir} ${TODIR}/  | tee declareout.txt
exitcode=$?
if [ $exitcode -ne 0 ]
then
    exit $exitcode
fi

fromString="committers/drops"
toString="downloads/drops"
replaceCommand="s!${fromString}!${toString}!g"

perl -w -pi -e ${replaceCommand} ${TODIR}/${declaredDir}/*.php
perl -w -pi -e ${replaceCommand} ${TODIR}/${declaredDir}/*.map

