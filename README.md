Eclipse Orbit Recipes
=====================

This repositories hosts recipes for building OSGi bundles as part of the Eclipse Orbit project. This repository is based on functionality provided by the [Eclipse EBR maven plug-ins](https://github.com/eclipse/ebr).

The output of the Eclipse Orbit builds are located on download.eclipse.org: <https://download.eclipse.org/tools/orbit/downloads/>


The Very Short Version
----------------------

See [Adding Bundles To Orbit in 5 Minutes](Add-bundle-in-5-minutes.md) as a quick explanation of the contribution process.



Prerequisites
-------------

This project uses Maven for assembling of OSGi bundles based on artifacts in Maven Central or
any other accessible Maven repository.

1. Install Java 11 (Java 8 and Java 17 don't work) and Maven.
2. Clone this repository and go into the repository root folder.



How to build all bundles yourself
---------------------------------

1. Clone this repository and go into the repository root folder.
2. Run the following command to build the OSGi bundle: `mvn clean install`

This will publish all OSGi bundles produced by the recipes into your local Maven repository. You can consume
the bundles directly from Maven in any Tycho build.


### Generate p2 repository

1. Go into the repository root folder.
2. `mvn clean install -f releng/aggregation-mirror-osgi/pom.xml`
2. `mvn clean install -f releng/aggregationfeature/pom.xml`
3. `mvn clean package -f releng/repository/pom.xml`

The repository will be made available as archive in `releng/repository/target`.

Note, you **must** build the recipes first and *install* the result into your local Maven repository. Otherwise
the p2 build won't find any bundles.


### How to build just a single recipe?

This is not difficult at all. Just change into the directory of the recipe to build and execute Maven from there.

1. `cd recipes/\<path/to/recipe\>`
2. `mvn clean package`

(To preview local changes, add -DdirtyWorkingTree=warning to ignore uncommitted Git changes - see "How to add recipes" for more details)

The resulting bundle will be available in the recipes `target` folder.



How to add recipes
------------------

Adding recipes to this repository is part of the general process for adding bundles to Orbit. Please read the
following additional information first before you proceed.

* [Adding Bundles to Orbit](Add-bundle.md)
* [Bundle Checklist](Bundle-checklist.md)
* [Older articles](https://wiki.eclipse.org/Category:Orbit) (these items are from the old Orbit wiki and are retained for reference, but they may contain out of date information)

It's important to ensure that the bundle you're adding has been approved for use. See [IP Provenance](Bundle-checklist.md#ip-provenance) for some instructions. See [IP Prereq Diligence](https://www.eclipse.org/projects/handbook/#ip-prereq-diligence) for further details.

### 1. Pick a Category

Recipes are organized in folders by category. There is no strict rule on categories, i.e. categories do not map to vendor names by definition.
However, it seems logical to select a category name based on some common critaria shared by recipies. Most of the time, "origin" of the 3rd
party libraries seems like a good fit. But occasionally, functionality (eg, 'logging') is also helpful in order to avoid too fine grained grouping (eg., categories with only two recipies).

In case of doubts/questions, please reach out to the [Orbit Committers List](mailto:orbit-dev@eclipse.org). Also, don't be afraid of mistakes.
It's all in a single Git repository so re-organization is possible at any time later on.

Note, when creating a new category please create the category pom.xml first before any recipes. Use another category pom.xml as template to inherit the proper Orbit recipe parent pom.
This ensure that proper Orbit defaults are used when creating recipes (for example, the bundle vendor is automatically set to "Eclipse Orbit").


### 2. Create the recipe

The preferred method for creating recipes is by consuming a Maven artifact. The EBR Maven plug-in can be used to
create a recipe including required Eclipse IP information based on data available in Maven artifact poms.

```sh
# create the recipe for a specific Maven artifact
# the recipe will be created in a folder named "<symbolicname-of-the-orbit-bundle>_<version>"
mvn ebr:create-recipe -DgroupId=<maven-source-groupId> -DartifactId=<maven-source-artifactId> -Dversion=<maven-source-version> -DbundleSymbolicName=<symbolicname-of-the-orbit-bundle>

# modify recipe pom and osgi.bnd to suit the needs of the bundle
cd <new-recipe-folder>
$EDITOR pom.xml
$EDITOR osgi.bnd

# do a test build (this will create a default ip_log.xml)
# (note the -DirtyWorkingTree=ignore to ignore uncommitted Git changes for now)
mvn -U clean package -DdirtyWorkingTree=warning

# review the generated about files
ls -la src/main/resources/about_files
cat src/main/resources/about.html

# add new recipe to category pom
$EDITOR ../pom.xml

# update the build feature with your bundle
$EDITOR ../../releng/aggregationfeature/feature.xml

# add, commit the recipe to Git and push to Gerrit for review
git add .; git commit -m "Added org.example.foo 1.2.3"
# NOTE: Please push via Pull Request to ensure you don't bypass code review
```

### 3. Troubleshooting

If you are having trouble with the build after submitting your change, this is typically because there is a missing dependency. It is ideal to have all transitive dependencies of the library you're adding available as OSGi bundles in Orbit, though there may be exceptions to this. The dependency metadata can all be customized using the osgi.bnd file. You can discover the dependencies using `mvn dependency:tree` under the project folder of the library you're adding.
