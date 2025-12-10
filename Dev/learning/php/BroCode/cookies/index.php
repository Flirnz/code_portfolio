<?php
    setcookie("fav_food", "pizza", time() + (86400*2), "/");
    setcookie("fav_drink", "coke", time() + (86400*2), "/");
    setcookie("fav_dessert", "ice cream", time() + (86400*2), "/");

    foreach ($_COOKIE as $key => $value) {
        echo "{$key} = {$value} <br>";
    }
    if (isset($_COOKIE["fav_food"])){
        echo "BUY SOME {$_COOKIE["fav_food"]}";

    }
?>
