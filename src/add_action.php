<?php
    include 'auth.php';

    if(isset($_POST['numero_action']) && isset($_POST['intervention_id'])){
        $numero_action = $_POST['numero_action'];
        $intervention_id = $_POST['intervention_id'];
        
        
        $add_action = "INSERT INTO actions_contenues (numero_action, numero_intervention) VALUES (?, ?)";
        $stmt = $pdo->prepare($add_action);
        
        $stmt->bindParam(1, $numero_action);
        $stmt->bindParam(2, $intervention_id);
        
        $stmt->execute();
        
        header("Location: intervention.php?id=$intervention_id");
        exit();
    }
?>