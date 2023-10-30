-- Truncate tables and restart identity
TRUNCATE employe, garage, intervention, devis, facture, survenir, contenir, action, requerir, piece, composition, modele_voiture, voiture, client, adresse RESTART IDENTITY CASCADE;

-- Import des données pour la table adresse
\COPY adresse(numero_adresse, numero_habitation, nom_voie, code_postal, pays) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/adresse.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table client
\COPY client(numero_client, nom_client, prenom_client, mail_client, telephone_client, numero_adresse) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/client.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table garage
\COPY garage(numero_SIREN, denomination_garage, forme_juridique_garage, date_creation_garage, numero_adresse) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/garage.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table modele_voiture
\COPY modele_voiture(numero_modele, type_modele, marque_modele, version_modele, annee_modele) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/modele_voiture.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table voiture
\COPY voiture(matricule_voiture, puissance_fiscale_voiture, cylindree_voiture, couleur_voiture, annee_circulation_voiture, numero_modele, numero_client) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/voiture.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table composition
\COPY composition(numero_modele, numero_serie_piece) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/composition.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table piece
\COPY piece(numero_serie_piece, type_piece, prix_piece, marque_piece) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/piece.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table action
\COPY action(numero_action, nom_action, duree_estime_action, tarif_action) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/action.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table requerir
\COPY requerir(numero_action, numero_serie_piece, quantite) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/requerir.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table intervention
\COPY intervention(numero_intervention, date_debut_intervention, date_fin_intervention, kilometrage, matricule_voiture, numero_SIREN) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/intervention.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table contenir
\COPY contenir(numero_action, numero_intervention) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/contenir.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table survenir
\COPY survenir(numero_action, numero_intervention) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/survenir.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table facture
\COPY facture(numero_facture, date_facture, montant_facture, numero_intervention) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/facture.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table devis
\COPY devis(numero_devis, date_devis, montant_devis, numero_intervention) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/devis.csv' DELIMITER ',' CSV HEADER;

-- Import des données pour la table employe
\COPY employe(numero_securite_sociale, nom_employe, prenom_employe, date_embauche_employe, salaire_horaire_employe, numero_SIREN, numero_adresse) FROM '/home/come/enseirb/sgbd/projet/sgbd-2023/data/employe.csv' DELIMITER ',' CSV HEADER;
