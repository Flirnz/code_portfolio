<?php
// 1. Load Configuration
require_once __DIR__ . '/config/config.php';

// 2. Autoloader (Manual version for learning)
// This magically loads your Class files when you use "use mvc\..."
spl_autoload_register(function ($class) {
    // Convert "mvc\Controller\RegisterController" -> "src/Controller/register.php"
    $prefix = 'mvc\\';
    $base_dir = __DIR__ . '/src/';

    $len = strlen($prefix);
    if (strncmp($prefix, $class, $len) !== 0) return;

    $relative_class = substr($class, $len);
    $file = $base_dir . str_replace('\\', '/', $relative_class) . '.php';

    if (file_exists($file)) {
        require $file;
    }
});

// 3. Simple Router Logic
// URL looks like: /my-php-project/example/mvc/Register/save
$request = $_SERVER['REQUEST_URI'];
$basePath = '/my-php-project/example/mvc'; // Setup your base folder path

// Remove the base path from the request to get the "clean" route
$route = str_replace($basePath, '', $request);
// Remove query parameters (?error=1)
$route = strtok($route, '?');
// Split by slash: "" / "Register" / "save"
$parts = explode('/', trim($route, '/'));

// Defaults
$controllerName = $parts[0] ?: 'Home'; // Default to Home
$actionName     = $parts[1] ?? 'index'; // Default to index()

// 4. Dispatch
// Convert "register" to "RegisterController"
$className = "mvc\\Controller\\" . ucfirst($controllerName) . "Controller";

if (class_exists($className)) {
    $controller = new $className();
    if (method_exists($controller, $actionName)) {
        $controller->$actionName();
    } else {
        echo "404 - Method '$actionName' not found";
    }
} else {
    echo "404 - Controller '$className' not found";
}