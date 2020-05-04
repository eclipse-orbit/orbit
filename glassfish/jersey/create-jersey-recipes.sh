#!/bin/sh
set -euv

# core
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-common -DbundleSymbolicName=org.glassfish.jersey.core.jersey-common "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-client -DbundleSymbolicName=org.glassfish.jersey.core.jersey-client "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-server -DbundleSymbolicName=org.glassfish.jersey.core.jersey-server "$@"

# containers
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.containers -DartifactId=jersey-container-servlet-core -DbundleSymbolicName=org.glassfish.jersey.containers.servlet.core "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.containers -DartifactId=jersey-container-servlet -DbundleSymbolicName=org.glassfish.jersey.containers.servlet "$@"

# client connectors
#mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.connectors -DartifactId=jersey-jetty-connector -DbundleSymbolicName=org.glassfish.jersey.connectors.jetty "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.connectors -DartifactId=jersey-apache-connector -DbundleSymbolicName=org.glassfish.jersey.apache.connector "$@"

# extensions
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.ext -DartifactId=jersey-entity-filtering -DbundleSymbolicName=org.glassfish.jersey.ext.entityfiltering "$@"

# media support
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-json-jackson -DbundleSymbolicName=org.glassfish.jersey.media.jersey-media-json-jackson "$@"
#mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-multipart -DbundleSymbolicName=org.glassfish.jersey.media.multipart "$@"
#mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-moxy -DbundleSymbolicName=org.glassfish.jersey.media.moxy "$@"
#mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-sse -DbundleSymbolicName=org.glassfish.jersey.media.sse "$@"

# all-in-one
#mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.bundles -DartifactId=jaxrs-ri -DbundleSymbolicName=org.glassfish.jersey.bundles.jaxrs.ri "$@"

# inject
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.inject -DartifactId=jersey-hk2 -DbundleSymbolicName=org.glassfish.jersey.inject.jersey-hk2 "$@"
