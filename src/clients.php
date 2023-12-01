<!DOCTYPE html>
<html>


<head>
    <title>Client visualisation</title>
    <link rel="stylesheet" href="css/clients.css">

</head>
<body>
    <script> 
        function openClientInfoList(){
            window.location.href = "table_view.php?table=client_informations_view";
        }
    </script>
    <?php include 'auth.php'; ?>
    <?php include 'navbar.php'; ?>

    <?php
        $request = "SELECT p.numero_securite_sociale id_client, p.nom_personne nom, p.prenom_personne prenom FROM personnes p";
        $stmt = $pdo->query($request);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    <div class="client-panel">
    <div class="client-selection">
        <h1>Selectionner un client</h1>
        <form>
            <select name="client" id="client">
                <?php foreach ($data as $row): ?>
                    <option value="<?= $row['id_client'] ?>"><?= $row['nom'] ?> <?= $row['prenom'] ?></option>
                <?php endforeach; ?>
            </select>
            <input type="submit" value="Valider">

        </form>

        <button onclick="openClientInfoList()" style="margin-top : 2%;" >Liste des clients</button>
    </div>

    <div class="client-information">
        <?php 
        $client_id = $_GET['client'] ?? NULL;
        
        $client_nom = $data[$client_id-1]['nom'] ?? NULL;
        $client_prenom = $data[$client_id-1]['prenom'] ?? NULL;
    
        $client_data = "SELECT * FROM get_client_informations($client_id)";
        $stmt = $pdo->query($client_data);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $client_voitures = "SELECT * FROM get_voiture_by_num_client($client_id)";
        $stmt = $pdo->query($client_voitures);
        $voitures = $stmt->fetchAll(PDO::FETCH_ASSOC);

        ?>


        <?php if($client_id != NULL){
            echo "<h1> $client_nom $client_prenom</h1>";
            
            //create a list of information

            echo "<ul>";
            foreach($data[0] as $key => $value){
                echo "<li>$key : $value</li>";
            }
            
            echo "<li>voitures : <ul>";
                
                foreach($voitures as $voiture){
                    echo "<li><a href = 'voiture.php?matricule=$voiture[matricule_voiture]  '>$voiture[matricule_voiture]</a></li>";
                }
            echo "</li></ul>";
                
            echo "</ul>";
        }
        ?>

    </div>
    </div>

    
</body>
</html>
