For the long version See [Adding Bundles to
Orbit](Add-bundle.md)

This is for primarily meant as a guide for contributing a bundle to make
its way into a release. This guide assumes all the steps to get approval
for the bundle itself have already been performed.

See [readme](README.md) and [Adding a bundle](Add-bundle.md) for a more thorough explanation

## Setup

-   Fork and Clone this repository

## Creation/Preparation

-   Choose a folder under which to create the recipe and then create it
    there using the below mvn command or the *create-\*-recipes.sh* if
    any:

`$ cd github/mongodb`  
`$ mvn ebr:create-recipe -DgroupId=org.mongodb -DartifactId=mongo-java-driver -Dversion=3.4.1 -DbundleSymbolicName=org.mongodb.mongo-java-driver`

-   Modify recipe pom and osgi.bnd to suite the needs of the bundle. If
    the bundles has dependencies, make sure to specify them under the
    Import-Package header in the osgi.bnd as opposed to just leaving it
    as '\*;resolution:=optional'.

`$ cd org.mongodb.mongo-java-driver_3.4.1`  
`$ $EDITOR pom.xml`  
`$ $EDITOR osgi.bnd`

-   Perform a test build of the package.

`$ mvn -U clean package -DdirtyWorkingTree=warning`

## Add To Build

-   Add the new recipe to the category pom as a module

(eg. <module>`org.mongodb.mongo-java-driver_3.4.1`</module>)

`$ cd ../`  
`$ $EDITOR pom.xml`

-   Add the recipe bundle to the aggregation feature to ensure it ends
    up in the generated repository

`$ cd ../../`  
`$ EDITOR releng/aggregationfeature/feature.xml`

(eg.
<plugin id="org.mongodb.mongo-java-driver" version="3.4.1.qualifier"/>)

-   Add and commit the new recipe and changes to the aggregation
    feature.

`$ git add github/mongodb/org.mongodb.mongo-java-driver_3.4.1 releng/aggregationfeature/feature.xml`  
`$ git commit`

## Building Locally (Recommended)

-   We should also test that our new recipe builds successfully prior to
    submitting for review

First we test that our recipe builds alongside all other recipes and
install them locally to be discovered later by our aggregation feature

`$ mvn clean install`

Next we test that the aggregation feature builds successfully

`$ mvn clean install -f releng/aggregationfeature/pom.xml`

Finally, we test that the generated repository containing all bundle
recipes builds successfully

`$ mvn clean package -f releng/repository/pom.xml`

## Contributing

-   Lastly, we push to review by creating a Pull Request.

## Consumption

Once a change has been reviewed and approved, a build should be
triggered within about an hour at
<https://ci.eclipse.org/orbit/job/orbit-recipes/> . Once the build
succeeds, information about where to find the build page, as well as the
generated p2 repository can be found at the bottom of the build's logs.

The automated builds are analogous to nightly builds, in that they are
not usually retained for long and are generally used merely for testing
purposes. For more stable repositories, committers have the ability to
push integration, milestone, and recommended (I, S, R) builds that can
also be promoted to the [downloads
page](http://download.eclipse.org/tools/orbit/downloads/) for
visibility.
