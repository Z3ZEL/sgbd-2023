<?php
include 'auth.php';

$tableName = $_POST['table'];

// Execute sql script '../sql/reset_db.sql'
$command = "cd .. && psql postgresql://$user:$password@$host:5432/$dbname -1 -f sql/donnees.sql";
$output = [];
$status = 0;

exec($command, $output, $status);



if($status === 0) {
    header("Location: table_view.php?table=$tableName");
} else {
    echo "Une erreur s'est produite lors de l'exécution de la commande : " . implode("\n", $output);
}
?>
