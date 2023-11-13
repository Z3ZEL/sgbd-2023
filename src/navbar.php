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
            <a href="table_view.php?table=action">Actions</a>
            <a href="table_view.php?table=requerir">Pièces requises</a>
            <a href="table_view.php?table=adresse">Adresses</a>
            <a href="table_view.php?table=client">Clients</a>
            <a href="table_view.php?table=devis">Devis</a>
            <a href="table_view.php?table=employe">Employés</a>
            <a href="table_view.php?table=facture">Factures</a>
            <a href="table_view.php?table=garage">Garages</a>
            <a href="table_view.php?table=intervention">Interventions</a>
            <a href="table_view.php?table=contenir">Action prévues</a>
            <a href="table_view.php?table=survenir">Actions survenues</a>
            <a href="table_view.php?table=modele_voiture">Modèles de voitures</a>
            <a href="table_view.php?table=type_piece">Types de pièce</a> 
            <a href="table_view.php?table=composition">Compositions</a>           
            <a href="table_view.php?table=piece">Pièces</a>
            <a href="table_view.php?table=voiture">Voitures</a>
        </div>
    </div>

    <!-- Bouton "Accueil" au centre -->
    <a href="index.php" class="central-button">Accueil</a>

    <a href="clients.php" class="central-button">Clients</a>

    <!-- Bouton "Recherche" à droite du bouton "Accueil" -->
    <a href="recherche.php" class="central-button">Recherche</a>
</div>
</html>
