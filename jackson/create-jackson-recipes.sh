#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
com.fasterxml.jackson.core
com.fasterxml.jackson.core
com.fasterxml.jackson.core
com.fasterxml.jackson.jaxrs
com.fasterxml.jackson.jaxrs
com.fasterxml.jackson.datatype
com.fasterxml.jackson.module
)
VERSION='2.12.1'
ARTIDS=(
jackson-core
jackson-annotations
jackson-databind
jackson-jaxrs-base
jackson-jaxrs-json-provider
jackson-datatype-guava
jackson-module-jaxb-annotations
)
BSNS=(
com.fasterxml.jackson.core.jackson-core
com.fasterxml.jackson.core.jackson-annotations
com.fasterxml.jackson.core.jackson-databind
com.fasterxml.jackson.jaxrs.jackson-jaxrs-base
com.fasterxml.jackson.jaxrs.jackson-jaxrs-json-provider
com.fasterxml.jackson.datatype.jackson-datatype-guava
com.fasterxml.jackson.module.jackson-module-jaxb-annotations
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION} ${BSNS[${i}]}
done
