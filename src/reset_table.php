<?php
include 'auth.php';

$tableName = $_POST['table'];

try {
    $sql = "TRUNCATE TABLE $tableName CASCADE";
    $pdo->exec($sql);
} catch (PDOException $e) {
    die("Erreur : " . $e->getMessage());
}

putenv("PGPASSWORD=$password");
$command = "psql -U $user -d $dbname -c \"\\COPY $tableName FROM '../data/$tableName.csv' DELIMITER ',' CSV HEADER\"";
putenv("PGPASSWORD=");

// Exécuter la commande shell
exec($command, $output, $status);

if($status === 0) {
    header("Location: table_view.php?table=$tableName");
} else {
    echo "Une erreur s'est produite lors de l'exécution de la commande : " . implode("\n", $output);
}
?>