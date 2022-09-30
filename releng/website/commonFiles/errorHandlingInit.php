<?php

// we will display errors, unless 0 used, which means "off"
// normally do not want to log or report _everything_ if in production mode
//error_reporting(0);
error_reporting ( E_ALL );

// user defined error handling function
function userErrorHandler($errno, $errmsg, $filename, $linenum, $vars) {
  // timestamp for the error entry
  $dt = gmdate ( "Y-m-d H:i:s (T) " );
  
  // define an assoc array of error string
  // in reality the only entries we should
  // consider are E_WARNING, E_NOTICE, E_USER_ERROR,
  // E_USER_WARNING and E_USER_NOTICE
  $errortype = array (
      E_ERROR => "Error",
      E_WARNING => "Warning",
      E_PARSE => "Parsing Error",
      E_NOTICE => "Notice",
      E_CORE_ERROR => "Core Error",
      E_CORE_WARNING => "Core Warning",
      E_COMPILE_ERROR => "Compile Error",
      E_COMPILE_WARNING => "Compile Warning",
      E_USER_ERROR => "User Error",
      E_USER_WARNING => "User Warning",
      E_USER_NOTICE => "User Notice" 
  );
  // set of errors for which a var trace will be saved
  $user_errors = array (
      E_USER_ERROR,
      E_USER_WARNING,
      E_USER_NOTICE 
  );
  
  $err = "<errorentry>\n";
  $err .= "\t<datetime>" . $dt . "</datetime>\n";
  $err .= "\t<errornum>" . $errno . "</errornum>\n";
  $err .= "\t<errortype>" . $errortype [$errno] . "</errortype>\n";
  $err .= "\t<errormsg>" . $errmsg . "</errormsg>\n";
  $err .= "\t<scriptname>" . $filename . "</scriptname>\n";
  $err .= "\t<scriptlinenum>" . $linenum . "</scriptlinenum>\n";
  
  if (in_array ( $errno, $user_errors )) {
    $err .= "\t<vartrace>" . wddx_serialize_value ( $vars, "Variables" ) . "</vartrace>\n";
  }
  $err .= "</errorentry>\n\n";
  
  // display to page
  echo "<br />Debug Error: $err <br />";
}

$old_error_handler = set_error_handler ( "userErrorHandler" );

$DEBUG_MODE = false;
$QString = $_SERVER ['QUERY_STRING'];
$C = strcasecmp ( $QString, "test" );
if ($C == 0) {
  // error_log("page started with 'test'\n", 3, $logging_file);
} else {
  
  $C = strcasecmp ( $QString, "debug" );
  if ($C == 0) {
    echo "<br /> This page was started in debug mode <br />";
    global $DEBUG_MODE;
    $DEBUG_MODE = true;
  }
}
?>
