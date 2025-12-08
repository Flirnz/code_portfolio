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
    <input type = "checkbox" name = "foods[]" value = "Pizza">Pizza<br>
    <input type = "checkbox" name = "foods[]" value = "Burger">Burger<br>
    <input type = "checkbox" name = "foods[]" value = "Fries">Fries<br>
    <input type = "checkbox" name = "foods[]" value = "Donuts">Donut <br>
    <input type = "submit" name = "submit" value = "Submit">



</form>

</body>
</html>
<?php
if(isset($_POST["submit"])) {
$foods = $_POST["foods"];
foreach ($foods as $food){
    echo $food . "<br>";
}


}
?>
