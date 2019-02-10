SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `article` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `organization_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity_unit_id` int(10) UNSIGNED NOT NULL,
  `default_unit_price` decimal(10,2) UNSIGNED NOT NULL,
  `default_tax` decimal(3,3) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `article_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `article_variety` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `plant_id` int(10) UNSIGNED NOT NULL,
  `variety_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bed` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `block_id` int(10) UNSIGNED NOT NULL,
  `name` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `block` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `zone_id` int(10) UNSIGNED NOT NULL,
  `name` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `sort` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `category` (`id`, `parent_id`, `key`, `value`, `sort`) VALUES
(1, NULL, 'task_category_id', '', 1),
(2, 1, 'crop_production', 'Production végétale', 1),
(3, 1, 'post_production', 'Post-production', 2),
(4, 1, 'trade', 'Commercialisation', 3),
(5, 2, 'primary', 'Principales opérations', 1),
(6, 2, 'maintenance', 'Préparation / Entretien', 3),
(7, 2, 'installation', 'Installation', 4),
(8, 2, 'destruction', 'Destruction', 5),
(9, 2, 'observation', 'Observation', 6),
(10, 5, 'seedling', 'Semis', 1),
(11, 5, 'planting', 'Plantation', 2),
(12, 6, 'loosening', 'Affinage du sol', 1),
(13, 6, 'mounding', 'Buttage', 2),
(14, 6, 'weed_control', 'Désherbage', 3),
(15, 6, 'uncompact', 'Décompactage du sol', 4),
(16, 6, 'fertilization', 'Fertilisation', 5),
(17, 6, 'irrigation', 'Irrigation', 6),
(18, 6, 'mulching', 'Paillage', 7),
(19, 6, 'trimming', 'Taille', 8),
(20, 6, 'pest_control', 'Traitement', 9),
(21, 7, 'irrigation', 'Irrigation', 1),
(22, 7, 'occultation', 'Occultation', 2),
(23, 7, 'climate_protection', 'Protection climatique', 3),
(24, 7, 'pest_protection', 'Protection ravageur', 4),
(25, 7, 'staking', 'Tuteurage', 5),
(26, 8, 'uprooting', 'Arrachage', 1),
(27, 8, 'grinding', 'Broyage', 2),
(28, 8, 'mowing', 'Fauchage', 3),
(29, 5, 'harvest', 'Récolte', 3),
(30, 8, 'rolling', 'Roulage', 5),
(31, 9, 'stage', 'Stade phénologique', 1),
(32, 3, 'sort', 'Tri', 1),
(33, 3, 'washing', 'Lavage', 2),
(34, 3, 'storage', 'Stockage', 3),
(35, 3, 'conditioning', 'Conditionnement', 4),
(36, 4, 'purchase', 'Achat', 1),
(37, 4, 'sale', 'Vente', 2),
(38, NULL, 'seedling_category_id', '', 1),
(39, 38, 'broadcasting', 'A la volée', 4),
(40, 38, 'drilling', 'En ligne', 2),
(41, 38, 'dibbling', 'En poquet', 3),
(42, NULL, 'installation_category_id', '', 1),
(43, 42, 'set', 'Pose', 1),
(44, 42, 'unset', 'Dépose', 2),
(45, NULL, 'stage_category_id', '', 1),
(46, 45, 'germination', 'Germination', 1),
(47, 45, 'growth', 'Croissance', 2),
(48, 45, 'flowering', 'Floraison', 3),
(49, 45, 'fruiting', 'Fructification', 4),
(50, 45, 'senescence', 'Sénescence', 5),
(51, NULL, 'article_category_id', '', 1),
(52, 51, 'seed', 'Semence', 1),
(53, 51, 'plant', 'Plant', 2),
(54, 51, 'harvest', 'Récolte', 3),
(55, 51, 'input', 'Intrant', 4),
(56, 51, 'tool', 'Outil', 5),
(57, 51, 'installation', 'Installation', 6),
(58, 51, 'cart', 'Panier', 7),
(59, NULL, 'article_quantity_unit_id', '', 1),
(60, 59, 'kg', 'kg', 1),
(61, 59, 'g', 'g', 2),
(62, 59, 'l', 'l', 3),
(63, 59, 'ml', 'ml', 4),
(64, 59, 'm', 'm', 5),
(65, 59, 'mm', 'mm', 6),
(66, 59, 'unit', 'pièce(s)', 7),
(67, 59, 'bunch', 'botte(s)', 8),
(68, 59, 'bouquet', 'bouquet(s)', 9),
(70, 38, 'pluging', 'En motte', 1),
(71, NULL, 'seedling_density_unit_id', '', 1),
(72, 71, 'g', 'g', 1),
(73, 71, 'seed', 'graine(s)', 2),
(74, NULL, 'seedling_area_unit_id', '', 1),
(75, 74, 'm²', 'm²', 1),
(76, 74, 'plug', 'motte(s)', 2),
(77, NULL, 'zone_category_id', '', 1),
(78, 77, 'field', 'Plein champ', 1),
(79, 77, 'greenhouse', 'Sous abri', 2),
(80, 74, 'tray', 'terrine(s)', 3),
(81, 71, 'cutting', 'bouture(s)', 3),
(82, NULL, 'planting_category_id', '', 1),
(83, 82, 'inline', 'En ligne', 1),
(84, 82, 'staggered', 'En quinconce', 2);

CREATE TABLE `crop` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `number` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `crop_location` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `crop_id` int(10) UNSIGNED NOT NULL,
  `zone_id` int(10) UNSIGNED NOT NULL,
  `block_id` int(10) UNSIGNED DEFAULT NULL,
  `bed_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `entity` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `family` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `family` (`id`, `name`) VALUES
(1, 'Alliaceae'),
(2, 'Apiaceae'),
(3, 'Asteraceae'),
(4, 'Boraginaceae'),
(5, 'Brassicaceae'),
(6, 'Caprifoliaceae'),
(7, 'Chenopodiaceae'),
(8, 'Convolvulaceae'),
(9, 'Cucurbitaceae'),
(10, 'Ericaceae'),
(11, 'Fabaceae'),
(12, 'Geraniaceae'),
(27, 'Hydrophyllaceae'),
(13, 'Iridaceae'),
(14, 'Juglandaceae'),
(15, 'Lamiaceae'),
(16, 'Liliaceae'),
(17, 'Linaceae'),
(18, 'Moraceae'),
(19, 'Poaceae'),
(20, 'Polygonaceae'),
(21, 'Rosaceae'),
(22, 'Rutaceae'),
(23, 'Solanaceae'),
(24, 'Tropaeolaceae'),
(26, 'Valerianaceae'),
(25, 'Vitaceae');

CREATE TABLE `genus` (
  `id` int(10) UNSIGNED NOT NULL,
  `family_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `genus` (`id`, `family_id`, `name`) VALUES
(6, 2, 'Anethum'),
(18, 2, 'Anthriscus'),
(19, 2, 'Apium'),
(24, 2, 'Coriandrum'),
(17, 2, 'Daucus'),
(27, 2, 'Foeniculum'),
(36, 2, 'Levisticum'),
(71, 2, 'Pastinaca'),
(49, 2, 'Petroselinum'),
(7, 2, 'Pimpinella'),
(4, 3, 'Achillea'),
(8, 3, 'Artemisia'),
(14, 3, 'Calendula'),
(15, 3, 'Chamaemelum'),
(20, 3, 'Cichorium'),
(65, 3, 'Cynara'),
(64, 3, 'Helianthus'),
(33, 3, 'Lactuca'),
(39, 3, 'Tagetes'),
(62, 3, 'Tanacetum'),
(12, 4, 'Borago'),
(55, 5, 'Armoracia'),
(13, 5, 'Brassica'),
(68, 5, 'Eruca'),
(25, 5, 'Lepidium'),
(54, 5, 'Raphanus'),
(44, 5, 'Sinapis'),
(61, 6, 'Sambucus'),
(11, 7, 'Beta'),
(26, 7, 'Spinacia'),
(32, 8, 'Ipomoea'),
(69, 9, 'Citrullus'),
(23, 9, 'Cucumis'),
(22, 9, 'Cucurbita'),
(47, 10, 'Vaccinium'),
(73, 11, 'Lens'),
(37, 11, 'Medicago'),
(3, 11, 'Phaseolus'),
(51, 11, 'Pisum'),
(66, 11, 'Trifolium'),
(28, 11, 'Vicia'),
(30, 12, 'Pelargonium'),
(31, 13, 'Gladiolus'),
(48, 14, 'Juglans'),
(34, 15, 'Hyssopus'),
(41, 15, 'Mentha'),
(43, 15, 'Monarda'),
(10, 15, 'Ocimum'),
(40, 15, 'Origanum'),
(57, 15, 'Rosmarinus'),
(60, 15, 'Salvia'),
(63, 15, 'Thymus'),
(5, 16, 'Allium'),
(9, 16, 'Asparagus'),
(35, 17, 'Linum'),
(45, 18, 'Morus'),
(72, 19, 'Avena'),
(76, 19, 'Secale'),
(38, 19, 'Zea'),
(75, 20, 'Fagopyrum'),
(56, 20, 'Rheum'),
(29, 21, 'Fragaria'),
(52, 21, 'Malus'),
(53, 21, 'Prunus'),
(50, 21, 'Pyrus'),
(58, 21, 'Rosa'),
(46, 21, 'Rubus'),
(59, 22, 'Ruta'),
(2, 23, 'Capsicum'),
(1, 23, 'Solanum'),
(16, 24, 'Tropaeolum'),
(67, 25, 'Vitis'),
(70, 26, 'Valerianella'),
(74, 27, 'Phacelia');

CREATE TABLE `input` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(10,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `installation` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `organization` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `supplier` tinyint(1) NOT NULL,
  `client` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `output` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `variety_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` decimal(10,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `photo` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `plant` (
  `id` int(10) UNSIGNED NOT NULL,
  `species_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `plant` (`id`, `species_id`, `name`) VALUES
(57, 1, 'Tomate'),
(59, 2, 'Pomme de terre'),
(55, 3, 'Piment'),
(56, 3, 'Poivron'),
(39, 4, 'Haricot'),
(49, 6, 'Ail'),
(1, 7, 'Aneth'),
(9, 8, 'Anis vert'),
(51, 10, 'Asperge'),
(58, 11, 'Aubergine'),
(44, 12, 'Basilic'),
(27, 13, 'Betterave'),
(26, 13, 'Blette'),
(15, 14, 'Bourrache'),
(82, 15, 'Brocoli'),
(77, 15, 'Chou cabus'),
(17, 15, 'Chou de Bruxelles'),
(79, 15, 'Chou frisé'),
(81, 15, 'Chou romanesco'),
(78, 15, 'Chou-fleur'),
(80, 15, 'Chou-rave'),
(60, 18, 'Capucine'),
(5, 19, 'Carotte'),
(2, 20, 'Cerfeuil commun'),
(3, 21, 'Cèleri'),
(10, 22, 'Chicorée'),
(83, 23, 'Chicorée amère'),
(11, 23, 'Endive'),
(50, 24, 'Ciboulette'),
(34, 25, 'Potimarron'),
(33, 25, 'Potiron'),
(36, 27, 'Courgette'),
(37, 27, 'Pâtisson'),
(35, 29, 'Courge musquée'),
(32, 30, 'Concombre'),
(31, 31, 'Melon'),
(4, 32, 'Coriandre'),
(23, 33, 'Cresson alénois'),
(46, 34, 'Échalote'),
(28, 35, 'Épinard'),
(6, 36, 'Fenouil'),
(41, 37, 'Fève'),
(66, 37, 'Féverole'),
(52, 40, 'Lin'),
(29, 41, 'Patate douce'),
(13, 42, 'Laitue'),
(7, 45, 'Livèche'),
(38, 46, 'Luzerne'),
(53, 47, 'Maïs'),
(42, 50, 'Menthe'),
(18, 51, 'Chou de Chine'),
(76, 51, 'Chou de Pékin'),
(19, 51, 'Mizuna'),
(21, 51, 'Navet'),
(20, 51, 'Navette'),
(43, 52, 'Monarde'),
(25, 53, 'Moutarde blanche'),
(47, 59, 'Oignon'),
(8, 61, 'Persil'),
(48, 62, 'Poireau'),
(40, 64, 'Pois'),
(24, 67, 'Radis'),
(16, 68, 'Raifort'),
(54, 69, 'Rhubarbe'),
(14, 74, 'Tanaisie'),
(45, 75, 'Thym'),
(12, 76, 'Tournesol'),
(75, 77, 'Topinambour'),
(61, 79, 'Vigne'),
(22, 80, 'Roquette'),
(30, 81, 'Pastèque'),
(62, 82, 'Mâche'),
(63, 83, 'Panais'),
(64, 84, 'Avoine'),
(65, 85, 'Colza'),
(67, 86, 'Lentille'),
(68, 87, 'Phacélie'),
(69, 88, 'Sarrasin'),
(70, 89, 'Seigle'),
(71, 90, 'Trèfle d\'Alexandrie'),
(72, 91, 'Trèfle incarnat'),
(73, 92, 'Vesce commune'),
(74, 93, 'Vesce velue');

CREATE TABLE `planting` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `output_id` int(10) UNSIGNED DEFAULT NULL,
  `variety_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `intra_row_spacing` smallint(5) UNSIGNED NOT NULL,
  `inter_row_spacing` smallint(5) UNSIGNED NOT NULL,
  `area` decimal(10,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `role` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `role_access` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `resource` varchar(255) NOT NULL,
  `create` tinyint(1) NOT NULL,
  `update` tinyint(1) NOT NULL,
  `delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `seedling` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `output_id` int(10) UNSIGNED DEFAULT NULL,
  `variety_id` int(10) UNSIGNED NOT NULL,
  `nursery` tinyint(1) NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `density` decimal(10,2) UNSIGNED NOT NULL,
  `density_unit_id` int(10) UNSIGNED NOT NULL,
  `area` decimal(10,2) UNSIGNED NOT NULL,
  `area_unit_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `species` (
  `id` int(10) UNSIGNED NOT NULL,
  `genus_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `species` (`id`, `genus_id`, `name`) VALUES
(1, 1, 'lycopersicum'),
(11, 1, 'melongena'),
(2, 1, 'tuberosum'),
(3, 2, 'annuum'),
(4, 3, 'vulgaris'),
(5, 4, 'millefolium'),
(34, 5, 'ascalonicum'),
(59, 5, 'cepa'),
(62, 5, 'porrum'),
(6, 5, 'sativum'),
(24, 5, 'schoenoprasum'),
(7, 6, 'graveolens'),
(8, 7, 'anisum'),
(9, 8, 'dracunculus'),
(10, 9, 'officinalis'),
(12, 10, 'basilicum'),
(13, 11, 'vulgaris'),
(14, 12, 'officinalis'),
(85, 13, 'Napus'),
(15, 13, 'oleracea'),
(51, 13, 'rapa'),
(16, 14, 'officinalis'),
(17, 15, 'nobile'),
(18, 16, 'majus'),
(19, 17, 'carota'),
(20, 18, 'cerefolium'),
(21, 19, 'graveolens'),
(22, 20, 'endivia'),
(23, 20, 'intybus'),
(28, 22, 'argyrosperma'),
(26, 22, 'ficifolia'),
(25, 22, 'maxima'),
(29, 22, 'moschata'),
(27, 22, 'pepo'),
(31, 23, 'melo'),
(30, 23, 'sativus'),
(32, 24, 'sativum'),
(33, 25, 'sativum'),
(35, 26, 'oleracea'),
(36, 27, 'vulgare'),
(37, 28, 'faba'),
(92, 28, 'sativa'),
(93, 28, 'villosa'),
(38, 29, '×ananassa'),
(39, 30, '×domesticum'),
(40, 31, 'communis'),
(41, 32, 'batatas'),
(42, 33, 'sativa'),
(43, 34, 'officinalis'),
(44, 35, 'usitatissimum'),
(45, 36, 'officinalis'),
(46, 37, 'sativa'),
(47, 38, 'mays'),
(48, 39, 'patula'),
(49, 40, 'majorana'),
(60, 40, 'vulgare'),
(50, 41, 'spicata'),
(52, 43, 'didyma'),
(53, 44, 'alba'),
(54, 45, 'nigra'),
(55, 46, 'fruticosus'),
(56, 46, 'idaeus'),
(57, 47, 'myrtillus'),
(58, 48, 'regia'),
(61, 49, 'crispum'),
(63, 50, 'communis'),
(64, 51, 'sativum'),
(65, 52, 'domestica'),
(66, 53, 'domestica'),
(67, 54, 'sativus'),
(68, 55, 'rusticana'),
(69, 56, 'rhabarbarum'),
(70, 57, 'officinalis'),
(71, 59, 'graveolens'),
(72, 60, 'officinalis'),
(73, 61, 'nigra'),
(74, 62, 'vulgare'),
(75, 63, 'vulgaris'),
(76, 64, 'annuus'),
(77, 64, 'tuberosus'),
(78, 65, 'cardunculus'),
(90, 66, 'alexandrinum'),
(91, 66, 'incarnatum'),
(79, 67, 'vinifera'),
(80, 68, 'sativa'),
(81, 69, 'lanatus'),
(82, 70, 'locusta'),
(83, 71, 'sativa'),
(84, 72, 'sativa'),
(86, 73, 'culinaris'),
(87, 74, 'tanacetifolia'),
(88, 75, 'esculentum'),
(89, 76, 'cereale');

CREATE TABLE `stage` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `variety_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `task` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `crop_id` int(10) UNSIGNED DEFAULT NULL,
  `output_id` int(10) UNSIGNED DEFAULT NULL,
  `organization_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `description` text,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tooling` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `trading` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL,
  `output_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` decimal(10,2) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) UNSIGNED NOT NULL,
  `tax` decimal(3,3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `trading_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `trading_id` int(10) UNSIGNED NOT NULL,
  `output_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(10,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `variety` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `plant_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `working` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `duration` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `zone` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`organization_id`,`name`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `category_id` (`category_id`),
  ADD KEY `quantity_unit_id` (`quantity_unit_id`);

ALTER TABLE `article_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`article_id`,`category_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `category_id` (`category_id`) USING BTREE;

ALTER TABLE `article_variety`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`article_id`,`plant_id`,`variety_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `plant_id` (`plant_id`) USING BTREE,
  ADD KEY `variety_id` (`variety_id`);

ALTER TABLE `bed`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`block_id`,`name`) USING BTREE,
  ADD KEY `block_id` (`block_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE;

ALTER TABLE `block`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`zone_id`,`name`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `zone_id` (`zone_id`) USING BTREE;

ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`parent_id`,`key`) USING BTREE,
  ADD UNIQUE KEY `unique_2` (`parent_id`,`sort`) USING BTREE,
  ADD KEY `parent_id` (`parent_id`);

ALTER TABLE `crop`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`article_id`,`number`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE;

ALTER TABLE `crop_location`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`crop_id`,`zone_id`,`block_id`,`bed_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `crop_id` (`crop_id`) USING BTREE,
  ADD KEY `bed_id` (`bed_id`) USING BTREE,
  ADD KEY `zone_id` (`zone_id`),
  ADD KEY `block_id` (`block_id`);

ALTER TABLE `entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `family`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `genus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`family_id`,`name`) USING BTREE,
  ADD KEY `family_id` (`family_id`);

ALTER TABLE `input`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE;

ALTER TABLE `installation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`category_id`,`article_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `category_id` (`category_id`);

ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`name`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE;

ALTER TABLE `output`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`,`variety_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `variety_id` (`variety_id`) USING BTREE;

ALTER TABLE `photo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`url`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE;

ALTER TABLE `plant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`species_id`,`name`) USING BTREE,
  ADD KEY `species_id` (`species_id`);

ALTER TABLE `planting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`,`output_id`,`variety_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `variety_id` (`variety_id`) USING BTREE,
  ADD KEY `output_id` (`output_id`),
  ADD KEY `category_id` (`category_id`);

ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`name`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`);

ALTER TABLE `role_access`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`role_id`,`resource`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `role_id` (`role_id`) USING BTREE;

ALTER TABLE `seedling`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`,`output_id`,`variety_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `variety_id` (`variety_id`) USING BTREE,
  ADD KEY `category_id` (`category_id`),
  ADD KEY `density_unit_id` (`density_unit_id`),
  ADD KEY `length_unit_id` (`area_unit_id`),
  ADD KEY `output_id` (`output_id`);

ALTER TABLE `species`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`genus_id`,`name`) USING BTREE,
  ADD KEY `genus_id` (`genus_id`) USING BTREE;

ALTER TABLE `stage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`category_id`,`variety_id`) USING BTREE,
  ADD KEY `variety_id` (`variety_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `category_id` (`category_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE;

ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`crop_id`,`output_id`,`organization_id`,`category_id`,`date`) USING BTREE,
  ADD KEY `crop_id` (`crop_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `organization_id` (`organization_id`) USING BTREE,
  ADD KEY `output_id` (`output_id`);

ALTER TABLE `tooling`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`),
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE;

ALTER TABLE `trading`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`article_id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `article_id` (`article_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `output_id` (`output_id`) USING BTREE;

ALTER TABLE `trading_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`trading_id`,`output_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `output_id` (`output_id`) USING BTREE,
  ADD KEY `trade_id` (`trading_id`) USING BTREE;

ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`email`);

ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`user_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `role_id` (`role_id`);

ALTER TABLE `variety`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`plant_id`,`name`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `plant_id` (`plant_id`) USING BTREE;

ALTER TABLE `working`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`task_id`,`user_id`) USING BTREE,
  ADD KEY `entity_id` (`entity_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

ALTER TABLE `zone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`entity_id`,`name`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `category_id` (`category_id`);


ALTER TABLE `article`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
ALTER TABLE `article_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `article_variety`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
ALTER TABLE `bed`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
ALTER TABLE `block`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
ALTER TABLE `crop`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
ALTER TABLE `crop_location`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
ALTER TABLE `entity`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `family`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
ALTER TABLE `genus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;
ALTER TABLE `input`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `installation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `organization`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `output`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
ALTER TABLE `photo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `plant`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
ALTER TABLE `planting`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `role_access`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `seedling`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `species`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
ALTER TABLE `stage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `task`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
ALTER TABLE `tooling`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `trading`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `trading_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `user_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `variety`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
ALTER TABLE `working`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
ALTER TABLE `zone`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_ibfk_4` FOREIGN KEY (`quantity_unit_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

ALTER TABLE `article_category`
  ADD CONSTRAINT `article_category_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_category_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_category_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

ALTER TABLE `article_variety`
  ADD CONSTRAINT `article_variety_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_variety_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_variety_ibfk_3` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `article_variety_ibfk_4` FOREIGN KEY (`variety_id`) REFERENCES `variety` (`id`) ON DELETE SET NULL;

ALTER TABLE `bed`
  ADD CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bed_ibfk_2` FOREIGN KEY (`block_id`) REFERENCES `block` (`id`) ON DELETE CASCADE;

ALTER TABLE `block`
  ADD CONSTRAINT `block_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `block_ibfk_2` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`) ON DELETE CASCADE;

ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

ALTER TABLE `crop`
  ADD CONSTRAINT `crop_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crop_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE;

ALTER TABLE `crop_location`
  ADD CONSTRAINT `crop_location_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crop_location_ibfk_2` FOREIGN KEY (`crop_id`) REFERENCES `crop` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crop_location_ibfk_3` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crop_location_ibfk_4` FOREIGN KEY (`block_id`) REFERENCES `block` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `crop_location_ibfk_5` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id`) ON DELETE SET NULL;

ALTER TABLE `genus`
  ADD CONSTRAINT `genus_ibfk_1` FOREIGN KEY (`family_id`) REFERENCES `family` (`id`) ON DELETE CASCADE;

ALTER TABLE `input`
  ADD CONSTRAINT `input_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `input_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `input_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE;

ALTER TABLE `organization`
  ADD CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE;

ALTER TABLE `output`
  ADD CONSTRAINT `output_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `output_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `output_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `output_ibfk_4` FOREIGN KEY (`variety_id`) REFERENCES `variety` (`id`);

ALTER TABLE `photo`
  ADD CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `photo_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE;

ALTER TABLE `plant`
  ADD CONSTRAINT `plant_ibfk_1` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`) ON DELETE CASCADE;

ALTER TABLE `planting`
  ADD CONSTRAINT `planting_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `planting_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `planting_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `planting_ibfk_4` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `planting_ibfk_5` FOREIGN KEY (`variety_id`) REFERENCES `variety` (`id`),
  ADD CONSTRAINT `planting_ibfk_6` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

ALTER TABLE `role`
  ADD CONSTRAINT `role_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE;

ALTER TABLE `role_access`
  ADD CONSTRAINT `role_access_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_access_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE;

ALTER TABLE `seedling`
  ADD CONSTRAINT `seedling_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_4` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_5` FOREIGN KEY (`variety_id`) REFERENCES `variety` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_6` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_7` FOREIGN KEY (`density_unit_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seedling_ibfk_8` FOREIGN KEY (`area_unit_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

ALTER TABLE `species`
  ADD CONSTRAINT `species_ibfk_1` FOREIGN KEY (`genus_id`) REFERENCES `genus` (`id`) ON DELETE CASCADE;

ALTER TABLE `stage`
  ADD CONSTRAINT `stage_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stage_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stage_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stage_ibfk_4` FOREIGN KEY (`variety_id`) REFERENCES `variety` (`id`) ON DELETE CASCADE;

ALTER TABLE `task`
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_ibfk_2` FOREIGN KEY (`crop_id`) REFERENCES `crop` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_ibfk_3` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_ibfk_4` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_ibfk_5` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

ALTER TABLE `tooling`
  ADD CONSTRAINT `tooling_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tooling_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tooling_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE;

ALTER TABLE `trading`
  ADD CONSTRAINT `trading_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trading_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trading_ibfk_3` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trading_ibfk_4` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE CASCADE;

ALTER TABLE `trading_item`
  ADD CONSTRAINT `trading_item_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trading_item_ibfk_2` FOREIGN KEY (`trading_id`) REFERENCES `trading` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trading_item_ibfk_3` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE CASCADE;

ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_role_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE;

ALTER TABLE `variety`
  ADD CONSTRAINT `variety_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `variety_ibfk_2` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`id`) ON DELETE CASCADE;

ALTER TABLE `working`
  ADD CONSTRAINT `working_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `working_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `working_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `zone`
  ADD CONSTRAINT `zone_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `zone_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
