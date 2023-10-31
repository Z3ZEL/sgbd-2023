<?php
include 'auth.php';

$tableName = $_POST['table'];

// Mettre à jour la commande pour exécuter le fichier SQL
$command = "psql -U $user -d $dbname -a -c \"\\i ../sql/donnees.sql\"";

// Exécuter la commande shell
putenv("PGPASSWORD=$password");
exec($command, $output, $status);
putenv("PGPASSWORD=");

if($status === 0) {
    header("Location: table_view.php?table=$tableName");
} else {
    echo "Une erreur s'est produite lors de l'exécution de la commande : " . implode("\n", $output);
}
?>
