<?php

include 'auth.php';
// Exécuter la requête SQL pour obtenir toutes les entrées de la table souhaitée
$tableName = $_GET['table'] ?? 'voiture';
$sql = "SELECT * FROM $tableName";
$stmt = $pdo->query($sql);

// Récupérer les données
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Récupérer les noms des colonnes
$columnNames = array_keys($data[0]);
?>
<!DOCTYPE html>
<html>
<head>
    <title><?= $tableName ?></title>
</head>
<body>
    <?php include 'navbar.php'; ?>
    <h1>Liste des <?= $tableName ?></h1>
    <table border="1">
        <tr>
            <?php foreach ($columnNames as $columnName): ?>
                <th><?= $columnName ?></th>
            <?php endforeach; ?>
        </tr>
        <?php foreach ($data as $row): ?>
        <tr>
            <?php foreach ($columnNames as $columnName): ?>
                <td><?= $row[$columnName] ?></td>
            <?php endforeach; ?>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
