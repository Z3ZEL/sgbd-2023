<?php
/* include 'auth.php'; */

$year = $_POST['year_mod'];
$numero_SIREN = $_POST['numero_SIREN'];

$sql = "CREATE TABLE models_year AS SELECT * FROM get_models_by_year(:year_mod, :numero_SIREN)";
$stmt = $pdo->prepare($sql);

// Bind parameters to the SQL statement
$stmt->bindParam(':year_mod', $year, PDO::PARAM_INT);
$stmt->bindParam(':numero_SIREN', $numero_SIREN, PDO::PARAM_INT);

// Execute the SQL statement
$stmt->execute();

?>
