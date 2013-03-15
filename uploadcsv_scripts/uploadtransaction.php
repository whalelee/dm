<?php

include_once 'constants.php';

$fin = fopen('C:/IS202/Data/ride.csv','r') or die('cant open file');
try {
    $link = new PDO("mysql:dbname=$database;host=127.0.0.1", $user, $password);
    echo 'Connection succeeded <br />' . PHP_EOL;
    
    $stmt = $link->prepare('INSERT INTO `transaction` (`Service_No`, `Card_ID`, `Serial_No`, `Start_Stop_No`, `End_Stop_No`, `Tap_In_Time`, `Tap_Out_Time`) values (:Service_No, :Card_ID, :Serial_No, :Start_Stop_No, :End_Stop_No, :Tap_In_Time, :Tap_Out_Time); ' );
    //Only give the length parameter if you **KNOW** that no line will be longer than that
    while (($data=fgetcsv($fin,1000,","))!==FALSE) {
        if ($data[0] !== 'CardID') {
            $Card_ID = $data[0];
            $Start_Stop_No = $data[1];
            $End_Stop_No = $data[2];
            $Tap_In_Time = $data[3];
            $Tap_Out_Time = $data[4];
            $Service_No = $data[5];
            $Serial_No = $data[6];
            if ($stmt->execute(array(':Serial_No' => $Serial_No, 
                ':Service_No' => $Service_No,
                ':Card_ID' => $Card_ID,
                ':Start_Stop_No' => $Start_Stop_No,
                ':End_Stop_No' => $End_Stop_No,
                ':Tap_In_Time' => $Tap_In_Time,
                ':Tap_Out_Time' => $Tap_Out_Time
                ))) {
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
