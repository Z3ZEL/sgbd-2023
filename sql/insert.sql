-- Truncate tables from base and restart identity
TRUNCATE personnes, adresses, garages, tarifs, voitures, compositions, modeles_voitures, requetes, pieces, types_pieces, actions_survenues, actions_contenues, actions, devis, factures, interventions RESTART IDENTITY CASCADE;

-- Import data for the table adresses
\copy adresses(numero_adresse, numero_habitation, nom_voie, code_postal, pays) FROM './data/adresses.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table personnes
\copy personnes(numero_securite_sociale, numero_adresse, nom_personne, prenom_personne, mail_personne, telephone_personne) FROM './data/personnes.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table garages
\copy garages(numero_SIREN, numero_adresse, denomination_garage, forme_juridique_garage, date_creation_garage) FROM './data/garages.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table modeles_voiture
\copy modeles_voitures(numero_modele, type_modele, marque_modele, version_modele, annee_modele) FROM './data/modeles_voitures.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table voitures
\copy voitures(matricule_voiture, numero_modele, numero_client, puissance_fiscale_voiture, cylindree_voiture, couleur_voiture, annee_circulation_voiture) FROM './data/voitures.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table types_pieces
\copy types_pieces(numero_type_piece, nom_type_piece) FROM './data/types_pieces.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table pieces
\copy pieces(numero_serie_piece, numero_type_piece, prix_piece, marque_piece) FROM './data/pieces.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table composition
\copy compositions(numero_serie_piece, numero_modele) FROM './data/compositions.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions
\copy actions(numero_action, nom_action, duree_estime_action, tarif_action) FROM './data/actions.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table tarif
\copy tarifs(numero_action, numero_modele, montant) FROM './data/tarifs.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table requete
\copy requetes(numero_action, numero_type_piece, quantite) FROM './data/requetes.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table interventions
\copy interventions(numero_intervention, matricule_voiture, numero_SIREN, date_debut_intervention, date_fin_intervention, kilometrage, effectuee) FROM './data/interventions.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions_contenues
\copy actions_contenues(numero_action, numero_intervention) FROM './data/actions_contenues.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions_survenues
\copy actions_survenues(numero_action, numero_intervention) FROM './data/actions_survenues.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table devis
\copy devis(numero_devis, numero_intervention, date_devis, montant_devis) FROM './data/devis.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table factures
\copy factures(numero_facture, numero_intervention, date_facture, montant_facture) FROM './data/factures.csv' DELIMITER ',' CSV HEADER;

-- Insert data for the table interventions
SELECT setval('interventions_numero_intervention_seq', (SELECT max(numero_intervention) FROM interventions i));

