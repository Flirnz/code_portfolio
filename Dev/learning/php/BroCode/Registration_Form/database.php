<?php
    $db_server = "localhost";
    $dv_username = "root";
    $db_pass = "";
    $db_name = "businessdb";
    $conn ="";
    try{
        $conn = mysqli_connect($db_server,$dv_username,$db_pass,$db_name);

    }
    catch(mysqli_sql_exception){
        echo "could not connect<br>";
    }
    if($conn){
        echo "connected<br>";
    }

?>