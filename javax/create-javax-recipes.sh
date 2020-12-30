#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
jakarta.websocket
)
ARTIDS=(
jakarta.websocket-api
)
VERSION=(
'2.0.0'
)
BSNS=(
jakarta.websocket
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION[${i}]} ${BSNS[${i}]}
done
