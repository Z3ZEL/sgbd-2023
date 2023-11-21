<?php
include 'auth.php';

$year = $_POST['year'];
$numero_SIREN = $_SESSION['numero_SIREN'];

// Prepare the SQL statement
$sql = "CREATE OR REPLACE VIEW models_year AS SELECT * FROM get_models_by_year(:year, :numero_SIREN)";
$stmt = $pdo->prepare($sql);

// Bind parameters to the SQL statement
$stmt->bindParam(':year', $year, PDO::PARAM_INT);
$stmt->bindParam(':numero_SIREN', $numero_SIREN, PDO::PARAM_INT);

// Execute the query and check for errors
if ($stmt->execute()) {
    // Redirect to the view
    header("Location: table_view.php?table=models_year");
} else {
    // Error handling
    echo "Error: " . $stmt->errorInfo()[2];
}
?>
