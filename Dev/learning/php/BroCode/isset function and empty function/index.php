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
<form action ="index.php" method = "post">
    <label>Username</label>
    <input type ="text" name = "username"><br>
    <label>Password</label>
    <input type ="password" name = "password"><br>
    <input type = "submit" name = "login" value = "Log in">
</form>

</body>
</html>

<?php
foreach($_POST as $key => $value){
    echo"{$key} = {$value}<br>";
}
if(isset($_POST["login"])){
    $username = $_POST["username"];
    $password = $_POST["password"];
    if(empty($username)){
        echo "Username is empty";
    }
    else if (empty($password)){
        echo "Password is empty";
    }
    else{
        echo "Welcome {$username}!";
    }
}

?>
