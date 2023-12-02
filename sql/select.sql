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
	select i.numero_intervention from interventions i where get_client_id_from_intervention(i.numero_intervention) = client_id
),
client_factures as (
	select * from factures f, client_interventions ci where ci.numero_intervention = f.numero_intervention 
)
select c.nom_personne  , c.prenom_personne  , c.mail_personne  , c.telephone_personne, SUM(cf.montant_facture)::int4  from personnes c, client_factures cf where c.numero_securite_sociale  = client_id
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


CREATE OR REPLACE FUNCTION public.get_actions_from_intervention(integer)
 RETURNS SETOF actions
 LANGUAGE sql
AS $function$
	with ra as (
	select ac.numero_action  from actions_contenues ac where ac.numero_intervention = $1
	union
	select as2.numero_action from actions_survenues as2 where as2.numero_intervention  = $1
	)
	select actions.* from actions, ra where actions.numero_action = ra.numero_action;
$function$
;

-- Requete : Obtenir la liste des modeles de voiture rencontrés sur une année pour un garage donné

CREATE OR REPLACE FUNCTION public.get_models_by_year(year integer, SIREN integer)
 RETURNS TABLE(numero_modele integer, type_modele character varying, marque_modele character varying, version_modele character varying, annee_modele integer)
 LANGUAGE plpgsql
AS $function$
    BEGIN
        RETURN QUERY
        SELECT DISTINCT modeles_voitures.numero_modele, modeles_voitures.type_modele, modeles_voitures.marque_modele, modeles_voitures.version_modele, modeles_voitures.annee_modele 
        FROM modeles_voitures
        JOIN voitures ON voitures.numero_modele = modeles_voitures.numero_modele
        JOIN interventions ON interventions.matricule_voiture = voitures.matricule_voiture
        WHERE interventions.numero_SIREN = SIREN
        AND interventions.date_debut_intervention BETWEEN (year || '-01-01')::date AND (year || '-12-31')::date;
    END;
$function$;

-- Requete : Obtenir la liste des interventions prévues dans les deux mois pour un garage donné

CREATE OR REPLACE FUNCTION public.get_interventions_by_two_months(SIREN integer)
 RETURNS TABLE(numero_intervention integer, matricule_voiture character varying, numero_SIREN integer, date_debut_intervention date, date_fin_intervention date, kilometrage integer)
 LANGUAGE plpgsql
AS $function$
    BEGIN
        RETURN QUERY
        SELECT interventions.numero_intervention, interventions.matricule_voiture, interventions.numero_SIREN, interventions.date_debut_intervention, interventions.date_fin_intervention, interventions.kilometrage
        FROM interventions
        WHERE interventions.numero_SIREN = SIREN
            AND interventions.date_debut_intervention BETWEEN (CURRENT_DATE)::date AND (CURRENT_DATE + INTERVAL '2 months')::date;
        END;
$function$;

-- Requete : Obtenir la liste des types de véhicules avec type d'interventions majoritaire pratiqué sur ces véhicules
CREATE OR REPLACE FUNCTION public.get_type_modele_by_majority_action()
 RETURNS TABLE(type_modele character varying, numero_action integer, nom_action character varying, max_count bigint)
 LANGUAGE plpgsql
AS $function$
    BEGIN
        RETURN QUERY
        WITH count_by_type AS 
        (
        SELECT modeles_voitures.type_modele, actions.numero_action, actions.nom_action, COUNT(*) AS count
        FROM actions
        JOIN (
            SELECT * FROM actions_contenues 
            UNION 
            SELECT * FROM actions_survenues
            ) AS join_actions
        ON actions.numero_action = join_actions.numero_action
        JOIN interventions
        ON join_actions.numero_intervention=interventions.numero_intervention
        JOIN voitures
        ON voitures.matricule_voiture=interventions.matricule_voiture
        JOIN modeles_voitures
        ON voitures.numero_modele=modeles_voitures.numero_modele
        GROUP BY modeles_voitures.type_modele, actions.numero_action
        ),
        max_by_type AS
        (
        SELECT count_by_type.type_modele, MAX(count) AS max_count
        FROM count_by_type
        GROUP BY count_by_type.type_modele
        )
        SELECT count_by_type.type_modele, count_by_type.numero_action, count_by_type.nom_action, max_by_type.max_count
        FROM count_by_type
        JOIN max_by_type
        ON count_by_type.type_modele=max_by_type.type_modele AND count_by_type.count=max_by_type.max_count
        ORDER BY count_by_type.type_modele, count_by_type.numero_action; 
    END;
$function$;