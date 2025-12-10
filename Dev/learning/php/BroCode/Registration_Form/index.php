<?php
    include("database.php");
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
    <form action = "<?php htmlspecialchars($_SERVER["PHP_SELF"])?>" method = "post">
        <h2>Welcome to Fakebook!</h2><br>
        username: <input type="text" name = "username"><br>
        password: <input type = "password" name = "password"><br>
        <input type = "submit" value = "Register" name = "submit">
    </form>

</body>
</html>
<?php
    if($_SERVER["REQUEST_METHOD"]== "POST"){
        $username = filter_input(INPUT_POST, "username", FILTER_SANITIZE_SPECIAL_CHARS);
        $password = filter_input(INPUT_POST, "password", FILTER_SANITIZE_SPECIAL_CHARS);

        if(empty($username)){
            echo "Username is empty";

        }
        else if (empty($password)){
            echo "password is empty";
        }
        else{
            $hash = password_hash($password, PASSWORD_DEFAULT);
            $sql = "INSERT INTO users (user, password) VALUES ('$username', '$hash')";
            try{
                mysqli_query($conn, $sql);
                echo "You are now registered!";
            }
            catch(mysqli_sql_exception){
                echo "username is taken!";
            }

        }
    }
    mysqli_close($conn);
?>

