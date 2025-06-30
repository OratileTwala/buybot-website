<?php
// buybot-website/api/join_program.php

header('Content-Type: application/json');
$usersFilePath = '../data/users.json';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

$userId = $input['userId'] ?? null;
$programId = $input['programId'] ?? null;

if ($userId === null || $programId === null) {
    echo json_encode(['success' => false, 'message' => 'User ID and Program ID are required.']);
    exit;
}

$users = [];
if (file_exists($usersFilePath)) {
    $jsonData = file_get_contents($usersFilePath);
    $users = json_decode($jsonData, true);
    if ($users === null && json_last_error() !== JSON_ERROR_NONE) {
        echo json_encode(['success' => false, 'message' => 'Invalid JSON in users data file.']);
        exit;
    }
}

$userFound = false;
foreach ($users as &$user) {
    if (isset($user['id']) && $user['id'] == $userId) {
        $userFound = true;
        if (!isset($user['joined_programs']) || !is_array($user['joined_programs'])) {
            $user['joined_programs'] = [];
        }
        if (in_array($programId, $user['joined_programs'])) {
            echo json_encode(['success' => false, 'message' => 'You have already joined this program.']);
            exit;
        }
        $user['joined_programs'][] = $programId;
        break;
    }
}

if (!$userFound) {
    echo json_encode(['success' => false, 'message' => 'User not found.']);
    exit;
}

if (file_put_contents($usersFilePath, json_encode($users, JSON_PRETTY_PRINT), LOCK_EX) === false) {
    echo json_encode(['success' => false, 'message' => 'Failed to write updated user data.']);
    exit;
}

echo json_encode(['success' => true, 'message' => 'Successfully joined program.']);
?>