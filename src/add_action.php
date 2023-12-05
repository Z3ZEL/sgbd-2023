<?php
    include 'auth.php';
    // Make sure $pdo is properly initialized with your database connection

    if(isset($_POST['numero_action']) && isset($_POST['intervention_id'])){
        $numero_action = $_POST['numero_action'];
        $intervention_id = $_POST['intervention_id'];
        
        
        // Prepare the SQL statement
        $add_action = "INSERT INTO actions_contenues (numero_action, numero_intervention) VALUES (?, ?)";
        $stmt = $pdo->prepare($add_action);
        
        // Bind the values to the prepared statement
        $stmt->bindParam(1, $numero_action);
        $stmt->bindParam(2, $intervention_id);
        
        // Execute the prepared statement
        $stmt->execute();
        
        // Redirect to the same page after the query is executed
        header("Location: intervention.php?id=$intervention_id");
        exit();
    }
?>