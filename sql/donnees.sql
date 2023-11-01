-- Truncate tables and restart identity
TRUNCATE employe, garage, intervention, devis, facture, survenir, contenir, action, requerir, type_piece, piece, composition, modele_voiture, voiture, client, adresse RESTART IDENTITY CASCADE;

-- Import des données pour la table adresse
\copy adresse(numero_adresse, numero_habitation, nom_voie, code_postal, pays) FROM './data/adresse.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table client
\copy client(numero_client, nom_client, prenom_client, mail_client, telephone_client, numero_adresse) FROM './data/client.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table garage
\copy garage(numero_SIREN, denomination_garage, forme_juridique_garage, date_creation_garage, numero_adresse) FROM './data/garage.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table piece
\copy type_piece(numero_type_piece, nom_type_piece) FROM './data/type_piece.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table piece
\copy piece(numero_serie_piece, prix_piece, marque_piece, numero_type_piece) FROM './data/piece.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table modele_voiture
\copy modele_voiture(numero_modele, type_modele, marque_modele, version_modele, annee_modele) FROM './data/modele_voiture.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table voiture
\copy voiture(matricule_voiture, puissance_fiscale_voiture, cylindree_voiture, couleur_voiture, annee_circulation_voiture, numero_modele, numero_client) FROM './data/voiture.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table composition
\copy composition(numero_modele, numero_serie_piece) FROM './data/composition.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table action
\copy action(numero_action, nom_action, duree_estime_action, tarif_action) FROM './data/action.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table requerir
\copy requerir(numero_action, numero_serie_piece, quantite) FROM './data/requerir.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table intervention
\copy intervention(numero_intervention, date_debut_intervention, date_fin_intervention, kilometrage, matricule_voiture, numero_SIREN) FROM './data/intervention.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table contenir
\copy contenir(numero_action, numero_intervention) FROM './data/contenir.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table survenir
\copy survenir(numero_action, numero_intervention) FROM './data/survenir.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table facture
\copy facture(numero_facture, date_facture, montant_facture, numero_intervention) FROM './data/facture.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table devis
\copy devis(numero_devis, date_devis, montant_devis, numero_intervention) FROM './data/devis.csv' DELIMITER ',' CSV HEADER

-- Import des données pour la table employe
\copy employe(numero_securite_sociale, nom_employe, prenom_employe, date_embauche_employe, salaire_horaire_employe, numero_SIREN, numero_adresse) FROM './data/employe.csv' DELIMITER ',' CSV HEADER
