-- ============================================================
--   Nom de la base   :  GARAGES                                
--   Nom de SGBD      :  PostgreSQL                   
--   Date de creation :  30/10/2023                       
-- ============================================================

DROP TABLE adresse;
DROP TABLE client;
DROP TABLE voitures;
DROP TABLE modele_voiture;
DROP TABLE composition;
DROP TABLE pieces;
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
--   Table : VOITURES                                          
-- ============================================================

CREATE TABLE voiture
(
    matricule_voiture               SERIAL                  NOT NULL,
    puissance_fiscale_voiture       INTEGER                         ,
    cylindree_voiture               INTEGER                         ,
    couleur_voiture                 VARCHAR(20)                     ,
    annee_circulation_voiture       INTEGER                         ,
    numero_modele                   INTEGER                         ,
    CONSTRAINT pk_voiture PRIMARY KEY (matricule_voiture)
);

-- ============================================================
--   Table : MODELE_VOITURE                                  
-- ============================================================

CREATE TABLE modele_voiture
(
    numero_modele                   SERIAL                  NOT NULL,
    type_modele                     VARCHAR(20)                     ,
    marque_modele                   VARCHAR(20)                     ,
    version_modele                  VARCHAR(20)                     ,
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
--   Table : PIECES                                        
-- ============================================================

CREATE TABLE pieces
(
    numero_serie_piece              SERIAL                   NOT NULL,
    type_piece                      VARCHAR(20)                      ,
    prix_piece                      INTEGER                          ,
    marque_piece                    VARCHAR(20)                      ,
    CONSTRAINT pk_pieces PRIMARY KEY (numero_serie_piece)
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
    nom_action                      VARCHAR(20)                      ,
    duree_estime_action             INTEGER                          ,
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
    matricule_voiture               INTEGER                          ,
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
    numero_securite_sociale         SERIAL                   NOT NULL,
    nom_employe                     VARCHAR(20)                      ,
    prenom_employe                  VARCHAR(20)                      ,
    date_embauche_employe            DATE                            ,
    salaire_horaire_employe         INTEGER                          ,
    numero_SIREN                    INTEGER                          ,
    numero_adresse                  INTEGER                          ,
    CONSTRAINT pk_employe PRIMARY KEY (numero_securite_sociale)
);

