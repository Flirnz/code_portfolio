<?php
// welcome.php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1>🎉 Welcome, <?php echo htmlspecialchars($_SESSION['username']); ?>!</h1>
    <p>You are logged in.</p>
    <p>User ID: <?php echo $_SESSION['user_id']; ?></p>
    <a href="logout.php" style="color: #f44336;">Logout</a>
</div>
</body>
</html>