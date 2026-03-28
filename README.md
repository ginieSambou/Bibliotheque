# Gestion de Bibliothèque (NEW_BIBLIO)

Une application moderne de gestion de bibliothèque développée avec **JavaFX**, **Hibernate** et **MySQL**. Ce projet offre une interface utilisateur intuitive pour gérer les livres, les adhérents et les emprunts au sein d'une bibliothèque.

## 🚀 Fonctionnalités

L'application propose les modules suivants :

- **📚 Gestion des Livres**
  - Ajout, modification et suppression de livres.
  - Classification par catégories.
  - Recherche multicritère (titre, auteur, catégorie).
- **👥 Gestion des Utilisateurs & Adhérents**
  - Gestion des comptes utilisateurs avec différents niveaux d'accès.
  - Suivi des informations des adhérents.
  - Sécurisation des mots de passe avec **BCrypt**.
- **🔄 Gestion des Emprunts**
  - Enregistrement des emprunts et des retours.
  - Suivi des dates d'échéance.
  - Historique complet des transactions.
- **📊 Tableau de Bord**
  - Statistiques en temps réel sur l'activité de la bibliothèque.

## 🛠 Technologies utilisées

- **Langage** : Java 19+
- **Interface Graphique** : [JavaFX 19](https://openjfx.io/) (FXML)
- **Persistence** : [Hibernate 6](https://hibernate.org/) (ORM)
- **Base de données** : [MySQL 8](https://www.mysql.com/)
- **Build & Gestion de dépendances** : [Maven](https://maven.apache.org/)

## 📋 Prérequis

Avant de lancer l'application, assurez-vous d'avoir :

1.  **Java JDK 19** ou supérieur installé.
2.  **Maven** installé et configuré.
3.  Une instance **MySQL** en cours d'exécution.
4.  La base de données créée (voir `hibernate.cfg.xml` pour les configurations).

## 🚀 Comment lancer l'application

Vous pouvez lancer l'application directement avec Maven en utilisant la commande suivante à la racine du projet :

```bash
mvn javafx:run
```

Pour compiler et empaqueter le projet :

```bash
mvn clean package
```

## 📂 Structure du Projet

- `src/main/java/com/biblio/controller` : Contrôleurs pour la gestion de l'interface utilisateur.
- `src/main/java/com/biblio/domain` : Classes entités (Modèles).
- `src/main/java/com/biblio/service` : Logique métier de l'application.
- `src/main/resources` : Fichiers FXML, styles CSS et configurations Hibernate.

---
Développé avec ❤️ pour simplifier la gestion de votre bibliothèque.
