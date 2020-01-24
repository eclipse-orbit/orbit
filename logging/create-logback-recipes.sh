#! /bin/bash

function ebr () {
  mvn -Debr-version=1.1.1-SNAPSHOT ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
ch.qos.logback
ch.qos.logback
ch.qos.logback
)
VERSION='1.2.3'
ARTIDS=(
logback-classic
logback-core
logback-classic
)
BSNS=(
ch.qos.logback.classic
ch.qos.logback.core
ch.qos.logback.slf4j
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
