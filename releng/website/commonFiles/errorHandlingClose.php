<?php
if (isset($old_error_handler) && sizeof($old_error_handler)) {
    set_error_handler($old_error_handler);
}
