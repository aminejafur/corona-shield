<?php
namespace Src\Controller;

use Src\Gateways\CollisionGateway;

class CollisionController {

    private $db;
    private $requestMethod;
    private $CollisionCIN;

    private $CollisionGateway;

    public function __construct($db, $requestMethod, $CollisionCIN)
    {
        $this->db = $db;
        $this->requestMethod = $requestMethod;
        $this->CollisionCIN = $CollisionCIN;

        $this->CollisionGateway = new CollisionGateway($db);
    }

    public function processRequest()
    {
        switch ($this->requestMethod) {
            case 'GET':
                if ($this->CollisionCIN) {
                    $response = $this->getCollision($this->CollisionCIN);
                } else {
                    $response = $this->getAllCollision();
                };
                break;
            case 'POST':
                $response = $this->createCollisionFromRequest();
                break;
            default:
                $response = $this->notFoundResponse();
                break;
        }
        header($response['status_code_header']);
        if ($response['body']) {
            echo $response['body'];
        }
    }

    private function getAllCollision()
    {
        $result = $this->CollisionGateway->findAll();
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode($result);
        return $response;
    }

    private function getCollision($collisions_with)
    {
        $result = $this->CollisionGateway->find($collisions_with);
        if (! $result) {
            return $this->notFoundResponse();
        }
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode($result);
        return $response;
    }

    private function createCollisionFromRequest()
    {
        // having issue with php://input
        // $input = (array) json_decode(file_get_contents('php://input'), TRUE);
        parse_str((string)filter_input(INPUT_SERVER, 'QUERY_STRING'), $input);
        if (! $this->validateCollision($input)) {
            return $this->unprocessableEntityResponse();
        }
        $this->CollisionGateway->insert($input);
        $response['status_code_header'] = 'HTTP/1.1 201 Created';
        $response['body'] = json_encode([
            'msg' => 'ok'
        ]);
        return $response;
    }

    private function validateCollision($input)
    {
        if (! isset($input['name'])) {
            return false;
        }
        if (! isset($input['date'])) {
            return false;
        }
        if (! isset($input['mac_adresse'])) {
            return false;
        }
        if (! isset($input['collision_with'])) {
            return false;
        }
        return true;
    }

    private function unprocessableEntityResponse()
    {
        $response['status_code_header'] = 'HTTP/1.1 422 Unprocessable Entity';
        $response['body'] = json_encode([
            'error' => 'Invalid input'
        ]);
        return $response;
    }

    private function notFoundResponse()
    {
        $response['status_code_header'] = 'HTTP/1.1 404 Not Found';
        $not_found = array('error' => 400, );
        $response['body'] = json_encode($not_found);
        return $response;
    }
}