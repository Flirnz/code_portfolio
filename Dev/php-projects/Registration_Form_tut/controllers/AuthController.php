<?php
// controllers/AuthController.php
require_once __DIR__ . '/../models/User.php';

class AuthController {
    private $user;

    public function __construct() {
        $this->user = new User();
    }

    // Handle registration
    public function register($postData) {
        try {
            // Set user data using method chaining
            $this->user
                ->setUsername($postData['username'] ?? '')
                ->setPassword($postData['password'] ?? '');

            // Register the user
            if($this->user->register()) {
                return [
                    'success' => true,
                    'message' => 'Registration successful! You can now login.'
                ];
            }
        } catch(Exception $e) {
            return [
                'success' => false,
                'message' => $e->getMessage()
            ];
        }

        return [
            'success' => false,
            'message' => 'Registration failed.'
        ];
    }

    // Simple validation (additional to model validation)
    public function validateInput($data) {
        $errors = [];

        if(empty($data['username'])) {
            $errors['username'] = 'Username is required';
        }

        if(empty($data['password'])) {
            $errors['password'] = 'Password is required';
        } elseif(strlen($data['password']) < 6) {
            $errors['password'] = 'Password must be at least 6 characters';
        }

        return $errors;
    }
}
?>