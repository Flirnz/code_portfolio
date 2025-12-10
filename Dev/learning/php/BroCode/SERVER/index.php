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
<form action = "<?php htmlspecialchars($_SERVER["PHP_SELF"]);?>" method = "post">
    username: <br>
    <input type = "text" name = "username"> <br>
    <input type = "submit" name ="login" value = "login">
</form>

</body>
</html>
<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    echo "HELLO";
}

?>