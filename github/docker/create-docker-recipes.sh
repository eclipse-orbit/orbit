#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
com.spotify
)
VERSION='3.6.8'
ARTIDS=(
docker-client
)
BSNS=(
com.spotify.docker.client
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
