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
<form action = "<?php htmlspecialchars($_SERVER["PHP_SELF"])?>" method = "post">
    <label>password</label><br>
    <input type = "password" name = "password"><br>
    <input type = "submit" name ="login" value = "Log in">
</form>
</body>
</html>
<?php
if($_SERVER["REQUEST_METHOD"] == "POST"){
    $password = "aaa";
    $hash = password_hash($_POST["password"], PASSWORD_DEFAULT);

    if(password_verify($password,$hash)){
        echo "Welcome";

    }
    else {
        echo "invalid password";
    }

}
?>