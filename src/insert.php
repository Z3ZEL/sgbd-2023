<?php
include 'auth.php';

$tableName = $_POST['table'];
$fields = $_POST;
unset($fields['table']);

//preparation de la reqête SQL
$columnNames = implode(", ", array_keys($fields));
$placeholders = implode(", ", array_fill(0, count($fields), '?'));

$sql = "INSERT INTO $tableName ($columnNames) VALUES ($placeholders)";

// Exécuter la requête SQL
$stmt = $pdo->prepare($sql);
$stmt->execute(array_values($fields));

// Rediriger vers la page de la table
header("Location: table_view.php?table=$tableName");
