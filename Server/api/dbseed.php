<?php
require 'bootstrap.php';
//run : phpdbseed.php
// infected : 0: infected, 1: infected, 2: recovred
$seed = <<<EOS
    CREATE TABLE IF NOT EXISTS users (
        id INT NOT NULL AUTO_INCREMENT,
        cin VARCHAR(100) NOT NULL,
        phone VARCHAR(100) NOT NULL,
        mac_adresse VARCHAR(100) NOT NULL,
        infected INT NOT NULL DEFAULT 0, 
        PRIMARY KEY (id)
    ) ENGINE=INNODB;

    CREATE TABLE IF NOT EXISTS collisions (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        date VARCHAR(100) NOT NULL,
        mac_adresse VARCHAR(100) NOT NULL,
        infected INT NOT NULL DEFAULT 0, 
        collision_with VARCHAR(100) NOT NULL,
        PRIMARY KEY (id)
    ) ENGINE=INNODB;

    INSERT INTO users
        (id, cin, phone, mac_adresse, infected)
    VALUES
        (1, 'BG156362', '0612654589', '85:84:96:20:66', 0),
        (2, 'BJ654562', '0674565589', '05:84:56:20:34', 0),
        (3, 'VJ578962', '0755464659', '85:44:96:20:96', 2),
        (4, 'KJ654562', '0574864415', '11:84:96:20:17', 1),
        (5, 'BJ968962', '0596321646', 'F5:84:96:20:85', 0),
        (6, 'YJ654862', '0764364316', '85:84:96:20:23', 1),
        (7, 'AJ138962', '0394659631', 'Y5:84:96:20:66', 2),
        (8, 'BH754962', '0645976464', 'G5:84:96:20:66', 0),
        (9, 'AC189328', '0645976464', '85:84:96:03:66', 1),
        (10, 'HZ043160', '0645976464', 'ES:84:96:2N:XD', 2),
        (11, 'JK348512', '0596734616', 'B5:84:96:20:51', 1);

        INSERT INTO collisions
        (id, name, date, mac_adresse, infected, collision_with)
    VALUES
        (1, 'My-Phone', '2020-05-12 19:26', 'Q5:84:96:20:66', 0, '85:84:96:20:23'),
        (2, 'Samsung Galaxy S7', '2020-05-12 19:26', '85:84:96:20:WX', 0, '85:84:96:20:23'),
        (3, 'Amine', '2020-05-12 19:26', 'CV:84:96:01:LM', 2, '85:84:96:20:23'),
        (4, 'Jhon Phone', '2020-05-12 19:26', '85:84:96:03:ES', 1, '85:84:96:20:23'),
        (5, 'CJ968962', '2020-05-12 19:26', 'FD:84:96:20:YR', 0, 'B5:84:96:20:51'),
        (6, 'I PHONE X', '2020-05-12 19:26', '85:47:96:04:JH', 1, 'B5:84:96:20:51'),
        (7, 'Jhon doe', '2020-05-12 19:26', 'YU:84:96:20:66', 2, '11:84:96:20:17'),
        (8, 'My-Phone 3', '2020-05-12 19:26', '85:84:96:03:66', 0, '05:84:56:20:34'),
        (9, 'Jhon phone', '2020-05-12 19:26', 'ES:84:96:2N:XD', 1, '05:84:56:20:34');
EOS;

try {
    echo "*** Starting Seed! ***\n";
    $createTable = $dbConnection->exec($seed);
    echo "*** Seeded! ***\n";
} catch (\PDOException $e) {
    exit($e->getMessage());
}
?>