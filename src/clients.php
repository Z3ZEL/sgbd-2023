<!DOCTYPE html>
<html>

<head>
    <title>Client visualisation</title>
    <link rel="stylesheet" href="css/clients.css">
</head>

<body>
    <script>
        function openClientInfoList() {
            window.location.href = "table_view.php?table=client_informations_view&submitable=false";
        }
    </script>
    <?php include 'auth.php'; ?>
    <?php include 'navbar.php'; ?>

    <?php
    $request = "SELECT client_id, nom, prenom 
                FROM client_informations_view
                ORDER BY client_id";

    $stmt = $pdo->query($request);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    
    <div class="client-panel">
        <div class="client-selection">
            <h1>Selectionner un client</h1>
            <form>
                <select name="client" id="client">
                    <?php foreach ($data as $row): ?>
                        <option value="<?= $row['client_id'] ?>" data-id="<?= $row['client_id'] ?>" <?php if ($row['client_id'] == $_GET['client']) echo "selected"; ?>>
                            <?= $row['client_id'] ?> - <?= $row['nom'] ?> <?= $row['prenom'] ?>
                        </option>
                    <?php endforeach; ?>
                </select>

                <input type="submit" value="Valider">
            </form>

            <button onclick="openClientInfoList()" style="margin-top: 2%;">Liste des clients</button>
        </div>

        <?php 
            $edit = (bool)$_GET['edit'] ?? false;

            $id_client = (int)$_GET['client'] ?? NULL; 


            if ($id_client != NULL) {
                $client_data = "SELECT * FROM client_informations_view WHERE client_id = $id_client";
                $stmt = $pdo->query($client_data);
                $data = $stmt->fetch(PDO::FETCH_ASSOC);
            }

            $client_nom = $data['nom'] ?? NULL;
            $client_prenom = $data['prenom'] ?? NULL;
        ?>

        <div class="client-information">


            <?php if ($id_client != NULL && $edit==false) {

                $client_voitures = "SELECT * FROM get_voiture_by_num_client($id_client)";
                $stmt = $pdo->query($client_voitures);
                $voitures = $stmt->fetchAll(PDO::FETCH_ASSOC);


                echo "<h1> $client_nom $client_prenom</h1>";

                //create a list of information

                echo "<ul>";
                foreach ($data as $key => $value) {
                    echo "<li>$key : $value</li>";
                }

                echo "<li>voitures : <ul>";

                foreach ($voitures as $voiture) {
                    echo "<li><a href='voiture.php?matricule=$voiture[matricule_voiture]'>$voiture[matricule_voiture]</a></li>";
                }
                echo "</li></ul>";

                echo "</ul>";

                //a submit button which add the edit=true GET parameter to the same current url
                echo "<form action='clients.php' method='get'>";
                echo "<input type='hidden' name='client' value='$id_client'>";
                echo "<input type='hidden' name='edit' value='true'>";
                echo "<input type='submit' value='Editer'>";
                echo "</form>";

            } 
            
            elseif ($id_client != NULL && $edit==true) {
                echo "<h1> $client_nom $client_prenom</h1>";

                //create an editable form
                echo "<form action='edit_client.php?client=$id_client' method='post'>";
                /*  number of keys that can be edited 
                    (for instance, the number of factures 
                    shouldn't be edited) */
                $lengthSub = 4;
                $startSub= 0;

                echo "<ul>";
                //hidden input to send the nSubmitableKeys value
                foreach ($data as $key => $value) {
                    if ($lengthSub > 0 && $startSub < 0) {
                        if (is_numeric($value)) {
                            echo "<li>$key : <input type='text' name='$key' value='$value'></li>";
                        } elseif (is_bool($value)) {
                            echo "<li>$key : <input type='checkbox' name='$key' value='$value'></li>";
                        } else {
                            echo "<li>$key : <input type='text' name='$key' value='$value'></li>";
                        }
                        $lengthSub--;
                    } else {
                        $startSub--;
                        echo "<li>$key : $value</li>";
                    }
                }

                echo "</ul>";

                echo "<input type='submit' value='Valider'>";
                echo "</form>";
            }
            ?>

            


</body>

</html>

