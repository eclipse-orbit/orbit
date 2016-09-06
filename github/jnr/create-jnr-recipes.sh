#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='com.github.jnr'
VERSIONS=(
0.9.1
0.12
2.0.9
3.0.29
0.12
1.0.2
1.2.11
1.2.11
)
ARTIDS=(
jnr-constants
jnr-enxio
jnr-ffi
jnr-posix
jnr-unixsocket
jnr-x86asm
jffi
jffi
)
BSNS=(
com.github.jnr.constants
com.github.jnr.enxio
com.github.jnr.ffi
com.github.jnr.posix
com.github.jnr.unixsocket
com.github.jnr.x86asm
com.github.jnr.jffi
com.github.jnr.jffi.native
)
CLASSIFIERS[7]=native

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
