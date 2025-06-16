-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 16 juin 2025 à 06:38
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestiondesprojets`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add member', 7, 'add_member'),
(26, 'Can change member', 7, 'change_member'),
(27, 'Can delete member', 7, 'delete_member'),
(28, 'Can view member', 7, 'view_member'),
(29, 'Can add project', 8, 'add_project'),
(30, 'Can change project', 8, 'change_project'),
(31, 'Can delete project', 8, 'delete_project'),
(32, 'Can view project', 8, 'view_project'),
(33, 'Can add team', 9, 'add_team'),
(34, 'Can change team', 9, 'change_team'),
(35, 'Can delete team', 9, 'delete_team'),
(36, 'Can view team', 9, 'view_team'),
(37, 'Can add task', 10, 'add_task'),
(38, 'Can change task', 10, 'change_task'),
(39, 'Can delete task', 10, 'delete_task'),
(40, 'Can view task', 10, 'view_task');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'gestiondesprojetsapp', 'member'),
(8, 'gestiondesprojetsapp', 'project'),
(9, 'gestiondesprojetsapp', 'team'),
(10, 'gestiondesprojetsapp', 'task');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-15 22:55:29.132904'),
(2, 'auth', '0001_initial', '2025-06-15 22:55:38.851022'),
(3, 'admin', '0001_initial', '2025-06-15 22:55:41.246106'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-06-15 22:55:41.274515'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-15 22:55:41.296417'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-06-15 22:55:41.886265'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-06-15 22:55:42.301317'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-06-15 22:55:42.745870'),
(9, 'auth', '0004_alter_user_username_opts', '2025-06-15 22:55:42.768667'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-06-15 22:55:43.072421'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-06-15 22:55:43.075520'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-06-15 22:55:43.096489'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-06-15 22:55:43.319518'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-06-15 22:55:43.626050'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-06-15 22:55:43.956763'),
(16, 'auth', '0011_update_proxy_permissions', '2025-06-15 22:55:43.982990'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-06-15 22:55:44.246744'),
(18, 'gestiondesprojetsapp', '0001_initial', '2025-06-15 22:55:47.202066'),
(19, 'sessions', '0001_initial', '2025-06-15 22:55:47.569469'),
(20, 'gestiondesprojetsapp', '0002_remove_member_created_at_remove_member_updated_at_and_more', '2025-06-16 01:22:37.736339'),
(21, 'gestiondesprojetsapp', '0003_alter_member_team', '2025-06-16 04:16:35.871444');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gestiondesprojetsapp_member`
--

DROP TABLE IF EXISTS `gestiondesprojetsapp_member`;
CREATE TABLE IF NOT EXISTS `gestiondesprojetsapp_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `role` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `skills` longtext,
  `status` varchar(20) NOT NULL,
  `avatar_emoji` varchar(2) NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestiondesprojetsapp_member_team_id_6e6f0108` (`team_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `gestiondesprojetsapp_member`
--

INSERT INTO `gestiondesprojetsapp_member` (`id`, `name`, `role`, `email`, `skills`, `status`, `avatar_emoji`, `team_id`) VALUES
(1, 'John Doe', 'Developer', 'john.doe@example.com', 'Python, Django, JavaScript', 'Active', '😎', 1),
(3, 'Peter Jones', 'Project Manager', 'peter.jones@example.com', 'Agile, Scrum, Kanban', 'Active', '💼', 1),
(4, 'Alice Brown', 'QA Engineer', 'alice.brown@example.com', 'Testing, Selenium, JUnit', 'Active', '🐞', 2);

-- --------------------------------------------------------

--
-- Structure de la table `gestiondesprojetsapp_project`
--

DROP TABLE IF EXISTS `gestiondesprojetsapp_project`;
CREATE TABLE IF NOT EXISTS `gestiondesprojetsapp_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `priority` varchar(10) NOT NULL,
  `deadline` date NOT NULL,
  `budget` decimal(12,2) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestiondesprojetsapp_project_team_id_7bc55b81` (`team_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `gestiondesprojetsapp_project`
--

INSERT INTO `gestiondesprojetsapp_project` (`id`, `name`, `description`, `priority`, `deadline`, `budget`, `updated_at`, `created_at`, `team_id`) VALUES
(1, 'Projet Alpha', 'Développement d\'une plateforme web', 'high', '2025-12-31', 50000.00, '2025-06-15 23:29:13.988871', '2025-06-15 23:19:31.000000', 1),
(2, 'Projet Beta', 'Analyse de données et visualisation', 'high', '2025-11-30', 31000.00, '2025-06-15 23:28:44.876754', '2025-06-15 23:19:31.000000', 2),
(3, 'Projet Gamma', 'Optimisation des performances système', 'medium', '2026-01-15', 45000.00, '2025-06-15 23:29:06.965741', '2025-06-15 23:19:31.000000', 1),
(4, 'Projet Delta', 'Migration vers le cloud', 'high', '2025-10-20', 35000.00, '2025-06-15 23:29:20.854421', '2025-06-15 23:19:31.000000', 3),
(5, 'Projet Epsilon', 'Automatisation des tâches administratives', 'medium', '2025-09-15', 25000.00, '2025-06-15 23:29:26.271132', '2025-06-15 23:19:31.000000', 2),
(6, 'Flutter Project', 'Projet d\'application mobile', 'high', '2025-06-22', 10000.00, '2025-06-15 23:42:05.658006', '2025-06-15 23:42:05.658052', 1),
(8, 'fiscalité', 'Compo de fiscalité', 'Normal', '2025-06-21', 10000.00, '0000-00-00 00:00:00.000000', '2025-06-16 02:26:27.524958', 8),
(9, 'IA et BIG DATA', 'Ia & big data', 'low', '2025-06-29', 0.00, '2025-06-16 02:29:09.383405', '2025-06-16 02:29:09.383467', 7);

-- --------------------------------------------------------

--
-- Structure de la table `gestiondesprojetsapp_task`
--

DROP TABLE IF EXISTS `gestiondesprojetsapp_task`;
CREATE TABLE IF NOT EXISTS `gestiondesprojetsapp_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `priority` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `due_date` date NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `assigned_to_id` bigint DEFAULT NULL,
  `project_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestiondesprojetsapp_task_assigned_to_id_3b4d50cd` (`assigned_to_id`),
  KEY `gestiondesprojetsapp_task_project_id_3720e0df` (`project_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `gestiondesprojetsapp_task`
--

INSERT INTO `gestiondesprojetsapp_task` (`id`, `title`, `description`, `priority`, `status`, `due_date`, `created_at`, `updated_at`, `assigned_to_id`, `project_id`) VALUES
(1, 'Conception de la maquette', 'Créer une maquette pour la plateforme web', 'Haute', 'completed', '2025-07-01', '2025-06-15 23:23:13.000000', '2025-06-16 04:40:04.075215', 1, 1),
(2, 'Développement du backend', 'Implémentation du serveur et de la base de données', 'Élevée', 'pending', '2025-08-15', '2025-06-15 23:23:13.000000', '2025-06-16 04:39:53.736147', 2, 1),
(3, 'Analyse des données clients', 'Explorer les tendances et visualisations pertinentes', 'Moyenne', 'En attente', '2025-10-01', '2025-06-15 23:23:13.000000', '2025-06-15 23:23:13.000000', 3, 2),
(4, 'Optimisation du code', 'Améliorer la performance des scripts existants', 'Haute', 'completed', '2025-09-30', '2025-06-15 23:23:13.000000', '2025-06-15 23:59:09.256456', 4, 3),
(5, 'Migration des données', 'Préparer et transférer les données vers le cloud', 'Moyenne', 'Non commen', '2025-09-15', '2025-06-15 23:23:13.000000', '2025-06-15 23:23:13.000000', NULL, 4),
(6, 'Configuration de l\'hébergement', 'Mettre en place l\'architecture cloud', 'Élevée', 'Planifié', '2025-10-05', '2025-06-15 23:23:13.000000', '2025-06-15 23:23:13.000000', 6, 4),
(7, 'Automatisation des processus', 'Créer des scripts pour automatiser les tâches récurrentes', 'Haute', 'completed', '2025-11-15', '2025-06-15 23:23:13.000000', '2025-06-16 02:38:32.787885', 7, 5),
(8, 'Test de la sécurité', 'Effectuer des audits et renforcer les protections', 'Élevée', 'completed', '2025-12-01', '2025-06-15 23:23:13.000000', '2025-06-16 04:47:22.249604', 8, 1),
(9, 'Déploiement de l\'application', 'Publier la plateforme en ligne', 'Critique', 'completed', '2025-12-20', '2025-06-15 23:23:13.000000', '2025-06-16 04:47:23.512701', 9, 1),
(10, 'Rapport final', 'Rédiger et présenter les résultats du projet', 'Moyenne', 'completed', '2025-12-31', '2025-06-15 23:23:13.000000', '2025-06-15 23:37:51.317200', 10, 2),
(11, 'Flutter Tache', 'Futter Tache', 'medium', 'completed', '2025-06-22', '2025-06-15 23:55:25.604226', '2025-06-15 23:55:58.418518', NULL, 6),
(12, 'Flutter Tache 2', 'Flutter Tache 2', 'high', 'pending', '2025-06-26', '2025-06-15 23:56:54.686643', '2025-06-16 01:57:24.271530', NULL, 6),
(13, 'hsdhsjh', 'dcjldicjd', 'low', 'pending', '2025-06-16', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', 1, 3),
(14, 'Bosser ECUE1', 'bossons ECUE 1', 'high', 'pending', '2025-06-16', '0000-00-00 00:00:00.000000', '2025-06-16 04:18:28.949606', 4, 8),
(15, 'Bosser ECUE 2', 'Bosser ECUE 2', 'high', 'completed', '2025-06-28', '2025-06-16 02:29:41.431747', '2025-06-16 02:29:41.431778', 4, 2),
(16, 'Data', 'Data', 'high', 'completed', '2025-06-16', '0000-00-00 00:00:00.000000', '2025-06-16 02:37:33.710370', NULL, 9),
(17, 'Perfect Tâche 3', 'ssd', 'high', 'pending', '2025-06-20', '2025-06-16 02:34:39.122223', '2025-06-16 02:34:39.122278', 4, 2),
(18, 'Ajout de tâche', 'ajout de tâche', 'high', 'pending', '2025-06-20', '2025-06-16 02:35:39.793282', '2025-06-16 02:35:39.793332', 4, 3),
(19, 'Dataming', 'data', 'high', 'completed', '2025-06-20', '2025-06-16 02:37:07.398329', '2025-06-16 02:37:45.133010', 4, 9);

-- --------------------------------------------------------

--
-- Structure de la table `gestiondesprojetsapp_team`
--

DROP TABLE IF EXISTS `gestiondesprojetsapp_team`;
CREATE TABLE IF NOT EXISTS `gestiondesprojetsapp_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `gestiondesprojetsapp_team`
--

INSERT INTO `gestiondesprojetsapp_team` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Team Alpha', 'Développement de solutions web', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(2, 'Team Beta', 'Analyse et visualisation de données', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(3, 'Team Gamma', 'Optimisation des performances systèmes', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(4, 'Team Delta', 'Infrastructure et migration cloud', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(5, 'Team Epsilon', 'Automatisation des processus', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(6, 'Team Zeta', 'Sécurité et audits techniques', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(7, 'Team Theta', 'Gestion de projets et coordination', '2025-06-15 23:24:17.000000', '2025-06-15 23:24:17.000000'),
(8, 'dd', 'zd', '2025-06-16 01:32:42.881133', '2025-06-16 01:32:42.905268');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
