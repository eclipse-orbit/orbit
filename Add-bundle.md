## Before You Do Anything

### Project Approvals and the IP Process

Don't waste your time working up an OSGi bundling of a third-party
library before you know that you will be able to use it. So, first start
the legal approval process with the Eclipse Foundation's legal
department.

See the IP Provenance item on [the bundle
checklist](Bundle-checklist.md#ip-provenance).
You can make a quick draft of the new bundle. Send and email to
[orbit-dev](https://accounts.eclipse.org/mailing-list/orbit-dev) for
advice.

## Checklist

The [Orbit Bundle Checklist](Bundle-checklist.md) provides
a concise checklist of the following steps.

## Setting up GIT for the new bundle

### Creating a new project for an Orbit bundle

When adding an entirely new library to Orbit, you have to create a
module in GIT to house the content. Follow these steps to set this up
the first time.

1.  First decide on the desired name (see [Bundle
    Naming](Bundle-naming.md)) and make sure to know the
    groupId, artifactId, and version for the maven artifact that will
    serve as a base for the bundle. For this example we'll use
    com.example.foo.
2.  Make sure you have this repo cloned
1.  You need to install the eclipse ebr maven plugin in your machine
    (see [1](https://github.com/eclipse/ebr))
2.  Choose a folder in orbit-recipes git repository under which to
    create the recipe and then create it there using (you might need to
    use the complete ebr name as discussed in the ebr README)

`$ mvn ebr:create-recipe -DgroupId=com.example -DartifactId=foo -Dversion=1.0.0 -DbundleSymbolicName=com.example.foo`

1.  If you are starting a new recipe, you need to add a parent pom to
    the new recipe folder and a module (or modules) with its respective
    pom for the recipes that will be group under the new recipe. Use the
    existing recipes as guidance.

## Library not available on Maven Central

The orbit build process, which makes use of CBI automates a large amount
of the work required to create a bundle from a regular jar library.
However, it depends heavily on the library being available from a maven
repository. The advantage to this approach is it takes away the burden
of uploading the library onto the committers while also opening up the
possibility of having contributors propose changes. Many libraries meet
this requirement and can be found on Maven Central, but for those that
are not there, or cannot be deployed there is an alternative.

The Orbit project provides a more convenient way to upload the library
as well as its sources to our own (Nexus) maven repository where
approved artifacts can be hosted. This is provided through a JIPP
(Jenkins Instance Per-Project) at
<https://ci.eclipse.org/orbit/job/upload-approved-artifacts/> .
Committers would merely trigger a build by providing the library, its
sources, the GAV (groupId, artifactId, version) that will identify it,
and the build would deploy the artifact(s).

## Adding a library for the first time

The page titled, [Adding Bundles To Orbit In 5
Minutes](Add-bundle-in-5-minutes.md) contains all
the necessary information for adding a library to Orbit for the first
time. The process is most straightforward when the library exists on
Maven Central repository.

## Moving an existing bundle to Orbit

Adding an existing bundle to Orbit is currently no too different from
adding a library for the first time (See [Adding Bundles To Orbit In 5
Minutes](Add-bundle-in-5-minutes.md)). The main
difference is that with an existing bundle, certain OSGi metadata may
need to be preserved while others may need to be reproduced to be as
identical to the original metadata.

## Project setup

No matter how you created your bundle in Orbit, the following outlines
how the project itself should be configured. Remember, it is often
simpler to use the Resource Navigator rather than the Project Explorer
since you really need to see all the files in your project and you
aren't really compiling or building anything.

-   In the MANIFEST.MF, ensure that the **Bundle-Classpath:** header is
    either missing or has only '.' as a value.
-   For most cases there is no need to have **Eclipse-Autostart: true**
    or such headers since this library is generic and will not have an
    OSGi bundle activator.
-   Similarly, for most bundles there is no need to set the
    **singleton:=true** on the **Bundle-SymbolicName** header.
-   Of course, you should set the
    **Bundle-RequiredExecutionEnvironment** header to the absolute
    minimum JRE required by the library. That can often be difficult to
    figure out. Look for some tools in PDE to help with this...
-   Where possible use **Import-Package** instead of **Require-Bundle**.
    This reduces sensitivity to different bundlings of the same library.
-   The Orbit community has agreed that **Bundle-Version** numbers
    should be the original library version number followed by .qualifier
    in the fourth segment. In the event that the original number is
    already four segments, that version number should be used and then
    followed by "\_qualifier". *Note that this versioning scheme differs
    from the normal Eclipse plug-in [Version
    Numbering](https://wiki.eclipse.org/Version_Numbering) if the external library
    does not follow the Eclipse rules.*
-   It is suggested that a 3 part version number be included in the
    project name, in the *.project* file. This is to enable those that
    use the Eclipse IDE preference to "Use .project project name instead
    of module name on check out". This makes it easier to check out
    multiple versions of a bundle (project) from its various branches.
    For example,

<projectDescription>  
`  `<name>`javax.xml_1.3.4`</name>  
`  `<comment></comment>  
`  `<projects>  
`  ...`  
`  ...`  
`  `</projects>  
</projectDescription>

## The osgi.bnd file

The osgi.bnd file is used to generate the MANIFEST.MF file for the
bundle so it is very important the contents of this file are correct.
This can be done by building the bundle locally to ensure the final
manifest generated is correct. This file also has a set of predefined
instructions (See
<http://bnd.bndtools.org/chapters/825-instructions-ref.html>). The
following is a list of items to consider when finalizing the osgi.bnd
file.

### Import-Package should have an optional catch-all

All Import-package statements within the osgi.bnd file should end in a
'\*;resolution:=optional' statement that serves as a fallback in the
event that any packages are missed.

`Import-Package: \`  
` org.foo.a.*;version="${range;[===,=+);${package-version}}", \`  
` org.bar.b.*;version="${range;[===,=+);${package-version}}", \`  
` *;resolution:=optional`

It has been argued that things could be made easier by simply having
'Import-Package: \*' and have all dependencies be automated. However,
contributors should be aware of every dependency that their package
uses, so stating them explicitly should be required. This approach still
allows grouping of various packages under a similar namespace using
wild-card matches.

### Emit No Import-Package

This can be done very simply by defining :

`Import-Package: !*`

### Permit Require-Bundle

By default, the Require-Bundle header is removed from the final
generated manifest by the ebr-maven-plugin, and usage of this header in
Orbit manifests is discouraged. If there is a good reason for why it
needs to be used one can permit its use by overriding the property in
the bundle's corresponding pom.xml file :

<properties>  
`  `  
`  <recipe.removeadditionalheaders></recipe.removeadditionalheaders>`  
</properties>

Now, the 'Require-Bundle' header may be defined in the osgi.bnd file.

### Bypass Errors

In some cases the ebr-maven-plugin may halt execution due to what it may
perceive as a packaging error. If the issue is in fact a false positive,
one can bypass it in the osgi.bnd file of the module causing the issue
using the fixupmessages instruction. See
<http://bnd.bndtools.org/instructions/fixupmessages.html> for more
information :

`-fixupmessages "Classes found in the wrong directory"; is:=warning`

The above instruction would ensure that any error/warning message
"Classes found in the wrong directory", would be set as a warning.

### <s> build.properties entries and .classpath file </s>

This is not necessary as the process of creating the bundles is handled
automatically.

A special note about the `build.properties` file:

For your binary bundle (not your source bundle), in most cases it will
have an entry like:

    output..=.

This tells PDE that when someone has the project loaded into their
workspace and other projects depend on it, then PDE should look at the
project root for class files to compile against.

Note that it is important **not** to have a `source..=.` entry in your
build.properties file as that will cause the bundle to be compiled and
this can be a problem with the nested source bundles.

A special note about the `.classpath` file:

Be sure the class folders are listed in the project's `build path`
properties and that they are marked *exported*. This only effects the
.classpath file and effects how PDE and JDT "find" the classes if it
happens to be checked out in a persons workspace while they are coding
other plugins.

### Special Detailed Notes on the four segment case

As documented above, in the event that the original package number is
already four segments, that version number should be used and then
followed by "\_qualifier". These leads to a few differences in exactly
how the final qualifier is computed and referred to in features and map
files. The following example are taken from [bug
152588](https://bugs.eclipse.org/bugs/show_bug.cgi?id=152588).

For example, for the junit version 4.1.0.01, the manifest.mf file
specifies

`   Bundle-Version: 4.1.0.01_qualifier`

But, the feature.xml file specifies

`   `<plugin id="org.junit" version="4.1.0.qualifier" />

The resulting jar file is named as follows.

`    org.junit_4.1.0.01_200704231307.jar`

And, the resulting bundle version matches the file name, for example,

`    Bundle-Version: 4.1.0.01_200704231307`

#### Avoid qualifiers that change with date and time of each build

Note: to avoid the "current date and time" substitution for qualifier
version -- which would cause a version increment each build, even though
contents not changed, use the exact same form in the feature.xml file.
(See .) For example, use 10.5.1.1_qualifier in the feature.xml file,
such as,

`  `<plugin id="org.apache.derby" version="10.5.1.1_qualifier" />

This will then cause the last time of modification to be substituted for
'qualifier', resulting in versions such as 10.5.1.1_v201108232300. This
may look different from usual, but will remain constant from build to
build.

### Special Detailed Notes on the RC case

Sometimes bundles need to be added that aren't full releases, but
'release candidates.' These release candidate plug-ins should share the
same branch as their full release cousins.

For example, let's say we have a plug-in ch.ethz.iks.slp 1.0.0 RC2, the
manifest.mf file specifies

`   Bundle-Version: 1.0.0.RC2_qualifier`

The branch the plug-in would be created in is v1_0\_0 even though it's
an RC2 release. Once 1.0.0 came out or say RC3, the branch would be
updated with the info code. This essentially limits us to one "1.0.0"
release at a time, but it's an acceptable workaround for the time being.

The feature.xml file specifies

`   `<plugin
        id="ch.ethz.iks.slp"
        download-size="0"
        install-size="0"
        version="1.0.0.qualifier" />

And, the (multiversion) map file specifies

`    plugin@ch.ethz.iks.slp,1.0.0=v200701261101,:pserver:anonymous....`

The resulting zip file is named as follows (zip, in this case, since it
is not a jarred bundle).

`    ch.ethz.iks.slp_1.0.0.RC2_200704231307.zip`

And, the resulting bundle version matches the file name, for example,

`    Bundle-Version: 1.0.0.RC2_200704231307`

Note: It's incredibly important that the final release is
lexicographically greater than the release candidate so it can be
updated properly. For example, ch.ethz.iks.slp_1.0.0.RC2_v200801291200
is \> than ch.ethz.iks.slp.1.0.0_v200801291200 because "R" is considered
greater than "v"

## Bundle Packaging Options

### Embedded Jars

Certain bundles may require that class files be provided as embedded
jars, and referenced under the `Bundle-ClassPath` attribute of the
`MANIFEST.MF`, as opposed to exploded jars at the root of the class
path.

To achieve this, simply define the property
`<recipe.unpackdependencies>false</recipe.unpackdependencies>` in the
bundle's module. One can further customize the naming of the embedded
jars using `<recipe.stripversion>true</recipe.stripversion>` to further
strip out the versioning from the listed jars.

<properties>  
`  <recipe.unpackdependencies>false</recipe.unpackdependencies>`  
`  <recipe.stripversion>true</recipe.stripversion>`  
</properties>

### Excluding Source Bundles

In cases where certain bundles must be distributed 'binary only',
without corresponding source bundles, this can be achieved through the
<excludes> configuration option of the `tycho-source-feature-plugin` in
`releng/mavenparent/pom.xml`

## Adding Bundles To A Maintenance Release

In some cases, it may be required to add bundles to maintenance releases
(eg. Oxygen.2) while active development is taking towards a newer
release (eg. Photon). This is simply a matter of cherry picking (through
git) the necessary changes onto the corresponding maintenance branch.

1.  Locate the maintenance branch corresponding to the release. It
    should be named RX_Y , where X.Y would be the version of the Eclipse
    release.
2.  `git cherry-pick ${COMMIT}` (resolving any conflicts)
3.  `GIT_COMMITTER_DATE="$(git show -s --format=%cd)" git commit --amend`

The `GIT_COMMITTER_DATE` environment variable ensures that the commit
date used for the cherry-picked commit matches that of the original
commit on the development branch. This is necessary to ensure that the
bundle built using the maintenance branch will be given the same
qualifier (through tycho-packaging-plugin's jgit time stamp provider) as
the original bundle in the event that there are no additional changes.

## Packaging licensing information

When packaging a third party library we have to ensure that the
licensing information is present and correctly used. Generally, the
**about_files**, **about.html**, **build.properties**, and the
**ip_log.xml** files will be automatically generated and correctly
defined. They should still be checked to ensure the correct license has
been detected and in the case of the **ip_log.xml** file, some
additional fields will need to be filled in manually such as the
corresponding ATO (Add To Orbit) CQ.

## National Language Considerations

The following are some tips to help make sure any text in the bundle is
not "garbled" during network or storage transfers and it is capable of
being properly translated to languages other than English.

-   As I think is true for all projects in an Eclipse repository, it is
    recommend you set the project's default encoding preference to
    ISO-8859-1. This project encoding applies to files that do not
    otherwise have any ability to specify their encoding (such as ".txt"
    or ".java" files). This is a good "single byte" encoding in general,
    and I think the CVS Repository Server assumes ISO-8859-1 as the
    default. Having it set as a project setting is good, so that, for
    example, if someone on windows checks it out and makes changes, and
    someone on Linux checks it out and makes changes, the default
    encoding for that project will be the same, no matter what the
    default encoding are on those different OS platforms.

<!-- -->

-   Be sure to "externalize" all the string in your manifest.mf files,
    and plugin.xml files, if you have any. There is usually at least
    two: the provider's name and the bundle's name.

## <s> What to use as Provider Name? </s>

This is automatically generated by the orbit-recipes build but if for
some reason this isn't being generated, Use "Eclipse Orbit".

This is for the `Bundle-Vendor:` header in manifest.mf files. This
should be externalized so what's in the manifest.mf file is a key,
usually something like

`Bundle-Vendor: %Bundle-Vendor.0`

and then in the plugin.properties, or bundle.properties file is there
you would have

`Bundle-Vendor.0 = Eclipse Orbit`

Historically, it used to be required to use "Eclipse.org". Beginning in
Galileo, however, the recommendation (requirement, actually) is to use
'Eclipse' followed by the project name, avoiding acronyms and
abbreviations etc, acknowledging that these are for end-users to read.
The appropriate "project name" differs from one top level project to
another. For example, in WTP, all sub-projects use the top level project
name ("Eclipse Web Tools Platform"). But in Tools, since the
sub-projects are all fairly different from one another, the Tools PMC
decided to use "Eclipse" followed by sub-project name. So, that's
"Eclipse Orbit" for us.

There is one exception. We have some bundles that are pre-built and we
just store them in our repository. There, the provider name is left as
it is, of course, since it is pre-built. But anything we build/assemble
should be "Eclipse Orbit".

## Avoid packing (pack200) nested jars

Unless there is an important reason to, avoid "packing" jars nested
inside Orbit bundles. The reason is that changes in Java 7 make these
packed children impossible to extract so tools such as p2 then has to
"fall back" and use the plain jar version of the bundle anyway ... all
adding up to a slight performance impact. See for more details.

Mechanically, the way to accomplish this is to include a file named
'eclipse.inf' in the META-INF folder that has contents of

`jarprocessor.exclude.children.pack=true`

Or, if you want to excluded nested jars from packing and from signing,
you can use

`jarprocessor.exclude.children=true`

Whether or not to exclude children from signing depends on how the jar
is anticipated to be used. In some cases, consumers might expect it to
be signed, in other cases, they might expect it not to be signed. For
use in the Eclipse IDE, it does not particularly matter, the default
Equinox settings will not 'verify' nested jars, though there are some
server runtimes that do. Most bundles in Orbit use
`jarprocessor.exclude.children=true`.

Occasionally, source-bundles also have "nested jars", so those would
also need the eclipse.inf file put in their META-INF directory.

## Remember to retain important aspect of original jar manifest

Part of the goal of creating Orbit bundles, is that when ever possible,
the Orbit bundle can continue to be used as a jar, just as it would have
been originally.

In some cases, this means there may be aspects in the original jar's
manifest that should be carried over to the manifest in the bundle.

### Examples of things important to retain

One example, if the original jar's manifest contains a *Main-Class*
directive, then the bundle's manifest should contain the same
*Main-Class* directives. One case of this is the Rhino bundle
(org.mozilla.javascript). It originally contained

` Main-Class: org.mozilla.javascript.tools.shell.Main`

which prints the version and starts up an interpreter "shell". It's best
to maintain that sort of functionality whenever possible.

### Examples of things not to retain

An example of what not to retain was raised in . Some jars have
*Class-Path:* directives in their MANIFEST.MF files. This is the
"non-OSGi" way of expressing a dependency on another jar (not to be
confused with OSGi's *Bundle-ClassPath:* which is a different concept).
In the cases I've seen, these 'Class-Path' directives become meaningless
in OSGi bundles, either because the path or the jar referenced in that
'Class-Path' no longer exists, or it exists in a different form, such as
with with version information added to the name. In some cases it
becomes part of what a bundle "requires", which, naturally, is expressed
in the "OSGi way". Having the 'Class-Path' there has no effect on the
bundle when run with OSGi and none of our build systems pay attention to
it, but as mentioned in there are some build systems that will flag any
"non-existing file" or "invalid path" as an error, interfering with the
build. Hence, it's a good idea to remove any lines that have a
'Class-Path' directive. In most cases, though, this directive is
probably useful in helping you "convert" the information when you create
the OSGi bundle, that is, that you can add a proper *Require-Bundle:* to
express the same relationship in the OSGi way.

## Export-Package guidelines

Normally, all packages in a bundle should be listed in the
Export-Package declaration in MANIFEST.MF.

But, if a bundle has packages that are not normally part of its
namespace, those should not be blindly exported, unless it is known that
they are supposed to be. That is, the first assumption should be the
bundle simply uses those packages internally, and are not part of its
API to expose to the rest of the world. See for a case where exporting
"foreign" packages can cause problems.

Also, normally, all exported packages should list the version they are
exporting. Keep in mind that if a package in an interface, defined by a
specification, then the version of the exported package should be the
version of the specification, not the bundle it is in. For example, we
use `"Export-Package: javax.xml;version="1.3"`, even though the package
is in the javax.xml bundle versioned at 1.3.4.

## Adding your bundle to the feature.xml

There is a feature in Orbit that is used solely to drive the build. To
modify it, checkout this repo. It will be located under releng/aggregationfeature/feature.xml.
You'd add your bundle to this feature like any other. For example,

`   `<plugin id="javax.servlet" version="2.3.0.qualifier" />


## Adding your bundle to the Orbit Build

See [ Adding To
Build](Add-bundle-in-5-minutes.md).

## Final steps (a.k.a being a good OSS citizen)

It's a good practice to contribute back OSGi packaging - many upstream
are not aware of OSGi and will appreciate patches. Having OSGi manifests
upstream has a couple of advantages:

-   shared burden of maintenance
-   easier adoption (3rd party software can use newer versions before it
    is located in Orbit and drive Eclipse migration to
    latest-and-greatest versions).
-   spreading the word about OSGi

