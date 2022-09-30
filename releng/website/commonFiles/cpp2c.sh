#! /bin/bash

function cpp2c () {

src=$1
target=$2
newname=$3
suffix=repository

if [ ! -e "${src}" ]; then
  echo "${src} does not exist."
  exit 1
fi

if [ ! -e "${target}" ]; then
  echo "${target} does not exist."
  exit 1
fi

build=${target}

if [ -z "${newname}" ]; then
  build=${target}/`basename ${src}`
  srcisrepo=0
else
  build=${target}/${newname}
  srcisrepo=1
fi

# Sanity check (operate on one or fewer repositories)
if [ -e "${build}" ]; then
  num=`find ${build} -name compositeContent.xml | wc -l`
  if [ ${num} -gt 1 ]; then
    echo "Too many composite repositories under ${build}. Aborting."
    exit 1
  fi
fi

rsync -av ${src}/ ${build}

for repo in compositeContent.xml compositeArtifacts.xml ; do
  children=$(xmllint -xpath '/repository/children/child/@location' `find ${src} -name ${repo}`)
  for child in ${children} ; do
    childLoc=`echo ${child} | cut -d'"' -f2`
    if [ ${srcisrepo} -eq 1 ]; then
      newChildLoc=$(realpath --relative-to=${build} ${src}/${childLoc})
    else
      newChildLoc=$(realpath --relative-to=`find ${build} -type d -name ${suffix}` `find ${src} -type d -name ${suffix}`/${childLoc})
    fi
    sed -i "s|${childLoc}|${newChildLoc}|g" `find ${build} -name ${repo}`
  done
done

# Add 'files.count' to ensure visibility on downloads page (if promotion)
if [ -z "${newname}" ]; then
  echo 1 > ${build}/files.count
fi

# Take into account fixed paths in index.html that must change
# Take into account relative paths to images that must change
if [ -e ${build}/index.html ]; then
  sed -i "/For HTTP access/ s|[NISR]-builds|downloads/drops|g" ${build}/index.html
  sed -i "s|\.\./\.\./commonFiles|\.\./\.\./\.\./commonFiles|g" ${build}/index.html
fi



}

function mkp2c () {

name=$1
src=$2
target=$3

timestamp=$(date -u +"v%Y%m%d%H%M%S")

if [ ! -e "${src}" ]; then
  echo "${src} does not exist."
  exit 1
fi

if [ ! -e "${target}" ]; then
  echo "${target} does not exist."
  exit 1
fi

mkdir -p ${target}/${name}
loc=$(realpath --relative-to=${target}/${name} ${src}/repository)

pushd ${target}/${name}

cat << EOF > compositeArtifacts.xml
<?compositeArtifactRepository version='1.0.0'?>
<repository name='Eclipse Orbit Composite Site ${name}'
    type='org.eclipse.equinox.internal.p2.artifact.repository.CompositeArtifactRepository' version='1.0.0'>
  <properties size='1'>
    <property name='p2.timestamp' value='${timestamp}'/>
  </properties>
  <children size='1'>
    <child location='${loc}'/>
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
    <child location='${loc}'/>
  </children>
</repository>
EOF

popd

}
