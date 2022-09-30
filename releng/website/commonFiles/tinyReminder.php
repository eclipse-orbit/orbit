<?php

// tiny banner to remind when looking at "local" or "test" machine results
$serverName = $_SERVER["SERVER_NAME"];


if (!stristr($serverName, "download.eclipse.org")) {
    echo "<p style=\"text-align: center;\">Reminder: this is <code>$serverName</code>.  See also <a href=\"http://download.eclipse.org/tools/orbit\">Live public eclipse orbit site</a>.</p>";
}

