<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Gestion des garages</title>
    <link rel="stylesheet" href="css/indexbis.css">
</head>

<body>


    <?php include 'navbar.php'; ?>
    <?php include 'auth.php'; ?>

    <?php
    function trunc($value, $max)
    {
        if ($value <= $max) {
            return $value;
        } else {
            return $max;
        }
    }
    ?>


    <!-- Image d'accueil -->

    <h1 style="margin:3%;">Bonjour</h1>

    <!-- select month & years -->
    <form  method="get" style="margin-left : 3%">
        <!-- Sélection de l'année -->
        <select name="year">
            <?php
            for ($year = 2019; $year <= 2024; $year++) {
                echo "<option value='$year'>$year</option> ";
            }
            ?>
        </select>

    <?php
                    $year = $_GET['year'] ?? 2019;
    ?>



        <input type="submit" value="Envoyer">
    </form>

    <?php
        echo "<h2 style=\"margin:3%;\" > Résultats pour l'année $year </h2>"; 
    ?>

    <div class="stats">

        <div class="stat">
            <h2 class="stat-item">Somme totale facturée</h2>
            <div class="stat-item stat-bar" style="flex : 5">
                <?php
                //get month and years 

            


                $sql = "SELECT SUM(montant_facture) FROM factures WHERE date_facture >= '$year-01-01'::date AND date_facture < '$year-12-31'::date";
                //previous month
                $sql2 = "SELECT SUM(montant_facture) FROM factures WHERE date_facture >= '$year-01-01'::date - interval '1 year' AND date_facture < '$year-12-31'::date - interval '1 year'";

                $stmt = $pdo->prepare($sql);
                $stmt->execute();
                $result = $stmt->fetch(PDO::FETCH_ASSOC);

                //check if null
                if ($result['sum'] == null) {
                    $result['sum'] = 0;
                }

                $stmt2 = $pdo->prepare($sql2);
                $stmt2->execute();
                $result2 = $stmt2->fetch(PDO::FETCH_ASSOC);

                //check if null
                if ($result2['sum'] == null && $result['sum'] == 0) {
                    $result2['sum'] = 1;
                } else if ($result2['sum'] == null) {
                    $result2['sum'] = $result['sum'];
                }
                //echo result relative at the miidle
                echo '<p style=" position: absolute; left: 50%; transform: translate(-50%, 0);">' . $result['sum'] . '€</p>';

                //insert progress bar
                echo '<div class="stat-bar-handle" style="width: ' . trunc($result['sum'] / $result2['sum'] * 100, 100) . '%"></div>';
                ?>
            </div>
            <p class="stat-item">
                <?php
                //compare last month
                if ($result['sum'] > $result2['sum']) {
                    echo 'En hausse de ' . round(($result['sum'] - $result2['sum']) / $result2['sum'] * 100, 0) . '%';
                } else if ($result['sum'] < $result2['sum']) {
                    echo 'En baisse de ' . round(($result2['sum'] - $result['sum']) / $result2['sum'] * 100, 0) . '%';
                }

                ?>
            </p>
        </div>

        <div class="stat">
            <h2 class="stat-item">Nombre d'heures sur le mois</h2>
            <div class="stat-item stat-bar" style="flex : 5">
                <?php
                //get month and years 
                

                $sql = "SELECT SUM(duree_estime_action) FROM actions, factures, actions_survenues WHERE date_facture >= '$year-01-01'::date AND date_facture < '$year-12-31'::date AND actions_survenues.numero_intervention = factures.numero_intervention AND actions_survenues.numero_action = actions.numero_action";
                //previous month
                $sql2 = "SELECT SUM(duree_estime_action) FROM actions, factures, actions_survenues WHERE date_facture >= '$year-01-01'::date - interval '1 year' AND date_facture < '$year-12-31'::date - interval '1 year' AND actions_survenues.numero_intervention = factures.numero_intervention AND actions_survenues.numero_action = actions.numero_action";

                $stmt = $pdo->prepare($sql);
                $stmt->execute();
                $result = $stmt->fetch(PDO::FETCH_ASSOC);

                //check if null
                if ($result['sum'] == null) {
                    $result['sum'] = 0;
                }

                $stmt2 = $pdo->prepare($sql2);
                $stmt2->execute();
                $result2 = $stmt2->fetch(PDO::FETCH_ASSOC);

                //check if null
                if ($result2['sum'] == null && $result['sum'] == 0) {
                    $result2['sum'] = 1;
                } else if ($result2['sum'] == null) {
                    $result2['sum'] = $result['sum'];
                }
                //echo result relative at the miidle
                echo '<p style=" position: absolute; left: 50%; transform: translate(-50%, 0);">' . $result['sum'] . 'h</p>';

                //insert progress bar
                echo '<div class="stat-bar-handle" style="width: ' . trunc($result['sum'] / $result2['sum'] * 100, 100) . '%"></div>';
                ?>
            </div>
            <p class="stat-item">
                <?php
                //compare last month
                if ($result['sum'] > $result2['sum']) {
                    echo 'En hausse de ' . round(($result['sum'] - $result2['sum']) / $result2['sum'] * 100, 0) . '%';
                } else if ($result['sum'] < $result2['sum']) {
                    echo 'En baisse de ' . round(($result2['sum'] - $result['sum']) / $result2['sum'] * 100, 0) . '%';
                }

                ?>
            </p>
        </div>


    </div>

    <?php include 'models_by_years.php'; ?>
    <?php include 'interventions_two_months.php'; ?>
    <?php include 'type_modele_by_majority_action.php'; ?>

</body>

</html>