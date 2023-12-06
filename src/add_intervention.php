<?php
    include 'auth.php';
    if(isset($_POST['date']) && isset($_POST['matricule'])){
        $date = $_POST['date'] ?? NULL;
        $matricule = $_POST['matricule'] ?? NULL;
        

        $request = "INSERT INTO interventions (matricule_voiture, date_debut_intervention, numero_siren) VALUES (?, ?, 567890123)";
        $stmt = $pdo->prepare($request);
        
        $stmt->execute([$matricule, $date]);
        
        $_POST = array();
        
        header("Location: voiture.php?matricule=$matricule");
        exit();
    } else {
        echo "Date and matricule are required.";
    }
?>