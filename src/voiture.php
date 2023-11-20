<!DOCTYPE html>
<html>
<head>
    <title>Voiture </title>
</head>
<body>
    <?php include 'auth.php'; ?>
    <?php include 'navbar.php'; ?>

    <?php
        $matricule = $_GET['matricule'];

        $request = "SELECT * FROM voitures WHERE matricule_voiture = '$matricule'";
        $stmt = $pdo->query($request);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo "<h1> $matricule </h1>";
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

</body>
</html>
