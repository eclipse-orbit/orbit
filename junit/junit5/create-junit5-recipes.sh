#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed for 'org.junit.platform'
GID_PLATFORM='org.junit.platform'
VERSION_PLATFORM='1.0.0-RC3'
ARTIDS_PLATFORM=(
junit-platform-commons
junit-platform-engine
junit-platform-launcher
junit-platform-runner
junit-platform-suite-api
)
BSNS_PLATFORM=(
org.junit.platform.commons
org.junit.platform.engine
org.junit.platform.launcher
org.junit.platform.runner
org.junit.platform.suite.api
)

for (( i=0; i< ${#ARTIDS_PLATFORM[@]}; i++ )); do
  ebr ${GID_PLATFORM} ${ARTIDS_PLATFORM[${i}]} ${VERSION_PLATFORM} ${BSNS_PLATFORM[${i}]}
done

# Edit these as needed for 'org.junit.jupiter'
GID_JUPITER='org.junit.jupiter'
VERSION_JUPITER='5.0.0-RC3'
ARTIDS_JUPITER=(
junit-jupiter-api
junit-jupiter-engine
junit-jupiter-migrationsupport
junit-jupiter-params
)
BSNS_JUPITER=(
org.junit.jupiter.api
org.junit.jupiter.engine
org.junit.jupiter.migrationsupport
org.junit.jupiter.params
)

for (( i=0; i< ${#ARTIDS_JUPITER[@]}; i++ )); do
  ebr ${GID_JUPITER} ${ARTIDS_JUPITER[${i}]} ${VERSION_JUPITER} ${BSNS_JUPITER[${i}]}
done

# Edit these as needed for 'org.junit.vintage'
GID_VINTAGE='org.junit.vintage'
VERSION_VINTAGE='4.12.0-RC3'
ARTIDS_VINTAGE=(
junit-vintage-engine
)
BSNS_VINTAGE=(
org.junit.vintage.engine
)

for (( i=0; i< ${#ARTIDS_VINTAGE[@]}; i++ )); do
  ebr ${GID_VINTAGE} ${ARTIDS_VINTAGE[${i}]} ${VERSION_VINTAGE} ${BSNS_VINTAGE[${i}]}
done

# Edit these as needed for 'org.opentest4j'
GID_OPENTEST4J='org.opentest4j'
VERSION_OPENTEST4J='1.0.0-RC1'
ARTIDS_OPENTEST4J=(
opentest4j
)
BSNS_OPENTEST4J=(
org.opentest4j
)

for (( i=0; i< ${#ARTIDS_OPENTEST4J[@]}; i++ )); do
  ebr ${GID_OPENTEST4J} ${ARTIDS_OPENTEST4J[${i}]} ${VERSION_OPENTEST4J} ${BSNS_OPENTEST4J[${i}]}
done
