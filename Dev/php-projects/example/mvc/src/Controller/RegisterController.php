<?php

namespace mvc\Controller;

use mvc\Model\UserModel;
// Halaman ini sengaja dikosongkan.
// TANTANGAN: Buat Controller logic di sini nanti!


class RegisterController extends Controller
{
    public function index()
    {
        $this->view('register');
    }
    public function save()
    {
        $user = new UserModel();

        $username = $_POST['username'];
        $email = $_POST['email'];
        $password = $_POST['password'];
        $confirm = $_POST['password_confirm'];

        if ($password !== $confirm) {
            echo "Password mismatch! Re-enter password! <br>";
        } else {
            $register = $user->createUser($username, $email, $password);
            if ($register) {
                echo "registered! <br>";
            } else {
                echo "error!<br>";
            }
        }
    }
}
