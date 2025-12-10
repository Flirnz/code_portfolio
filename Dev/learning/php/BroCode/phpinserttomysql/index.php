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
    <form action =
</body>
</html>
<?php
$username = "sandy";
$password = "clarinet";
$hash = password_hash($password, PASSWORD_DEFAULT);

$sql = "INSERT INTO users (user, password) VALUES ('$username',' $hash')";

try{
    mysqli_query($conn, $sql);
    echo "User is now registered";

}
catch(mysqli_sql_exception){
    echo "could not register user";
}

mysqli_close($conn);
?>

