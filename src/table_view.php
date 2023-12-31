<?php

include 'auth.php';

if (isset($_GET['fct'])) {
    $fct = $_GET['fct'];
        $sql = "SELECT * FROM $fct(";
        if(isset($_GET['param'])) {
            $params = $_GET['param'];
            $sql .= implode(',', $params);
        }
        $sql .= ")";
        $tableName = $fct;
    } else {
    $tableName = $_GET['table'] ?? 'voiture';
    $sql = "SELECT * FROM $tableName";
}

$stmt = $pdo->query($sql);

// Récupérer les données
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$data = array_reverse($data);

// Récupérer les noms des colonnes
$columnNames=array();

if(!empty($data))
{
    $columnNames = array_keys($data[0]);
}
else{
    $meta = $stmt->getColumnMeta(0);  // Récupérer les métadonnées de la première colonne
    $columnNames = [$meta['name']];  // Initialiser le tableau des noms de colonnes
    for ($i = 1; $meta = $stmt->getColumnMeta($i); $i++) {  // Continuer pour les autres colonnes
        $columnNames[] = $meta['name'];
    }
}

?>
<!DOCTYPE html>
<html>
<head>
    <title><?= $tableName ?></title>
</head>
<body>
    <?php include 'navbar.php'; ?>
    <h1>Liste des <?= $tableName ?></h1>

    <!-- Réinitialisation de la base -->
    <div>
        <form action="reset_db.php" method="post">
            <input type="hidden" name="table" value="<?= $tableName ?>">
            <input type="submit" value="Réinitialiser la base de données">
        </form>
    </div>

    <!-- Affichage des entrées de la table -->
    <div>
        <form action="insert.php" method="post">
            <input type="hidden" name="table" value="<?= $tableName ?>">
            <table border="1">
                <!-- En-têtes du tableau -->
                <tr>
                    <?php if ( !isset($_GET['submitable']) || $_GET['submitable'] != 'false') : ?><th></th><?php endif; ?>
                    <?php foreach ($columnNames as $columnName): ?>
                        <th><?= $columnName ?></th>
                    <?php endforeach; ?>
                </tr>

                <!-- Ligne pour l'ajout d'une nouvelle entrée -->
                <?php if ( !isset($_GET['submitable']) || $_GET['submitable'] != 'false') : ?>
                    <tr>
                        <td><input type="submit" value="+"></td>
                        <?php foreach ($columnNames as $columnName): ?>
                            <td>
                                <input style="background-color: var(--background-color); color: var(--primary-color);" type="text" id="<?= $columnName ?>" name="<?= $columnName ?>">
                            </td>
                        <?php endforeach; ?>
                    </tr>
                <?php endif; ?>
            </form>

            <!-- Données du tableau -->
            <?php foreach ($data as $row): ?>
                <tr>
                <?php if (!isset($_GET['submitable']) || $_GET['submitable'] !== 'false'): ?>
                    <form action="delete_entry.php" method="post">
                        <input type="hidden" name="table" value="<?= $tableName ?>">
                        <input type="hidden" name="pk" value="<?= $row[$columnNames[0]] ?>">
                        <input type="hidden" name="pk_column" value="<?= $columnNames[0] ?>">
                        <td><input type="submit" value="-"></td>
                    </form>
                <?php endif; ?>
                    <?php foreach ($columnNames as $columnName): ?>
                        <td><?= $row[$columnName] ?></td>
                    <?php endforeach; ?>
                </tr>
            <?php endforeach; ?>

            </table>
        </div>
    </body>
</html>
