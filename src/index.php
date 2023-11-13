<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Gestion des garages</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <?php include 'navbar.php'; ?>
    <?php include 'auth.php'; ?>
    
    <?php 
        function trunc($value, $max){
            if($value <= $max){
                return $value;
            }else {
                return $max;
            }
        }
    ?>


    <!-- Image d'accueil -->
    
    <h1 style="margin:3%;">Bonjour</h1>

    <!-- select month & years -->
    <form action="index.php" method="post" style="margin-left: 3%;">
    <div class="date-selection">
        <label for="month">Mois</label>
        <select name="month" id="month" >
            <?php foreach (range(1, 12) as $month):  ?>
                <option value="<?= str_pad($month, 2, '0', STR_PAD_LEFT) ?>" <?php if ($_POST['month'] == str_pad($month, 2, '0', STR_PAD_LEFT)) {echo 'selected';} ?>><?= str_pad($month, 2, '0', STR_PAD_LEFT) ?></option>           
            <?php endforeach; ?>
        </select>
        <label for="year">Année</label>
        <select name="year" id="year" >
            <option value="2019" <?php if ($_POST['year'] == '2019') {echo 'selected';} ?>>2019</option>
            <option value="2020" <?php if ($_POST['year'] == '2020') {echo 'selected';} ?>>2020</option>
            <option value="2021" <?php if ($_POST['year'] == '2021') {echo 'selected';} ?>>2021</option>
        </select>

        <input type="submit" value="Valider">
    </div>
    </form>

    <div class="stats"> 

    <div class="stat">
        <h2 class="stat-item">Somme totale facturée</h2>
        <div class="stat-item stat-bar" style="flex : 5">
        <?php
            //get month and years 
            $month = $_POST['month'];
            $year = $_POST['year'];

            if ($month == null) {
                $month = '01';
            }
            if ($year == null) {
                $year = '2019';
            }

            $sql = "SELECT SUM(montant_facture) FROM facture WHERE date_facture >= '$year-$month-01'::date AND date_facture < '$year-$month-01'::date + interval '1 month'";
            //previous month
            $sql2 = "SELECT SUM(montant_facture) FROM facture WHERE date_facture >= '$year-$month-01'::date - interval '1 month' AND date_facture < '$year-$month-01'::date";

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
            }else if ($result2['sum'] == null) {
                $result2['sum'] = $result['sum'];
            }
            //echo result relative at the miidle
            echo '<p style=" position: absolute; left: 50%; transform: translate(-50%, 0);">' . $result['sum'] . '€</p>';

            //insert progress bar
            echo '<div class="stat-bar-handle" style="width: ' . trunc($result['sum'] / $result2['sum'] * 100,100) . '%"></div>';
        ?>
        </div>
        <p class="stat-item">
            <?php
                //compare last month
                if ($result['sum'] > $result2['sum']) {
                    echo 'En hausse de ' . round(($result['sum'] - $result2['sum']) / $result2['sum'] * 100, 0) . '%';

                }else if ($result['sum'] < $result2['sum']) {
                    echo 'En baisse de ' . round(($result2['sum'] - $result['sum']) / $result2['sum'] * 100, 0) . '%';
                }
            
            ?>
        </p>
    </div>

    <div class="stat">
        <h2 class="stat-item">Nombre d'heures</h2>
        <div class="stat-item stat-bar" style="flex : 5">
            <div class="stat-bar-handle" style="width: 100%"></div>
        </div>
        <p class="stat-item">0</p>
    </div>
    

    </div>
    
</body>
</html>