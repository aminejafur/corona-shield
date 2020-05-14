<?php
require "../bootstrap.php";
use Src\Controller\UserController;
use Src\Controller\CollisionController;

// Headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// all records
// GET /{'users','collisions'}

// return a specific user or collisions
// GET /{'users','collisions'}/{id,CIN}

// create record
// POST /{'users','collisions'}

// update record
// PUT /users/{id}

// delete record
// DELETE /users/{id}

// Parse URL
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = explode( '/', $uri );

// check if the first param is users or collisions
$array = ['users','collisions'];

if (!in_array($uri[1], $array)) {
    header("HTTP/1.1 404 Not Found");
    $not_found = array('error' => 400, );
    echo json_encode($not_found);
    exit();
}

// return either user id or cin
$findBy = null;
if (isset($uri[2])) {
    $findBy = ($uri[1] == $array[0]) ? (int) $uri[2] : (string)$uri[2];
}

//get request methode [GET,PUT,POST,DELETE]
$requestMethod = $_SERVER["REQUEST_METHOD"];

// pass the request method + user ID or CIN CollisionS to the Controllers 
if($uri[1] == $array[0]){
    $controller = new UserController($dbConnection, $requestMethod, $findBy);
}else{
    $controller = new CollisionController($dbConnection, $requestMethod, $findBy);
}
// Execute HTTP request
$controller->processRequest();