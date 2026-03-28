-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 28 mars 2026 à 11:08
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bibliotheque`
--
CREATE DATABASE IF NOT EXISTS `bibliotheque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `bibliotheque`;

-- --------------------------------------------------------

--
-- Structure de la table `adherent`
--

DROP TABLE IF EXISTS `adherent`;
CREATE TABLE IF NOT EXISTS `adherent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateInscription` date DEFAULT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matricule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `libelle`, `description`) VALUES
(1, 'Roman', 'Livres de fiction');

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
CREATE TABLE IF NOT EXISTS `emprunt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dateEmprunt` date DEFAULT NULL,
  `dateRetour` date DEFAULT NULL,
  `rendu` tinyint(1) DEFAULT '0',
  `adherent_id` bigint DEFAULT NULL,
  `livre_id` bigint DEFAULT NULL,
  `dateRetourEffective` date DEFAULT NULL,
  `dateRetourPrevue` date DEFAULT NULL,
  `penalite` double NOT NULL,
  `utilisateur_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKns1a53a21x7i1w1k3sb69f5e0` (`adherent_id`),
  KEY `FKjnn7ll8vl64xhmb6779svt7c` (`livre_id`),
  KEY `FK9xnw03cvhy9kw6so91fl3yn4e` (`utilisateur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auteur` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isbn` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  `categorie_id` bigint DEFAULT NULL,
  `anneePublication` int NOT NULL,
  `categorie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombreExemplaires` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `categorie_id` (`categorie_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`id`, `titre`, `auteur`, `isbn`, `disponible`, `categorie_id`, `anneePublication`, `categorie`, `nombreExemplaires`) VALUES
(1, 'Les Misérables', 'Victor Hugo', 'ISBN-12345', 1, 1, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `profil`
--

DROP TABLE IF EXISTS `profil`;
CREATE TABLE IF NOT EXISTS `profil` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `profil`
--

INSERT INTO `profil` (`id`, `libelle`, `description`) VALUES
(1, 'ADMIN', 'Administrateur du système');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motDePasse` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `profil_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `FKssvnc79lcj8l1hwgm230fiuh7` (`profil_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `login`, `motDePasse`, `nom`, `prenom`, `email`, `actif`, `profil_id`) VALUES
(1, 'ginie', 'ginie123', 'GINIE', 'Admin', 'ginie@biblio.com', 1, 1);
--
-- Base de données : `bibliotheque_db`
--
CREATE DATABASE IF NOT EXISTS `bibliotheque_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bibliotheque_db`;

-- --------------------------------------------------------

--
-- Structure de la table `adherents`
--

DROP TABLE IF EXISTS `adherents`;
CREATE TABLE IF NOT EXISTS `adherents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telephone` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `actif` bit(1) NOT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_inscription` date DEFAULT NULL,
  `matricule` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6vqi9nci42rnnsengwt1pmwhf` (`email`),
  UNIQUE KEY `UK_sxyept663b3657rqw8tyb2t7j` (`matricule`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adherents`
--

INSERT INTO `adherents` (`id`, `email`, `nom`, `prenom`, `telephone`, `actif`, `adresse`, `date_inscription`, `matricule`) VALUES
(1, 'giniebb@gmail.com', 'Virginie', 'SAMBOU', '785622353', b'1', NULL, NULL, NULL),
(2, 'thegoat@gmail.com', 'Chritiano', 'GOAT', '763875727', b'0', NULL, NULL, NULL),
(3, 'sall@gmail.com', 'SALL', 'MARIEME', '786005605', b'0', NULL, NULL, NULL),
(4, 'maraniasse@gmail.com', 'Niasse', 'Mara', '762345372', b'1', NULL, NULL, NULL),
(5, 'omarndiaye@gmail.com', 'NDIAYE', 'Omar', '770001111', b'1', NULL, '2026-03-03', 'MAT005'),
(6, 'aissatoudiop@gmail.com', 'DIOP', 'Aissatou', '770002222', b'1', NULL, '2026-03-03', 'MAT006'),
(7, 'mamadoufall@gmail.com', 'FALL', 'Mamadou', '770003333', b'1', NULL, '2026-03-03', 'MAT007'),
(8, 'fatousow@gmail.com', 'SOW', 'Fatou', '770004444', b'1', NULL, '2026-03-03', 'MAT008'),
(9, 'cheikhba@gmail.com', 'BA', 'Cheikh', '770005555', b'1', NULL, '2026-03-03', 'MAT009'),
(10, 'khadijagueye@gmail.com', 'GUEYE', 'Khadija', '770006666', b'1', NULL, '2026-03-03', 'MAT010'),
(11, 'ibrahimaseck@gmail.com', 'SECK', 'Ibrahima', '770007777', b'1', NULL, '2026-03-03', 'MAT011'),
(12, 'mariamsy@gmail.com', 'SY', 'Mariama', '770008888', b'1', NULL, '2026-03-03', 'MAT012');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1nq4pjt2g6jvnovpid67kncm5` (`libelle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `libelle`, `description`) VALUES
(1, 'ROMAN', NULL),
(2, 'DEVELOPPEMENT PERSONNEL', NULL),
(3, 'FICTIONS', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `emprunts`
--

DROP TABLE IF EXISTS `emprunts`;
CREATE TABLE IF NOT EXISTS `emprunts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_emprunt` date NOT NULL,
  `date_retour_effective` date DEFAULT NULL,
  `date_retour_prevue` date DEFAULT NULL,
  `adherent_id` bigint DEFAULT NULL,
  `livre_id` bigint DEFAULT NULL,
  `penalite` int DEFAULT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5gdu5mujebshemuwwi4sla7bx` (`adherent_id`),
  KEY `FK57rm7d75bto0x8yxmrfvjnydw` (`livre_id`),
  KEY `FKd5i4kghuhrwdm3mhtn9iben5b` (`utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emprunts`
--

INSERT INTO `emprunts` (`id`, `date_emprunt`, `date_retour_effective`, `date_retour_prevue`, `adherent_id`, `livre_id`, `penalite`, `utilisateur_id`) VALUES
(1, '2026-02-25', '2026-03-03', '2026-02-28', 2, 1, 1500, NULL),
(2, '2026-02-25', '2026-02-25', '2026-02-25', 3, 2, NULL, NULL),
(3, '2026-03-03', '2026-03-03', '2026-03-04', 4, 4, 0, NULL),
(4, '2026-03-11', '2026-03-11', '2026-03-12', 5, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `livres`
--

DROP TABLE IF EXISTS `livres`;
CREATE TABLE IF NOT EXISTS `livres` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `annee_publication` int DEFAULT NULL,
  `auteur` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `isbn` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `categorie_id` bigint DEFAULT NULL,
  `exemplaires_disponibles` int NOT NULL,
  `disponible` bit(1) NOT NULL,
  `nombre_exemplaires` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_7p1gicrlporibbko4qec7e6pp` (`isbn`),
  KEY `FKfnlv2rmpf229lropillhdqgqc` (`categorie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livres`
--

INSERT INTO `livres` (`id`, `annee_publication`, `auteur`, `isbn`, `titre`, `categorie_id`, `exemplaires_disponibles`, `disponible`, `nombre_exemplaires`) VALUES
(1, 2019, 'Darren Hardy', '978-2354564063', 'L\'effet cumule', NULL, 1, b'1', 0),
(2, 2020, 'James Clear', '978-2035969200', 'Atomic Habits', NULL, 0, b'0', 0),
(3, 2007, 'YTRR', '345678765', 'BCCG', 3, 0, b'0', 0),
(4, 2002, 'Sathies', '233333333', 'RoGER', 1, 2, b'1', 1),
(5, 1973, 'Mariama Ba', '9782723601236', 'Une si longue lettre', 1, 4, b'1', 4),
(6, 1960, 'Ousmane Sembene', '9782266098701', 'Les bouts de bois de Dieu', 1, 3, b'1', 3),
(7, 1961, 'Cheikh Hamidou Kane', '9782266118907', 'L\'aventure ambiguë', 1, 2, b'1', 2),
(8, 2009, 'Fatou Diome', '9782253124805', 'Le ventre de l\'Atlantique', 3, 3, b'1', 3),
(9, 1862, 'Victor Hugo', '9782070409180', 'Les Miserables', 1, 6, b'1', 6),
(10, 1943, 'Antoine de Saint Exupery', '9782070612757', 'Le Petit Prince', 1, 7, b'1', 7),
(11, 1956, 'Aminata Sow Fall', '9782723604568', 'La greve des battus', 3, 2, b'1', 2),
(12, 2003, 'Ken Bugul', '9782723612346', 'Le baobab fou', 3, 2, b'1', 2),
(13, 2018, 'David Goggins', '9781544512281', 'Cant Hurt Me', 2, 3, b'1', 3),
(14, 2017, 'Paulo Coelho', '9782290004448', 'L\'Alchimiste', 1, 4, b'1', 4),
(15, 2015, 'Albert Camus', '9782070360023', 'L\'Etranger', 1, 3, b'1', 3);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mot_de_passe_hache` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nom_utilisateur` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `actif` bit(1) NOT NULL,
  `must_change_password` bit(1) NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_creation` datetime(6) DEFAULT NULL,
  `derniere_connexion` datetime(6) DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_a2ykdvttcaxt46ks7qlwda4hr` (`nom_utilisateur`),
  UNIQUE KEY `UK_6ldvumu3hqvnmmxy1b6lsxwqy` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `mot_de_passe_hache`, `nom_utilisateur`, `role`, `actif`, `must_change_password`, `nom`, `prenom`, `date_creation`, `derniere_connexion`, `email`) VALUES
(1, '$2a$10$OnqjhW7H9ZgFcFf5g7IJJe7RFK3bl2JWozvyj.WKKduF6NmXs04wq', 'admin', 'ADMIN', b'1', b'0', NULL, NULL, NULL, '2026-03-28 10:12:09.595853', NULL),
(2, '$2a$10$ua34lt..WMXlSZIbj7yZnOe61dlteQMzEtgrBKc0NVBNWTxV4cACS', 'ginies', 'BIBLIOTHECAIRE', b'1', b'0', 'ginie', 'sambou', NULL, NULL, NULL),
(3, '$2a$10$RnzybNJFNXjK0Jew1oaOrOHTirvIO/Nt.kt22MZtJ9FKfv7s.Zh32', 'mariemes', 'BIBLIOTHECAIRE', b'1', b'1', 'sall', 'marieme', '2026-03-03 18:14:10.284036', NULL, 'mariemesall@gmail.com');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emprunts`
--
ALTER TABLE `emprunts`
  ADD CONSTRAINT `FK57rm7d75bto0x8yxmrfvjnydw` FOREIGN KEY (`livre_id`) REFERENCES `livres` (`id`),
  ADD CONSTRAINT `FK5gdu5mujebshemuwwi4sla7bx` FOREIGN KEY (`adherent_id`) REFERENCES `adherents` (`id`),
  ADD CONSTRAINT `FKd5i4kghuhrwdm3mhtn9iben5b` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`);

--
-- Contraintes pour la table `livres`
--
ALTER TABLE `livres`
  ADD CONSTRAINT `FKfnlv2rmpf229lropillhdqgqc` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`);
--
-- Base de données : `dbicm`
--
CREATE DATABASE IF NOT EXISTS `dbicm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `dbicm`;

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `CNI` varchar(255) NOT NULL,
  `ICM` float NOT NULL,
  `poids` float NOT NULL,
  `taille` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `dbjava`
--
CREATE DATABASE IF NOT EXISTS `dbjava` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `dbjava`;

-- --------------------------------------------------------

--
-- Structure de la table `adherent`
--

DROP TABLE IF EXISTS `adherent`;
CREATE TABLE IF NOT EXISTS `adherent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matricule` varchar(50) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `dateInscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actif` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricule` (`matricule`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
CREATE TABLE IF NOT EXISTS `emprunt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `livre_id` int NOT NULL,
  `adherent_id` int NOT NULL,
  `utilisateur_id` int NOT NULL,
  `dateEmprunt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dateRetourPrevue` date NOT NULL,
  `dateRetourEffective` date DEFAULT NULL,
  `penalite` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `livre_id` (`livre_id`),
  KEY `adherent_id` (`adherent_id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `auteur` varchar(150) DEFAULT NULL,
  `categorie` varchar(100) DEFAULT NULL,
  `anneePublication` year DEFAULT NULL,
  `nombreExemplaires` int DEFAULT '1',
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Prenom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`Id`, `Prenom`, `Nom`, `age`) VALUES
(1, 'OMAR', 'NDIAYE', 0);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `motDePasse` varchar(255) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `profil` enum('ADMIN','BIBLIOTHECAIRE') NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `dateCreation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `derniereConnexion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `login`, `motDePasse`, `nom`, `prenom`, `email`, `profil`, `actif`, `dateCreation`, `derniereConnexion`) VALUES
(1, 'admin', 'admin123', 'Admin', 'System', 'admin@bibliotheque.com', 'ADMIN', 1, '2026-02-17 18:35:34', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_u` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prenom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`id_u`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_u`, `nom`, `prenom`, `age`) VALUES
(1, 'Sambou', 'Henry', 24),
(2, 'Sambou', 'Virginie', 20),
(3, 'Teuw', 'AmDouX', 25),
(4, 'Sambou', 'Henry', 24),
(5, 'ARAMA', 'YACOUBA', 21);
--
-- Base de données : `dbl2`
--
CREATE DATABASE IF NOT EXISTS `dbl2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `dbl2`;

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `idPersonne` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(30) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`idPersonne`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `dbschool`
--
CREATE DATABASE IF NOT EXISTS `dbschool` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `dbschool`;

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

DROP TABLE IF EXISTS `classe`;
CREATE TABLE IF NOT EXISTS `classe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `niveau` int NOT NULL,
  `specialite` int NOT NULL,
  `libelle` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(255) NOT NULL,
  `Adresse` varchar(255) NOT NULL,
  `Matricule` varchar(255) NOT NULL,
  `idClasse` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `demoi32026`
--
CREATE DATABASE IF NOT EXISTS `demoi32026` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `demoi32026`;

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

DROP TABLE IF EXISTS `classe`;
CREATE TABLE IF NOT EXISTS `classe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `classe`
--

INSERT INTO `classe` (`id`, `nom`) VALUES
(1, 'L3 Reseau Informatique'),
(2, 'L3 Génie Logiciel'),
(3, 'L3 Réseaux et Télécommunications'),
(4, 'M1 Cybersécurité'),
(5, 'M1 Data Science'),
(6, 'M2 Intelligence Artificielle'),
(7, 'M2 Cybersécurité'),
(8, 'L2 IAGE'),
(9, 'L1 RI'),
(10, 'M1 Cloud Computing');

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `adresse` varchar(500) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `nationalite_id` int NOT NULL,
  `classe_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nationalite` (`nationalite_id`),
  KEY `fk_classe` (`classe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `nom`, `adresse`, `latitude`, `longitude`, `nationalite_id`, `classe_id`) VALUES
(1, 'Dupont Diop', '12 Rue de la République, Paris 75001', 48.8566, 2.3522, 1, 1),
(2, 'Martin Sophie', '45 Avenue des Champs-Élysées, Paris 75008', 48.8698, 2.3078, 1, 2),
(3, 'El Mansouri Ahmed', '23 Boulevard Mohammed V, Casablanca', 33.5731, -7.5898, 2, 1),
(4, 'Ben Ali Fatima', '78 Rue Habib Bourguiba, Tunis', 36.8065, 10.1815, 4, 3),
(5, 'Diallo Mamadou', '56 Avenue Léopold Sédar Senghor, Dakar', 14.6928, -17.4467, 5, 4),
(6, 'Kouassi Jean-Marc', '89 Boulevard de la République, Abidjan', 5.36, -4.0083, 6, 2),
(7, 'Nkomo Paul', '34 Rue de la Réunification, Yaoundé', 3.848, 11.5021, 7, 5),
(8, 'Garcia Maria', '67 Calle Mayor, Madrid', 40.4168, -3.7038, 8, 1),
(9, 'Rossi Giovanni', '91 Via Roma, Rome', 41.9028, 12.4964, 9, 6),
(10, 'Silva Pedro Faye', '22 Rua Augusta, Lisbonne', 38.7223, -9.1393, 10, 3),
(11, 'Bernard Claire', '15 Rue Victor Hugo, Lyon 69002', 45.764, 4.8357, 1, 7),
(12, 'Petit Thomas', '88 Avenue de la Libération, Marseille 13001', 43.2965, 5.3698, 1, 8),
(13, 'Benali Karim', '42 Rue des Martyrs, Alger', 36.7538, 3.0588, 3, 4),
(14, 'Amrani Leila', '19 Boulevard Anfa, Casablanca', 33.5928, -7.6192, 2, 2),
(15, 'Traoré Ibrahim', '73 Avenue de l\'Indépendance, Dakar', 14.7167, -17.4677, 5, 5),
(16, 'Koffi Aya', '28 Rue du Commerce, Abidjan', 5.3364, -4.0267, 6, 9),
(17, 'Mballa Christian', '51 Avenue Kennedy, Douala', 4.0511, 9.7679, 7, 6),
(18, 'Lopez Carlos', '36 Plaza de España, Barcelona', 41.3851, 2.1734, 8, 3),
(19, 'Bianchi Laura', '64 Corso Vittorio Emanuele, Milan', 45.4642, 9.19, 9, 7),
(20, 'Santos Ana', '49 Praça do Comércio, Porto', 41.1579, -8.6291, 10, 1),
(21, 'Moreau Antoine Seck', '7 Boulevard Saint-Germain, Paris 75005', 48.8534, 2.3488, 1, 2),
(22, 'Dubois Maria', '33 Rue de la Paix, Nice 06000', 43.6962, 7.2661, 1, 4),
(23, 'El Fassi Youssef', '18 Rue Oukaimeden, Rabat', 34.0209, -6.8416, 2, 8),
(24, 'Gharbi Salma', '55 Avenue Habib Bourguiba, Sfax', 34.7406, 10.7603, 4, 5),
(25, 'Ndiaye Ousmane', '82 Rue Felix Faure, Saint-Louis', 16.0286, -16.4917, 5, 3),
(26, 'Touré Aminata', '25 Boulevard Latrille, Abidjan', 5.3411, -4.0282, 6, 6),
(27, 'Essomba François', '71 Rue de Nachtigal, Yaoundé', 3.8667, 11.5167, 7, 9),
(28, 'Fernandez Luis', '44 Gran Via, Valencia', 39.4699, -0.3763, 8, 7),
(29, 'Romano Marco', '93 Via Nazionale, Florence', 43.7696, 11.2558, 9, 1),
(30, 'Oliveira João', '17 Avenida da Liberdade, Lisbonne', 38.7167, -9.15, 10, 2),
(31, 'Lambert Julie', '62 Rue Gambetta, Bordeaux 33000', 44.8378, -0.5792, 1, 10),
(32, 'Rousseau Michel Sankara', '11 Place Bellecour, Lyon 69002', 45.7578, 4.832, 1, 3),
(33, 'Bouazza Rachid', '39 Boulevard Zerktouni, Marrakech', 31.6295, -7.9811, 2, 5),
(34, 'Trabelsi Nadia', '77 Avenue de Carthage, Tunis', 36.819, 10.1658, 4, 8),
(35, 'Sow Cheikh', '26 Rue Parchappe, Dakar', 14.6937, -17.4441, 5, 10),
(36, 'Bamba Kouadio', '58 Avenue Franchet d\'Esperey, Abidjan', 5.325, -4.0167, 6, 4),
(37, 'Ngono Marie-Claire', '41 Avenue de Gaulle, Yaoundé', 3.8578, 11.518, 7, 7),
(38, 'Martinez Elena', '85 Paseo de la Castellana, Madrid', 40.4381, -3.6889, 8, 6),
(39, 'Ferrari Stefano', '52 Piazza San Marco, Venise', 45.4408, 12.3155, 9, 9),
(40, 'Pereira Cristina', '69 Rua das Flores, Porto', 41.1429, -8.6109, 10, 10);

-- --------------------------------------------------------

--
-- Structure de la table `nationalite`
--

DROP TABLE IF EXISTS `nationalite`;
CREATE TABLE IF NOT EXISTS `nationalite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `nationalite`
--

INSERT INTO `nationalite` (`id`, `nom`) VALUES
(1, 'Sénégalaise'),
(2, 'Ivoirienne'),
(3, 'Camerounaise'),
(4, 'Gabonaise'),
(5, 'Congolaise'),
(6, 'Tchadienne'),
(7, 'Angolaise'),
(8, 'Gambienne'),
(9, 'Guinéenne'),
(10, 'Comorienne');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_etudiants_complet`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_etudiants_complet`;
CREATE TABLE IF NOT EXISTS `v_etudiants_complet` (
`adresse` varchar(500)
,`id` int
,`laClasse` varchar(100)
,`laNationalite` varchar(100)
,`latitude` double
,`longitude` double
,`nom` varchar(255)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_stats_classe`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_stats_classe`;
CREATE TABLE IF NOT EXISTS `v_stats_classe` (
`classe` varchar(100)
,`nombre_etudiants` bigint
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_stats_nationalite`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_stats_nationalite`;
CREATE TABLE IF NOT EXISTS `v_stats_nationalite` (
`nationalite` varchar(100)
,`nombre_etudiants` bigint
);

-- --------------------------------------------------------

--
-- Structure de la vue `v_etudiants_complet`
--
DROP TABLE IF EXISTS `v_etudiants_complet`;

DROP VIEW IF EXISTS `v_etudiants_complet`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_etudiants_complet`  AS SELECT `e`.`id` AS `id`, `e`.`nom` AS `nom`, `e`.`adresse` AS `adresse`, `e`.`latitude` AS `latitude`, `e`.`longitude` AS `longitude`, `n`.`nom` AS `laNationalite`, `c`.`nom` AS `laClasse` FROM ((`etudiant` `e` join `nationalite` `n` on((`e`.`nationalite_id` = `n`.`id`))) join `classe` `c` on((`e`.`classe_id` = `c`.`id`))) ORDER BY `e`.`nom` ASC ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_stats_classe`
--
DROP TABLE IF EXISTS `v_stats_classe`;

DROP VIEW IF EXISTS `v_stats_classe`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stats_classe`  AS SELECT `c`.`nom` AS `classe`, count(`e`.`id`) AS `nombre_etudiants` FROM (`classe` `c` left join `etudiant` `e` on((`c`.`id` = `e`.`classe_id`))) GROUP BY `c`.`id`, `c`.`nom` ORDER BY `nombre_etudiants` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_stats_nationalite`
--
DROP TABLE IF EXISTS `v_stats_nationalite`;

DROP VIEW IF EXISTS `v_stats_nationalite`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stats_nationalite`  AS SELECT `n`.`nom` AS `nationalite`, count(`e`.`id`) AS `nombre_etudiants` FROM (`nationalite` `n` left join `etudiant` `e` on((`n`.`id` = `e`.`nationalite_id`))) GROUP BY `n`.`id`, `n`.`nom` ORDER BY `nombre_etudiants` DESC ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `fk_classe` FOREIGN KEY (`classe_id`) REFERENCES `classe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nationalite` FOREIGN KEY (`nationalite_id`) REFERENCES `nationalite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de données : `devoirfx`
--
CREATE DATABASE IF NOT EXISTS `devoirfx` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `devoirfx`;

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

DROP TABLE IF EXISTS `classe`;
CREATE TABLE IF NOT EXISTS `classe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `niveau` varchar(255) NOT NULL,
  `specialite` varchar(255) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `formations_cnfteia`
--
CREATE DATABASE IF NOT EXISTS `formations_cnfteia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `formations_cnfteia`;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1, 'Virginie_Sambou', 'b28fa77e8dc8ed7c4868b5124fa9691e');

-- --------------------------------------------------------

--
-- Structure de la table `formateurs`
--

DROP TABLE IF EXISTS `formateurs`;
CREATE TABLE IF NOT EXISTS `formateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL,
  `statut` enum('actif','suspendu') DEFAULT 'actif',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `formateurs`
--

INSERT INTO `formateurs` (`id`, `nom`, `email`, `mot_de_passe`, `statut`) VALUES
(1, 'kasse', 'kasse@gmail.com', '$2y$10$iJVy4odLKtyW9MAubiE8deH13ao1YcXQrCjaE5IsoLwIpj/ksd2Ui', 'actif');

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

DROP TABLE IF EXISTS `formations`;
CREATE TABLE IF NOT EXISTS `formations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `domaine` varchar(100) NOT NULL,
  `niveau` varchar(100) NOT NULL,
  `nombre_places` int DEFAULT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `publie` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `inscriptions`
--

DROP TABLE IF EXISTS `inscriptions`;
CREATE TABLE IF NOT EXISTS `inscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formation_id` int DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `structure` varchar(100) DEFAULT NULL,
  `commentaire` text,
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `formation_id` (`formation_id`,`email`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `inscriptions`
--

INSERT INTO `inscriptions` (`id`, `formation_id`, `nom`, `email`, `telephone`, `structure`, `commentaire`, `date_inscription`, `created_at`) VALUES
(11, 5, 'aissatou', 'giniesambou@gmail.com', '785622353', 'RH', NULL, '2025-10-13 10:45:46', '2025-10-13 10:45:46'),
(12, 1, 'MBT', 'amdoux06@gmail.com', '765251512', 'RH', 'yes', '2025-10-14 21:17:00', '2025-10-14 21:17:00');

-- --------------------------------------------------------

--
-- Structure de la table `lecons`
--

DROP TABLE IF EXISTS `lecons`;
CREATE TABLE IF NOT EXISTS `lecons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module_id` int DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `lecons`
--

INSERT INTO `lecons` (`id`, `module_id`, `titre`, `description`) VALUES
(1, 1, 'Chap1', 'Normes'),
(2, 1, 'Chap2', 'Techniques'),
(4, 3, 'Chap1', 'tre');

-- --------------------------------------------------------

--
-- Structure de la table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formateur_id` int DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `description` text,
  `animateur` varchar(100) DEFAULT NULL,
  `format` varchar(50) DEFAULT NULL,
  `publie` tinyint(1) DEFAULT '0',
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `limite` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `formateur_id` (`formateur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `modules`
--

INSERT INTO `modules` (`id`, `formateur_id`, `titre`, `description`, `animateur`, `format`, `publie`, `date_debut`, `date_fin`, `limite`) VALUES
(1, 1, 'Redaction admin', 'Cette formation a pour objectif de renforcer les compétences des participants dans la rédaction professionnelle et administrative. Elle met l’accent …', 'cabinet', 'Présentiel', 1, NULL, NULL, 2),
(3, 1, 'Pharmacien(ne)', 'MMMMMMMMMMMMMM', 'cabinet', 'En ligne', 1, NULL, NULL, 2);
--
-- Base de données : `gestion_produits`
--
CREATE DATABASE IF NOT EXISTS `gestion_produits` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `gestion_produits`;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `prix` double NOT NULL,
  `quantite` int NOT NULL,
  `mttc` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `libelle`, `prix`, `quantite`, `mttc`) VALUES
(1, 'Stylo', 100, 2, 200),
(2, 'Cahier', 500, 3, 1500),
(3, 'Sac', 2000, 1, 2000),
(6, 'Blanco', 300, 20, 6000);
--
-- Base de données : `ges_banque`
--
CREATE DATABASE IF NOT EXISTS `ges_banque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `ges_banque`;

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agence` varchar(50) NOT NULL,
  `codebanque` varchar(50) NOT NULL,
  `numero` varchar(100) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `compte`
--

INSERT INTO `compte` (`id`, `agence`, `codebanque`, `numero`, `montant`) VALUES
(1, '', '', '', 0),
(3, 'bdk', '4', '2', 2000),
(4, 'bdg', '4', '3', 40000);
--
-- Base de données : `job_recruitment`
--
CREATE DATABASE IF NOT EXISTS `job_recruitment` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `job_recruitment`;

-- --------------------------------------------------------

--
-- Structure de la table `candidatures`
--

DROP TABLE IF EXISTS `candidatures`;
CREATE TABLE IF NOT EXISTS `candidatures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `offre_id` int DEFAULT NULL,
  `candidat_id` int DEFAULT NULL,
  `statut` enum('en_cours','acceptee','refusee') DEFAULT 'en_cours',
  `date_postulation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `offre_id` (`offre_id`),
  KEY `candidat_id` (`candidat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `candidatures`
--

INSERT INTO `candidatures` (`id`, `offre_id`, `candidat_id`, `statut`, `date_postulation`) VALUES
(1, 4, 7, '', '2025-05-17 16:01:16'),
(2, 4, 2, '', '2025-05-17 16:18:14'),
(3, 4, 8, '', '2025-05-17 16:45:40'),
(4, 3, 2, '', '2025-05-23 14:22:08'),
(5, 4, 10, '', '2025-05-23 14:48:45'),
(6, 4, 11, '', '2025-05-23 15:03:27'),
(7, 4, 12, '', '2025-05-23 23:02:41');

-- --------------------------------------------------------

--
-- Structure de la table `candidat_profiles`
--

DROP TABLE IF EXISTS `candidat_profiles`;
CREATE TABLE IF NOT EXISTS `candidat_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `cv` text,
  `competences` text,
  `niveau_etude` varchar(100) DEFAULT NULL,
  `experience` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `offres`
--

DROP TABLE IF EXISTS `offres`;
CREATE TABLE IF NOT EXISTS `offres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recruteur_id` int DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `description` text,
  `localisation` varchar(100) DEFAULT NULL,
  `secteur` varchar(100) DEFAULT NULL,
  `date_publication` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `recruteur_id` (`recruteur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `offres`
--

INSERT INTO `offres` (`id`, `recruteur_id`, `titre`, `description`, `localisation`, `secteur`, `date_publication`) VALUES
(1, 3, 'Pharmacien(ne)', ' Nous recherchons un(e) pharmacien(ne) qualifié(e) pour rejoindre notre équipe. Responsabilités : gestion des prescriptions, conseil aux patients et gestion des stocks.', 'Dakar, Sénégal', 'Santé', '2025-05-17 15:36:02'),
(2, 4, ' Professeur de Mathématiques', ' École secondaire recherche un professeur de mathématiques pour enseigner aux élèves du collège et du lycée. Qualifications requises : diplôme en mathématiques et expérience en enseignement.', 'Ziguinchor, Sénégal', ' Éducation', '2025-05-17 15:39:33'),
(3, 5, ' Responsable Marketing Digital', ' Nous avons besoin d\'un responsable marketing pour développer et exécuter des stratégies digitales. Expérience en gestion de campagnes publicitaires et analyse de marché nécessaire.', 'Dakar, Sénégal', 'Commerce', '2025-05-17 15:41:28'),
(4, 6, 'Développeur Web PHP/MySQL', 'ous cherchons un développeur web expérimenté pour travailler sur des projets innovants. Compétences requises : HTML, CSS, JavaScript, et PHP/MySQL.', 'Dakar, Sénégal', 'Technologie', '2025-05-17 15:44:09');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(100) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cv` varchar(255) DEFAULT NULL,
  `niveau_etude` varchar(100) DEFAULT NULL,
  `competences` text,
  `experience` text,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('candidat','recruteur','admin') NOT NULL,
  `status` enum('actif','bloque') DEFAULT 'actif',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `prenom`, `nom`, `name`, `email`, `cv`, `niveau_etude`, `competences`, `experience`, `password`, `role`, `status`, `created_at`) VALUES
(1, NULL, NULL, 'virginie', 'giniesambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$Zt2AhWjimOswqkfeNSY3reVxvwnCUCnfqtA4l5n4FtTch8MuzRtTq', 'candidat', 'actif', '2025-05-17 14:29:02'),
(2, NULL, NULL, 'Virginie SAMBOU', 'ginieginger@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$AINhwxllzhsNdkTHoPMHouoXTSWm9/6AVKq5EyN.ghI6cDaTOoqFq', 'candidat', 'actif', '2025-05-17 15:08:12'),
(3, NULL, NULL, 'RoRo', 'rosinesambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$av6JX6jRlNhEBtw8/AO8Yeo2rO4zWDGCJ6XNv8KAQTqmaUWiNbLti', 'recruteur', 'actif', '2025-05-17 15:18:02'),
(4, NULL, NULL, 'HCS', 'ririsambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$/WCEWZb5MOqF5tKk6RL45e6YtXaUkJ5iKqXbedfKiaWLxyLLUTNSe', 'recruteur', 'actif', '2025-05-17 15:37:41'),
(5, NULL, NULL, 'MBT', 'amdoux06@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$r2oM1D7X3maB0p.U/GUBtu2xue6mr3U8mRtrdoNyUO7LzoF7bhCvy', 'recruteur', 'actif', '2025-05-17 15:40:31'),
(6, NULL, NULL, 'Ginie', 'vmmasambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$0FoSu9gtfRXId8ci96RXdOXafHRdSfPWLN57In6ySOnFBrNF5CdaG', 'recruteur', 'actif', '2025-05-17 15:43:06'),
(7, NULL, NULL, 'FDS', 'fatouds@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$W28VSHUuCrzXCiqFVaI98OoO/GDYzCMq/nGW5qJFhU4AtX7LC3C0.', 'candidat', 'actif', '2025-05-17 15:59:57'),
(8, NULL, NULL, 'Ginie bbe', 'giniebbe@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$MwK5EqNzsioCc/9qtNq0fuf3TYrxy9VzlmgMnEl2HLcRLVUtDcWQu', 'candidat', 'actif', '2025-05-17 16:45:13'),
(9, NULL, NULL, 'Virginie SAMBOU', 'viginiesambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$5Ox.WuY1on0uSRuIc2PSeudERkCRSexNu1KlI3CxN/C134VA8v41G', 'candidat', 'actif', '2025-05-23 14:23:58'),
(10, NULL, NULL, 'Virginie SAMBOU', 'virgiesambou@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$qiViNKtix7y47gH1mUdp2uZVr44VXOf4Zb0yDQW3z.cX.Ophx8O7K', 'candidat', 'actif', '2025-05-23 14:48:13'),
(11, NULL, NULL, 'Henry', 'henrycharles@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$/Osmu92.KBrSXQGawexCQOvSLUGyaiCy7xMd79mPqMOO5XVeP/1uC', 'candidat', 'actif', '2025-05-23 15:03:14'),
(12, NULL, NULL, 'Mamy Faye', 'mamyfaye@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$lrxXhfLGevHDfE.I.zxILusjsmCh3dt8IthemuFHu1OO4B236s7gC', 'candidat', 'actif', '2025-05-23 23:02:26'),
(14, NULL, NULL, 'Giniezo', 'giniezo@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$13RrYuv/c5ENAXesR.qo6elLCgU7EGFF5QvYCmKCPSXgSRpsYpJ56', 'candidat', 'actif', '2025-05-23 23:48:58'),
(15, NULL, NULL, 'nene', 'nancia@gmail.com', NULL, NULL, NULL, NULL, '$2y$10$cuLJWruEu6sZIvsda5xxYekUX0kXuwvon.XS6ZvtHOY/CZt8UIBgC', 'candidat', 'actif', '2025-06-04 10:03:59');
--
-- Base de données : `virginie sambou`
--
CREATE DATABASE IF NOT EXISTS `virginie sambou` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `virginie sambou`;

-- --------------------------------------------------------

--
-- Structure de la table `virginie sambou`
--

DROP TABLE IF EXISTS `virginie sambou`;
CREATE TABLE IF NOT EXISTS `virginie sambou` (
  `Virginie` int NOT NULL AUTO_INCREMENT,
  `sambou` varchar(255) NOT NULL,
  `s` varchar(255) NOT NULL,
  `t` int NOT NULL,
  PRIMARY KEY (`Virginie`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `vmmas_recrutement`
--
CREATE DATABASE IF NOT EXISTS `vmmas_recrutement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `vmmas_recrutement`;

-- --------------------------------------------------------

--
-- Structure de la table `applications`
--

DROP TABLE IF EXISTS `applications`;
CREATE TABLE IF NOT EXISTS `applications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `candidate_id` int NOT NULL,
  `cover_letter` text,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cv` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `candidate_id` (`candidate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `applications`
--

INSERT INTO `applications` (`id`, `job_id`, `candidate_id`, `cover_letter`, `status`, `applied_at`, `cv`, `created_at`) VALUES
(1, 1, 1, 'Forte de plusieurs années d’expérience en développement web et animée par une passion pour l’innovation, je suis convaincue que mes compétences techniques et mon esprit d’initiative seront des atouts majeurs pour contribuer au succès de votre entreprise. Motivée à relever de nouveaux défis, je souhaite mettre mon expertise au service de votre équipe pour participer activement à la réalisation de projets ambitieux.', 'pending', '2025-06-04 18:12:17', 'cv_68408c81717a7.pdf', '2025-06-20 23:12:23'),
(2, 2, 7, 'Bonsoir, c\'est Ndeye Dip FAYE!!!', 'pending', '2025-06-20 22:45:01', 'cv_6855e46db32c7.pdf', '2025-06-20 23:12:23'),
(3, 1, 6, 'JE SUIS COMPETENTE', 'accepted', '2025-06-30 23:57:02', NULL, '2025-06-30 23:57:02');

-- --------------------------------------------------------

--
-- Structure de la table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
CREATE TABLE IF NOT EXISTS `candidates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `skills` text,
  `education` text,
  `experience` text,
  `resume_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `industry` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recruiter_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `salary` varchar(50) DEFAULT NULL,
  `status` enum('active','closed') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `responsibilities` text,
  `profil_recherche` text,
  `job_type` varchar(100) DEFAULT 'Temps plein',
  `salary_range` varchar(100) DEFAULT 'À négocier',
  PRIMARY KEY (`id`),
  KEY `recruiter_id` (`recruiter_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`id`, `recruiter_id`, `title`, `description`, `location`, `salary`, `status`, `created_at`, `responsibilities`, `profil_recherche`, `job_type`, `salary_range`) VALUES
(1, 4, 'Technicien en Maintenance Électrique', 'a SENELEC de Keur Massar recherche un technicien en maintenance électrique pour assurer l’entretien, la réparation et le suivi des installations électriques du poste de distribution.\r\n\r\nResponsabilités :\r\n\r\nEffectuer des inspections régulières des équipements.\r\n\r\nDiagnostiquer et réparer les pannes électriques.\r\n\r\nVeiller à la sécurité des installations et au respect des normes.\r\n\r\nRédiger des rapports d\'intervention.Profil recherché :\r\n\r\nDiplôme en électrotechnique ou équivalent.\r\n\r\nExpérience de 2 ans minimum en milieu industriel ou énergétique.\r\n\r\nBonne connaissance des équipements de distribution électrique.\r\n\r\nAutonomie, rigueur et esprit d’équipe.', 'Poste basé à Keur Massar, dans les locaux de la SENELEC.', '250 000 FCFA - 300 000 FCFA', 'active', '2025-06-04 16:53:05', 'Effectuer des inspections régulières des équipements.\r\n\r\nDiagnostiquer et réparer les pannes électriques.\r\n\r\nVeiller à la sécurité des installations et au respect des normes.\r\n\r\nRédiger des rapports d\'intervention.', 'Diplôme en électrotechnique ou équivalent.\r\n\r\nExpérience de 2 ans minimum en milieu industriel ou énergétique.\r\n\r\nBonne connaissance des équipements de distribution électrique.\r\n\r\nAutonomie, rigueur et esprit d’équipe.', 'Temps plein', 'À négocier'),
(2, 5, 'Stagiaire Réseaux & Maintenance', '', 'EMG Automobiles, Dakar', 'Stage non rémunéré', 'active', '2025-06-20 18:41:09', 'Assister dans la configuration et la maintenance du réseau informatique\r\n\r\nAider à l’installation et à la mise à jour des logiciels\r\n\r\nSoutenir l’équipe dans les tâches techniques quotidiennes', 'Étudiant(e) en informatique (réseau, maintenance ou équivalent)\r\n\r\nConnaissances de base en administration réseau et systèmes\r\n\r\nAutonomie, rigueur et sens de l’initiative\r\n\r\nCapacité à travailler en équipe', 'Temps plein', 'À négocier'),
(3, 8, 'Stagiaire Commercial / Assistant(e) Ventes', '', 'Liberté 6, Dakar', 'Non rémunéré', 'active', '2025-06-21 11:03:48', 'Accueillir et orienter les clients au showroom\r\n\r\nAssister les commerciaux dans la présentation des véhicules\r\n\r\nParticiper à la gestion des fiches véhicules et du suivi client\r\n\r\nAider à la publication des annonces sur les plateformes en ligne\r\n\r\nAppuyer l’équipe dans les tâches administratives et logistiques', 'Étudiant(e) en commerce, vente ou marketing\r\n\r\nBonne présentation et aisance relationnelle\r\n\r\nSens de l’écoute, rigueur et dynamisme\r\n\r\nIntérêt pour le secteur automobile', 'Temps plein', 'À négocier'),
(4, 9, 'Vendeur(euse) Boutique Prêt-à-Porter', '', 'Point E, Dakar', 'À discuter selon le profil', 'active', '2025-06-21 11:16:11', 'Accueillir et conseiller la clientèle\r\n\r\nAssurer la vente et l\'encaissement\r\n\r\nMettre en valeur les articles en boutique\r\n\r\nParticiper au rangement et à la gestion du stock\r\n\r\nContribuer à la propreté et à l’organisation de l’espace de vente', 'Bonne présentation et sens du contact\r\n\r\nDynamique, souriant(e) et motivé(e)\r\n\r\nExpérience en vente souhaitée (même courte)\r\n\r\nDisponible, ponctuel(le) et sérieux(se)', 'Temps plein', 'À négocier'),
(5, 11, 'Technicien(ne) d’installation à domicile', '', 'Dakar', 'À partir de 100 000 FCFA / mois (selon profil)', 'active', '2025-06-23 20:05:22', 'Installer et entretenir des équipements (climatiseurs, ventilateurs, électroménagers…)\r\n\r\nIntervenir chez les clients pour de petites réparations\r\n\r\nDiagnostiquer les pannes et proposer des solutions rapides\r\n\r\nRédiger des rapports d’intervention', 'Formation en électricité ou maintenance\r\n\r\nSérieux(se), ponctuel(le), bon relationnel\r\n\r\nCapable de travailler en autonomie\r\n\r\nExpérience souhaitée, même courte', 'Temps plein', 'À négocier'),
(6, 12, 'Employé(e) polyvalent(e) de snack', '', 'Dakar, Colobane', '90 000 à 120 000 FCFA / mois', 'active', '2025-06-23 20:08:56', 'Prendre les commandes des clients\r\n\r\nPréparer sandwichs, jus et petites collations\r\n\r\nMaintenir la propreté du poste de travail\r\n\r\nEncaisser les clients et gérer la caisse\r\n\r\nAider à la réception des marchandises', 'Ponctuel(le), propre et dynamique\r\n\r\nRapide et motivé(e)\r\n\r\nSavoir lire, écrire et compter\r\n\r\nExpérience dans un snack est un plus, mais pas obligatoire', 'Temps plein', 'À négocier'),
(7, 14, 'Agent de blanchisserie', '', 'Dakar, Sacré-Cœur', '80 000 FCFA / mois', 'active', '2025-06-23 20:15:10', 'Laver, repasser et plier les vêtements\r\n\r\nTrier le linge selon les types de tissus\r\n\r\nVeiller à la propreté de l’espace de travail\r\n\r\nAccueillir les clients et gérer les dépôts/retraits', 'Sérieux(se), ponctuel(le) et propre\r\n\r\nCapable d’utiliser un fer à repasser\r\n\r\nEndurant(e) et organisé(e)\r\n\r\nDébutant accepté si motivé(e)', 'Temps plein', 'À négocier'),
(8, 15, 'Assistant(e) de planning', '', 'Dakar, HLM', '100 000 FCFA / mois', 'active', '2025-06-23 20:18:07', 'Prendre les appels et réserver les courses\r\n\r\nOrganiser les plannings des chauffeurs\r\n\r\nSuivre les itinéraires et signaler les retards\r\n\r\nAssurer une bonne communication avec les clients', 'Aisance au téléphone\r\n\r\nBonne organisation et esprit logique\r\n\r\nSavoir utiliser WhatsApp, Google Maps ou Excel\r\n\r\nCalme et réactif(ve)', 'Temps plein', 'À négocier'),
(9, 16, 'Aide-cuisinier(ère)', '', 'Dakar, Ouest-Foire', '90 000 FCFA / mois', 'active', '2025-06-23 20:22:07', 'Aider à la préparation des plats (sandwichs, plats du jour…)\r\n\r\nLaver et couper les légumes, nettoyer le plan de travail\r\n\r\nGérer les commandes simples\r\n\r\nRespecter les règles d’hygiène', 'Motivation pour travailler en cuisine\r\n\r\nPropreté, rapidité et discipline\r\n\r\nSavoir suivre des consignes\r\n\r\nExpérience souhaitée mais non obligatoire', 'Temps plein', 'À négocier'),
(10, 17, 'Assistant(e)', '', 'Guediawaye', '80000', 'active', '2025-07-12 10:55:44', 'gerer les appels', 'une personne ponctuelle et respectueuse', 'Temps plein', 'À négocier');

-- --------------------------------------------------------

--
-- Structure de la table `saved_jobs`
--

DROP TABLE IF EXISTS `saved_jobs`;
CREATE TABLE IF NOT EXISTS `saved_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `candidate_id` int NOT NULL,
  `job_id` int NOT NULL,
  `saved_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `job_id` (`job_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `saved_jobs`
--

INSERT INTO `saved_jobs` (`id`, `candidate_id`, `job_id`, `saved_at`) VALUES
(3, 1, 1, '2025-06-22 23:36:42');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `user_type` enum('candidate','recruiter','admin') NOT NULL,
  `company_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `company_id` (`company_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `last_name`, `user_type`, `company_id`, `is_active`, `created_at`, `name`, `full_name`, `company_name`) VALUES
(1, 'giniesambou@gmail.com', '$2y$10$0izIkwmzKun/aSohvcm5hev1KSDdS/s7BccJJqWOLsG9eudoX1SLK', 'Virginie', 'SAMBOU', 'candidate', NULL, 1, '2025-06-04 16:05:51', '', '', NULL),
(3, 'rosinesambou@gmail.com', '$2y$10$Ah0BY7eymEVsMiVLM.ogt.T.u32kRJbIQUbR/bgKNYWRIDofCLCfO', 'Rosine', 'SAMBOU', 'candidate', NULL, 1, '2025-06-04 16:30:54', '', '', NULL),
(4, 'henrysambou@gmail.com', '$2y$10$EhlDjNjBb3nn9lgfXXO8YuNG.nLvoVLSMs2N6ihm0nDTExXzbrYR6', 'Henry', 'SAMBOU', 'recruiter', NULL, 1, '2025-06-04 16:38:05', '', '', 'Senelec'),
(5, 'fatouds@gmail.com', '$2y$10$uHbHN38bCxqWObBIQ6d0E.27pBJBp6ialHRSuqiYAEo9Pp0bn5Jlu', 'Fatou', 'SANE', 'recruiter', NULL, 1, '2025-06-20 17:43:47', '', '', 'EMG'),
(6, 'ginieginger@gmail.com', '$2y$10$t3MIDojUdRjZhLQ5.zC8rO4lFu6Re8Q9m2o5AofVXjCQ1g92gL9Ta', 'Ginie', 'SAMBOU', 'candidate', NULL, 1, '2025-06-20 17:47:17', '', '', NULL),
(7, 'mamyfaye@gmail.com', '$2y$10$szRno.a5O6aawF861FMhi.3BLeXaG.Cr4UzwWHfwgtqpPxywlmvs.', 'Mamy', 'FAYE', 'candidate', NULL, 1, '2025-06-20 22:42:36', '', '', NULL),
(8, 'amdoux06@gmail.com', '$2y$10$QUs9bL2Nwoes75Yp44oTRuf.dT8DhzTGzJ0RsNLxn0m7tLw3QvtVO', 'AmdouX', 'TEUW', 'recruiter', NULL, 1, '2025-06-21 11:01:32', '', '', 'AmGn Automobiles – Vente de voitures'),
(9, 'nanciasambou@gmail.com', '$2y$10$yLyajyWBC0QkjEX1vFoSxOAiOVUlNd8gXQEJQEY9kQzXYVwME2U0u', 'Nancia', 'SAMBOU', 'recruiter', NULL, 1, '2025-06-21 11:11:54', '', '', 'MarieAnne SHOP'),
(10, 'yacou@gmail.com', '$2y$10$eT6Y2EJADK7DSY7kHDWLveMF9/XbHUKunN1msXEEbk4oTQ6Cqmg0a', 'yacouba', 'Arama', 'candidate', NULL, 1, '2025-06-21 11:46:33', '', '', NULL),
(11, 'abdelkader@gmail.com', '$2y$10$PjWnk7ZQGZ9epmy3e9dALOAGzq.hlPWKLGM/EcuNZSxJMXu3chFye', 'Kader', 'Drame', 'recruiter', NULL, 1, '2025-06-23 20:03:35', '', '', 'Domitek Services – Maintenance et équipements domestiques'),
(12, 'nms@gmail.com', '$2y$10$k6CqCqbo84X4sRq31WCdnObD.sX6T3mJpAezy6n6/axEAzN2M.wZ6', 'Marieme', 'SALL', 'recruiter', NULL, 1, '2025-06-23 20:07:25', '', '', 'Snack Express – Restauration rapide'),
(14, 'djibson@gmail.com', '$2y$10$zMDJYYrWidxpU/edTJi4RusIdIZcuImNBVx2tgAtu3OyPKE73trTG', 'Djibril', 'MBAYE', 'recruiter', NULL, 1, '2025-06-23 20:14:05', '', '', 'Lavage Pro – Blanchisserie'),
(15, 'layegana@gmail.com', '$2y$10$.J2g1RERaQFFPtdZUFvhh.JP7ex9an8cVDQN9bgUUYJnw3qCTuv96', 'Ablaye', 'DIOCKOU', 'recruiter', NULL, 1, '2025-06-23 20:17:10', '', '', 'GoTaxi – Réseau de transport'),
(16, 'sndiaye@gmail.com', '$2y$10$5Otkk/oQ6ivU4UoNZiSLAuHTliOgw2AaJDQYqWPV93v2PoyJaKiAy', 'Samba', 'DIOUF', 'recruiter', NULL, 1, '2025-06-23 20:20:47', '', '', 'Téranga Food'),
(17, 'maraseye@gmail.com', '$2y$10$5VvzxDuitEgKwM5cBGNyBe.mZOi1J8ibgBohgubRxuf32Zzy78P5C', 'Mara', 'SEYE', 'recruiter', NULL, 1, '2025-07-12 10:52:43', '', '', 'SEYE TELECOM');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
