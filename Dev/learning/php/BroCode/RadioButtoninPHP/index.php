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
    <input type ="radio" name = "credit_card" value = "Visa"> Visa<br>
    <input type ="radio" name = "credit_card" value = "MasterCard"> Master Card<br>
    <input type ="radio" name = "credit_card" value = "Paypal"> Paypal<br>
    <input type ="submit" name = "confirm" value = "Confirm">


</form>


</body>
</html>

<?php
if(isset($_POST["confirm"])){

    $credit_card = null;
    if(isset($_POST["credit_card"])){
        $credit_card = $_POST["credit_card"];

    }
    switch($credit_card){
        case "Visa": echo "Visa"; break;
        case "MasterCard": echo "MasterCard"; break;
        case "Paypal": echo "Paypal"; break;
        default: echo "Please select a credit card";
}

}

?>