<?php
// models/User.php
require_once __DIR__ . '/../config/Database.php';

class User {
    private $id;
    private $username;
    private $password;
    private $created_at;

    // Database connection
    private $conn;
    private $table = 'users';

    public function __construct() {
        $database = Database::getInstance();
        $this->conn = $database->getConnection();
    }

    // Getters and Setters (Encapsulation)
    public function getId() {
        return $this->id;
    }

    public function getUsername() {
        return $this->username;
    }

    public function setUsername($username) {
        $this->username = $this->sanitize($username);
        return $this; // Allows method chaining
    }

    public function setPassword($password) {
        $this->password = $this->hashPassword($password);
        return $this;
    }

    // Create new user (Registration)
    public function register() {
        // Validate
        if(!$this->validate()) {
            throw new Exception("Invalid user data");
        }

        // Check if username exists
        if($this->usernameExists()) {
            throw new Exception("Username already taken");
        }

        // Prepare SQL with prepared statement (SECURE!)
        $sql = "INSERT INTO " . $this->table . " (user, password) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            throw new Exception("SQL preparation failed: " . $this->conn->error);
        }

        // Bind parameters
        $stmt->bind_param("ss", $this->username, $this->password);

        // Execute
        if($stmt->execute()) {
            $this->id = $stmt->insert_id;
            $stmt->close();
            return true;
        } else {
            throw new Exception("Registration failed: " . $stmt->error);
        }
    }

    // Check if username already exists
    private function usernameExists() {
        $sql = "SELECT id FROM " . $this->table . " WHERE user = ? LIMIT 1";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $this->username);
        $stmt->execute();
        $stmt->store_result();

        $exists = $stmt->num_rows > 0;
        $stmt->close();

        return $exists;
    }

    // Validate user data
    private function validate() {
        if(empty($this->username) || empty($this->password)) {
            return false;
        }

        if(strlen($this->username) < 3 || strlen($this->username) > 50) {
            return false;
        }

        if(strlen($this->password) < 6) {
            return false;
        }

        return true;
    }

    // Password hashing
    private function hashPassword($password) {
        return password_hash($password, PASSWORD_DEFAULT);
    }

    // Sanitize input
    private function sanitize($input) {
        return htmlspecialchars(strip_tags(trim($input)));
    }

    // Find user by username (for login later)
    public function findByUsername($username) {
        $sql = "SELECT * FROM " . $this->table . " WHERE user = ? LIMIT 1";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows === 1) {
            $row = $result->fetch_assoc();
            $this->id = $row['id'];
            $this->username = $row['user'];
            $this->password = $row['password'];
            $this->created_at = $row['created_at'];
            return true;
        }

        return false;
    }

    // Verify password (for login)
    public function verifyPassword($password) {
        return password_verify($password, $this->password);
    }
}
?>