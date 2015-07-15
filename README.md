Eclipse Orbit Recipes
=====================

This repositories hosts recipes for building OSGi bundles as part of the Eclipse Orbit project.



Prerequisites
-------------

This project uses Maven for assembling of OSGi bundles based on artifacts in Maven Central or
any other accessible Maven repository.

1. Install Java (at least Java 7, Java 8 preferred) and Maven
2. Clone this repository and go into the repository root folder.



How to build all bundles yourself
---------------------------------

1. Clone this repository and go into the repository root folder.
2. Run the following command to build the OSGi bundle: `mvn clean install`

This will publish all OSGi bundles produced by the recipes into your local Maven repository. You can consume
the bundles directly from Maven in any Tycho build.


### Generate p2 repository

1. Go into the repository root folder.
2. `cd releng/p2`
3. `mvn clean package`

The repository will be made available as archive in `releng/p2/repository/target`.

Note, you **must** build the recipes first and *install* the result into your local Maven repository. Otherwise
the p2 build won't find any bundles.


### How to build just a single recipe?

This is not difficult at all. Just change into the directory of the recipe to build and execute Maven from there.

1. `cd recipes/\<path/to/recipe\>`
2. `mvn clean package`

The resulting bundle will be available in the recipes `target` folder.



How to add recipes
------------------

Adding recipes to this repository is part of the general process for adding bundles to Orbit. Please read the
following additional information first before you proceed.

* [Adding Bundles to Orbit](https://wiki.eclipse.org/Orbit/Adding_Bundles_to_Orbit), especially section "Project Approvals and the CQ Process" 
* [Bundle Checklist](https://wiki.eclipse.org/Orbit_Bundle_Checklist)
* [Additional articles](https://wiki.eclipse.org/Category:Orbit)


### 1. Pick a Category

Recipes are organized in folders by category. There is no strict rule on categories, i.e. categories do not map to vendor names by definition.
However, it seems logical to select a category name based on some common critaria shared by recipies. Most of the time, functionalit"origin" of the 3rd 
party libraries seems like a good fit. But occasionally, functionality (eg, 'logging') is also helpful in order to avoid too fine grained grouping (eg., categories with only two recipies).

In case of doubts/questions, please reach out to the [Orbit Committers List](mailto:orbit-dev@eclipse.org). Also, don't be afraid of mistakes. 
It's all in a single Git repository so re-organization is possible at any time later on.

Note, when creating a new category please create the category pom.xml first before any recipes. Use another category pom.xml as template to inherit the proper Orbit recipe parent pom. 
This ensure that proper Orbit defaults are used when creating recipes (for example, the bundle vendor is automatically set to "Eclipse Orbit").


### 2. Create the recipe

The preferred method for creating recipies is by consuming a Maven artifact. The EBR Maven plug-in can be used to
create a recipe including required Eclipse IP information based on data available in Maven artifact poms.

    # create the recipe for a specific Maven artifact
    # the recipe will be created in a folder named "<symbolicname-of-the-orbit-bundle>_<version>"
    mvn ebr:create-recipe -DgroupId=<maven-source-groupId> -DartifactId=<maven-source-artifactId> -Dversion=<maven-source-version> -DbundleSymbolicName=<symbolicname-of-the-orbit-bundle>

    # modify recipe pom and osgi.bnd to suite the needs of the bundle
    cd <new-recipe-folder>
    $EDITOR pom.xml
    $EDITOR osgi.bnd

    # do a test build (this will create a default ip_log.xml)
    # (note the -DirtyWorkingTree=ignore to ignore uncommitted Git changes for now)
    mvn -U clean package -DdirtyWorkingTree=warning

    # hidden gem: automatically create a CQ for an Eclipse project
    # (use carefully, creates the CQ if noone is referenced in the ip_log.xml file)
    #mvn -V clean package -DsubmitCqsToProject=<Eclipse.project.id> -DcqCryptography=<Yes|No|Unknown|Explanation> -DdirtyWorkingTree=warning
    # (once the CQ is created, source to upload can be found in 'target/sources-for-eclipse-ipzilla')
    # (after uploading the source, wait for approval)
    # (after approval, login to the project portal and create the ATO CQ for Orbit and update the CQ number in ip_log.xml as explained below)

    # enter the CQ number into the IP log and add any missing information
    # (note, this must be the Add-to-Orbit "ATO" CQ filed against the Orbit project)
    $EDITOR src/eclipse/ip_log.xml

    # review the generated about files
    ls -la src/main/resources/about_files
    cat src/main/resources/about.html

    # add new recipe to category pom
    $EDITOR ../pom.xml

    # add, commit the recipe to Git and push it up for review
    

