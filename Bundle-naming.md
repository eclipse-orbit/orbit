Bundling third party code libraries such as Log4j or Commons Logging is
generally easy. Choosing a bundle symbolic name (BSN) for the bundle can
be challenging. There are a number of questions that must be asked,
options investigated and decisions made. The information here is an
attempt to capture some of these issues in an effort to get some level
of uniformity within the Eclipse and OSGi communities. This information
is put here to generate discussion and surface and resolve issues.

## Issue 1 : Namespace ownership

While it is suggested that BSN's be in the form of reverse domain names,
this is not required by the OSGi spec. Assuming you want to follow that
guideline, there are two choices for the BSN; use your namespace or use
the namespace of the library's originator. Some thoughts from the
community...

-   Using your namespace correctly stamps the bundle as your view of the
    library
-   Using the originator's namespace correctly attributes
    credit/ownership for the function
-   Using the originator's namespace inhibits the originator from free
    use of their namespace
-   Using your namespace leads to many names for the same thing (e.g.,
    org.eclipse.orbit.jetty and org.apache.felix.jetty vs. just
    org.mortbay.jetty)

As you can see, there are reasonable yet diametrically opposed views.
There is some clarity in this space however.

-   if you modify or add to the library code then using your own
    namespace is probably best as you are not incorrectly assigning
    responsibility (i.e., blame) to the originator.

## Issue 2 : Evolution

On the whole the issues raised here only come up because library
producers are not producing OSGi bundles. The hope is that over time
library producers will change and begin to ship OSGi bundles natively.
As such, they will take responsibility for choosing a BSN. Some thoughts
from the community...

-   When that happens, what if they choose the same name as we choose
    now?
-   The choice we make now will help guide the producers when picking a
    BSN (we are setting the example)
-   What about version number clashes?
-   What about people who are using Require-Bundle?

## Option 1 : Dominant package name

For many libraries it is easy to identify one Java package as being "the
root" of the function. This is a reasonable choice for the BSN assuming
you are comfortable using the originator's domain name. This option
implies names such as org.mortbay.jetty.

Note that some libraries do not use full domain names in their package
naming. MX4J packages for example are simply mx4j.\*. Following this
option would lead to a BSN of just mx4j. As noted above, this is
perfectly legal. One could opt here to add in the remaining domain
segments and go for net.sourceforge.mx4j.

## Option 2 : Your namespace + originator simple name

If you would prefer to use your own namespace (or have modified/added
code) a BSN of the form org.eclipse.orbit.jetty seems reasonable. Here
the first part is the shortest sequence that is in your control and the
remaining part is the "short name" of the originator's function.

## Option 3 : Your namespace + originator's full name

To be 100% safe with respect to namespace clashes, you could use the
originator's full name in conjunction with your namespace to create a
BSN of the form org.eclipse.orbit.org.mortbay.jetty. Here the first part
is the shortest sequence that is in your control and the remaining part
is the "full name" of the originator's function.

Jeff McAffer says: this seems excessive.

## Issue 3 : Distinguishing different implementations

In some cases, there are different implementations of a package or
interface, even of the exact same version. In this case, the simple
package name and version is not enough to distinguish the different
implementations. Note that in Eclipse, it is generally assumed that a
bundle symbolic name and version specify a unique set of executable
bits, so it would be confusing to distribute bundles with same name,
same version, but different implementations. (See bug
[226813](https://bugs.eclipse.org/bugs/show_bug.cgi?id=226813) for some
discussion of this).

javax.mail has been one of the bundles that has several implementors
(sun, glassfish, geronimo, etc) so looking at the latest versions of
those bundles in Orbit would help illustrate some of these issues and
problems.

There are two things that should be done when there are different
implementations of the same API from different vendors.

First, 'vendor' attribute should be used when exporting packages, so
that clients who care, can specify it on their import package
statements. For example, from the javax.mail from glassfish, in the
manifest.mf file one export line looks like

` javax.mail; vendor=glassfish; version="1.4.1",`

For contrast, this could be

` javax.mail; vendor=geronimo; version="1.4.1",`

The second thing to do is to add the 'vendor' name to the end of the
main package name (the main package name being that described in "Option
1" above). So, for javax.mail, this would be javax.mail.glassfish or
javax.mail.geronimo. This pattern of the putting the vendor name last is
a little bit arbitrary, but seems to make the most sense in the big
picture of all bundles, by putting the most significant part of the name
first. Here, "most significant" means how someone might be looking for a
function in an alphabetized list of bundles. So, to be explicit, it's
assumed they are looking for "javax.mail" and then would pick which
implementation they wanted.

Note: as of this writing, some of the bundles in Orbit, do not perfectly
match the advise given here, simply because they were done before this
policy was decided.

Also note: It is assumed we would start to use the vendor name in the
bundle symbolic identifier only once there was an actual "conflict" in
Orbit. Even if we know there is more than one implementation out in the
world, there is no need to use it initially, if there is only one
implementation in Orbit. There is no harm in doing so ... we are just
stating it is not **required**.

