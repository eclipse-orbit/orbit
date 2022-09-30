#!/usr/bin/env bash

# Important: it is assumed this script is ran from the directory
# that is the parent of the directory to rename

BUILD_NAME=$1

ARCHIVE_DIR=/home/data/httpd/archive.eclipse.org/tools/orbit/downloads/drops
DOWNLOAD_DIR=/home/data/httpd/download.eclipse.org/tools/orbit/downloads/drops

echo
echo "Moving build $BUILD_NAME to archives."
echo "  That is, from"
echo "  $DOWNLOAD_DIR"
echo "  to"
echo "  $ARCHIVE_DIR"
echo

# do move (commented out, to do replace only)
# mv "${DOWNLOAD_DIR}"/"${BUILD_NAME}" "${ARCHIVE_DIR}"

# fix up URLs
fromString=download.eclipse.org
toString=archive.eclipse.org
replaceCommand="s!${fromString}!${toString}!g"

mkdir -p "${ARCHIVE_DIR}"/"$BUILD_NAME"/mapbackup
cp "${ARCHIVE_DIR}"/"$BUILD_NAME"/*.map "${ARCHIVE_DIR}"/"$BUILD_NAME"/mapbackup/
perl -w -pi -e ${replaceCommand} "${ARCHIVE_DIR}"/"$BUILD_NAME"/*.map

# TODO: may need to fix up artifacts.jar/xml file if it is
# has mirror URL by removing it's mirror URL
