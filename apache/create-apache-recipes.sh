#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='xerces'
VERSIONS=(
2.12.1
)
ARTIDS=(
xercesImpl
)
BSNS=(
xercesImpl
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
