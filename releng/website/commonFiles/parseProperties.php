<?php


  function parseProperties($filename)
  {
    $properties;
    $i = 0;
    $handle = fopen($filename, "r");
    if ($handle)
    {
      $size = filesize($filename);
      $content = fread($handle, $size);
      fclose($handle);

      $lineArray = explode("\n",$content);

      while(list(,$line) = each($lineArray)) {
      $line = trim($line);
      if (strlen($line) > 0) {
          //echo $line, "<br />";
          $propertyPair = explode("=", $line);
          $propertyPair[0] = trim($propertyPair[0], " \"\'");
          $propertyPair[1] = trim($propertyPair[1], " \"\'");

          $properties[$propertyPair[0]] = $propertyPair[1];
          $i++;
      }
      }
      }
    return $properties;
  }

?>
