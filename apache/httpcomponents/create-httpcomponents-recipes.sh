#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='org.apache.httpcomponents'
VERSIONS=(
4.4.16
4.4.16
4.5.14
4.5.14
)
ARTIDS=(
httpcore
httpcore-nio
httpclient
httpclient-win
)
BSNS=(
org.apache.httpcomponents.httpcore
org.apache.httpcomponents.httpcore-nio
org.apache.httpcomponents.httpclient
org.apache.httpcomponents.httpclient.win
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
