Orbit itself does not have releases, per se, since the 3rd party jars
that are bundled have already been released. But, we will still use the
Eclipse [Simultaneous Release](https://wiki.eclipse.org/Simultaneous_Release) rhythm
to set deadlines for ourselves and promote and retain bundles.

An Orbit milestone date will be considered the same as the base Eclipse
platform milestone date, since for anyone in a [Simultaneous
Release](https://wiki.eclipse.org/Simultaneous_Release) to use an Orbit Bundle, it
would have to be ready (and final) at least a week or two before their
milestone deadline.

### Continuous Builds

Our continuous builds produce builds on the [downloads
page](http://download.eclipse.org/tools/orbit/downloads). Their purpose
is for the committers to have something to see or download and confirm
all is as they expect it to be. These builds are often short lived and
can be deleted without notice.

Note that all new changes eventually trigger an integration (I) build
that gets automatically promoted to the downloads page.

### Milestone and Recommended Release Process

Some of the steps are a little different for Recommended than
Milestones - see comments as you go through the list.

1.  Log in with your committer account on
    <https://ci.eclipse.org/orbit/>
2.  Go to the
    [orbit-recipes](https://ci.eclipse.org/orbit/job/orbit-recipes/)
    JIPP
    1.  Click 'Build with Parameters'
        1.  For S-builds:
            1.  Change the `BUILD_LABEL` to `S` using the drop-down box,
                to indicate a stable build
        2.  For R-builds:
            1.  Change the `BUILD_LABEL` to `R` using the drop-down box,
                to indicate a recommended build
    2.  Make sure `SIMREL_NAME` is set to the name of the simultaneous
        release (eg. 2019-03) to which this build will contribute
    3.  Make sure `DESCRIPTION` is set to the description desired on the
        downloads page (at least e.g. 2022-06 M1, can include additional
        notes and URLs. Cannot include double-quotes, e.g.
        <a href='https://download.eclipse.org/tools/orbit/downloads/2022-03'>`2022-03`</a>)
    4.  Leave everything else as-is, and click build
    5.  Once the build succeeds, click the 'Keep this build forever'
        button
3.  **The notes.php** step has been removed as that is done as part of
    the build, using `DESCRIPTION`
4.  **The promote-to-downloads** step has been removed as that is done
    always as part of the build now.
5.  Announce the release of the milestone build on the orbit-dev mailing
    list.
    1.  Use a previous announcement email as a starting point
    2.  To generate the p2 diffs: `p2ql diff ${oldRepo} ${newRepo}`
        1.  To setup p2 diffs:
            1.  `mkdir -p ~/git`
            2.  `cd ~/git`
            3.  `git clone `[`https://github.com/rgrunber/fedoraproject-p2`](https://github.com/rgrunber/fedoraproject-p2)
            4.  `cd ~/git/fedoraproject-p2`
            5.  `mvn clean package`
            6.  `git clone `[`https://github.com/rgrunber/utils-for-eclipse`](https://github.com/rgrunber/utils-for-eclipse)
            7.  `cd ~/git/utils-for-eclipse`
            8.  `mvn clean package`
            9.  Add a recent eclipse to the `PATH` (maybe best to match
                the one listed in
                <https://github.com/rgrunber/fedoraproject-p2/blob/5a3081a0b45599223c6dced8631bc40b218ed172/pom.xml#L61-L68>)
            10. `./p2ql diff ${oldRepo} ${newRepo}`
6.  Once you have made the announcement, the build is considered
    released. Be sure to update the `referenceRepoBuild` in
    `releng/mavenparent/pom.xml` property to reference the released
    build. This will ensure that new packages introduced in this (just
    announced) release have their timestamps frozen until further
    possible changes are introduced.
7.  Notify Eclipse Plaform by commenting in the bug with title "Eclipse
    4.xx prerequisitres: Orbit" (see this
    [example](https://github.com/eclipse-platform/eclipse.platform.releng.aggregator/issues/172)
    for the 4.24 release)

### Milestones and Recommended ("Final") Bundles Area

Once per milestone, (roughly simultaneous with the platform's
milestone), a rebuild will occur on the latest commit, and the earlier
weekly builds may be deleted. Each Milestone Build will be retained
until an Eclipse Simultaneous Release and then all deleted.

It was decided in June 12, 2007 status meeting to (still) have dated
directories for the "final" builds, and was decided to call them
"R-builds", which may sound like "Released", but is "Recommended" for
Orbit, since Orbit does not have Releases in the Eclipse sense of that
word.

The bundles in "Recommended" builds will only be changed (re-created) if
there are serious bugs found with them. Even then, any "Recommended"
builds will be retained long term, such as for 2 years or so, so build
scripts will not break and be re-creatable.

#### Milestones and Recommended Build "Notes" Column

On the main download page is a column labeled "Notes". While technically
any "note" can be put in there, at a minimum for every "R-build" and
"S-build" a note should be added for which Simultaneous Release the
build was first recommended for.

Adding notes to the file is a matter of "hand editing" the "notes.php"
file on the download server. It is under

`.../tools/orbit/downloads/`

and new entries are added, by adding new array entries, which are
indexed by the "display name" of the download. For example, if existing
file started with the following:

`<?php`  
  
`$notes = array();`  
  
`$notes["R20140525021250"]="Luna, Luna SR1";`  
`$notes["R20140114142710"]="Kepler SR2";`  

then the next R-build was for Mars, and named R201506011000, and no new
R-build for Luna SR2, that file would end up starting with:

`<?php`  
  
`$notes = array();`  
  
`$notes["R20150601100000"]="Mars";`  
`$notes["R20140525021250"]="Luna, Luna SR1, Luna SR2";`  
`$notes["R20140114142710"]="Kepler SR2";`

This file, and others are stored in module
org.eclipse.orbit.releng.downloadsites but there is no automatic update
or anything from those files, to download server.

### Milestone dates

The Orbit milestones dates will be a -3 delivery (Tuesday) in
Simultaneous Releases, to allow all projects to pick up prereqs (even
the Platform, the 0 delivery).

### Build Retention

Milestone builds will be retained until the Recommend build is produced.

Recommended builds will be kept forever, the most recent one(s) on
'download.eclipse.org' but older ones will be moved to
'archive.eclipse.org' (which is not mirrored) The old, archived builds
should rarely be needed, used only be used if someone needed to
re-create some old build which was based upon it, such as for long term
maintenance.

### Bundle Retention in active builds

It is our Orbit project's policy that once a bundle is delivered in an
R-build, it will be retained forever in that R-build (or its
repository). But, in active (or, current) builds, to be used for future
releases, we may remove old versions of bundles according to the
following guidelines.

-   Normally only 1 version of a bundle will be in active builds. Older
    bundle versions should be removed, since they would presumably never
    be used by other, active Eclipse projects. If projects or adopters
    still needed some older version, say for maintenance builds, they
    can get them from the older R-build repositories where they were
    last provided. Note: "versions" in this context, refers to
    differences in the major, minor, or service fields of the version.
    There is never a case where the same version, but different
    qualifiers would be in an active build. But, of course, it is common
    for the qualifier to change from one Orbit release to another, if
    fixes are made to the manifest, for example.

<!-- -->

-   Why continue to have any bundle in "active builds" once it is built
    and deemed ready? The reason is to have the ability to have
    "integration builds" and "milestone builds" in order to get proper
    feedback and testing before we literally make it permanent in an
    R-build. There may well be improvements in the build process where
    only "one or two" bundles are built at a time and then go into the
    "I-build repository". In that case, the I-build repository would be
    considered the "active build". Plus, there is a desire to allow
    consumers, especially of "active builds" to refer to just one
    repository and "get everything they need" instead of having to refer
    to several repositories to to piece together their dependencies.

<!-- -->

-   There are a few exceptions to the above "only 1 version" rule:

  
\- First and foremost, someone requests it, via bugzilla and gives good
reason why they need an older version still.

\- For any known cases in the yearly Simultaneous Release where
consumers already use more than one version -- again, for a good reason
(such as the APIs changed in the newer version, and the project does not
have the ability or need to move to the new API).

\- There might be cases where the latest version of some package in
Orbit depends on an older version of a package but that package itself
can be used independently and someone wants to use a newer version of
it.

-   Any removal of an older version will normally be done by M3 of the
    current yearly release cycle (though RC1 is normally considered the
    "API freeze" date). This allows exceptions or mistakes to be
    corrected in time for the yearly release with no danger of "last
    minute" breakage. And M3 is the latest possible time (normally) ...
    committers should make an effort to do much earlier in a yearly
    release cycle.

<!-- -->

-   Remember, older versions will stay in our SCM, as they are, forever.
    That is, the older versions are simply removed from the active
    builds ... never from SCM nor existing R-build repositories. This is
    partially so someone could find them if needed to investigate
    something, but also so we can easily add them back to active builds
    if needed.

<!-- -->

-   Removals should be documented in bugzilla ... similar to how
    additions are shoudl be documented in bugzilla.
