#!/bin/sh
set -euv

# core
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-common -DbundleSymbolicName=org.glassfish.jersey.core.common "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-client -DbundleSymbolicName=org.glassfish.jersey.core.client "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.core -DartifactId=jersey-server -DbundleSymbolicName=org.glassfish.jersey.core.server "$@"

# containers
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.containers -DartifactId=jersey-container-servlet-core -DbundleSymbolicName=org.glassfish.jersey.containers.servlet.core "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.containers -DartifactId=jersey-container-servlet -DbundleSymbolicName=org.glassfish.jersey.containers.servlet "$@"

# client connectors
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.connectors -DartifactId=jersey-jetty-connector -DbundleSymbolicName=org.glassfish.jersey.connectors.jetty "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.connectors -DartifactId=jersey-apache-connector -DbundleSymbolicName=org.glassfish.jersey.connectors.apache "$@"

# extensions
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.ext -DartifactId=jersey-entity-filtering -DbundleSymbolicName=org.glassfish.jersey.ext.entityfiltering "$@"

# media support
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-multipart -DbundleSymbolicName=org.glassfish.jersey.media.multipart "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-moxy -DbundleSymbolicName=org.glassfish.jersey.media.moxy "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.media -DartifactId=jersey-media-sse -DbundleSymbolicName=org.glassfish.jersey.media.sse "$@"

# other
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.bundles.repackaged -DartifactId=jersey-guava -DbundleSymbolicName=org.glassfish.jersey.repackaged.guava "$@"
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.bundles.repackaged -DartifactId=jersey-jsr166e -DbundleSymbolicName=org.glassfish.jersey.repackaged.jsr166e "$@"

# all-in-one
mvn -U -e -V ebr:create-recipe -DgroupId=org.glassfish.jersey.bundles -DartifactId=jaxrs-ri -DbundleSymbolicName=org.glassfish.jersey.bundles.jaxrs.ri "$@"
