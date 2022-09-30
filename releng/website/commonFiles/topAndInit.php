


<table border="0" width="100%">
	<tr>
		<td width="50%"><?php echo $indexTop; ?></td>
		<td width="50%" align="right"><a href="http://www.eclipse.org/orbit/">
				<img border="0" alt="Orbit unofficial download logo"
				src="../commonFiles/coolGears.png" height="120" width="120" />
		</a></td>
	</tr>
</table>

<!-- heading end -->


<hr />
<table border="0">
	<tr>
		<td><?php echo $pageExplanation; ?></td>
	</tr>
</table>


<?php

if (!isset($dlconfigfilename)) {
	$dlconfigfilename='dlconfig.txt';
}

$contents = substr(file_get_contents($dlconfigfilename),0,-1);
$contents = str_replace("\n", "", $contents);

#split the content file by & and fill the arrays
$elements = explode("&",$contents);
$t = 0;
$p = 0;
for ($c = 0; $c < count($elements); $c++) {
	$tString = "dropType";
	$pString = "dropPrefix";
	if (strstr($elements[$c],$tString)) {
		$temp = preg_split("/=/",$elements[$c]);
		$dropType[$t] = trim($temp[1]);
		$t++;
	}
	if (strstr($elements[$c],$pString)) {
		$temp = preg_split("/=/",$elements[$c]);
		$dropPrefix[$p] = trim($temp[1]);
		$p++;
	}
}

// debug
//echo "Debug: droptype count: ", count($dropType), "<br />";

for ($i = 0; $i < count($dropType); $i++) {
	$dt = $dropType[$i];
	$dt = trim($dt);
	$typeToPrefix[$dt] = $dropPrefix[$i];

	//echo "Debug prefix: ", $dropPrefix[$i], "<br />";
	//echo "Debug dropType: ", $dropType[$i], "<br />";

}


$latestTimeStamp=array();
$latestFile = array();
$buckets = array();
$timeStamps = array();

function computeBuildName($longname) {
	//echo "Debug: computeBuildName longname: ", $longname, "<br />";
	$majorParts = explode("/", $longname);
	//echo "Debug: computeBuildName majorParts: ", var_dump($majorParts), "<br />";
	return $majorParts[2];
}
function computeStreamName($longname) {
	$majorParts = explode("/", $longname);
	$nParts = sizeof($majorParts);
	if ($nParts > 1) {
		// a format such as "drops/R3.0"
		$name = $majorParts[1];

	}
	else {
		// a format with two parts: such as "orbit-I"
		$majorParts = explode("-", $longname);
		$name = $majorParts[0]."-".$majorParts[1];
	}
	return $name;
}


function printSectionSeparator ($prefix, $value) {
	//echo "Debug: printSectionSeparator: prefix: $prefix value: $value <br />";
	echo "<tr bgcolor=\"#999999\">\n";

	//echo"<td align=\"left\" colspan=\"11\">\n
	echo"<td align=\"left\" colspan=\"0\">\n
	            <a name=\"$prefix\">\n
	            <font color=\"#FFFFFF\" face=\"Arial,Helvetica\">\n";
	echo "$value";
	echo "</font></a></td>\n";
	 
	echo "</tr>";
}


?>
