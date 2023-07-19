<?php

$relativePath="..";
//echo "relativePath: $relativePath<br />\n";
$dropPrefix = array();
$dropPrefix[]="R";
$dropPrefix[]="S";
$dropPrefix[]="N";
$dropPrefix[]="M";

$dropType = array();
$dropType[]="<b>R</b>ecommended: Long term, persisted repositories.";
$dropType[]="<b>S</b>table: To be used for Milestone builds";
$dropType[]="<b>N</b>ightly: Consume by aggregator to produce simrel-orbit nightly build";
$dropType[]="<b>M</b>aintenance: Work towards Oxygen.3a";

// the "prefix" array and dropType array must be of same size, defined in right order
//echo "Debug: droptype count: ", count($dropType), "<br />";
for ($i = 0; $i < count($dropType); $i++) {
  $typeToPrefix[$dropType[$i]] = $dropPrefix[$i];
  //echo "Debug prefix: ", $dropPrefix[$i], "<br />";
  //echo "Debug dropType: ", $dropType[$i], "<br />";
}
