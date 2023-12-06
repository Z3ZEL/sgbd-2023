# Projet SGBD : Entretien de Véhicules

## Introduction
Ce projet, réalisé dans le cadre d'un module de Système de Gestion de Bases de Données (SGBD) pour la 2ème année informatique, vise à développer une base de données pour la gestion de l'entretien de véhicules au sein d'un garage. L'application modélise et implémente une base de données relationnelle pour gérer de manière efficace les informations clients, les détails des véhicules, et un historique complet des interventions réalisées ou programmées.

Les fonctionnalités principales incluent :
- Enregistrement et suivi des clients et de leurs véhicules.
- Gestion détaillée des caractéristiques des véhicules et des interventions nécessaires.
- Historique complet des prises en charge, facturations, et interventions externes.
- Rappels automatisés pour les interventions de maintenance régulières ou prescrites.
- Référentiel des types d'interventions avec une grille tarifaire variable selon le type de véhicule.

Ce README décrit les étapes pour déployer la base de données et configurer l'application pour une utilisation locale.

## Notice d'utilisation
Pour déployer la base de données, suivez ces étapes :

1. Chargez les fichiers suivants depuis `psql` :
   - `sql/create.sql`
   - `sql/select.sql`
   - `sql/update.sql`
   - `sql/insert.sql`

   La base sera alors prête à l'emploi avec son lot de données de tests.

2. Pour supprimer la base, chargez le fichier `sql/drop.sql`.

3. Remplissez les identifiants de la base de données dans le fichier `src/auth_sample.php` et renommez-le en `auth.php`.

4. Exécutez la commande `make` pour lancer l'hébergement sur `localhost:8000`, à condition d'avoir les paquets PHP requis.

## Auteurs
REINERT Mathis,
L'HONORE Antoine,
RODRIGUEZ Esteban,
PERIN Côme

## Lien vers le Sujet
https://moodle.bordeaux-inp.fr/pluginfile.php/258995/mod_resource/content/2/projet_SGBD_Garage.pdf

## Lien du dépot GIT
git@github.com:Z3ZEL/sgbd-2023.git