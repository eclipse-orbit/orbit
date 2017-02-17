#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='org.apache.httpcomponents'
VERSIONS=(
4.4.4
4.5.2
4.5.2
)
ARTIDS=(
httpcore
httpclient
httpclient-win
)
BSNS=(
org.apache.httpcomponents.httpcore
org.apache.httpcomponents.httpclient
org.apache.httpcomponents.httpclient.win
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
