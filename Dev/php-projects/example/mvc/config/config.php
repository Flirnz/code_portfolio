<?php
// Halaman ini sengaja dikosongkan.
// TANTANGAN: Buat koneksi database pake PDO di sini nanti!
function getDB(){
    $host = 'localhost';
    $db = 'contoh';
    $password = '';
    $user = 'root';
    $dsn = "mysql:host=$host;dbname=$db;charset=utf8";

    $con = new PDO($dsn,$user,$password);

    return $con;


}


?>