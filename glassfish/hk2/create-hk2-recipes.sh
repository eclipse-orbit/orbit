#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
org.glassfish.hk2.external
)
ARTIDS=(
aopalliance-repackaged
)
VERSION=(
'2.6.1'
)
BSNS=(
org.glassfish.hk2.external.aopalliance-repackaged
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION[${i}]} ${BSNS[${i}]}
done
