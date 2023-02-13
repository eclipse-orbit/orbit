#!/bin/bash

set -xeu

# Inputs for this script, with an example of what that looks like:
contentFile=$1 # /path/to/content.xml (extracted from build's content.jar)
buildlabel=$2 # I20230210160017
buildURL=$3 # https://ci.eclipse.org/orbit/job/orbit-recipes/472/
repoPath=$4 # https://download.eclipse.org/tools/orbit/downloads/drops/I20230210160017/repository
zipFileSize=$5 # 322M

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

pageTitle="Orbit Build $buildlabel"
downloadUrlPrefix='https://www.eclipse.org/downloads/download.php?file=/tools/orbit/committers/drops/${buildlabel}/'
downloadWithRedirectUrlPrefix='https://www.eclipse.org/downloads/download.php?r=1&file=/tools/orbit/committers/drops/${buildlabel}/'

cat - <<HEADER
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="Christopher Guindon" />
<meta name="keywords" content="eclipse.org, Eclipse Foundation" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,700,300,600,100" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="/eclipse.org-common/themes/solstice/public/images/favicon.ico" />
<title>$pageTitle</title>

<link rel="stylesheet" href="/eclipse.org-common/themes/solstice/public/stylesheets/styles.min.css">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style>
td, th {
  font-family: monospace, monospace;
  padding-left: 1em;
  padding-top: .25em;
  padding-bottom: .25em;
  padding-right: 0;
  text-align: left;
  vertical-align: top;
}

table.downloads {
  font-family: monospace, monospace;
  width: 80%;
  margin-left: auto;
  margin-right: auto;
  border-collapse: collapse;
}

td.latest {
  text-align: left;
  padding-left: 1em;
  padding-top: .25em;
  padding-bottom: .25em;
  padding-right: 0;
  width: 100%;
  background-color: #3b335a;
  color: #FFFFFF;
  colspan: 3;
}

td.main {
  text-align: left;
  padding-left: 1em;
  padding-top: .25em;
  padding-bottom: .25em;
  padding-right: 0;
  width: 100%;
  background-color: #76708C;
  color: #FFFFFF;
}

td.main {
  text-align: left;
  padding-left: 1em;
  padding-top: .25em;
  padding-bottom: .25em;
  padding-right: 0;
  width: 100%;
  background-color: #76708C;
  color: #FFFFFF;
}

td.name {
  width: 20%;
  padding-left: 2em;
  text-align: left;
}

th.name {
  width: 20%;
  text-align: left;
  text-style: bold;
}

td.status {
  padding-left: 2em;
  text-align: left;
}

th.status {
  text-align: left;
  text-style: bold;
}

td.date {
  width: 30%;
  padding-left: 2em;
  text-align: left;
}

th.date {
  width: 30%;
  text-align: left;
  text-style: bold;
}

img.cs { /* character size image */
  border: 0;
  width: 1em;
  height: 1em;
  vertical-align: text-bottom;
  margin: 0 0.5em 0 0;
}
</style>

</head>
<body class="" id="body_solstice">
  <a class="sr-only" href="#content">Skip to main content</a>
  <header role="banner">
    <div class="container">

      <div id="row-toolbar" class="text-right hidden-print">

        <div id="row-toolbar-col" class="col-md-24">
          <ul class="list-inline">
            <!-- leaving space instead of "sign in" -->
            <li>&nbsp;</li>
            <li>&nbsp;</li>
          </ul>
        </div>

      </div>

      <div id="row-logo-search">
        <div id="header-left" class="col-sm-14 col-md-16 col-lg-19">
          <div class="row">
            <div class="hidden-xs">
              <a href="https://eclipse.org/"><img
                src="/eclipse.org-common/themes/solstice/public/images/logo/eclipse-800x188.png" alt="Eclipse.org logo"
                class="logo-eclipse-default img-responsive" /></a>
            </div>
            <div id="main-menu" class="navbar row yamm">
              <div id="navbar-collapse-1" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                  <li><a href="https://eclipse.org/users/" target="_self">Getting Started </a></li>
                  <li><a href="https://eclipse.org/membership/" target="_self">Members</a></li>
                  <li><a href="https://eclipse.org/projects/" target="_self">Projects</a></li>
                  <li class="dropdown visible-xs"><a href="#" data-toggle="dropdown" class="dropdown-toggle">Community <b
                      class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="https://marketplace.eclipse.org">Marketplace</a></li>
                      <li><a href="https://events.eclipse.org">Events</a></li>
                      <li><a href="//www.planeteclipse.org/">Planet Eclipse</a></li>
                      <li><a href="https://eclipse.org/community/eclipse_newsletter/">Newsletter</a></li>
                      <li><a href="https://www.youtube.com/user/EclipseFdn">Videos</a></li>
                    </ul></li>
                  <li class="dropdown visible-xs"><a href="#" data-toggle="dropdown" class="dropdown-toggle">Participate <b
                      class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="https://bugs.eclipse.org/bugs/">Report a Bug</a></li>
                      <li><a href="https://eclipse.org/forums/">Forums</a></li>
                      <li><a href="https://eclipse.org/mail/">Mailing Lists</a></li>
                      <li><a href="https://wiki.eclipse.org/">Wiki</a></li>
                      <li><a href="https://wiki.eclipse.org/IRC">IRC</a></li>
                      <li><a href="https://eclipse.org/contribute/">How to Contribute</a></li>
                    </ul></li>
                  <li class="dropdown visible-xs"><a href="#" data-toggle="dropdown" class="dropdown-toggle">Working Groups
                      <b class="caret"></b>
                  </a>
                    <ul class="dropdown-menu">
                      <li><a href="https://wiki.eclipse.org/Auto_IWG">Automotive</a></li>
                      <li><a href="https://iot.eclipse.org">Internet of Things</a></li>
                      <li><a href="https://locationtech.org">LocationTech</a></li>
                      <li><a href="https://lts.eclipse.org">Long-Term Support</a></li>
                      <li><a href="https://polarsys.org">PolarSys</a></li>
                      <li><a href="https://science.eclipse.org">Science</a></li>
                    </ul></li>
                  <!-- More -->
                  <li class="dropdown hidden-xs"><a data-toggle="dropdown" class="dropdown-toggle">More<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li>
                        <!-- Content container to add padding -->
                        <div class="yamm-content">
                          <div class="row">
                            <ul class="col-sm-8 list-unstyled">
                              <li><p>
                                  <strong>Community</strong>
                                </p></li>
                              <li><a href="https://marketplace.eclipse.org">Marketplace</a></li>
                              <li><a href="https://events.eclipse.org">Events</a></li>
                              <li><a href="//www.planeteclipse.org/">Planet Eclipse</a></li>
                              <li><a href="https://eclipse.org/community/eclipse_newsletter/">Newsletter</a></li>
                              <li><a href="https://www.youtube.com/user/EclipseFdn">Videos</a></li>
                            </ul>
                            <ul class="col-sm-8 list-unstyled">
                              <li><p>
                                  <strong>Participate</strong>
                                </p></li>
                              <li><a href="https://bugs.eclipse.org/bugs/">Report a Bug</a></li>
                              <li><a href="https://eclipse.org/forums/">Forums</a></li>
                              <li><a href="https://eclipse.org/mail/">Mailing Lists</a></li>
                              <li><a href="https://wiki.eclipse.org/">Wiki</a></li>
                              <li><a href="https://wiki.eclipse.org/IRC">IRC</a></li>
                              <li><a href="https://eclipse.org/contribute/">How to Contribute</a></li>
                            </ul>
                            <ul class="col-sm-8 list-unstyled">
                              <li><p>
                                  <strong>Working Groups</strong>
                                </p></li>
                              <li><a href="https://wiki.eclipse.org/Auto_IWG">Automotive</a></li>
                              <li><a href="https://iot.eclipse.org">Internet of Things</a></li>
                              <li><a href="https://locationtech.org">LocationTech</a></li>
                              <li><a href="https://lts.eclipse.org">Long-Term Support</a></li>
                              <li><a href="https://polarsys.org">PolarSys</a></li>
                              <li><a href="https://science.eclipse.org">Science</a></li>
                            </ul>
                          </div>
                        </div>
                      </li>
                    </ul></li>
                </ul>
              </div>
              <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                  <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                    class="icon-bar"></span> <span class="icon-bar"></span>
                </button>
                <a href="https://eclipse.org/" class="navbar-brand visible-xs"><img
                  src="/eclipse.org-common/themes/solstice/public/images/logo/eclipse-800x188.png" alt="Eclipse.org logo"
                  width="180" class="logo-eclipse-default" /></a>
              </div>
            </div>
          </div>
        </div>
        <div id="header-right" class="form-inline col-sm-10 col-md-8 col-lg-5 hidden-print hidden-xs">
          <div id="header-right-container">
            <div id="custom-search-form">
              <form action="//www.google.com/cse" id="form-eclipse-search" role="form" class="input-group">
                <input type="hidden" name="cx" value="017941334893793413703:sqfrdtd112s" /> <input id="search-box"
                  placeholder="Search eclipse.org" type="text" name="q" size="25" class="form-control" /> <span
                  class="input-group-btn">
                  <button class="btn btn-default" type="submit">
                    <i class="fa fa-search"></i>
                  </button>
                </span>
              </form>
            </div>
            <!-- /input-group -->
            <script type="text/javascript"
              src="//www.google.com/coop/cse/brand?form=searchbox_017941334893793413703%3Asqfrdtd112s&amp;lang=en"></script>
            <a id="btn-call-for-action" href="https://eclipse.org/downloads/" class="btn btn-huge btn-warning"><i
              class="fa fa-download"></i> Packages</a>
          </div>
        </div>

      </div>

    </div>
  </header>
  <section id="breadcrumb" class="defaut-breadcrumbs hidden-print">
    <div class="container">
      <ol class="breadcrumb">
        <li><a href="https://www.eclipse.org/">Home</a></li>
        <li><a href="https://www.eclipse.org/projects/">Projects</a></li>
        <li><a href="https://www.eclipse.org/orbit/">Orbit</a></li>
        <li><a href="https://download.eclipse.org/tools/orbit/downloads/">Orbit Downloads</a></li>
        <li class="active">$pageTitle</li>
      </ol>
    </div>
  </section>
  <main role="main">
  <div class="container background-image-none" id="novaContent">

HEADER


echo "<h1>Orbit Build: $buildlabel</h1>"

echo "<h2>Useful Information</h2>"
echo "<p>In addition to the bundles themselves, the following maps, project sets, and test results are useful for committers and consumers:</p>"
echo "<a href=\"$buildURL\">Maven Build Output</a><br />"
echo "<a href=\"reporeports/\">CBI Repository Analysis Reports</a><br />"

echo "<h2>Orbit Build Repository</h2>"
echo "<p>For HTTP access, a p2 repository for this specific build can be found by adding 'repository' to the end of this download site URL, namely:<br />"
echo "<a href=\"${repoPath}\">${repoPath}</a></p>"

echo "<h2>Zipped Orbit Build Repository</h2>"
echo "<p>The following zip file is a compressed-archive version of the above repository, for those that need or desire to have a copy of the whole repository on their local machine:<br />"
echo "<a href=\"{$downloadUrlPrefix}orbit-buildrepo-$buildlabel.zip\">orbit-buildrepo-$buildlabel.zip</a> (<a href=\"checksum/orbit-buildrepo-$buildlabel.zip.md5\">md5</a>) (<a href=\"checksum/orbit-buildrepo-$buildlabel.zip.sha1\">sha1</a>) $zipFileSize</p>"

echo "<h2>Individual Bundles</h2>"

echo "<h3>Statistics</h3>"
nDistinctBundles=$(xmllint --xpath "count(/repository/units/unit[provides/provided/@namespace='org.eclipse.equinox.p2.eclipse.type' and provides/provided/@name='bundle' and not(preceding::unit/@id=../../@id)]/@id)" $contentFile)
echo "<p>Number of distinct third party packages: $nDistinctBundles.<br />"
nBundles=$(xmllint --xpath "count(/repository/units/unit[provides/provided/@namespace='org.eclipse.equinox.p2.eclipse.type' and provides/provided/@name='bundle']/@id)" $contentFile)
echo "Number of bundles (including different versions): $nBundles. <br />"
nTotalBundles=$(xmllint --xpath "count(/repository/units/unit[provides/provided/@name='bundle' or provides/provided/@name='source']/@id)" $contentFile)
echo "Total number of bundles (including source): $nTotalBundles."

echo "<h3>CQ/IPZilla/IPLab/ClearlyDefined</h3>"
echo "<p>Historically Orbit maintained cross referencing of IP information. With innovations across the Eclipse Foundation the Orbit project no longer maintains this information going forward and instead relies on IP being processed the same way as for other projects by using <a href='https://github.com/eclipse/dash-licenses'>Dash License</a> and the related tools.</p>"

echo "<h3>Table of Bundles</h3>"
echo "<table class=\"table table-striped table-condensed\">"
echo "<tr>"
echo "<th align=\"left\">Bundle</th>"
echo "<th>Source</th>"
echo "<th>Version</th>"
echo "</tr>"

xsltproc -stringparam repoPath "$repoPath" ${DIR}/repo-index.xsl $contentFile

echo "</table>"

cat - <<FOOTER

</div>
</main>
<!-- /#main-content-container-row -->
<p id="back-to-top">
  <a class="visible-xs" href="#top">Back to the top</a>
</p>
<footer role="contentinfo">

  <div class="container">

    <div class="row">
      <section id="footer-eclipse-foundation" class="col-xs-offset-1 col-xs-11 col-sm-7 col-md-6 col-md-offset-0 hidden-print">
        <h2 class="section-title">Eclipse Foundation</h2>
        <ul class="nav">
          <li><a href="https://eclipse.org/org/">About us</a></li>
          <li><a href="https://eclipse.org/org/foundation/contact.php">Contact Us</a></li>
          <li><a href="https://eclipse.org/donate">Donate</a></li>
          <li><a href="https://eclipse.org/org/documents/">Governance</a></li>
          <li><a href="https://eclipse.org/artwork/">Logo and Artwork</a></li>
          <li><a href="https://eclipse.org/org/foundation/directors.php">Board of Directors</a></li>
        </ul>
      </section>
      <section id="footer-legal" class="col-xs-offset-1 col-xs-11 col-sm-7 col-md-6 col-md-offset-0 hidden-print ">
        <h2 class="section-title">Legal</h2>
        <ul class="nav">
          <li><a href="https://eclipse.org/legal/privacy.php">Privacy Policy</a></li>
          <li><a href="https://eclipse.org/legal/termsofuse.php">Terms of Use</a></li>
          <li><a href="https://eclipse.org/legal/copyright.php">Copyright Agent</a></li>
          <li><a href="https://eclipse.org/org/documents/epl-v10.php">Eclipse Public License </a></li>
          <li><a href="https://eclipse.org/legal/">Legal Resources </a></li>

        </ul>
      </section>

      <section id="footer-useful-links" class="col-xs-offset-1 col-xs-11 col-sm-7 col-md-6 col-md-offset-0 hidden-print">
        <h2 class="section-title">Useful Links</h2>
        <ul class="nav">
          <li><a href="https://bugs.eclipse.org/bugs/">Report a Bug</a></li>
          <li><a href="//help.eclipse.org/">Documentation</a></li>
          <li><a href="https://eclipse.org/contribute/">How to Contribute</a></li>
          <li><a href="https://eclipse.org/mail/">Mailing Lists</a></li>
          <li><a href="https://eclipse.org/forums/">Forums</a></li>
          <li><a href="//marketplace.eclipse.org">Marketplace</a></li>
        </ul>
      </section>

      <section id="footer-other" class="col-xs-offset-1 col-xs-11 col-sm-7 col-md-6 col-md-offset-0 hidden-print">

        <h2 class="section-title">Other</h2>
        <ul class="nav">
          <li><a href="https://eclipse.org/ide/">IDE and Tools</a></li>
          <li><a href="https://eclipse.org/projects">Community of Projects</a></li>
          <li><a href="https://eclipse.org/org/workinggroups/">Working Groups</a></li>
        </ul>

        <ul class="list-inline social-media">
          <li><a href="https://twitter.com/EclipseFdn"><i class="fa fa-twitter-square"></i></a></li>
          <li><a href="https://plus.google.com/+Eclipse"><i class="fa fa-google-plus-square"></i></a></li>
          <li><a href="https://www.facebook.com/eclipse.org"><i class="fa fa-facebook-square"></i> </a></li>
          <li><a href="https://www.youtube.com/user/EclipseFdn"><i class="fa fa-youtube-square"></i></a></li>
        </ul>

      </section>
      <div id="copyright" class="col-xs-offset-1 col-sm-14 col-md-24 col-md-offset-0">
        <div>
          <span class="hidden-print"><img
            src="/eclipse.org-common/themes/solstice/public/images/logo/eclipse-logo-bw-800x188.png"
            alt="Eclipse.org black and white logo" width="166" height="39" id="logo-eclipse-white" /></span>
          <p id="copyright-text">Copyright &copy; 2014 The Eclipse Foundation. All Rights Reserved.</p>
        </div>
      </div>
      <a href="#" class="scrollup">Back to the top</a>
    </div>
  </div>
</footer>

<!-- Placed at the end of the document so the pages load faster -->
<script src="/eclipse.org-common/themes/solstice/public/javascript/main.min.js"></script>
</body>
</html>
FOOTER
