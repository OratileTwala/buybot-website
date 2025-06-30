<?php
// buybot-website/api/create_user.php
// Handles creating a new user and saving to users.json

header('Content-Type: application/json');
$filePath = '../data/users.json'; // Path to your users.json file

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

$name = $input['name'] ?? '';
$email = $input['email'] ?? '';
$password_hash = $input['password_hash'] ?? '';
$date_of_birth = $input['date_of_birth'] ?? '';

// Basic server-side validation
if (empty($name) || empty($email) || empty($password_hash) || empty($date_of_birth)) {
    echo json_encode(['success' => false, 'message' => 'All fields are required.']);
    exit;
}

$users = [];
if (file_exists($filePath)) {
    $jsonData = file_get_contents($filePath);
    $users = json_decode($jsonData, true);
    if ($users === null && json_last_error() !== JSON_ERROR_NONE) {
        echo json_encode(['success' => false, 'message' => 'Invalid JSON in users data file.']);
        exit;
    }
}

foreach ($users as $user) {
    if (isset($user['email']) && $user['email'] === $email) {
        echo json_encode(['success' => false, 'message' => 'Email already registered.']);
        exit;
    }
}

$newId = count($users) > 0 ? max(array_column($users, 'id')) + 1 : 1;

$newUser = [
    'id' => $newId,
    'name' => $name,
    'email' => $email,
    'password_hash' => $password_hash,
    'date_of_birth' => $date_of_birth,
    'joined_programs' => [],
    'created_at' => date('c')
];

$users[] = $newUser;

if (file_put_contents($filePath, json_encode($users, JSON_PRETTY_PRINT), LOCK_EX) === false) {
    echo json_encode(['success' => false, 'message' => 'Failed to write user data. Check file permissions.']);
    exit;
}

echo json_encode(['success' => true, 'message' => 'Account created successfully!', 'userId' => $newId]);
?>