<!-- views/register.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Fakebook</title>
    <style>
        .error { color: red; margin-top: 5px; }
        .success { color: green; margin-top: 5px; }
        .form-group { margin-bottom: 15px; }
        input { padding: 8px; width: 200px; }
    </style>
</head>
<body>
<div style="max-width: 400px; margin: 50px auto;">
    <h2>Welcome to Fakebook!</h2>

    <?php if(isset($message) && isset($status)): ?>
        <div class="<?php echo $status === 'error' ? 'error' : 'success'; ?>">
            <?php echo htmlspecialchars($message); ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="">
        <div class="form-group">
            <label for="username">Username:</label><br>
            <input type="text"
                   id="username"
                   name="username"
                   value="<?php echo htmlspecialchars($_POST['username'] ?? ''); ?>"
                   required>
            <?php if(isset($errors['username'])): ?>
                <div class="error"><?php echo $errors['username']; ?></div>
            <?php endif; ?>
        </div>

        <div class="form-group">
            <label for="password">Password:</label><br>
            <input type="password"
                   id="password"
                   name="password"
                   required>
            <?php if(isset($errors['password'])): ?>
                <div class="error"><?php echo $errors['password']; ?></div>
            <?php endif; ?>
        </div>

        <div class="form-group">
            <input type="submit"
                   name="submit"
                   value="Register">
            <a href="login.php" style="margin-left: 10px;">Already have an account?</a>
        </div>
    </form>
</div>
</body>
</html>