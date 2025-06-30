<?php
// buybot-website/api/read_training_programs.php

header('Content-Type: application/json');
$filePath = '../data/training_programs.json';

if (!file_exists($filePath)) {
    echo json_encode(['success' => false, 'message' => 'Training programs data file not found.']);
    exit;
}

$jsonData = file_get_contents($filePath);
if ($jsonData === false) {
    echo json_encode(['success' => false, 'message' => 'Failed to read training programs data.']);
    exit;
}

$programs = json_decode($jsonData, true);
if ($programs === null && json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON in training programs data file.']);
    exit;
}

echo json_encode(['success' => true, 'programs' => $programs]);
?>