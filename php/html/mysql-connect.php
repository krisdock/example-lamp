<?php
try{
    $mysql_host = getenv('MYSQL_HOST');
    $dbh = new pdo( "mysql:host=$mysql_host:3306;dbname=sakila",
                    getenv('MYSQL_USER'),
                    getenv('MYSQL_PASSWORD'),
                    array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    die(json_encode(array('outcome' => true)));
}
catch(PDOException $ex){
    die(json_encode(array('outcome' => false, 'message' => "Unable to connect: $ex")));
}
?>
