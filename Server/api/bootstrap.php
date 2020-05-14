<?php
require 'vendor/autoload.php';
use Dotenv\Dotenv;

use Src\Database\DatabaseConnection;

$dotenv = new DotEnv(__DIR__);
$dotenv->load();

$dbConnection = (new DatabaseConnection())->getConnection();