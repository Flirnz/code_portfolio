<?php
session_start();
?>
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
This is the login page<br>
<a href="home.php">This goes to homepage</a><br>
<form action = "index.php" method = "post">
    <label>Username</label><br>
    <input type = "text" name = "username"><br>
    <label>Password</label><br>
    <input type = "password" name = "password"><br>
    <input type = "submit" value = "login" name = "login"><br>

</form>

</body>
</html>
<?php
if(isset($_POST["login"])){


    if(!empty($_POST["username"])&&!empty($_POST["password"])){
        $_SESSION["username"] = $_POST["username"];
        $_SESSION["password"] = $_POST["password"];
        header("location: home.php");
    }
    else{
        echo "Username or password is missing";
    }
}
?>