-- ============================================================
--   Nom de la base   :  GARAGES                                
--   Nom de SGBD      :  PostgreSQL                   
--   Date de creation :  30/10/2023                       
-- ============================================================

DROP TABLE adresse;
DROP TABLE client;
DROP TABLE voiture;
DROP TABLE modele_voiture;
DROP TABLE composition;
DROP TABLE piece;
DROP TABLE requerir;
DROP TABLE action;
DROP TABLE contenir;
DROP TABLE survenir;
DROP TABLE facture;
DROP TABLE devis;
DROP TABLE intervention;
DROP TABLE garage;
DROP TABLE employe;

-- ============================================================
--   Table : ADRESSE                                          
-- ============================================================

CREATE TABLE adresse
(
    numero_adresse                  SERIAL                 NOT NULL,
    numero_habitation               INTEGER                        ,
    nom_voie                        VARCHAR(40)                    ,
    code_postal                     VARCHAR(10)                    ,
    pays                            VARCHAR(20)                    ,
    CONSTRAINT pk_adresse PRIMARY KEY (numero_adresse)
);

-- ============================================================
--   Table : CLIENT                                          
-- ============================================================

CREATE TABLE client
(
    numero_client                   SERIAL                  NOT NULL,
    nom_client                      VARCHAR(20)                     ,
    prenom_client                   VARCHAR(20)                     ,
    mail_client                     VARCHAR(40)                     ,
    telephone_client                VARCHAR(20)                     ,
    numero_adresse                  INTEGER                         ,
    CONSTRAINT pk_client PRIMARY KEY (numero_client)
);

-- ============================================================
--   Table : VOITURE                                          
-- ============================================================

CREATE TABLE voiture
(
    matricule_voiture               VARCHAR(10)             NOT NULL,
    puissance_fiscale_voiture       INTEGER                         ,
    cylindree_voiture               INTEGER                         ,
    couleur_voiture                 VARCHAR(20)                     ,
    annee_circulation_voiture       INTEGER                         ,
    numero_modele                   INTEGER                         ,
    numero_client                   INTEGER                         ,
    CONSTRAINT pk_voiture PRIMARY KEY (matricule_voiture)
);

-- ============================================================
--   Table : MODELE_VOITURE                                  
-- ============================================================

CREATE TABLE modele_voiture
(
    numero_modele                   SERIAL                  NOT NULL,
    type_modele                     VARCHAR(40)                     ,
    marque_modele                   VARCHAR(20)                     ,
    version_modele                  VARCHAR(40)                     ,
    annee_modele                    INTEGER                         ,
    CONSTRAINT pk_modele_voiture PRIMARY KEY (numero_modele)
);

-- ============================================================
--   Table : COMPOSITION                                    
-- ============================================================

CREATE TABLE composition
(
    numero_modele                   INTEGER                  NOT NULL,
    numero_serie_piece              INTEGER                  NOT NULL,
    CONSTRAINT pk_composition PRIMARY KEY (numero_modele, numero_serie_piece)
);

-- ============================================================
--   Table : piece                                        
-- ============================================================

CREATE TABLE piece
(
    numero_serie_piece              SERIAL                   NOT NULL,
    type_piece                      VARCHAR(40)                      ,
    prix_piece                      FLOAT                            ,
    marque_piece                    VARCHAR(20)                      ,
    CONSTRAINT pk_piece PRIMARY KEY (numero_serie_piece)
);

-- ============================================================
--   Table : REQUERIR                                      
-- ============================================================

CREATE TABLE requerir
(
    numero_action                   INTEGER                  NOT NULL,
    numero_serie_piece              INTEGER                  NOT NULL,
    quantite                        INTEGER                          ,
    CONSTRAINT pk_requerir PRIMARY KEY (numero_action, numero_serie_piece)
);

-- ============================================================
--   Table : ACTION                                       
-- ============================================================

CREATE TABLE action
(
    numero_action                   SERIAL                   NOT NULL,
    nom_action                      TEXT                             ,
    duree_estime_action             FLOAT                            ,
    tarif_action                    INTEGER                          ,
    CONSTRAINT pk_action PRIMARY KEY (numero_action)
);

-- ============================================================
--   Table : CONTENIR                                      
-- ============================================================

CREATE TABLE contenir
(
    numero_action                   INTEGER                  NOT NULL,
    numero_intervention             INTEGER                  NOT NULL,
    CONSTRAINT pk_contenir PRIMARY KEY (numero_action, numero_intervention)
);

-- ============================================================
--   Table : SURVENIR                                      
-- ============================================================

CREATE TABLE survenir
(
    numero_action                   INTEGER                  NOT NULL,
    numero_intervention             INTEGER                  NOT NULL,
    CONSTRAINT pk_survenir PRIMARY KEY (numero_action, numero_intervention)
);

-- ============================================================
--   Table : FACTURE                                       
-- ============================================================

CREATE TABLE facture
(
    numero_facture                  SERIAL                   NOT NULL,
    date_facture                    DATE                             ,
    montant_facture                 FLOAT                            ,
    numero_intervention             INTEGER                          ,
    CONSTRAINT pk_facture PRIMARY KEY (numero_facture)
);

-- ============================================================
--   Table : DEVIS                                         
-- ============================================================

CREATE TABLE devis
(
    numero_devis                    SERIAL                   NOT NULL,
    date_devis                      DATE                             ,
    montant_devis                   FLOAT                            ,
    numero_intervention             INTEGER                          ,
    CONSTRAINT pk_devis PRIMARY KEY (numero_devis)
);

-- ============================================================
--   Table : INTERVENTION                                  
-- ============================================================

CREATE TABLE intervention
(
    numero_intervention             SERIAL                   NOT NULL,
    date_debut_intervention         DATE                             ,
    date_fin_intervention           DATE                             ,
    kilometrage                     INTEGER                          ,
    matricule_voiture               VARCHAR(10)                          ,
    numero_SIREN                    INTEGER                          ,
    CONSTRAINT pk_intervention PRIMARY KEY (numero_intervention)
);

-- ============================================================
--   Table : GARAGE                                        
-- ============================================================

CREATE TABLE garage
(
    numero_SIREN                    SERIAL                   NOT NULL,
    denomination_garage             VARCHAR(40)                      ,
    forme_juridique_garage          VARCHAR(20)                      ,
    date_creation_garage            DATE                             ,
    numero_adresse                  INTEGER                          ,
    CONSTRAINT pk_garage PRIMARY KEY (numero_SIREN)
);

-- ============================================================
--   Table : EMPLOYE                                       
-- ============================================================

CREATE TABLE employe
(
    numero_securite_sociale         VARCHAR(20)                   NOT NULL,
    nom_employe                     VARCHAR(20)                      ,
    prenom_employe                  VARCHAR(20)                      ,
    date_embauche_employe           DATE                             ,
    salaire_horaire_employe         FLOAT                          ,
    numero_SIREN                    INTEGER                          ,
    numero_adresse                  INTEGER                          ,
    CONSTRAINT pk_employe PRIMARY KEY (numero_securite_sociale)
);

-- FOREIGN KEYS
-- ============================================================

-- Client
ALTER TABLE client
ADD CONSTRAINT fk_client_adresse FOREIGN KEY (numero_adresse) REFERENCES adresse(numero_adresse);

-- Voiture
ALTER TABLE voiture
ADD CONSTRAINT fk_voiture_modele_voiture FOREIGN KEY (numero_modele) REFERENCES modele_voiture(numero_modele);
ALTER TABLE voiture
ADD CONSTRAINT fk_voiture_numero_client FOREIGN KEY (numero_client) REFERENCES client(numero_client);

-- Composition
ALTER TABLE composition
ADD CONSTRAINT fk_composition_modele_voiture FOREIGN KEY (numero_modele) REFERENCES modele_voiture(numero_modele);
ALTER TABLE composition
ADD CONSTRAINT fk_composition_piece FOREIGN KEY (numero_serie_piece) REFERENCES piece(numero_serie_piece);

-- Requerir
ALTER TABLE requerir
ADD CONSTRAINT fk_requerir_action FOREIGN KEY (numero_action) REFERENCES action(numero_action);
ALTER TABLE requerir
ADD CONSTRAINT fk_requerir_piece FOREIGN KEY (numero_serie_piece) REFERENCES piece(numero_serie_piece);

-- Contenir
ALTER TABLE contenir
ADD CONSTRAINT fk_contenir_action FOREIGN KEY (numero_action) REFERENCES action(numero_action);
ALTER TABLE contenir
ADD CONSTRAINT fk_contenir_intervention FOREIGN KEY (numero_intervention) REFERENCES intervention(numero_intervention);

-- Survenir
ALTER TABLE survenir
ADD CONSTRAINT fk_survenir_action FOREIGN KEY (numero_action) REFERENCES action(numero_action);
ALTER TABLE survenir
ADD CONSTRAINT fk_survenir_intervention FOREIGN KEY (numero_intervention) REFERENCES intervention(numero_intervention);

-- Facture
ALTER TABLE facture
ADD CONSTRAINT fk_facture_intervention FOREIGN KEY (numero_intervention) REFERENCES intervention(numero_intervention);

-- Devis
ALTER TABLE devis
ADD CONSTRAINT fk_devis_intervention FOREIGN KEY (numero_intervention) REFERENCES intervention(numero_intervention);

-- Intervention
ALTER TABLE intervention
ADD CONSTRAINT fk_intervention_voiture FOREIGN KEY (matricule_voiture) REFERENCES voiture(matricule_voiture);
ALTER TABLE intervention
ADD CONSTRAINT fk_intervention_garage FOREIGN KEY (numero_SIREN) REFERENCES garage(numero_SIREN);

-- Garage
ALTER TABLE garage
ADD CONSTRAINT fk_garage_adresse FOREIGN KEY (numero_adresse) REFERENCES adresse(numero_adresse);

-- Employe
ALTER TABLE employe
ADD CONSTRAINT fk_employe_garage FOREIGN KEY (numero_SIREN) REFERENCES garage(numero_SIREN);
ALTER TABLE employe
ADD CONSTRAINT fk_employe_adresse FOREIGN KEY (numero_adresse) REFERENCES adresse(numero_adresse);

-- ============================================================
