Here are the steps for adding a new bundle to Orbit. Please use them as
a checklist to ensure that you have done everything correctly when you
have a new bundle to add.

### IP Provenance

All contributions to Orbit need to be approved for use, either
automatically or by raising an iplab issue for the content if the
automatic check does not work. The automatic check is done by activating
the "license-check" profile, e.g. `mvn verify -P license-check`. If the
automatic check fails you may need to raise an [iplab issue (choose
vet-third-party in Description dropdown to get correct
template)](https://gitlab.eclipse.org/eclipsefdn/emo-team/iplab/-/issues/new).
Send and email to
[orbit-dev](https://accounts.eclipse.org/mailing-list/orbit-dev) for
advice.

### Add the Bundle to Git

In Orbit we store the metadata necessary to generate a bundle in the
[orbit-recipes](http://git.eclipse.org/c/gerrit/orbit/orbit-recipes.git/)
Git repository. Look at our [Adding Bundles to
Orbit](Add-bundle.md) document for instructions on
how to initially put your bundle into Orbit.

### Verify the osgi.bnd

The osgi.bnd file is used to generate the bundle manifest
(`META-INF/MANIFEST.MF`), and while this file gets generated with some
defaults, it is very important to verify it as well as the contents of
the generated manifest to ensure the final result is what one expects.
In particular the `Import-Package` header patterns should be verified.

### Update the Feature

In Eclipse we build features so when we add a new bundle to Orbit, we
must add it to the feature so the builder is aware that we should build
it. Please update `releng/aggregationfeature/feature.xml` in
[orbit-recipes](https://git.eclipse.org/c/orbit/orbit-recipes.git/) with
an entry for your new bundle. (you don't need one for the source bundle)
Changes to the Orbit feature are done in the master branch on Git.

<plugin id="javax.servlet" version="2.3.0.qualifier" />

### Final Notes

-   When in doubt, look at the other bundles in Orbit to see what they
    did.
-   Always check the build output to ensure that it is what you expect.

### Example Layout

Here is an example structure for a bundle.

    my.bundle.id_1.0.0/
        pom.xml
        src/
            main/resources/
                about_files/LICENSE.txt
                about.html
        .project
        osgi.bnd

