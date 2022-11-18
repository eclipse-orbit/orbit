#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dclassifier=$4 -DbundleSymbolicName=$5
}

# Edit these as needed
GID='com.github.jnr'
VERSIONS=(
0.10.3
0.32.13
2.2.11
3.1.15
0.38.17
1.0.2
1.0.0
1.3.9
1.3.9
)
ARTIDS=(
jnr-constants
jnr-enxio
jnr-ffi
jnr-posix
jnr-unixsocket
jnr-x86asm
jnr-a64asm
jffi
jffi-native
)
BSNS=(
com.github.jnr.constants
com.github.jnr.enxio
com.github.jnr.ffi
com.github.jnr.posix
com.github.jnr.unixsocket
com.github.jnr.x86asm
com.github.jnr.a64asm
com.github.jnr.jffi
com.github.jnr.jffi.native
)
CLASSIFIERS[8]=native

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GID} ${ARTIDS[${i}]} ${VERSIONS[${i}]} "${CLASSIFIERS[${i}]}" ${BSNS[${i}]}
done
