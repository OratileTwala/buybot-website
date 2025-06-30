<?php
// buybot-website/api/read_all_users.php

header('Content-Type: application/json');
$filePath = '../data/users.json';

if (!file_exists($filePath)) {
    echo json_encode(['success' => false, 'message' => 'Users data file not found.']);
    exit;
}

$jsonData = file_get_contents($filePath);
if ($jsonData === false) {
    echo json_encode(['success' => false, 'message' => 'Failed to read users data.']);
    exit;
}

$users = json_decode($jsonData, true);
if ($users === null && json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON in users data file.']);
    exit;
}

foreach ($users as &$user) {
    unset($user['password_hash']);
}

echo json_encode(['success' => true, 'users' => $users]);
?>