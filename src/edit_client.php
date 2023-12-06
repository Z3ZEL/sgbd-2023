<?php

include 'auth.php';

$client = (int)$_GET['client'] ?? NULL;
$nom = $_POST['nom'] ?? NULL;
$prenom = $_POST['prenom'] ?? NULL;
$mail = $_POST['mail'] ?? NULL;
$telephone = $_POST['telephone'] ?? NULL;

//execute the sql function update_personne, giving it the parameters in the same order above
$stmt = $pdo->prepare("SELECT update_personne(:client, :nom, :prenom, :mail, :telephone)");
$stmt->execute(['client' => $client, 'nom' => $nom, 'prenom' => $prenom, 'mail' => $mail, 'telephone' => $telephone]);

//goes back on clients.php?client=$client
header("Location: clients.php?client=$client");

?>