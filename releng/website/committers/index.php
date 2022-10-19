<html>
<head>
<link rel="stylesheet" href="https://dev.eclipse.org/default_style.css">
<title>Eclipse Orbit Committers Downloads</title>

<style>
img.cs { /* character size image */
  border: 0;
  width: 1em;
  height: 1em;
  vertical-align: text-bottom;
  margin: 0 0.5em 0 0;
}
</style>
</head>
<body>

  <!-- heading start -->
<?php

// tiny banner to remind when looking at "local" machine results
$serverName = $_SERVER ["SERVER_NAME"];

if (! stristr ( $serverName, "eclipse.org" )) {
  echo '<center><p>Reminder: this is <font color="#FF0000">', $serverName, '</font>  See also <a href="https://download.eclipse.org/tools/orbit" target="_top">Live public eclipse orbit site</a>.</center><hr />';
}

if (function_exists ( "date_default_timezone_set" )) {
  date_default_timezone_set ( "UTC" );
  // echo "<p>default timezone: ";
  // echo date_default_timezone_get();
  // echo "</p>";
}

?>


<?php

// we will display errors, unless 0 used, which means "off"
// normally do not want to log or report _everything_ if in production
// mode
error_reporting ( 0 );

$DEBUG_MODE = false;
$QString = $_SERVER ['QUERY_STRING'];
$C = strcasecmp ( $QString, "test" );
if ($C == 0) {
  echo "page started with  'test'\n";
} else {
  $C = strcasecmp ( $QString, "debug" );
  if ($C == 0) {
    echo "<br /> This page was started in debug mode <br />";
    error_reporting ( E_ALL );
    global $DEBUG_MODE;
    $DEBUG_MODE = true;
  }
}
?>

<table border=0 cellpadding=2 width="100%">
    <tr>
      <td><font class=indextop>Orbit Committer Downloads</font> <br /> <font
        class=indexsub>Latest builds from the Orbit Project</font><br /></td>
      <td align="right"><img src="../commonFiles/coolGears.png" height=120
        width=120 /></td>
    </tr>
  </table>
  <!-- heading end -->

  <p>
    The Orbit "committer builds" have moved. Please use (and update your
    bookmarks) <a href="https://build.eclipse.org/orbit/committers">https://build.eclipse.org/orbit/committers</a>.
  </p>

  <p>
    As always, the "regular builds", for most users and consumers are
    available at <a
      href="https://download.eclipse.org/tools/orbit/downloads/">https://download.eclipse.org/tools/orbit/downloads/</a>.
  </p>

  <!-- footer -->
  <center>
    <hr />
    <p>
      All downloads are provided under the terms and conditions of the <a
        href="https://www.eclipse.org/legal/epl/notice.php">Eclipse.org
        Software User Agreement</a> unless otherwise specified.
    </p>

    <p>
      If you have problems downloading the drops, contact the <a
        href="mailto:webmaster@eclipse.org">webmaster</a>.
    </p>
  </center>
  <!-- end footer -->


</body>
</html>
<?php
if (isset ( $old_error_handler ) && sizeof ( $old_error_handler)) {
    set_error_handler($old_error_handler);
}
?>

