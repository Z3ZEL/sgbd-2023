<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche - Gestion des garages</title>
    <link rel="stylesheet" href="css/search_page.css">
</head>
<body>
    <?php include 'navbar.php'; ?>

    <div class="search-container"> <!-- sera remplacer par du php -->
        <h2>Je cherche :</h2>
        <form action="resultats.php" method="post">

        <fieldset>
            <legend>Adresses</legend>
            <input type="checkbox" id="numero_adresse" name="adresses[]" value="numero_adresse">
            <label for="numero_adresse">Numéro d'adresse</label><br>

            <input type="checkbox" id="numero_habitation" name="adresses[]" value="numero_habitation">
            <label for="numero_habitation">Numéro d'habitation</label><br>

            <input type="checkbox" id="nom_voie" name="adresses[]" value="nom_voie">
            <label for="nom_voie">Nom de la voie</label><br>

            <input type="checkbox" id="code_postal" name="adresses[]" value="code_postal">
            <label for="code_postal">Code Postal</label><br>

            <input type="checkbox" id="pays" name="adresses[]" value="pays">
            <label for="pays">Pays</label><br>
        </fieldset>

        <fieldset>
            <legend>Clients</legend>
            <input type="checkbox" id="numero_client" name="clients[]" value="numero_client">
            <label for="numero_client">Numéro de client</label><br>

            <input type="checkbox" id="numero_adresse_client" name="clients[]" value="numero_adresse">
            <label for="numero_adresse_client">Numéro d'adresse du client</label><br>

            <input type="checkbox" id="nom_client" name="clients[]" value="nom_client">
            <label for="nom_client">Nom du client</label><br>

            <input type="checkbox" id="prenom_client" name="clients[]" value="prenom_client">
            <label for="prenom_client">Prénom du client</label><br>

            <input type="checkbox" id="mail_client" name="clients[]" value="mail_client">
            <label for="mail_client">Mail du client</label><br>

            <input type="checkbox" id="telephone_client" name="clients[]" value="telephone_client">
            <label for="telephone_client">Téléphone du client</label><br>
        </fieldset>

        <input type="submit" value="Rechercher">
        </form>
    </div>
</body>
</html>