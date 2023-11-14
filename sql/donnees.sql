-- Truncate tables from base and restart identity
TRUNCATE personnes, adresses, garages, tarif, voitures, composition, modeles_voiture, requete, pieces, types_pieces, actions_survenues, actions_contenues, actions, devis, factures, interventions RESTART IDENTITY CASCADE;

-- Import data for the table personnes
\copy personnes(numero_securite_sociale, numero_adresse, nom_personne, prenom_personne, mail_personne, telephone_personne) FROM './data/personne.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table adresses
\copy adresses(numero_adresse, numero_habitation, nom_voie, code_postal, pays) FROM './data/adresse.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table garages
\copy garages(numero_SIREN, numero_adresse, denomination_garage, forme_juridique_garage, date_creation_garage) FROM './data/garage.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table modeles_voiture
\copy modeles_voiture(numero_modele, type_modele, marque_modele, version_modele, annee_modele) FROM './data/modele_voiture.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table voitures
\copy voitures(matricule_voiture, numero_modele, numero_client, puissance_fiscale_voiture, cylindree_voiture, couleur_voiture, annee_circulation_voiture) FROM './data/voiture.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table composition
\copy composition(numero_serie_piece, numero_modele) FROM './data/composition.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table tarif
\copy tarif(numero_action, numero_modele, montant) FROM './data/tarif.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table types_pieces
\copy types_pieces(numero_type_piece, nom_type) FROM './data/type_piece.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table pieces
\copy pieces(numero_serie_piece, numero_type_piece, prix_piece, marque_piece) FROM './data/piece.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table requete
\copy requete(numero_action, numero_type_piece, quantite) FROM './data/requete.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions
\copy actions(numero_action, nom_action, duree_estime_action, tarif_action) FROM './data/action.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions_contenues
\copy actions_contenues(numero_action, numero_intervention) FROM './data/action_contenue.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table actions_survenues
\copy actions_survenues(numero_action, numero_intervention) FROM './data/action_survenue.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table devis
\copy devis(numero_devis, numero_intervention, date_devis, montant_devis) FROM './data/devis.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table factures
\copy factures(numero_facture, numero_intervention, date_facture, montant_facture) FROM './data/facture.csv' DELIMITER ',' CSV HEADER;

-- Import data for the table interventions
\copy interventions(numero_intervention, matricule_voiture, numero_SIREN, date_debut_intervention, date_fin_intervention, kilometrage, effectuee) FROM './data/intervention.csv' DELIMITER ',' CSV HEADER;
