#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GID='org.apache.xmlgraphics'
VERSION='1.8'
ARTIDS=(
batik-css
batik-util
batik-gui-util
)
BSNS=(
org.apache.batik.css
org.apache.batik.util
org.apache.batik.util.gui
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
