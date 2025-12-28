<?php
// config/Database.php
class Database {
    private $host = "localhost";
    private $db_name = "your_database";
    private $username = "root";
    private $password = "";
    private $conn;

    // Singleton pattern - only one connection
    private static $instance = null;

    // Private constructor to prevent direct creation
    private function __construct() {
        try {
            $this->conn = new mysqli(
                $this->host,
                $this->username,
                $this->password,
                $this->db_name
            );

            if($this->conn->connect_error) {
                throw new Exception("Connection failed: " . $this->conn->connect_error);
            }

            $this->conn->set_charset("utf8mb4");
        } catch(Exception $e) {
            die("Database error: " . $e->getMessage());
        }
    }

    // Get the single instance
    public static function getInstance() {
        if(self::$instance === null) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    // Get the connection
    public function getConnection() {
        return $this->conn;
    }

    // Prevent cloning
    private function __clone() {}

    // Prevent unserialization
    public function __wakeup() {}

    // Close connection
    public function __destruct() {
        if($this->conn) {
            $this->conn->close();
        }
    }
}
?>