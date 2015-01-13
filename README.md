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
2. `cd recipes`
3. `mvn clean install`

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



