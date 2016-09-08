#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='org.apache.httpcomponents'
VERSIONS=(
4.5
4.5
)
ARTIDS=(
httpcore
httpclient
)
BSNS=(
org.apache.httpcomponents.httpcore
org.apache.httpcomponents.httpclient
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
