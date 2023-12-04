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
                        <option value="<?= $row['id_client'] ?>" data-id="<?= $row['id_client'] ?>">
                            <?= $row['id_client'] ?> - <?= $row['nom'] ?> <?= $row['prenom'] ?>
                        </option>
                    <?php endforeach; ?>
                </select>

                <input type="submit" value="Valider">
            </form>

            <button onclick="openClientInfoList()" style="margin-top: 2%;">Liste des clients</button>
        </div>

        <?php $edit = $_GET['edit'] ?? false; ?>

        <div class="client-information">
            <?php
            $client_id = $_GET['client'] ?? NULL;

            $client_nom = $data[$client_id - 1]['nom'] ?? NULL;
            $client_prenom = $data[$client_id - 1]['prenom'] ?? NULL;

            $client_data = "SELECT * FROM get_client_informations($client_id)";
            $stmt = $pdo->query($client_data);
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            $client_voitures = "SELECT * FROM get_voiture_by_num_client($client_id)";
            $stmt = $pdo->query($client_voitures);
            $voitures = $stmt->fetchAll(PDO::FETCH_ASSOC);
            ?>


            <?php if ($client_id != NULL && $edit==false) {
                echo "<h1> $client_nom $client_prenom</h1>";

                //create a list of information

                echo "<ul>";
                foreach ($data[0] as $key => $value) {
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
                echo "<input type='hidden' name='client' value='$client_id'>";
                echo "<input type='hidden' name='edit' value='true'>";
                echo "<input type='submit' value='Editer'>";
                echo "</form>";

            } 
            
            elseif ($client_id != NULL && $edit==true) {
                echo "<h1> $client_nom $client_prenom</h1>";

                //create an editable form
                echo "<form action='edit_client.php' method='post'>";
                echo "<input type='hidden' name='client' value='$client_id'>";

                /*  number of keys that can be edited 
                    (for instance, the number of factures 
                    shouldn't be edited) */
                $nSubmitableKeys = 4;

                echo "<ul>";
                //hidden input to send the nSubmitableKeys value
                echo "<input type='hidden' name='nSubmitableKeys' value='$nSubmitableKeys'>";
                foreach ($data[0] as $key => $value) {
                    if ($nSubmitableKeys > 0) {
                        echo "<li>$key : <input type='text' name='$key' value='$value'></li>";
                        $nSubmitableKeys--;
                    } else {
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

