<?php
// Halaman ini sengaja dikosongkan.
// SILAKAN KETIK ULANG KODENYA DI SINI! (Jangan Copas)
// Mulai dari: Namespace, Class, dan Constructor.
namespace mvc\Model;
class UserModel{
    private $db;

    public function __construct(){
        $this->db = \getDB();

    }
    public function createUser($username,$email,$password){
        $hash = password_hash($password, PASSWORD_DEFAULT);

        $sql = "INSERT INTO users (username,email,password) VALUES (:username,:email,:password)";
        $stmt = $this->db->prepare($sql);
        try{
            return $stmt->execute([
                ':username' => $username,
                ':email' => $email,
                ':password' => $hash,
            ]);
            
        }
        catch(\PDOException $e){
            return false;
        }
    }

}