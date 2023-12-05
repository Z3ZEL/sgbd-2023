<?php
    include 'auth.php';
    // add intervention
    if(isset($_POST['date']) && isset($_POST['matricule'])){
        $date = $_POST['date'] ?? NULL;
        $matricule = $_POST['matricule'] ?? NULL;
        

        // Prepare the SQL statement
        $request = "INSERT INTO interventions (matricule_voiture, date_debut_intervention, numero_siren) VALUES (?, ?, 567890123)";
        $stmt = $pdo->prepare($request);
        
        // Bind the parameters and execute the query
        $stmt->execute([$matricule, $date]);
        
        // Reset the POST data
        $_POST = array();
        
        // Redirect to voiture.php with the matricule parameter
        header("Location: voiture.php?matricule=$matricule");
        exit();
    } else {
        // Handle the case when date or matricule is empty
        echo "Date and matricule are required.";
    }
?>