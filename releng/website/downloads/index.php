<?php
$pageTitle="Orbit Downloads";
include 'dlconfig.php';
include 'notes.php';
include $relativePath . '/commonFiles/DL.header.php.html';
include $relativePath . '/commonFiles/tinyReminder.php';
include $relativePath . '/commonFiles/setDateToUTC.php';
include $relativePath . '/commonFiles/errorHandlingInit.php';
 
?>

<h1><?php echo "$pageTitle" ?>
<a href="https://projects.eclipse.org/projects/tools.orbit"><img src="../commonFiles/coolGears.png" alt="Orbit Gears" style="backgroundColor: #FFFFFF; float: right; width: 120px; height: 120px; margin-left: 10px;margin-bottom: 10x; margin-right: 0px; margin-top: 0px;" /></a>
</h1>

<p>This is the starting page for where you can find the current builds provided by the
<a href="https://projects.eclipse.org/projects/tools.orbit">Eclipse Orbit Project</a>.
See our <a href="https://wiki.eclipse.org/Promotion%2C_Release%2C_and_Retention_Policies">Retention Policies</a> for the meaning
of the different types of builds (I, S, M, R). <a href="https://archive.eclipse.org/tools/orbit/downloads/">Archived Builds</a> are provided
for previous R-Builds that are no longer in demand, but which we keep on a non-mirrored site, for long term support, historical or academic use.
As a reminder to committers, see <a href="https://ci.eclipse.org/orbit/">
the "continuous builds" on the build machine</a> to check recent additions for accuracy before they are promoted here to downloads.
</p>

<p>In addition to the static release repositories referenced in the 'Notes' section, there are 'latest-X' repositories provided for convenience where consumers may wish to use a particular build type.
<a href="latest-I">latest-I</a>, 
<a href="latest-S">latest-S</a>, and
<a href="latest-R">latest-R</a>
are available.
</p>

<?php
$latestTimeStamp=array();
$latestFile = array();
if (file_exists("drops")) {
  $aDirectory = dir("drops");
  $latestTimeStamp[0] = array();
  $latestFile[0] = array();

  // debug
  //echo "current directory: " . realpath("./") . "<br />\n";
  //echo "full directory: " . realpath("./drops") . "<br />\n";
  //echo "full directory from one: " . realpath("drops") . "<br />\n";
  //echo "aDirectory: " . $aDirectory->path . "<br />\n";

  while (false !== ($anEntry = $aDirectory->read())) {
    //echo "<br />Debug anEntry: " . $anEntry . "<br />" ;
    // Short cut because we know aDirectory only contains other directories.
    if ($anEntry != "." && $anEntry!=".." ) {
      //echo "Debug anEntry: " . $anEntry . "<br />" ;
      $aDropDirectoryName = "drops/".$anEntry;
      //echo "Debug full anEntry: " . $aDropDirectoryName . "<br />" ;
      if (is_dir($aDropDirectoryName) && is_Readable($aDropDirectoryName)) {
        $aDropDirectory = dir($aDropDirectoryName);
        //echo "Debug aDropDirectory: $aDropDirectory->path <br />" ;
        $fileCount = 0;
        while ($aDropEntry = $aDropDirectory->read()) {
          //echo "Debug aDropEntry: $aDropEntry<br />" ;
          if ( (stristr($aDropEntry, ".tar.gz")) || (stristr($aDropEntry, ".zip")) ) {
            // Count the dropfile entry in the directory (so we won't display links, if not all there
            $fileCount = $fileCount + 1;
          }
        }
        $aDropDirectory->close();
      }
      // Read the count file
      $countFile = "drops/$anEntry/files.count";
      $indexFile = "drops/$anEntry/index.html";
      if (!file_exists($indexFile)) {
        $indexFile = "drops/$anEntry/index.php";
      }
      if (file_exists($countFile) && file_exists($indexFile)) {
        $anArray = file($countFile);
        // debug
        //echo "Number according to files.count: ", $anArray[0];
        //echo "   actual counted files: ", $fileCount;
        // If a match - process the directoryVV
        if ($anArray[0] == $fileCount) {
          // debug
          //echo "yes, counted equaled expected count<br />\n";
          // debug
          //   echo "anEntry: $anEntry<br />\n";
          $buildTypePart = substr($anEntry, 0, 1);
          // debug
          //   echo "buildTypePart: $buildTypePart<br />\n";
          $buckets[0][$buildTypePart][] = $anEntry;
          $timePart = substr($anEntry,1);
          // debug
          //   echo "timePart: $timePart<br />\n";
          $year = substr($timePart, 0, 4);
          $month = substr($timePart, 4, 2);
          $day = substr($timePart, 6, 2);
          $hour = substr($timePart,8,2);
          $minute = substr($timePart,10,2);
          $newTimePart = "$year-$month-$day $hour:$minute UTC";
          $timeStamp = strtotime($newTimePart);
          $timeStamps[$anEntry] = gmdate("D, j M Y -- H:i  \(\U\T\C\)", $timeStamp);
        }
      }
    }
  }
  $aDirectory->close();
}
?>

<?php

echo "<table class=\"downloads\">\n";
$bValue = 0;

foreach($dropType as $value) {
  $prefix=$typeToPrefix[$value];
  if (isset($buckets) && array_key_exists($bValue, $buckets) && $buckets[$bValue] != NULL && array_key_exists($prefix, $buckets[$bValue])) {
    if ($DEBUG_MODE){
      echo "<br />bValue: $bValue<br />\n";
      echo "prefix: $prefix<br />\n";
      echo "value: $value<br />\n";
      echo "dropType: $dropType<br />\n";
      echo "bucket: $buckets[$bValue][$prefix]<br/>\n";
    }
    $aBucket = $buckets[$bValue][$prefix];
    if (isset($aBucket)) {

      // name attribute can have no spaces, so we tranlate them to 
      // underscores (could effect targeted links)
      $valueName=strtr($value,' ','_');
      $valueName=strtr($valueName,'<b>','');
      $valueName=strtr($valueName,'</b>','');
      echo "  <tr id=\"$valueName\" >\n";
      echo "    <td class=\"main\" colspan=\"3\">$value</td>\n";
      echo "  </tr>\n";

      echo "<tr>\n";
      echo "  <th class=\"name\">Build Name</th>\n";
      echo "  <th class=\"date\">Build Date</th>\n";
      echo "  <th class=\"name\">Notes</th>\n";
      echo "</tr>\n";

      rsort($aBucket);
      $i = 0;
      $ts = array();
      $ts2iv = array();
      foreach($aBucket as $iv) {
        $ivTimePart = substr($iv, 1);
        $ts[$i] = $ivTimePart;
        $ts2iv[$ts[$i]] = $iv;
        $i++;
      }
      rsort($ts);
      $i = 0;
      $aBucket = array();
      foreach($ts as $tsvalue) {
        $aBucket[$i] = $ts2iv[$tsvalue];
        $i++;
      }
      foreach($aBucket as $innerValue) {
        echo "<tr>\n";
        echo "  <td class=\"name\"><a href=\"drops/$innerValue/\">$innerValue</a></td>\n";
        echo "  <td class=\"date\">$timeStamps[$innerValue]</td>\n";
        if (isset($notes[$innerValue])) {
          echo "  <td class=\"name\">$notes[$innerValue]</td>\n";
        }
        else {
          echo "  <td class=\"name\">&nbsp;</td>\n";
        }
        echo "</tr>\n";
      }
    }
  }
}
echo "</table>\n";


include "$relativePath/commonFiles/errorHandlingClose.php";
include "$relativePath/commonFiles/DL.footer.php.html";
?>
