<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<form action = "index.php" method = "post">
    <label>Username</label><br>
    <input type = "text" name = "username"><br>
    <label>Email</label><br>
    <input type = "email" name = "email"><br>
    <label>Password</label><br>
    <input type = "password" name = "password"><br>
    <label>Age</label><br>
    <input type = "number" name ="age"> <br>
    <input type = "submit" name = "login" value = "Log in">


</form>

</body>
</html>
<?php
    if(isset($_POST["login"])){
        //sanitize input
        $username = filter_input(INPUT_POST, "username", FILTER_SANITIZE_SPECIAL_CHARS);
        $email = filter_input(INPUT_POST,"email", FILTER_SANITIZE_EMAIL);
        $password = filter_input(INPUT_POST,"password",FILTER_SANITIZE_STRING);
        $age = filter_input(INPUT_POST,"age", FILTER_VALIDATE_INT);

        if (empty($username)){
            echo "Username is invalid!<br>";
        }
        else {
            echo "Your username is {$username}<br>";

        }
        if (empty($email)){
            echo "email is invalid!<br>";
        }
        else {
            echo "Your email is {$email}<br>";

        }
        if (empty($password)){
            echo "password is invalid!<br>";

        }
        else {
            echo "Your password is {$password}<br>";

        }
        if (empty($age)||$age <= 0){
            echo "age is invalid!<br>";
        }
        else {
            echo "Your age is {$age}<br>";

        }


    }
?>