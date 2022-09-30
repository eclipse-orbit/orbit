<?php

$THISHOST = getenv("HOST");

echo "hostname: " . $THISHOST . "<br>\n";

echo "size: " . strlen($THISHOST) . "<br>\n";

echo "as hex: " . bin2hex($THISHOST) . "<br>\n";

$ISHOSTSET = isset($THISHOST);

echo "is set: " . $ISHOSTSET . "<br>\n";

if ($ISHOSTSET) {
    echo "HOST is set<br>\n";
} else {
    echo "HOST is not set<br>\n";
}

if (is_null ($THISHOST)) {
    echo "HOST is null<br>\n";
} else {
    echo "HOST is not null<br>\n";
}
if (" " === $THISHOST) {
    echo "HOST is blank<br>\n";
} else {
    echo "HOST is not blank<br>\n";
}

if ("" === $THISHOST) {
    echo "HOST is empty string<br>\n";
} else {
    echo "HOST is not empty string<br>\n";
}

if (empty($THISHOST)) {
    echo "HOST is empty<br>\n";
} else {
    echo "HOST is not empty<br>\n";
}


?>

