<?php
// index.php - Main controller
session_start();

// Autoload classes (simple version)
spl_autoload_register(function($class) {
    $paths = [
        'config/' . $class . '.php',
        'models/' . $class . '.php',
        'controllers/' . $class . '.php'
    ];

    foreach($paths as $path) {
        if(file_exists($path)) {
            require_once $path;
            return;
        }
    }
});

// Handle form submission
if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $authController = new AuthController();

    // Validate input
    $errors = $authController->validateInput($_POST);

    if(empty($errors)) {
        // Attempt registration
        $result = $authController->register($_POST);

        if($result['success']) {
            $message = $result['message'];
            $status = 'success';

            // Clear form
            $_POST = [];
        } else {
            $message = $result['message'];
            $status = 'error';
        }
    }
}

// Include the view
require 'views/register.php';
?>