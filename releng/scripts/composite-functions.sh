#! /bin/bash

# This function is used to make composite repo to simulate soft link (as soft links aren't allowed on download.eclipse.org)
# Usage:
#  make_composite_repo_files NAME LOCATION
# When NAME is the name of the repo (e.g. the BUILD_TIME)
# and LOCATION is the relative directory to redirect to
#
# This shoud be run in an empty directory and the results copied
# to download.eclipse.org
function make_composite_repo_files () {

  name=$1
  location=$2

  timestamp=$(date +%s%3N)

  cat << EOF > compositeArtifacts.xml
<?compositeArtifactRepository version='1.0.0'?>
<repository name='Eclipse Orbit Composite Site ${name}'
    type='org.eclipse.equinox.internal.p2.artifact.repository.CompositeArtifactRepository' version='1.0.0'>
  <properties size='1'>
    <property name='p2.timestamp' value='${timestamp}'/>
  </properties>
  <children size='1'>
    <child location='${location}'/>
  </children>
</repository>
EOF

  cat << EOF > compositeContent.xml
<?compositeMetadataRepository version='1.0.0'?>
<repository name='Eclipse Orbit Composite Site ${name}'
    type='org.eclipse.equinox.internal.p2.metadata.repository.CompositeMetadataRepository' version='1.0.0'>
  <properties size='1'>
    <property name='p2.timestamp' value='${timestamp}'/>
  </properties>
  <children size='1'>
    <child location='${location}'/>
  </children>
</repository>
EOF

  cat << EOF > p2.index
version = 1
metadata.repository.factory.order = compositeContent.xml,\!
artifact.repository.factory.order = compositeArtifacts.xml,\!
EOF

}


# This function is used to make a composite repo (with make_composite_repo_files) and upload it to download.eclipse.org
# Usage:
#  upload_composite_repo_files NAME LOCATION
# When NAME is the name of the repo (e.g. the BUILD_TIME)
# and LOCATION is the relative directory to redirect to
# and DOWNLOAD_LOC is the directory under ORBIT_DOWNLOAD_LOC to place the results
function upload_composite_repo_files () {
  name=$1
  location=$2
  download_loc=$3

  d=$(mktemp -d)
  pushd $d
  make_composite_repo_files ${name} ${location}
  ssh genie.orbit@projects-storage.eclipse.org rm -rf ${ORBIT_DOWNLOAD_LOC}/${download_loc}
  ssh genie.orbit@projects-storage.eclipse.org mkdir -p ${ORBIT_DOWNLOAD_LOC}/${download_loc}
  scp -r * genie.orbit@projects-storage.eclipse.org:${ORBIT_DOWNLOAD_LOC}/${download_loc}
  popd
  rm -rf $d
}