#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
org.slf4j
org.slf4j
org.slf4j
org.slf4j
org.slf4j
org.slf4j
org.slf4j
)
VERSION='1.7.30'
ARTIDS=(
slf4j-api
jcl-over-slf4j
log4j-over-slf4j
slf4j-nop
slf4j-simple
jul-to-slf4j
slf4j-ext
)
BSNS=(
org.slf4j.api
org.slf4j.apis.jcl
org.slf4j.apis.log4j
org.slf4j.binding.nop
org.slf4j.binding.simple
org.slf4j.bridge.jul
org.slf4j.ext
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
