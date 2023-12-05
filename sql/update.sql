-- function : UPDATE nom, prenom, mail, telephone FROM personnes WHERE numero_securite_sociale is given with post method

CREATE OR REPLACE FUNCTION update_personne(
    numero_securite_sociale_arg INTEGER,
    nom_personne_arg VARCHAR(50),
    prenom_personne_arg VARCHAR(50),
    mail_personne_arg VARCHAR(50),
    telephone_personne_arg INTEGER
)
RETURNS void AS $$
BEGIN
    UPDATE personnes
    SET nom_personne = nom_personne_arg, prenom_personne = prenom_personne_arg, mail_personne = mail_personne_arg, telephone_personne = telephone_personne_arg
    WHERE numero_securite_sociale = numero_securite_sociale_arg;
END;
$$ LANGUAGE plpgsql;


