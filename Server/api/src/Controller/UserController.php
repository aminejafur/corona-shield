<?php
namespace Src\Controller;

use Src\Gateways\UserGateway;

class UserController {

    private $db;
    private $requestMethod;
    private $userId;

    private $usersGateway;

    public function __construct($db, $requestMethod, $userId)
    {
        $this->db = $db;
        $this->requestMethod = $requestMethod;
        $this->userId = $userId;

        $this->usersGateway = new UserGateway($db);
    }

    public function processRequest()
    {
        switch ($this->requestMethod) {
            case 'GET':
                if ($this->userId) {
                    $response = $this->getUser($this->userId);
                } else {
                    $response = $this->getAllUsers();
                };
                break;
            case 'POST':
                $response = $this->createUserFromRequest();
                break;
            case 'PUT':
                $response = $this->updateUserFromRequest($this->userId);
                break;
            case 'DELETE':
                $response = $this->deleteUser($this->userId);
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

    private function getAllUsers()
    {
        $result = $this->usersGateway->findAll();
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode($result);
        return $response;
    }

    private function getUser($id)
    {
        $result = $this->usersGateway->find($id);
        if (! $result) {
            return $this->notFoundResponse();
        }
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode($result);
        return $response;
    }

    private function createUserFromRequest()
    {
        // having issue with php://input
        // $input = (array) json_decode(file_get_contents('php://input'), TRUE);
        parse_str((string)filter_input(INPUT_SERVER, 'QUERY_STRING'), $input);
        if (! $this->validateusers($input)) {
            return $this->unprocessableEntityResponse();
        }
        $this->usersGateway->insert($input);
        $response['status_code_header'] = 'HTTP/1.1 201 Created';
        $response['body'] = json_encode([
            'msg' => 'ok'
        ]);
        return $response;
    }

    private function updateUserFromRequest($id)
    {
        $result = $this->usersGateway->find($id);
        if (! $result) {
            return $this->notFoundResponse();
        }
        $input = (array) json_decode(file_get_contents('php://input'), TRUE);
        if (! $this->validateusers($input)) {
            return $this->unprocessableEntityResponse();
        }
        $this->usersGateway->update($id, $input);
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode([
            'msg' => 'ok'
        ]);
        return $response;
    }

    private function deleteUser($id)
    {
        $result = $this->usersGateway->find($id);
        if (! $result) {
            return $this->notFoundResponse();
        }
        $this->usersGateway->delete($id);
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = null;
        return $response;
    }

    private function validateusers($input)
    {
        if (! isset($input['cin'])) {
            return false;
        }
        if (! isset($input['phone'])) {
            return false;
        }
        if (! isset($input['mac_adresse'])) {
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