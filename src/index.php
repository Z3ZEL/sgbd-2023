<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Choix du garage</title>
    <link rel="stylesheet" href="css/index.css">
</head>

<?php
include 'auth.php';

$request = "SELECT * FROM garages";
$stmt = $pdo->query($request);
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<body>

    <div id="choix">
        <h1>Choisissez votre garage : </h1>
        <form action="indexbis.php" method="post">
            <select name="garage" id="garage" onchange="this.form.submit()">
                <?php
                $request = "SELECT * FROM garages";
                $stmt = $pdo->query($request);
                $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo "<option value=''></option>";
                foreach ($data as $row) {
                    echo "<option value='" . $row['numero_SIREN'] . "'>" . $row['denomination_garage'] . "</option>";
                }
                ?>
            </select>
        </form>
    </div>
    

</body>


</html>