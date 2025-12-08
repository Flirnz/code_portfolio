<?php
$age = 101;
$adult = true;
$hours = 10;
$rate = 10;
$weekly_pay = null;

if ($age >= 21 && $age < 100){
    echo "You may enter<br>";
}
else if ($age <= 0)
{
    echo "Invalid age, please enter a valid age!<br>";

}
else if ($age >= 100){
    echo "You are too old!<br>";
}
else {
    echo "You are not old enough!<br>";
}
if ($adult){
    echo "You may enter<br>";
}
else {
    echo "You are too young!<br>";
}
if ($hours <= 0){
    $weekly_pay = 0;

} else if ($hours < 0){
    $weekly_pay = $hours * $rate;

}
else{
    $weekly_pay = $hours * $rate;
}
echo "You made {$weekly_pay} this week <br>";


?>