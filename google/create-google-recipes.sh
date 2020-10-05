#! /bin/bash

function ebr () {
  mvn ebr:create-recipe -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DbundleSymbolicName=$4
}

# Edit these as needed
GIDS=(
com.google.auth
com.google.auto.value
com.google.http-client
com.google.http-client
com.google.j2objc
io.opencensus
io.opencensus
io.grpc
org.conscrypt
)
VERSION=(
0.20.0
1.7
1.34.2
1.34.2
1.3
0.26.0
0.26.0
1.29.0
2.5.1
)
ARTIDS=(
google-auth-library-credentials
auto-value-annotations
google-http-client
google-http-client-jackson2
j2objc-annotations
opencensus-contrib-http-util
opencensus-api
grpc-context
conscrypt-openjdk-uber
)
BSNS=(
com.google.auth.google-auth-library-credentials
com.google.auto.value.auto-value-annotations
com.google.http-client.google-http-client
com.google.http-client.google-http-client-jackson2
com.google.j2objc.j2objc-annotations
io.opencensus.opencensus-contrib-http-util
io.opencensus.opencensus-api
io.grpc.grpc-context
org.conscrypt.conscrypt-openjdk-uber
)

for (( i=0; i< ${#ARTIDS[@]}; i++ )); do
  ebr ${GIDS[${i}]} ${ARTIDS[${i}]} ${VERSION[${i}]} ${BSNS[${i}]}
done