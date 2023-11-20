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
DROP TABLE IF EXISTS requetes CASCADE;
DROP TABLE IF EXISTS modeles_voitures CASCADE;
DROP TABLE IF EXISTS compositions CASCADE;
DROP TABLE IF EXISTS voitures CASCADE;
DROP TABLE IF EXISTS adresses CASCADE;
DROP TABLE IF EXISTS personnes CASCADE;
DROP TABLE IF EXISTS garages CASCADE;
DROP TABLE IF EXISTS tarifs CASCADE;

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
    montant_facture FLOAT,
    PRIMARY KEY (numero_facture)
);

--Table devis
CREATE TABLE devis (
    numero_devis INTEGER NOT NULL,
    numero_intervention INTEGER NOT NULL,
    date_devis DATE NOT NULL,
    montant_devis FLOAT,
    PRIMARY KEY (numero_devis)
);

--Table actions
CREATE TABLE actions (
    numero_action INTEGER NOT NULL,
    nom_action VARCHAR(50) NOT NULL,
    duree_estime_action FLOAT,
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
    prix_piece FLOAT,
    marque_piece VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero_serie_piece)
);

--Table requetes
CREATE TABLE requetes (
    numero_action INTEGER NOT NULL,
    numero_type_piece INTEGER NOT NULL,
    quantite INTEGER NOT NULL,
    PRIMARY KEY (numero_action, numero_type_piece)
);

--Table modeles_voiture
CREATE TABLE modeles_voitures (
    numero_modele INTEGER NOT NULL,
    type_modele VARCHAR(50) NOT NULL,
    marque_modele VARCHAR(50) NOT NULL,
    version_modele VARCHAR(50) NOT NULL,
    annee_modele INTEGER NOT NULL,
    PRIMARY KEY (numero_modele)
);

--Table compositions
CREATE TABLE compositions (
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
CREATE TABLE tarifs (
    numero_action INTEGER NOT NULL,
    numero_modele INTEGER NOT NULL,
    montant FLOAT,
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

--Table requetes
ALTER TABLE requetes ADD CONSTRAINT fk_requetes_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);
ALTER TABLE requetes ADD CONSTRAINT fk_requetes_types_pieces FOREIGN KEY (numero_type_piece) REFERENCES types_pieces(numero_type_piece);

--Table compositions
ALTER TABLE compositions ADD CONSTRAINT fk_compositions_pieces FOREIGN KEY (numero_serie_piece) REFERENCES pieces(numero_serie_piece);
ALTER TABLE compositions ADD CONSTRAINT fk_compositions_modeles_voitures FOREIGN KEY (numero_modele) REFERENCES modeles_voitures(numero_modele);

--Table voitures
ALTER TABLE voitures ADD CONSTRAINT fk_voitures_modeles_voitures FOREIGN KEY (numero_modele) REFERENCES modeles_voitures(numero_modele);
ALTER TABLE voitures ADD CONSTRAINT fk_voitures_personnes FOREIGN KEY (numero_client) REFERENCES personnes(numero_securite_sociale);

--Table personnes
ALTER TABLE personnes ADD CONSTRAINT fk_personnes_adresses FOREIGN KEY (numero_adresse) REFERENCES adresses(numero_adresse);

--Table garages
ALTER TABLE garages ADD CONSTRAINT fk_garages_adresses FOREIGN KEY (numero_adresse) REFERENCES adresses(numero_adresse);

--Table tarifs
ALTER TABLE tarifs ADD CONSTRAINT fk_tarifs_actions FOREIGN KEY (numero_action) REFERENCES actions(numero_action);
ALTER TABLE tarifs ADD CONSTRAINT fk_tarifs_modeles_voitures FOREIGN KEY (numero_modele) REFERENCES modeles_voitures(numero_modele);



-- public.client_informations_view source

CREATE OR REPLACE VIEW public.client_informations_view
AS SELECT p.numero_securite_sociale AS client_id,
    gci.nom,
    gci.prenom,
    gci.mail,
    gci.telephone,
    gci.total_facture
   FROM personnes p,
    LATERAL get_client_informations(p.numero_securite_sociale) gci(nom, prenom, mail, telephone, total_facture);



CREATE OR REPLACE FUNCTION public.get_client_id_from_intervention(intervention_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
	declare
		client_id int4;
	begin
		select p.numero_securite_sociale
		into client_id
		from personnes p, voitures v, interventions i
		where 
			i.numero_intervention  = intervention_id and 
			i.matricule_voiture = v.matricule_voiture and 
			v.numero_client = p.numero_securite_sociale 
		limit 1;
		return client_id;
	END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_client_informations(client_id integer)
 RETURNS TABLE(nom character varying, prenom character varying, mail character varying, telephone integer, total_facture integer)
 LANGUAGE plpgsql
AS $function$
	begin
		return query 
		with client_interventions as (
	select i.numero_intervention from interventions i where get_client_id_from_intervention(i.numero_intervention) = 4
),
client_factures as (
	select * from factures f, client_interventions ci where ci.numero_intervention = f.numero_intervention 
)
select c.nom_personne  , c.prenom_personne  , c.mail_personne  , c.telephone_personne, SUM(cf.montant_facture)::int4  from personnes c, client_factures cf where c.numero_securite_sociale  = 4
group by c.nom_personne, c.prenom_personne , c.mail_personne, c.telephone_personne  ;
	END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_voiture_by_num_client(num_client integer)
 RETURNS TABLE(matricule_voiture character varying)
 LANGUAGE plpgsql
AS $function$
	BEGIN
		return query 
			select v.matricule_voiture from voitures v where v.numero_client = num_client;
	END;
$function$
;
