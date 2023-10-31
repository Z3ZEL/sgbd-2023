<?php
include 'auth.php';

$tableName = $_POST['table'];
$primaryKeyValue = $_POST['pk'];
$primaryKeyColumn = $_POST['pk_column'];

$sql = "DELETE FROM $tableName WHERE $primaryKeyColumn = :pk";
$stmt = $pdo->prepare($sql);

$stmt->bindParam(':pk', $primaryKeyValue, PDO::PARAM_INT);
$stmt->execute();

header("Location: table_view.php?table=$tableName");
exit();
?>
