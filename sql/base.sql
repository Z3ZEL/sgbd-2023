-- ============================================================
--   Nom de la base   :  GARAGES                                
--   Nom de SGBD      :  PostgreSQL                   
--   Date de creation :  30/10/2023                       
-- ============================================================

--DROP table CASCADE for each table above
DROP TABLE IF EXISTS interventions CASCADE;
DROP TABLE IF EXISTS factures CASCADE;
DROP TABLE IF EXISTS devis CASCADE;
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS actions_contenues CASCADE;
DROP TABLE IF EXISTS actions_survenues CASCADE;
DROP TABLE IF EXISTS types_pieces CASCADE;
DROP TABLE IF EXISTS pieces CASCADE;
DROP TABLE IF EXISTS requete CASCADE;
DROP TABLE IF EXISTS modeles_voiture CASCADE;
DROP TABLE IF EXISTS composition CASCADE;
DROP TABLE IF EXISTS voitures CASCADE;
DROP TABLE IF EXISTS adresses CASCADE;
DROP TABLE IF EXISTS personnes CASCADE;
DROP TABLE IF EXISTS garages CASCADE;
DROP TABLE IF EXISTS tarif CASCADE;

--CREATE TABLES

--Table interventions
CREATE TABLE interventions (
    numero_intervention INTEGER NOT NULL,
    matricule_voiture VARCHAR(10) NOT NULL,
    numero_SIREN INTEGER NOT NULL,
    date_debut_intervention DATE NOT NULL,
    date_fin_intervention DATE NOT NULL,
    kilometrage INTEGER NOT NULL,
    effectuee BOOLEAN NOT NULL,
    PRIMARY KEY (numero_intervention)
);

--Table factures
CREATE TABLE factures (
    numero_facture INTEGER NOT NULL,
    numero_intervention INTEGER NOT NULL,
    date_facture DATE NOT NULL,
    montant_facture INTEGER NOT NULL,
    PRIMARY KEY (numero_facture)
);

--Table devis
CREATE TABLE devis (
    numero_devis INTEGER NOT NULL,
    numero_intervention INTEGER NOT NULL,
    date_devis DATE NOT NULL,
    montant_devis INTEGER NOT NULL,
    PRIMARY KEY (numero_devis)
);

--Table actions
CREATE TABLE actions (
    numero_action INTEGER NOT NULL,
    nom_action VARCHAR(50) NOT NULL,
    duree_estime_action INTEGER NOT NULL,
    tarif_action INTEGER NOT NULL,
    PRIMARY KEY (numero_action)
);

--Table actions_contenues
CREATE TABLE actions_contenues (
    numero_action INTEGER NOT NULL,
    numero_intervention INTEGER NOT NULL,
    PRIMARY KEY (numero_action, numero_intervention)
);

--Table actions_survenues
CREATE TABLE actions_survenues (
    numero_action INTEGER NOT NULL,
    numero_intervention INTEGER NOT NULL,
    PRIMARY KEY (numero_action, numero_intervention)
);

--Table types_pieces
CREATE TABLE types_pieces (
    numero_type_piece INTEGER NOT NULL,
    nom_type_piece VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero_type_piece)
);

--Table pieces
CREATE TABLE pieces (
    numero_serie_piece INTEGER NOT NULL,
    numero_type_piece INTEGER NOT NULL,
    prix_piece INTEGER NOT NULL,
    marque_piece VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero_serie_piece)
);

--Table requete
CREATE TABLE requete (
    numero_action INTEGER NOT NULL,
    numero_type_piece INTEGER NOT NULL,
    quantite INTEGER NOT NULL,
    PRIMARY KEY (numero_action, numero_type_piece)
);

--Table modeles_voiture
CREATE TABLE modeles_voiture (
    numero_modele INTEGER NOT NULL,
    type_modele VARCHAR(50) NOT NULL,
    marque_modele VARCHAR(50) NOT NULL,
    version_modele VARCHAR(50) NOT NULL,
    annee_modele INTEGER NOT NULL,
    PRIMARY KEY (numero_modele)
);

--Table composition
CREATE TABLE composition (
    numero_serie_piece INTEGER NOT NULL,
    numero_modele INTEGER NOT NULL,
    PRIMARY KEY (numero_serie_piece, numero_modele)
);

--Table voitures
CREATE TABLE voitures (
    matricule_voiture VARCHAR(10) NOT NULL,
    numero_modele INTEGER NOT NULL,
    numero_client INTEGER NOT NULL,
    puissance_fiscale_voiture INTEGER NOT NULL,
    cylindree_voiture INTEGER NOT NULL,
    couleur_voiture VARCHAR(50) NOT NULL,
    annee_circulation_voiture INTEGER NOT NULL,
    PRIMARY KEY (matricule_voiture)
);

--Table adresses
CREATE TABLE adresses (
    numero_adresse INTEGER NOT NULL,
    numero_habitation INTEGER NOT NULL,
    nom_voie VARCHAR(50) NOT NULL,
    code_postal INTEGER NOT NULL,
    pays VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero_adresse)
);

--Table personnes
CREATE TABLE personnes (
    numero_securite_sociale INTEGER NOT NULL,
    numero_adresse INTEGER NOT NULL,
    nom_personne VARCHAR(50) NOT NULL,
    prenom_personne VARCHAR(50) NOT NULL,
    mail_personne VARCHAR(50) NOT NULL,
    telephone_personne INTEGER NOT NULL,
    PRIMARY KEY (numero_securite_sociale)
);

--Table garages
CREATE TABLE garages (
    numero_SIREN INTEGER NOT NULL,
    numero_adresse INTEGER NOT NULL,
    denomination_garage VARCHAR(50) NOT NULL,
    forme_juridique_garage VARCHAR(50) NOT NULL,
    date_creation_garage DATE NOT NULL,
    PRIMARY KEY (numero_SIREN)
);

--Table tarif
CREATE TABLE tarif (
    numero_action INTEGER NOT NULL,
    numero_modele INTEGER NOT NULL,
    montant INTEGER NOT NULL,
    PRIMARY KEY (numero_action, numero_modele)
);

--FOREIGN KEYS

--Table interventions
ALTER TABLE interventions ADD CONSTRAINT fk_interventions_voitures FOREIGN KEY (matricule_voiture) REFERENCES voitures(matricule_voiture);
ALTER TABLE interventions ADD CONSTRAINT fk_interventions_garages FOREIGN KEY (numero_SIREN) REFERENCES garages(numero_SIREN);

--Table factures
ALTER TABLE factures ADD CONSTRAINT fk_factures_interventions FOREIGN KEY (numero_intervention) REFERENCES interventions(numero_intervention);

--Table devis
ALTER TABLE devis ADD CONSTRAINT fk_devis_interventions FOREIGN KEY (numero_intervention) REFERENCES interventions(numero_intervention);

--Table actions_contenues
ALTER TABLE actions_contenues ADD CONSTRAINT fk_actions_contenues_interventions FOREIGN KEY (numero_intervention) REFERENCES interventions(numero_intervention);
ALTER TABLE actions_contenues ADD CONSTRAINT fk_actions_contenues_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);

--Table actions_survenues
ALTER TABLE actions_survenues ADD CONSTRAINT fk_actions_survenues_interventions FOREIGN KEY (numero_intervention) REFERENCES interventions(numero_intervention);
ALTER TABLE actions_survenues ADD CONSTRAINT fk_actions_survenues_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);

--Table pieces
ALTER TABLE pieces ADD CONSTRAINT fk_pieces_types_pieces FOREIGN KEY (numero_type_piece) REFERENCES types_pieces(numero_type_piece);

--Table requete
ALTER TABLE requete ADD CONSTRAINT fk_requete_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);
ALTER TABLE requete ADD CONSTRAINT fk_requete_types_pieces FOREIGN KEY (numero_type_piece) REFERENCES types_pieces(numero_type_piece);

--Table composition
ALTER TABLE composition ADD CONSTRAINT fk_composition_pieces FOREIGN KEY (numero_serie_piece) REFERENCES pieces(numero_serie_piece);
ALTER TABLE composition ADD CONSTRAINT fk_composition_modeles_voiture FOREIGN KEY (numero_modele) REFERENCES modeles_voiture(numero_modele);

--Table voitures
ALTER TABLE voitures ADD CONSTRAINT fk_voitures_modeles_voiture FOREIGN KEY (numero_modele) REFERENCES modeles_voiture(numero_modele);
ALTER TABLE voitures ADD CONSTRAINT fk_voitures_personnes FOREIGN KEY (numero_client) REFERENCES personnes(numero_securite_sociale);

--Table personnes
ALTER TABLE personnes ADD CONSTRAINT fk_personnes_adresses FOREIGN KEY (numero_adresse) REFERENCES adresses(numero_adresse);

--Table garages
ALTER TABLE garages ADD CONSTRAINT fk_garages_adresses FOREIGN KEY (numero_adresse) REFERENCES adresses(numero_adresse);

--Table tarif
ALTER TABLE tarif ADD CONSTRAINT fk_tarif_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);
ALTER TABLE tarif ADD CONSTRAINT fk_tarif_modeles_voiture FOREIGN KEY (numero_modele) REFERENCES modeles_voiture(numero_modele);
