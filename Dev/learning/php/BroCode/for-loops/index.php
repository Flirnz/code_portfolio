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
<form action = index.php method = "post">
    <label> Enter a number to count to:</label>
    <input type = text name = "counter">
    <input type = submit value = "start">
</form>

</body>
</html>
<?php
    $counter = $_POST["counter"];
    for($i = 1 ; $i <= $counter; $i++){
        echo $i . "<br>";
    }
?>
