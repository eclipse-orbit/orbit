<?
function displayBuildMachine() {
  include 'parseProperties.php';
  $properties = parseProperties ( "buildmachineinfo.properties" );
  $constString = "This build brought to you by ";
  $varString = "";
  $buildComputerPropValue = $properties ["buildComputer"];
  
  if (strcmp ( $buildComputerPropValue, "build" ) == 0) {
    $varString = "a server donated from lomboz.org";
  } else {
    if (strcmp ( $buildComputerPropValue, "utils" ) == 0) {
      $varString = "a server donated from eclipse.org";
    } else {
      $varString = " a non-standard build server: " . $buildComputerPropValue;
    }
  }
  $result = $constString . $varString;
  return $result;
}

?>
