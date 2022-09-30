<?php
$debugRecentHistory = false;
$sectionHeaderPrinted = array ();

foreach ( $dropType as $value ) {
  $prefix = $typeToPrefix [$value];
  
  if ($debugRecentHistory) {
    echo "dropType value: $value <br />";
    echo "prefix: $prefix <br />";
  }
  
  echo "<table width=\"100%\" cellpadding=2>\n";
  
  foreach ( $buildBranches as $bValue ) {
    if ($debugRecentHistory) {
      echo "loop through each buildBranch: $bValue <br />";
      echo "isset(\$buckets): " . isset ( $buckets ) . "<br />";
    }
    if (isset ( $buckets ) && array_key_exists ( $bValue, $buckets ) && array_key_exists ( $prefix, $buckets [$bValue] )) {
      
      // if we have already printed the section heading, so not do so
      // again
      // Note, we have this convoluted logic, since we don't have a
      // clear heirarchy .... we could have an "R build" in "orbit-I"
      // branch, for example, due to renaming it
      
      if (! array_key_exists ( $prefix, $sectionHeaderPrinted )) {
        printSectionSeparator ( $prefix, $value );
        // we could set to anything ... we only check if it has been
        // set.
        $sectionHeaderPrinted [$prefix] = true;
      }
      
      if ($debugRecentHistory) {
        echo "in loop<br />";
      }
      
      if (array_key_exists ( $bValue, $buckets ) && array_key_exists ( $prefix, $buckets [$bValue] )) {
        $aBranchBucket = $buckets [$bValue] [$prefix];
      }
      if (isset ( $aBranchBucket )) {
        rsort ( $aBranchBucket );
        if ($debugRecentHistory) {
          echo "buckets in this branch: <br />";
          foreach ( $aBranchBucket as $tempBucket ) {
            echo "$tempBucket <br />";
          }
        }
        
        foreach ( $aBranchBucket as $innerValue ) {
          
          $buildName = computeBuildName ( $innerValue );
          $streamName = computeStreamName ( $bValue );
          
          echo "<tr>";
          echo "<td class=\"name\">";
          
          // the buildFailedEarly.txt file is an intentional indicator
          // file that
          // says the build failed early, in some fairly "bad" way so
          // repos, zips, tests etc.,
          // could not be created. Some excerpt of log file is
          // containted there, so sometimes
          // reading that file alone is enough to know what the problem
          // is ... but other times,
          // whole log may need to be examined.
          
          if (file_exists ( "$innerValue/buildFailedEarly.txt" )) {
            echo "<a href=\"$innerValue/buildFailedEarly.txt\"><img class=\"cs\" alt=\"Build Failed\" src=\"".$relativePath."/commonFiles/Fail.gif\" /></a>";
          } else {
            
            // the testsFailed.txt file is an intentional indicator
            // (only) file
            // echo "Debug: check for testsFailed.txt: ",
            // "$innerValue/testsFailed.txt", "<br />";
            if ((file_exists ( "$innerValue/testsFailed.txt" )) || (file_exists ( "$innerValue/testsFailedIPLog.txt" ))) {
              echo "<a href=\"$innerValue/results-$buildName.xml\"><img class=\"cs\" alt=\"Tests Failed\" src=\"".$relativePath."/commonFiles/Fail.gif\" /></a>";
            } elseif (file_exists ( "$innerValue/testsOk.txt" )) {
              echo "<a href=\"$innerValue/results-$buildName.xml\"><img class=\"cs\" alt=\"Tests Passed\" src=\"".$relativePath."/commonFiles/Checkmark.gif\" /></a>";
            } else {
              echo "<img class=\"cs\" alt=\"Status unknown (not good)\" src=\"".$relativePath."/commonFiles/Questionmark.gif\" />";
            }
          }
          echo "<a href=\"$innerValue/\">$buildName</a></td>";
          echo "<td width=\"10%\">$streamName</td>";
          echo "<td class=\"date\">$timeStamps[$innerValue]</td>";
          echo "<td>&nbsp;</td>";
          echo "</tr>";
        }
      }
    }
  }
  echo "</table>";
}
?>


