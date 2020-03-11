<?php

/**
 * Drush specific config.
 * Use this file to set up site aliases and specific config for different environments
 */

// Skip data from these tables when syncing or exporting the db:
$command_specific['sql-sync'] = array('structure-tables-list' => 'cache,cache_*,history,sessions,watchdog');
$command_specific['sql-dump'] = array('structure-tables-list' => 'cache,cache_*,history,sessions,watchdog');
