<?php
    class user{
        private $conn;
        private $table_name = "users";

        public $username;
        public $email;
        public $password;

        public function __conturct($db){
            $this->conn = $db;
        }
        public function register(){
            $query = "INSERT INTO " . $this->table_name . " (username, email, password) VALUES (:username, :emai, :password)";
            $stmt = $this->conn->prepare($query);

            $this->username = htmlspecialchars(strip_tags($this->username));
            $this->email = htmlspecialchars(strip_tags($this->email));

            $password_hash = password_hash($this->password, PASSWORD_DEFAULT);

            $stmt->bindparam(":username", $this->username);
            $stmt->bindparam(":email", $this->email);
            $stmt->bindparam(":password", $password_hash);

            if($stmt->execute()){
                return true;
            }

            return false;
        }
    }
?>