#! /bin/bash

# N (nightly), I (integration), S (stable), or R (recommended)
build_label=${BUILD_LABEL}
# format: NYYYYMMDDHHMM
timestamp=${build_label}`date -u +"%Y%m%d%H%M%S"`

drops_loc=/home/data/httpd/download.eclipse.org/tools/orbit/downloads/drops2
# trailing slashes affect rsync behaviour
src_repo=releng/repository/target/repository
dst_repo=${drops_loc}/${timestamp}

if [ -z "${build_label}" ]; then
  echo "A BUILD_LABEL variable must be defined by the CI system but none could be found."
  exit 1
fi

if [ ! -r ${src_repo} ]; then
  echo "${src_repo} does not exist or is not readable, cannote promote."
  exit 1
fi

if [ ! -w ${drops_loc} ]; then
  echo "${drops_loc} does not exist or is not writable, cannot promote."
  exit 1
fi

jar_count=`find ${src_repo} -name "*.jar" | wc -l`
packed_jar_count=`find ${src_repo} -name "*.jar.pack.gz" | wc -l`

echo "${jar_count} jar files and ${packed_jar_count} packed jar files will be promoted"

rsync -av ${src_repo} ${dst_repo}
res=$?
if [ "${res}" != "0" ]; then
  echo "Promotion failed with error code ${res}."
  exit 1
fi

echo "Promotion succeeded!"
