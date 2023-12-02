<!DOCTYPE html>
<html>
<head>
    <title>Voiture </title>
    <link rel="stylesheet" href="css/voiture.css">
</head>
<body>
    <script>
        function openInterventionPage(num_intervention){
            window.location.href = "intervention.php?id="+num_intervention;
        }
    </script>

    <?php include 'auth.php'; ?>
    <?php include 'navbar.php'; ?>

    <?php
        $matricule = $_GET['matricule'];

        $request = "SELECT * FROM voitures WHERE matricule_voiture = '$matricule'";
        $stmt = $pdo->query($request);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    <div class="voiture-panel">
    <div class="voiture-info">
    <?php
        echo "<h1 style='text-align:center;'> $matricule </h1>";
        echo "<ul>";
        foreach($data[0] as $key => $value){
            if($key == "numero_client"){
                echo "<li>$key : <a href = 'clients.php?client=$value'>$value</a></li>";
            }else{
            echo "<li>$key : $value</li>";
            }
        }
        echo "</ul>";
    ?>
    </div>
    <div class="voiture-intervention">

    <?php
        $request = "SELECT * FROM interventions WHERE matricule_voiture = '$matricule'";
        $stmt = $pdo->query($request);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo "<h1 style='text-align:center;'> Interventions </h1>";
        echo "<ul>";
        foreach($data as $row){
            echo "<div class='intervention'> 
            <div class='intervention-info' style='flex:8'> 
            Numero intervention : $row[numero_intervention] </br>
            Date : $row[date_debut_intervention]
            </div>";
            
            echo "<div class='intervention-content' style='flex:1'>";

            if ($row['effectuee'] == true){
                echo "<p>✔️</p>";
            }else{
                echo "<p>❌</p>";
            }
            
            echo "<button style='margin:3%; margin-left:4em; width:10em;' onclick='openInterventionPage($row[numero_intervention])'>Voir</button>";

            echo "</div>
            </div>";    
        }
        echo "</ul>";
    ?>
    </div>


    </div>
</body>
</html>
