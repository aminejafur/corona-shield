<?php
namespace Src\Gateways;

class CollisionGateway {

    private $db = null;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $statement = "
            SELECT 
                collisions.*, users.phone, users.cin FROM collisions 
            LEFT JOIN users 
                ON users.mac_adresse = collisions.mac_adresse
        ";

        try {
            $statement = $this->db->query($statement);
            $result = $statement->fetchAll(\PDO::FETCH_ASSOC);
            return $result;
        } catch (\PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function find($collisions_with)
    {
        $statement = "
        SELECT collisions.id, collisions.name, collisions.date, collisions.infected ,collisions.mac_adresse, users.cin , users.phone
            FROM collisions 
        LEFT JOIN users 
            ON users.mac_adresse = collisions.mac_adresse
            WHERE collisions.collision_with = ?
        ORDER BY collisions.mac_adresse
        ";

        try {
            $statement = $this->db->prepare($statement);
            $statement->execute(array($collisions_with));
            $result = $statement->fetchAll(\PDO::FETCH_ASSOC);
            return $result;
        } catch (\PDOException $e) {
            exit($e->getMessage());
        }    
    }

    public function insert(Array $input)
    {
        $statement = "
            INSERT INTO collisions 
                (name, date, mac_adresse, collision_with)
            VALUES
                (:name, :date, :mac_adresse, :collision_with);
        ";
        try {
            $statement = $this->db->prepare($statement);
            $statement->execute(array(
                'name' => $input['name'],
                'date'  => $input['date'],
                'mac_adresse' => $input['mac_adresse'],
                'collision_with' => $input['collision_with'],
            ));
            return $statement->rowCount();
        } catch (\PDOException $e) {
            exit($e->getMessage());
        }    
    }

}