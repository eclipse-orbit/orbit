# com.google.auth:oauth2-http:0.20.0

## Dependency hierarchy 
The following represents the dependency hierarchy for adds to orbit related to this bundle.  When this bundle is updated, some or all of the related adds may need to be updated also.

com.google.auth:oauth2-http:0.20.0
--com.google.auth:google-auth-library-credentials:0.20.0
--com.google.auto.value:auto-value-annotations:1.7
--com.google.http-client:google-http-client:1.34.2
----com.google.j2objc:j2objc-annotations:1.3
----io.opencensus:opencensus-contrib-http-util:0.26.0
----io.opencensus:opencensus-api:0.26.0
------io.grpc:grpc-context:1.29.0
--com.google.http-client:google-http-client-jackson2:1.34.2

## CQ Info
In order to aid in future CQs, here is the CQ information for the related adds.

-com.google.http-client:google-http-client:1.34.2
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21992
https://search.maven.org/artifact/com.google.http-client/google-http-client/1.34.2/jar
https://github.com/googleapis/google-http-java-client/blob/master/google-http-client/pom.xml
Apache 2

Google HTTP Client Library for Java. Functionality that works on all supported Java platforms, including Java 7 (or higher) desktop (SE) and web (EE), Android, and Google App Engine.

Maven Information
-----------------
Group Id: com.google.http-client
Artifact Id: google-http-client
Version: 1.34.2
File: google-http-client-1.34.2.jar

-com.google.http-client:google-http-client-jackson2:1.34.2
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21993
https://search.maven.org/artifact/com.google.http-client/google-http-client-jackson2/1.34.2/jar
https://github.com/googleapis/google-http-java-client/blob/master/google-http-client-jackson2/pom.xml
Apache 2

Jackson 2 extensions to the Google HTTP Client Library for Java.

Maven Information
-----------------
Group Id: com.google.http-client
Artifact Id: google-http-client-jackson2
Version: 1.34.2
File: google-http-client-jackson2-1.34.2.jar

-com.google.auth:google-auth-library-credentials:0.20.0
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21994
https://search.maven.org/artifact/com.google.auth/google-auth-library-credentials/0.20.0/jar
https://github.com/googleapis/google-auth-library-java
BSD 3

Open source authentication client library for Java.

Maven Information
-----------------
Group Id: com.google.auth
Artifact Id: google-auth-library-credentials
Version: 0.20.0
File: google-auth-library-credentials-0.20.0.jar

-com.google.auto.value:auto-value-annotations:1.7
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21999
https://search.maven.org/artifact/com.google.auto.value/auto-value-annotations/1.7/jar
https://github.com/google/auto
https://github.com/google/auto/tree/master/value/annotations
Apache 2

A collection of source code generators for Java.

Maven Information
-----------------
Group Id: com.google.auto.value
Artifact Id: auto-value-annotations
Version: 1.7
File: auto-value-annotations-1.7.jar

-com.google.j2objc:j2objc-annotations:1.3
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21995
https://search.maven.org/artifact/com.google.j2objc/j2objc-annotations/1.3/jar
https://github.com/google/j2objc
https://github.com/google/j2objc
Apache 2

A set of annotations that provide additional information to the J2ObjC translator to modify the result of translation.
 
Maven Information
-----------------
Group Id: com.google.j2objc
Artifact Id: j2objc-annotations
Version: 1.3
File: j2objc-annotations-1.3.jar

-io.opencensus:opencensus-contrib-http-util:0.26.0
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21996
https://search.maven.org/artifact/io.opencensus/opencensus-contrib-http-util/0.26.0/jar
http://opencensus.io/
https://github.com/census-instrumentation/opencensus-java/tree/master/contrib/http_util
Apache 2

The OpenCensus HTTP Util for Java is a collection of utilities for trace instrumentation when working with HTTP.

Maven Information
-----------------
Group Id: io.opencensus
Artifact Id: opencensus-contrib-http-util
Version: 0.26.0
File: opencensus-contrib-http-util-0.26.0.jar

-io.opencensus:opencensus-api:0.26.0
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21997
https://search.maven.org/artifact/io.opencensus/opencensus-api/0.26.0/jar
http://opencensus.io/
https://github.com/census-instrumentation/opencensus-java/tree/master/api
Apache 2

OpenCensus is a toolkit for collecting application performance and behavior data.

Maven Information
-----------------
Group Id: io.opencensus
Artifact Id: opencensus-api
Version: 0.26.0
File: opencensus-api-0.26.0.jar

-io.grpc:grpc-context:1.29.0
https://dev.eclipse.org/ipzilla/show_bug.cgi?id=21998
https://search.maven.org/artifact/io.grpc/grpc-context/1.29.0/jar
https://grpc.io
https://github.com/grpc/grpc-java/tree/master/context
Apache 2

A high-performance, open source universal RPC framework

Maven Information
-----------------
Group Id: io.grpc
Artifact Id: grpc-context
Version: 1.29.0
File: grpc-context-1.29.0.jar

# Maven :dependencyTree output
[INFO] --- maven-dependency-plugin:3.1.1:list (default-cli) @ google-auth-library-oauth2-http ---
[INFO] 
[INFO] The following files have been resolved:
[INFO]    com.google.auto.value:auto-value-annotations:jar:1.7:compile -- module auto.value.annotations (auto)
[INFO]    com.google.code.findbugs:jsr305:jar:3.0.2:compile -- module jsr305 (auto)
[INFO]    com.google.auth:google-auth-library-credentials:jar:0.20.0:compile -- module com.google.auth [auto]
[INFO]    com.google.http-client:google-http-client:jar:1.34.0:compile -- module com.google.api.client [auto]
[INFO]    org.apache.httpcomponents:httpclient:jar:4.5.10:compile -- module org.apache.httpcomponents.httpclient [auto]
[INFO]    commons-logging:commons-logging:jar:1.2:compile -- module commons.logging (auto)
[INFO]    commons-codec:commons-codec:jar:1.11:compile -- module org.apache.commons.codec [auto]
[INFO]    org.apache.httpcomponents:httpcore:jar:4.4.12:compile -- module org.apache.httpcomponents.httpcore [auto]
[INFO]    com.google.j2objc:j2objc-annotations:jar:1.3:compile -- module j2objc.annotations (auto)
[INFO]    io.opencensus:opencensus-api:jar:0.24.0:compile -- module opencensus.api (auto)
[INFO]    io.grpc:grpc-context:jar:1.22.1:compile -- module grpc.context (auto)
[INFO]    io.opencensus:opencensus-contrib-http-util:jar:0.24.0:compile -- module opencensus.contrib.http.util (auto)
[INFO]    com.google.http-client:google-http-client-jackson2:jar:1.34.0:compile -- module com.google.api.client.json.jackson2 [auto]
[INFO]    com.fasterxml.jackson.core:jackson-core:jar:2.10.1:compile -- module com.fasterxml.jackson.core
[INFO]    com.google.guava:guava:jar:28.2-android:compile -- module com.google.common [auto]
[INFO]    com.google.guava:failureaccess:jar:1.0.1:compile -- module failureaccess (auto)
[INFO]    com.google.guava:listenablefuture:jar:9999.0-empty-to-avoid-conflict-with-guava:compile -- module listenablefuture (auto)
[INFO]    org.checkerframework:checker-compat-qual:jar:2.5.5:compile -- module org.checkerframework.checker.qual [auto]
[INFO]    com.google.errorprone:error_prone_annotations:jar:2.3.4:compile -- module com.google.errorprone.annotations [auto]
[INFO]    junit:junit:jar:4.13:test -- module junit [auto]
[INFO]    org.hamcrest:hamcrest-core:jar:1.3:test -- module hamcrest.core (auto)
