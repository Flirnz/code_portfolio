<?php
 include_once "Database.php";
 include_once "User.php";

 $message = "";
 if($_SERVER["REQUEST_METHOD"] == "POST"){
     $database = new Database();
     $db = $database->getConnection();
     $user = new User($db);

     $user->username = $_POST["username"];
     $user->email = $_POST["email"];
     $user->password = $_POST["password"];

     try{
         if($user->register()){
             header("Location:index.php");
             exit();
         }
         else{
             $message = "Unable to register user!";

         }

     }catch(PDOException $exception){
         if ($exception->getCode() == 23000) {
             $message = "Username or email already exists!";

         }
         else{
             $message = "Database error:";
         }

     }
 }
 ?>
 <!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>

    <h2>Register</h2>

    <?php if ($message): ?>
        <p style="color:red;"><?php echo $message; ?></p>
    <?php endif; ?>

    <form method="POST" action="register.php">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Sign Up</button>
    </form>

</body>
</html>