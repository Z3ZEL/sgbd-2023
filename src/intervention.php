<?php

 include 'auth.php';
include 'navbar.php';   

// Retrieve the necessary data from voiture and clients pages
$intervention_id = $_GET['id']; // Assuming you pass the car ID as a query parameter


// Query the database or data source to fetch interventions based on car ID and client ID
// Replace this with your actual database query
$intervention = "SELECT * FROM interventions WHERE numero_intervention = '$intervention_id'";
$stmt = $pdo->query($intervention);
$intervention = $stmt->fetchAll(PDO::FETCH_ASSOC);


// Display the interventions
?>
<!DOCTYPE html>
<html>
<head>
    <title>Visualize Interventions</title>
    <link rel="stylesheet" href="css/intervention.css">

</head>
<body>

    <div class="intervention-panel">
        <div style="flex:1;" class="intervention-info container">
            <?php
                echo "<h1> Intervention n°$intervention_id </h1>";
                echo "<ul>";
                foreach($intervention[0] as $key => $value){
                    if($key == "effectuee")
                        echo "<li>$key : ".($value == 1 ? "Oui" : "Non")."</li>";
                    if($key == "matricule_voiture")
                        echo "<li>$key : <a href = 'voiture.php?matricule=$value'>$value</a></li>";
                    else if($key != "numero_intervention")
                    echo "<li>$key : $value</li>";
                }
                echo "</ul>";
            ?>
        </div>
        <div style="flex:3;" class="intervention-content container">
            <h1> Liste des actions </h1>
            <?php
                $actions = "SELECT nom_action, tarif_action, duree_estime_action FROM get_actions_from_intervention('$intervention_id')";
                $stmt = $pdo->query($actions);
                $actions = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo "<div class=\"actions\">";
                foreach($actions as $action){
                    echo "<div class=\"action-item\">";
                    echo "<h3>$action[nom_action]</h3>";
                    echo "<p>Tarif  : $action[tarif_action]€</p>";
                    echo "<p>Durée : $action[duree_estime_action]h</p>";
            
                    echo "</div>";
                }
                echo "</div>";

            ?>
        </div>
    </div>
    
</body>
</html>
