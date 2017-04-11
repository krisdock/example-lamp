<?php
try{
    $dbh = new pdo( 'mysql:host=mysql.default.svc.cluster.local:3306;dbname=sakila',
                    'root',
                    'starbuck',
                    array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    die(json_encode(array('outcome' => true)));
}
catch(PDOException $ex){
    die(json_encode(array('outcome' => false, 'message' => 'Unable to connect')));
}
?>