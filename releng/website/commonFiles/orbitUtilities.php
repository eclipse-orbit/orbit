<?php
$bundlesToUnzipList = array ();
function cleanup($string) {
  $result = str_replace ( "\n", "", $string );
  $result = str_replace ( "\r", "", $result );
  $result = trim ( $result );
  return $result;
}
class BundleToUnzip {
  public $id = "";
  public $version = "";
  function __construct($id, $version) {
    $this->id = trim ( $id );
    $this->version = trim ( $version );
  }
}
class Bundle {
  public $symbolicId = "";
  public $version = "";
  public $qualifier = "";
  public $fullfilename = "";
  public $pack = "";
  public $cq = "";
  public $name = "";
  public $email = "";
  public $note = "";
  public $sourceBundle;
  function __construct($aFullFileNameEntry, $logmissingipdata) {
    $START_GROUP = "(";
    $END_GROUP = ")";
    $UNDERSCORE = "_";
    $BACKSLASH = "\\";
    $LITERAL_PERIOD = "\\.";
    $ANYDIGITS = "\d*";
    $ANY = ".*";
    $ZERO_OR_ONE = "?";
    $PERL_DELIM = "/";

    $this->fullfilename = $aFullFileNameEntry;

    $pattern = $PERL_DELIM . $START_GROUP . $ANY . $END_GROUP . $UNDERSCORE . $START_GROUP . $ANYDIGITS . $LITERAL_PERIOD . $ANYDIGITS . $LITERAL_PERIOD . $ANYDIGITS . $END_GROUP . $LITERAL_PERIOD . $ZERO_OR_ONE . $START_GROUP . $ANY . $END_GROUP . $ZERO_OR_ONE . $LITERAL_PERIOD . $START_GROUP . "zip" . "|" . "jar" . $END_GROUP . $PERL_DELIM;

    // echo "";
    // echo "pattern: " . $pattern . "<br />";
    // echo "input: " . $this->fullfilename . "<br />";
    // echo "";
    $validMatch = preg_match ( $pattern, $aFullFileNameEntry, $matches );
    if ($validMatch) {
      // $item = 0;
      // foreach ($matches as $match) {
      // echo "match " . $item . ": " . $match . "<br />";
      // $item = $item + 1;
      // }
      $this->symbolicId = trim ( $matches [1] );
      $this->version = trim ( $matches [2] );
      if (array_key_exists ( 3, $matches )) {
        $this->qualifier = $matches [3];
      }
      $this->pack = checkPacked ( $this->symbolicId, $this->version );
    } else {
      $this->symbolicId = "Error: apparently not a valid bundle name/version: " . $this->fullfilename;
    }

    $xmldatafile = "ip_logs/" . $this->symbolicId . ".xml";
    // echo "filename: " . $xmldatafile . "<br />";
    if (file_exists ( $xmldatafile )) {
      // Load the XML source
      $xml = new DOMDocument ();
      $xml->load ( $xmldatafile );
      // find the version element

      $xpath = new DOMXPath ( $xml );
      $projectNodes = $xpath->query ( "//project[@version='$this->version']" );
      $nNodes = $projectNodes->length;
      if ($nNodes > 0) {
        $projectNode = $projectNodes->item ( 0 );
        $zElements = $projectNode->getElementsByTagName ( "ipzilla" );
        foreach ( $zElements as $zElement ) {
          $this->cq = $zElement->getAttribute ( "bug_id" );
        }

        $cElements = $projectNode->getElementsByTagName ( "contact" );
        foreach ( $cElements as $cElement ) {
          $nElement = $cElement->getElementsByTagName ( "name" );
          $this->name = $nElement->item ( 0 )->nodeValue;
          $this->name = cleanup ( $this->name );
          $mElement = $cElement->getElementsByTagName ( "email" );
          $this->email = $mElement->item ( 0 )->nodeValue;
          $this->email = cleanup ( $this->email );
          $this->email = str_replace ( "@", "*at*", $this->email );
        }

        // TODO: avoid the html markup <p> by using an array, or similar
        $notesElements = $projectNode->getElementsByTagName ( "notes" );
        foreach ( $notesElements as $notesElement ) {
          $noteElement = $notesElement->getElementsByTagName ( "note" );
          foreach ( $noteElement as $niElement ) {
            $notevalue = $niElement->nodeValue;
            $notevalue = cleanup ( $notevalue );
            if ($notevalue != "") {
              $this->note = $this->note . "<p>" . $notevalue . "</p>";
            }
          }
        }
      } else {
        $this->cq = "No project info for this version?";
        if ($logmissingipdata) {
          // source handled differently, elsewhere
          if (! endsWith ( $xmldatafile, "source.xml" )) {
            writeIPLogError ( $xmldatafile, $this->cq, $this->version );
          }
        }
      }
    } else {
      $this->cq = "No data file found";
      if ($logmissingipdata) {
        // source handled differently, elsewhere
        if (! endsWith ( $xmldatafile, "source.xml" )) {
          writeIPLogError ( $xmldatafile, $this->cq, null );
        }
      }
    }
  }
  function __toString() {
    return $this->symbolicId . " " . $this->version;
  }
}
function writeIPLogError($ipfilename, $errmessage, $expectedIPLogVersion) {
  // $ipoutfilename=$_SERVER['DOCUMENT_ROOT']."//iplogFileErrors.txt";
  // echo "docroot: " . $_SERVER['DOCUMENT_ROOT'] . "\n";
  // echo "dir: " . __DIR__ . "\n";
  // echo "file: " . __FILE__ . "\n";
  global $ipouterrors;
  // $ipoutfilename=__DIR__."/iplogFileErrors.txt";
  // $iphandle = fopen($ipoutfilename, "a+b");
  $writestring = "\nError in IP_log file:\n\t$ipfilename\n\t$errmessage\n";
  if ($expectedIPLogVersion != null) {
    $writestring = $writestring . "\tVersion expected in IP log xml file: $expectedIPLogVersion\n";
  }
  $ipouterrors [] = $writestring;
  // if (fwrite($iphandle, $writestring) === false) {
  // echo "Cannot write to $ipoutfilename. <br />";
  // }
  // fclose($iphandle);
}
function endsWith($str, $sub) {
  return (substr ( $str, strlen ( $str ) - strlen ( $sub ) ) === $sub);
}
function stripSuffix($str, $suffix) {
  $result = $str;
  if (endsWith ( $str, $suffix )) {
    $pos = strrpos ( $str, $suffix );
    $result = substr ( $str, 0, $pos );
  }
  return $result;
}
function getBundle($list, $id, $version) {
  foreach ( $list as $bundle ) {
    if ($bundle->symbolicId == $id && $bundle->version == $version) {
      return $bundle;
    }
  }
}
function countDistinct($list) {
  $idList = array ();
  foreach ( $list as $bundle ) {
    $idList [$bundle->symbolicId] = $bundle->symbolicId;
  }
  return count ( array_unique ( $idList ) );
}
function countDistinctCQs($list) {
  $idList = array ();
  foreach ( $list as $bundle ) {
    $idList [$bundle->cq] = $bundle->cq;
  }
  return count ( array_unique ( $idList ) );
}
function getListOfCQs($list) {
  $COMMA = "%2C";
  $idList = "";
  $moreThanOne = false;
  foreach ( $list as $bundle ) {
    if ($moreThanOne) {
      $idList = $idList . $COMMA . $bundle->cq;
    } else {
      $idList = $bundle->cq;
      $moreThanOne = true;
    }
  }
  return $idList;
}
function countTotal($list) {
  $result = 0;
  foreach ( $list as $bundle ) {
    // always one for bundle
    $result = $result + 1;
    if (isset ( $bundle->sourceBundle )) {
      // one for source, if provided
      $result = $result + 1;
    }
  }
  return $result;
}
function getBundleList($dir) {

  // init required data
  getBundlesToUnzip ();

  // prepare arrary of bundles to display
  $bundleList = array ();

  // pass 1
  $aDirectory = dir ( $dir );
  while ( $anEntry = $aDirectory->read () ) {

    // we are just looking for jar and zip files, no directories, and
    // just displaying the name
    if ($anEntry != "." && $anEntry != ".." && ((endsWith ( $anEntry, ".zip" ) || endsWith ( $anEntry, ".jar" )))) {

      // echo "anEntryName: " . $anEntry . "<br />";
      $aBundle = new Bundle ( $anEntry, true );
      // echo "";
      // echo "bundle: " . $aBundle . "<br />";
      // echo "id: " . $aBundle->symbolicId . "<br />";
      // echo "";

      if (endsWith ( $aBundle->symbolicId, ".source" )) {
        // add to matching bundle object
        // skip source this pass
      } else {
        $bundleList [$aBundle->fullfilename] = $aBundle;
      }
    }
  }
  $aDirectory->close ();

  // pass 2
  $aDirectory = dir ( $dir );
  // loop again to pick up source bundles
  while ( $anEntry = $aDirectory->read () ) {

    // we are just looking for jar and zip files, no directories, and
    // just displaying the name
    if ($anEntry != "." && $anEntry != ".." && ((endsWith ( $anEntry, ".zip" ) || endsWith ( $anEntry, ".jar" )))) {

      // echo "anEntryName: " . $anEntry . "<br />";
      $aBundle = new Bundle ( $anEntry, false );
      // echo "";
      // echo "bundle: " . $aBundle . "<br />";
      // echo "id: " . $aBundle->symbolicId . "<br />";
      // echo "";

      if (endsWith ( $aBundle->symbolicId, ".source" )) {
        // add to matching bundle object
        // this logic assumes source bundle is always found following
        // regular bundle
        // may need to make two passes?
        // also assumes there's just one id-version (i.e. not multiple
        // qualifiers).
        $correspondingID = stripSuffix ( $aBundle->symbolicId, ".source" );
        $correspondingBundle = getBundle ( $bundleList, $correspondingID, $aBundle->version );
        if (isset ( $correspondingBundle )) {
          $correspondingBundle->sourceBundle = $aBundle;
        } else {
          echo "Logic Error: PHP script found a source bundle, " . $aBundle->symbolicId . ", before the corresponding code bundle";
        }
      } else {
        // skip bundles this time, just getting source bundles
      }
    }
  }
  $aDirectory->close ();

  return $bundleList;
}
function getBuildBaseName($dropDirectory) {
  // for now, a simply heuristic to get build name ... same as
  // base directory name. It's done as a seperate function, though,
  // since
  // in future, may have to read a property file, or something.
  return basename ( $dropDirectory );
}
function fileSizeForDisplay($filename) {
  $onekilo = 1024;
  $onemeg = $onekilo * $onekilo;
  $criteria = 10 * $onemeg;
  $scaleChar = "M";
  if (file_exists ( $filename )) {
    $zipfilesize = filesize ( $filename );
    if ($zipfilesize > $criteria) {
      $zipfilesize = round ( $zipfilesize / $onemeg, 0 );
      $scaleChar = "M";
    } else {
      $zipfilesize = round ( $zipfilesize / $onekilo, 0 );
      $scaleChar = "K";
    }
  } else {
    $zipfilesize = 0;
  }
  $result = "(" . $zipfilesize . $scaleChar . ")";
  return $result;
}
function getBundlesToUnzip() {
  global $bundlesToUnzipList;
  $file_handle = fopen ( "bundlesToUnzip.properties", "r" );
  if ($file_handle !== false) {
    while ( ! feof ( $file_handle ) ) {
      $line = fgets ( $file_handle );
      if (! (strpos ( $line, "#" ) === 0)) {
        $dataline = explode ( ",", $line );
        $id = $dataline [0];
        // guard against blank or empty lines?
        // TODO: not sure how they get in there to begin with?
        if (! empty ( $id )) {
          $version = $dataline [1];
          $bundleToUnzip = new BundleToUnzip ( $id, $version );
          $bundlesToUnzipList [] = $bundleToUnzip;
        }
      }
    }
    fclose ( $file_handle );
  }
  return $bundlesToUnzipList;
}
function checkPacked($id, $version) {
  // echo "id: $id version: $version \n <br />";
  global $bundlesToUnzipList;
  $result = "";
  $arrayLength = sizeof ( $bundlesToUnzipList );
  for($i = 0; $i < $arrayLength; $i ++) {
    $bundleToUnzip = $bundlesToUnzipList [$i];
    // echo " compareBundleToUnzip: id: $bundleToUnzip->id version:
    // $bundleToUnzip->version \n <br />";

    if ($id == $bundleToUnzip->id && $version == $bundleToUnzip->version) {
      $result = " (unzip)";
      break;
    }
  }
  return $result;
}

?>
