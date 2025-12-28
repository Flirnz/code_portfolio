<?php
// ============================================
// FILE: index.php
// PURPOSE: Main registration page
// ============================================

// 1. Include the database connection
include 'database.php';

// 2. Start session (for login later)
session_start();

// 3. Variables for messages
$error = "";
$success = "";

// 4. Check if form was submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // 5. Get form data
    $username = $_POST['username'];
    $password = $_POST['password'];

    // 6. Simple validation
    if (empty($username) || empty($password)) {
        $error = "Please fill in both fields!";
    }
    else if (strlen($password) < 6) {
        $error = "Password must be at least 6 characters!";
    }
    else {
        // 7. Check if username already exists
        $check_sql = "SELECT id FROM users WHERE username = '$username'";
        $result = mysqli_query($conn, $check_sql);

        if (mysqli_num_rows($result) > 0) {
            $error = "Username already taken!";
        }
        else {
            // 8. Hash password for security
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);

            // 9. Insert into database
            $sql = "INSERT INTO users (username, password) VALUES ('$username', '$hashed_password')";

            if (mysqli_query($conn, $sql)) {
                $success = "✅ Registration successful!";
                // Clear form
                $username = "";
            }
            else {
                $error = "Error: " . mysqli_error($conn);
            }
        }
    }
}

// 10. Close database connection
mysqli_close($conn);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Registration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1>📝 Register</h1>

    <?php if ($error): ?>
        <div class="error-box">
            <?php echo $error; ?>
        </div>
    <?php endif; ?>

    <?php if ($success): ?>
        <div class="success-box">
            <?php echo $success; ?><br>
            <a href="login.php">Click here to login</a>
        </div>
    <?php endif; ?>

    <form method="POST" action="">
        <div class="input-group">
            <label for="username">Username:</label>
            <input type="text"
                   id="username"
                   name="username"
                   value="<?php echo isset($_POST['username']) ? htmlspecialchars($_POST['username']) : ''; ?>"
                   placeholder="Enter username"
                   required>
        </div>

        <div class="input-group">
            <label for="password">Password:</label>
            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Enter password (min 6 chars)"
                   required>
        </div>

        <button type="submit" class="btn">Register</button>

        <div class="login-link">
            Already have an account? <a href="login.php">Login here</a>
        </div>
    </form>

    <div class="debug">
        <p><strong>Debug Info:</strong></p>
        <p>Database: <?php echo isset($conn) ? "Connected" : "Not connected"; ?></p>
        <p><a href="view_users.php">View all registered users</a></p>
    </div>
</div>
</body>
</html>