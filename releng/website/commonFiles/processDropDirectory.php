<?php
$buildTypePart = substr ( $anEntryLine [2], 0, 1 ); // expect M, I, etc.
$buckets [$buildBranch] [$buildTypePart] [] = $aDropDirectoryName;

$timePart = substr ( $anEntryLine [2], 1 );
$year = substr ( $timePart, 0, 4 );
$month = substr ( $timePart, 4, 2 );
$day = substr ( $timePart, 6, 2 );
$hour = substr ( $timePart, 8, 2 );
$minute = substr ( $timePart, 10, 2 );

$newTimePart = "$year-$month-$day $hour:$minute UTC";

$timeStamp = strtotime ( $newTimePart );

$timeStamps [$buildBranch . "/" . $artifactTimeStamp . $anEntry] = gmdate ( "D, j M Y -- H:i  \(\U\T\C\)", $timeStamp );

if ((sizeof ( $latestTimeStamp [$buildBranch] ) > 0) && (isset ( $latestTimeStamp [$buildBranch] [$buildTypePart] ))) {
  if ($timeStamp > $latestTimeStamp [$buildBranch] [$buildTypePart]) {
    $latestTimeStamp [$buildBranch] [$buildTypePart] = $timeStamp;
    $latestFile [$buildBranch] [$buildTypePart] = $aDropDirectoryName;
  }
} else {
  $latestTimeStamp [$buildBranch] [$buildTypePart] = $timeStamp;
  $latestFile [$buildBranch] [$buildTypePart] = $aDropDirectoryName;
}
?>