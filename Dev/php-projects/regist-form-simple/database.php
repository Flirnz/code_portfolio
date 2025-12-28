<?php
// ============================================
// FILE: database.php
// PURPOSE: Only connects to database
// ============================================

// 1. Database settings
$host = "localhost";      // Server name
$username = "root";       // MySQL username (XAMPP default)
$password = "";           // MySQL password (empty for XAMPP)
$database = "simple_site"; // Your database name

// 2. Create connection
$conn = mysqli_connect($host, $username, $password, $database);

// 3. Check connection
if (!$conn) {
    // If connection fails, try to create database
    die("Connection failed: " . mysqli_connect_error() .
        "<br><br>Try this: <br>
        1. Open phpMyAdmin (http://localhost/phpmyadmin)<br>
        2. Click 'New'<br>
        3. Database name: 'simple_site'<br>
        4. Click 'Create'");
}

// 4. Optional: Create table if doesn't exist
$table_sql = "CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";

if (!mysqli_query($conn, $table_sql)) {
    echo "Note: Table creation failed: " . mysqli_error($conn);
}

// 5. Connection is ready to use
//    $conn variable can be used in other files
?>