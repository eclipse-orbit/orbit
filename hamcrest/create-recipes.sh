#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
org.hamcrest
)
VERSION='1.3'
ARTIDS=(
hamcrest-library
)
BSNS=(
org.hamcrest.library
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
