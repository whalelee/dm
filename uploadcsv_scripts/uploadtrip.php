<?php

include_once 'constants.php';

$fin = fopen('C:/IS202/Data/trip.csv','r') or die('cant open file');
try {
    $link = new PDO("mysql:dbname=$database;host=127.0.0.1", $user, $password);
    echo 'Connection succeeded <br />' . PHP_EOL;
    
    $stmt = $link->prepare('INSERT INTO `trip` (`Service_No`, `Serial_No`, `Trip_SDT`, `Duration`, `Plate_No`, `Staff_ID`) values (:Service_No, :Serial_No, :Trip_SDT, :Duration, :Plate_No, :Staff_ID); ' );
    //Only give the length parameter if you **KNOW** that no line will be longer than that
    while (($data=fgetcsv($fin,1000,","))!==FALSE) {
        if ($data[0] !== 'ServiceNumber') {
            $Service_No = $data[0];
            $Serial_No = $data[1];
            $Trip_SDT = $data[2];
            $Duration = empty($data[3]) ? NULL : $data[3];
            $Plate_No = empty($data[4]) ? NULL : $data[4];
            $Staff_ID = empty($data[5]) ? NULL : $data[5];
            if ($stmt->execute(array(':Serial_No' => $Serial_No, 
                ':Service_No' => $Service_No,
                ':Trip_SDT' => $Trip_SDT,
                ':Duration' => $Duration,
                ':Plate_No' => $Plate_No,
                ':Staff_ID' => $Staff_ID))) {
                echo 'Record inserted <br />' . PHP_EOL;
            } else {
                $err = $stmt->errorInfo();
                echo 'Insert Failed: ' . $err[2] . PHP_EOL;
            }
        }
    }
    
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}
fclose($fin);
