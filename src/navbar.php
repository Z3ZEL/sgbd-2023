<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/navbar.css">
</head>

<div class="navbar">
    <!-- Menu déroulant "Parcourir" à gauche -->
    <div class="dropdown">
        <button class="dropbtn">Parcourir</button>
        <div class="dropdown-content">
            <a href="table_view.php?table=actions">Actions</a>
            <a href="table_view.php?table=requetes">Pièces requises</a>
            <a href="table_view.php?table=adresses">Adresses</a>
            <a href="table_view.php?table=clients">Clients</a>
            <a href="table_view.php?table=devis">Devis</a>
            <a href="table_view.php?table=factures">Factures</a>
            <a href="table_view.php?table=garages">Garages</a>
            <a href="table_view.php?table=interventions">Interventions</a>
            <a href="table_view.php?table=actions_contenues">Action prévues</a>
            <a href="table_view.php?table=actions_survenues">Actions survenues</a>
            <a href="table_view.php?table=modeles_voitures">Modèles de voitures</a>
            <a href="table_view.php?table=types_pieces">Types de pièce</a> 
            <a href="table_view.php?table=compositions">Compositions</a>           
            <a href="table_view.php?table=pieces">Pièces</a>
            <a href="table_view.php?table=voitures">Voitures</a>
            <a href="table_view.php?table=tarifs">Tarifs</a>
            <a href="table_view.php?table=requetes">Requetes</a>            

        </div>
    </div>

    <!-- Bouton "Accueil" au centre -->
    <a href="index.php" class="central-button">Accueil</a>

    <a href="clients.php" class="central-button">Clients</a>

    <!-- Bouton "Recherche" à droite du bouton "Accueil" -->
    <a href="recherche.php" class="central-button">Recherche</a>
</div>
</html>
