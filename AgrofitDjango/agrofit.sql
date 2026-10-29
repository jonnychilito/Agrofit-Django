-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.11.16-MariaDB - MariaDB Server
-- Server OS:                    Win64
-- HeidiSQL Version:             12.19.0.7314
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for agrofit
CREATE DATABASE IF NOT EXISTS `agrofit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci */;
USE `agrofit`;

-- Dumping structure for table agrofit.administradores
CREATE TABLE IF NOT EXISTS `administradores` (
  `idAdmin` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAdmin`),
  KEY `FK_administradores_usuarios` (`idUsuario_fk`),
  CONSTRAINT `FK_administradores_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.administradores: ~0 rows (approximately)
INSERT INTO `administradores` (`idAdmin`, `idUsuario_fk`) VALUES
	(1, 1);

-- Dumping structure for table agrofit.aprendices
CREATE TABLE IF NOT EXISTS `aprendices` (
  `idAprendiz` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  `idFicha_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAprendiz`),
  KEY `FK_aprendices_usuarios` (`idUsuario_fk`),
  KEY `FK_aprendices_fichas` (`idFicha_fk`),
  CONSTRAINT `FK_aprendices_fichas` FOREIGN KEY (`idFicha_fk`) REFERENCES `fichas` (`idFicha`) ON UPDATE CASCADE,
  CONSTRAINT `FK_aprendices_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.aprendices: ~12 rows (approximately)
INSERT INTO `aprendices` (`idAprendiz`, `idUsuario_fk`, `idFicha_fk`) VALUES
	(1, 6, 1),
	(2, 7, 1),
	(3, 8, 2),
	(4, 9, 2),
	(5, 10, 3),
	(6, 11, 3),
	(7, 12, 4),
	(8, 13, 4),
	(9, 14, 5),
	(10, 15, 6),
	(13, 27, 1),
	(16, 31, 2);

-- Dumping structure for table agrofit.aprendiz_rutina
CREATE TABLE IF NOT EXISTS `aprendiz_rutina` (
  `idAprendizRutina` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  `idRutina_fk` int(11) NOT NULL,
  `fechaAsignacion` date NOT NULL,
  `estado` enum('ACTIVA','COMPLETADA','CANCELADA') DEFAULT 'ACTIVA',
  PRIMARY KEY (`idAprendizRutina`),
  KEY `FK_ar_rutinas` (`idRutina_fk`),
  KEY `FK_aprendiz_rutina_usuarios` (`idUsuario_fk`),
  CONSTRAINT `FK_aprendiz_rutina_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ar_rutinas` FOREIGN KEY (`idRutina_fk`) REFERENCES `rutinas` (`idRutina`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.aprendiz_rutina: ~15 rows (approximately)
INSERT INTO `aprendiz_rutina` (`idAprendizRutina`, `idUsuario_fk`, `idRutina_fk`, `fechaAsignacion`, `estado`) VALUES
	(1, 6, 6, '2026-08-01', 'COMPLETADA'),
	(2, 6, 7, '2026-10-05', 'ACTIVA'),
	(3, 13, 6, '2024-08-01', 'COMPLETADA'),
	(4, 7, 1, '2024-10-05', 'ACTIVA'),
	(5, 8, 5, '2024-09-01', 'ACTIVA'),
	(6, 9, 6, '2024-09-01', 'ACTIVA'),
	(7, 10, 3, '2024-08-15', 'ACTIVA'),
	(8, 11, 4, '2024-08-15', 'ACTIVA'),
	(9, 12, 8, '2024-09-10', 'ACTIVA'),
	(10, 13, 6, '2024-09-10', 'ACTIVA'),
	(11, 14, 2, '2024-10-01', 'ACTIVA'),
	(12, 15, 5, '2024-10-01', 'ACTIVA'),
	(14, 27, 8, '2026-09-24', 'ACTIVA'),
	(15, 2, 1, '2026-09-25', 'ACTIVA'),
	(17, 31, 2, '2026-09-26', 'ACTIVA');

-- Dumping structure for table agrofit.asistencias
CREATE TABLE IF NOT EXISTS `asistencias` (
  `idAsistencia` int(11) NOT NULL AUTO_INCREMENT,
  `idAprendiz_fk` int(11) NOT NULL,
  `fechaAsistencia` date NOT NULL,
  `horaEntrada` time DEFAULT NULL,
  `horaSalida` time DEFAULT NULL,
  `estado` enum('PRESENTE','AUSENTE','EXCUSA') DEFAULT 'PRESENTE',
  PRIMARY KEY (`idAsistencia`),
  KEY `FK_asistencias_aprendices` (`idAprendiz_fk`),
  CONSTRAINT `FK_asistencias_aprendices` FOREIGN KEY (`idAprendiz_fk`) REFERENCES `aprendices` (`idAprendiz`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.asistencias: ~20 rows (approximately)
INSERT INTO `asistencias` (`idAsistencia`, `idAprendiz_fk`, `fechaAsistencia`, `horaEntrada`, `horaSalida`, `estado`) VALUES
	(1, 1, '2024-11-04', '06:00:00', '07:30:00', 'PRESENTE'),
	(2, 1, '2024-11-05', '06:05:00', '07:35:00', 'PRESENTE'),
	(3, 1, '2024-11-06', NULL, NULL, 'AUSENTE'),
	(4, 1, '2024-11-07', '06:00:00', '07:30:00', 'PRESENTE'),
	(5, 2, '2024-11-04', '06:10:00', '07:40:00', 'PRESENTE'),
	(6, 2, '2024-11-05', NULL, NULL, 'EXCUSA'),
	(7, 2, '2024-11-06', '06:00:00', '07:30:00', 'PRESENTE'),
	(8, 3, '2024-11-04', '14:00:00', '15:30:00', 'PRESENTE'),
	(9, 3, '2024-11-05', '14:00:00', '15:30:00', 'PRESENTE'),
	(10, 3, '2024-11-06', NULL, NULL, 'AUSENTE'),
	(11, 4, '2024-11-04', '14:05:00', '15:35:00', 'PRESENTE'),
	(12, 4, '2024-11-07', NULL, NULL, 'AUSENTE'),
	(13, 5, '2024-11-04', '18:00:00', '19:30:00', 'PRESENTE'),
	(14, 5, '2024-11-05', '18:10:00', '19:40:00', 'PRESENTE'),
	(15, 6, '2024-11-04', '18:00:00', '19:30:00', 'PRESENTE'),
	(16, 6, '2024-11-06', '18:05:00', '19:35:00', 'PRESENTE'),
	(17, 7, '2024-11-05', '06:00:00', '07:30:00', 'PRESENTE'),
	(18, 8, '2024-11-05', '06:00:00', '07:30:00', 'PRESENTE'),
	(19, 9, '2024-11-06', '14:00:00', '15:30:00', 'PRESENTE'),
	(20, 10, '2024-11-06', '18:00:00', '19:30:00', 'PRESENTE');

-- Dumping structure for table agrofit.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.auth_group: ~0 rows (approximately)

-- Dumping structure for table agrofit.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table agrofit.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.auth_permission: ~120 rows (approximately)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 3, 'add_permission'),
	(6, 'Can change permission', 3, 'change_permission'),
	(7, 'Can delete permission', 3, 'delete_permission'),
	(8, 'Can view permission', 3, 'view_permission'),
	(9, 'Can add group', 2, 'add_group'),
	(10, 'Can change group', 2, 'change_group'),
	(11, 'Can delete group', 2, 'delete_group'),
	(12, 'Can view group', 2, 'view_group'),
	(13, 'Can add content type', 4, 'add_contenttype'),
	(14, 'Can change content type', 4, 'change_contenttype'),
	(15, 'Can delete content type', 4, 'delete_contenttype'),
	(16, 'Can view content type', 4, 'view_contenttype'),
	(17, 'Can add session', 5, 'add_session'),
	(18, 'Can change session', 5, 'change_session'),
	(19, 'Can delete session', 5, 'delete_session'),
	(20, 'Can view session', 5, 'view_session'),
	(21, 'Can add centro formacion', 6, 'add_centroformacion'),
	(22, 'Can change centro formacion', 6, 'change_centroformacion'),
	(23, 'Can delete centro formacion', 6, 'delete_centroformacion'),
	(24, 'Can view centro formacion', 6, 'view_centroformacion'),
	(25, 'Can add dependencias centro', 7, 'add_dependenciascentro'),
	(26, 'Can change dependencias centro', 7, 'change_dependenciascentro'),
	(27, 'Can delete dependencias centro', 7, 'delete_dependenciascentro'),
	(28, 'Can view dependencias centro', 7, 'view_dependenciascentro'),
	(29, 'Can add fichas', 8, 'add_fichas'),
	(30, 'Can change fichas', 8, 'change_fichas'),
	(31, 'Can delete fichas', 8, 'delete_fichas'),
	(32, 'Can view fichas', 8, 'view_fichas'),
	(33, 'Can add programas', 9, 'add_programas'),
	(34, 'Can change programas', 9, 'change_programas'),
	(35, 'Can delete programas', 9, 'delete_programas'),
	(36, 'Can view programas', 9, 'view_programas'),
	(37, 'Can add aprendiz rutina', 10, 'add_aprendizrutina'),
	(38, 'Can change aprendiz rutina', 10, 'change_aprendizrutina'),
	(39, 'Can delete aprendiz rutina', 10, 'delete_aprendizrutina'),
	(40, 'Can view aprendiz rutina', 10, 'view_aprendizrutina'),
	(41, 'Can add ejercicios', 11, 'add_ejercicios'),
	(42, 'Can change ejercicios', 11, 'change_ejercicios'),
	(43, 'Can delete ejercicios', 11, 'delete_ejercicios'),
	(44, 'Can view ejercicios', 11, 'view_ejercicios'),
	(45, 'Can add maquinas', 12, 'add_maquinas'),
	(46, 'Can change maquinas', 12, 'change_maquinas'),
	(47, 'Can delete maquinas', 12, 'delete_maquinas'),
	(48, 'Can view maquinas', 12, 'view_maquinas'),
	(49, 'Can add musculos', 13, 'add_musculos'),
	(50, 'Can change musculos', 13, 'change_musculos'),
	(51, 'Can delete musculos', 13, 'delete_musculos'),
	(52, 'Can view musculos', 13, 'view_musculos'),
	(53, 'Can add partes cuerpo', 14, 'add_partescuerpo'),
	(54, 'Can change partes cuerpo', 14, 'change_partescuerpo'),
	(55, 'Can delete partes cuerpo', 14, 'delete_partescuerpo'),
	(56, 'Can view partes cuerpo', 14, 'view_partescuerpo'),
	(57, 'Can add rutina ejercicios', 15, 'add_rutinaejercicios'),
	(58, 'Can change rutina ejercicios', 15, 'change_rutinaejercicios'),
	(59, 'Can delete rutina ejercicios', 15, 'delete_rutinaejercicios'),
	(60, 'Can view rutina ejercicios', 15, 'view_rutinaejercicios'),
	(61, 'Can add rutinas', 16, 'add_rutinas'),
	(62, 'Can change rutinas', 16, 'change_rutinas'),
	(63, 'Can delete rutinas', 16, 'delete_rutinas'),
	(64, 'Can view rutinas', 16, 'view_rutinas'),
	(65, 'Can add semana adaptacion', 17, 'add_semanaadaptacion'),
	(66, 'Can change semana adaptacion', 17, 'change_semanaadaptacion'),
	(67, 'Can delete semana adaptacion', 17, 'delete_semanaadaptacion'),
	(68, 'Can view semana adaptacion', 17, 'view_semanaadaptacion'),
	(69, 'Can add asistencias', 18, 'add_asistencias'),
	(70, 'Can change asistencias', 18, 'change_asistencias'),
	(71, 'Can delete asistencias', 18, 'delete_asistencias'),
	(72, 'Can view asistencias', 18, 'view_asistencias'),
	(73, 'Can add evaluaciones fisicas', 19, 'add_evaluacionesfisicas'),
	(74, 'Can change evaluaciones fisicas', 19, 'change_evaluacionesfisicas'),
	(75, 'Can delete evaluaciones fisicas', 19, 'delete_evaluacionesfisicas'),
	(76, 'Can view evaluaciones fisicas', 19, 'view_evaluacionesfisicas'),
	(77, 'Can add progreso', 20, 'add_progreso'),
	(78, 'Can change progreso', 20, 'change_progreso'),
	(79, 'Can delete progreso', 20, 'delete_progreso'),
	(80, 'Can view progreso', 20, 'view_progreso'),
	(81, 'Can add Usuario', 30, 'add_usuarios'),
	(82, 'Can change Usuario', 30, 'change_usuarios'),
	(83, 'Can delete Usuario', 30, 'delete_usuarios'),
	(84, 'Can view Usuario', 30, 'view_usuarios'),
	(85, 'Can add administradores', 21, 'add_administradores'),
	(86, 'Can change administradores', 21, 'change_administradores'),
	(87, 'Can delete administradores', 21, 'delete_administradores'),
	(88, 'Can view administradores', 21, 'view_administradores'),
	(89, 'Can add aprendices', 22, 'add_aprendices'),
	(90, 'Can change aprendices', 22, 'change_aprendices'),
	(91, 'Can delete aprendices', 22, 'delete_aprendices'),
	(92, 'Can view aprendices', 22, 'view_aprendices'),
	(93, 'Can add dependencias funcionario', 23, 'add_dependenciasfuncionario'),
	(94, 'Can change dependencias funcionario', 23, 'change_dependenciasfuncionario'),
	(95, 'Can delete dependencias funcionario', 23, 'delete_dependenciasfuncionario'),
	(96, 'Can view dependencias funcionario', 23, 'view_dependenciasfuncionario'),
	(97, 'Can add entrenadores', 24, 'add_entrenadores'),
	(98, 'Can change entrenadores', 24, 'change_entrenadores'),
	(99, 'Can delete entrenadores', 24, 'delete_entrenadores'),
	(100, 'Can view entrenadores', 24, 'view_entrenadores'),
	(101, 'Can add especialidades', 25, 'add_especialidades'),
	(102, 'Can change especialidades', 25, 'change_especialidades'),
	(103, 'Can delete especialidades', 25, 'delete_especialidades'),
	(104, 'Can view especialidades', 25, 'view_especialidades'),
	(105, 'Can add funcionarios', 26, 'add_funcionarios'),
	(106, 'Can change funcionarios', 26, 'change_funcionarios'),
	(107, 'Can delete funcionarios', 26, 'delete_funcionarios'),
	(108, 'Can view funcionarios', 26, 'view_funcionarios'),
	(109, 'Can add horarios instructor', 27, 'add_horariosinstructor'),
	(110, 'Can change horarios instructor', 27, 'change_horariosinstructor'),
	(111, 'Can delete horarios instructor', 27, 'delete_horariosinstructor'),
	(112, 'Can view horarios instructor', 27, 'view_horariosinstructor'),
	(113, 'Can add Rol', 28, 'add_roles'),
	(114, 'Can change Rol', 28, 'change_roles'),
	(115, 'Can delete Rol', 28, 'delete_roles'),
	(116, 'Can view Rol', 28, 'view_roles'),
	(117, 'Can add Tipo de documento', 29, 'add_tipodocumento'),
	(118, 'Can change Tipo de documento', 29, 'change_tipodocumento'),
	(119, 'Can delete Tipo de documento', 29, 'delete_tipodocumento'),
	(120, 'Can view Tipo de documento', 29, 'view_tipodocumento');

-- Dumping structure for table agrofit.centro_formacion
CREATE TABLE IF NOT EXISTS `centro_formacion` (
  `idCentro` int(11) NOT NULL AUTO_INCREMENT,
  `nomCentro` varchar(50) NOT NULL,
  `codCentro` varchar(50) NOT NULL,
  `direccionC` varchar(50) NOT NULL,
  PRIMARY KEY (`idCentro`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.centro_formacion: ~3 rows (approximately)
INSERT INTO `centro_formacion` (`idCentro`, `nomCentro`, `codCentro`, `direccionC`) VALUES
	(1, 'Centro Agropecuario', '9113', 'Carrera 9 No. 71N-60, Sede Alto Cauca, Popayán'),
	(2, 'Centro de Teleinformática y Producción Industrial', '9221', 'Carrera 9 No. 71N-60, Sede Alto Cauca, Popayán'),
	(3, 'Centro de Comercio y Servicios', '9307', 'Calle 4 No. 2-80, Popayán');

-- Dumping structure for table agrofit.dependencias_centro
CREATE TABLE IF NOT EXISTS `dependencias_centro` (
  `idDependencia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `idCentro_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDependencia`),
  KEY `FK_dependencias_centro_centro_formacion` (`idCentro_fk`),
  CONSTRAINT `FK_dependencias_centro_centro_formacion` FOREIGN KEY (`idCentro_fk`) REFERENCES `centro_formacion` (`idCentro`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.dependencias_centro: ~4 rows (approximately)
INSERT INTO `dependencias_centro` (`idDependencia`, `nombre`, `idCentro_fk`) VALUES
	(1, 'DIRECCION ESTRATEGICA Y DE CONTROL', 3),
	(2, 'AREA MISIONAL Y ACADEMICA', 1),
	(3, 'SERVICIOS ESPECIALES Y PROMOCION', 2),
	(4, 'SOPORTE ADMINISTRATIVO Y FINANCIERO', NULL);

-- Dumping structure for table agrofit.dependencias_funcionario
CREATE TABLE IF NOT EXISTS `dependencias_funcionario` (
  `idDependenciaF` int(11) NOT NULL AUTO_INCREMENT,
  `nomDependenciaF` varchar(200) NOT NULL,
  PRIMARY KEY (`idDependenciaF`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.dependencias_funcionario: ~7 rows (approximately)
INSERT INTO `dependencias_funcionario` (`idDependenciaF`, `nomDependenciaF`) VALUES
	(1, 'Coordinación de Formación Profesional'),
	(2, 'Coordinación Académica'),
	(3, 'Gestión Administrativa'),
	(4, 'Bienestar al Aprendiz'),
	(5, 'Sistemas y Tecnologías de la Información'),
	(6, 'Control Interno'),
	(7, 'Coordinación Misional');

-- Dumping structure for table agrofit.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_usuarios_idUsuario` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_usuarios_idUsuario` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.django_admin_log: ~0 rows (approximately)

-- Dumping structure for table agrofit.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.django_content_type: ~30 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(2, 'auth', 'group'),
	(3, 'auth', 'permission'),
	(4, 'contenttypes', 'contenttype'),
	(5, 'sessions', 'session'),
	(6, 'centros', 'centroformacion'),
	(7, 'centros', 'dependenciascentro'),
	(8, 'centros', 'fichas'),
	(9, 'centros', 'programas'),
	(10, 'rutinas', 'aprendizrutina'),
	(11, 'rutinas', 'ejercicios'),
	(12, 'rutinas', 'maquinas'),
	(13, 'rutinas', 'musculos'),
	(14, 'rutinas', 'partescuerpo'),
	(15, 'rutinas', 'rutinaejercicios'),
	(16, 'rutinas', 'rutinas'),
	(17, 'rutinas', 'semanaadaptacion'),
	(18, 'seguimiento', 'asistencias'),
	(19, 'seguimiento', 'evaluacionesfisicas'),
	(20, 'seguimiento', 'progreso'),
	(21, 'usuarios', 'administradores'),
	(22, 'usuarios', 'aprendices'),
	(23, 'usuarios', 'dependenciasfuncionario'),
	(24, 'usuarios', 'entrenadores'),
	(25, 'usuarios', 'especialidades'),
	(26, 'usuarios', 'funcionarios'),
	(27, 'usuarios', 'horariosinstructor'),
	(28, 'usuarios', 'roles'),
	(29, 'usuarios', 'tipodocumento'),
	(30, 'usuarios', 'usuarios');

-- Dumping structure for table agrofit.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.django_migrations: ~22 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'usuarios', '0001_initial', '2026-10-29 18:41:02.597498'),
	(2, 'contenttypes', '0001_initial', '2026-10-29 18:41:02.622405'),
	(3, 'admin', '0001_initial', '2026-10-29 18:41:02.673050'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2026-10-29 18:41:02.675852'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-10-29 18:41:02.678166'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2026-10-29 18:41:02.709420'),
	(7, 'auth', '0001_initial', '2026-10-29 18:41:02.793695'),
	(8, 'auth', '0002_alter_permission_name_max_length', '2026-10-29 18:41:02.813985'),
	(9, 'auth', '0003_alter_user_email_max_length', '2026-10-29 18:41:02.817989'),
	(10, 'auth', '0004_alter_user_username_opts', '2026-10-29 18:41:02.822101'),
	(11, 'auth', '0005_alter_user_last_login_null', '2026-10-29 18:41:02.825571'),
	(12, 'auth', '0006_require_contenttypes_0002', '2026-10-29 18:41:02.826692'),
	(13, 'auth', '0007_alter_validators_add_error_messages', '2026-10-29 18:41:02.830487'),
	(14, 'auth', '0008_alter_user_username_max_length', '2026-10-29 18:41:02.834258'),
	(15, 'auth', '0009_alter_user_last_name_max_length', '2026-10-29 18:41:02.837841'),
	(16, 'auth', '0010_alter_group_name_max_length', '2026-10-29 18:41:02.849585'),
	(17, 'auth', '0011_update_proxy_permissions', '2026-10-29 18:41:02.855775'),
	(18, 'auth', '0012_alter_user_first_name_max_length', '2026-10-29 18:41:02.859211'),
	(19, 'centros', '0001_initial', '2026-10-29 18:41:02.862605'),
	(20, 'rutinas', '0001_initial', '2026-10-29 18:41:02.867158'),
	(21, 'seguimiento', '0001_initial', '2026-10-29 18:41:02.869875'),
	(22, 'sessions', '0001_initial', '2026-10-29 18:41:02.897450');

-- Dumping structure for table agrofit.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.django_session: ~1 rows (approximately)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('elz7rigxqr7l5pc7nu2hbadb48v56b1r', '.eJxVi0sKwjAQQO8yaykzSUsy3elFwnSSmiC0kM9KvLsILnT7Pk8IMnoOo6UaSoQVCC6_bBN9pOMjRhtSy9kmGT0dvahoOY_peq_nXvrt2_3NWVqGFRANk12cGFaerY3GsccFN0WjBr0TTzGR3dGTqkXjlJ2bmZWjJ2J4vQHh1zUz:1xMV5g:JegV21s2mXHihb8mSjhhoxjGWIfZGRF4Z_pYwbJF2h8', '2026-11-12 18:43:08.298471');

-- Dumping structure for table agrofit.ejercicios
CREATE TABLE IF NOT EXISTS `ejercicios` (
  `idEjercicio` int(11) NOT NULL AUTO_INCREMENT,
  `idMaquina_fk` int(11) DEFAULT NULL,
  `idMusculo_fk` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `repeticiones` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `videoDemo` varchar(250) DEFAULT NULL,
  `descanso` time DEFAULT NULL,
  PRIMARY KEY (`idEjercicio`),
  KEY `FK_ejercicios_maquinas` (`idMaquina_fk`),
  KEY `FK_ejercicios_musculos` (`idMusculo_fk`),
  CONSTRAINT `FK_ejercicios_maquinas` FOREIGN KEY (`idMaquina_fk`) REFERENCES `maquinas` (`idMaquina`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ejercicios_musculos` FOREIGN KEY (`idMusculo_fk`) REFERENCES `musculos` (`idMusculo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.ejercicios: ~20 rows (approximately)
INSERT INTO `ejercicios` (`idEjercicio`, `idMaquina_fk`, `idMusculo_fk`, `nombre`, `repeticiones`, `descripcion`, `videoDemo`, `descanso`) VALUES
	(1, 1, 1, 'Press de Banca Plano', 12, 'Acostado, bajar barra al pecho y empujar arriba', NULL, '00:01:30'),
	(2, 1, 1, 'Press de Banca Inclinado', 10, 'Banca 45°, trabaja la parte superior del pecho', NULL, '00:01:30'),
	(3, 2, 3, 'Jalón al Pecho', 12, 'Sentado en polea alta, jalar barra hacia el pecho', NULL, '00:01:00'),
	(4, 2, 3, 'Jalón Trasero', 10, 'Igual que jalón al pecho pero barra detrás de la cabeza', NULL, '00:01:00'),
	(5, 3, 13, 'Prensa de Piernas', 15, 'Sentado, empujar plataforma con los pies', NULL, '00:02:00'),
	(6, 4, 3, 'Remo en Máquina', 12, 'Jalar maneral hacia el abdomen, trabaja espalda', NULL, '00:01:30'),
	(7, 5, 13, 'Extensión de Cuádriceps', 15, 'Sentado, extender piernas completamente', NULL, '00:01:00'),
	(8, 6, 9, 'Curl de Bíceps en Máquina', 12, 'Sentado, flexionar el codo levantando el peso', NULL, '00:01:00'),
	(9, 7, 10, 'Extensión de Tríceps Máquina', 12, 'Extensión de codo para trabajar tríceps', NULL, '00:01:00'),
	(10, 8, 1, 'Press Inclinado Smith', 10, 'Press de pecho en Smith con banca inclinada', NULL, '00:01:30'),
	(11, 9, 15, 'Aductores', 15, 'Sentado, juntar piernas contra la resistencia', NULL, '00:01:00'),
	(12, 10, 18, 'Elevación de Pantorrillas', 20, 'De pie, elevar talones lo más alto posible', NULL, '00:00:45'),
	(13, 11, 6, 'Press de Hombros Máquina', 12, 'Empujar peso sobre la cabeza, trabaja deltoides', NULL, '00:01:30'),
	(14, NULL, 16, 'Sentadilla Libre', 12, 'Barra en hombros, bajar hasta muslos paralelos al suelo', NULL, '00:02:00'),
	(15, NULL, 16, 'Peso Muerto', 10, 'Levantar barra del suelo con espalda recta', NULL, '00:02:30'),
	(16, NULL, 11, 'Abdominales Crunch', 20, 'Acostado, subir torso contrayendo el abdomen', NULL, '00:00:45'),
	(17, NULL, 12, 'Plancha Abdominal', 1, 'Sostener posición de plancha 60 segundos', NULL, '00:01:00'),
	(18, NULL, 9, 'Curl Bíceps con Mancuerna', 12, 'Alternando brazos, flexionar codo con mancuerna', NULL, '00:01:00'),
	(19, NULL, 10, 'Fondos de Tríceps', 12, 'En barras paralelas, bajar cuerpo y empujar arriba', NULL, '00:01:00'),
	(20, 12, NULL, 'Cardio en Cinta 30 min', 1, 'Trote continuo a ritmo moderado durante 30 minutos', NULL, '00:00:00');

-- Dumping structure for table agrofit.entrenadores
CREATE TABLE IF NOT EXISTS `entrenadores` (
  `idEntrenador` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  `idEspecialidad_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEntrenador`) USING BTREE,
  KEY `FK_entrenadores_usuarios` (`idUsuario_fk`),
  KEY `FK_entrenadores_especialidades` (`idEspecialidad_fk`),
  CONSTRAINT `FK_entrenadores_especialidades` FOREIGN KEY (`idEspecialidad_fk`) REFERENCES `especialidades` (`idEspecialidad`) ON UPDATE CASCADE,
  CONSTRAINT `FK_entrenadores_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.entrenadores: ~4 rows (approximately)
INSERT INTO `entrenadores` (`idEntrenador`, `idUsuario_fk`, `idEspecialidad_fk`) VALUES
	(1, 3, 3),
	(2, 4, 1),
	(3, 5, 2),
	(5, 28, 1);

-- Dumping structure for table agrofit.especialidades
CREATE TABLE IF NOT EXISTS `especialidades` (
  `idEspecialidad` int(11) NOT NULL AUTO_INCREMENT,
  `nomEsp` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEspecialidad`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.especialidades: ~6 rows (approximately)
INSERT INTO `especialidades` (`idEspecialidad`, `nomEsp`) VALUES
	(1, 'Musculación'),
	(2, 'CrossFit'),
	(3, 'Cardio'),
	(4, 'Powerlifting'),
	(5, 'Rehabilitación'),
	(6, 'Entrenamiento funcional');

-- Dumping structure for table agrofit.evaluaciones_fisicas
CREATE TABLE IF NOT EXISTS `evaluaciones_fisicas` (
  `idEvaluacion` int(11) NOT NULL AUTO_INCREMENT,
  `idAprendiz_fk` int(11) NOT NULL,
  `idEntrenador_fk` int(11) NOT NULL,
  `fechaEvaluacion` date NOT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `altura` decimal(4,2) DEFAULT NULL,
  `imc` decimal(4,2) DEFAULT NULL,
  `frecuenciaCardiaca` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`idEvaluacion`),
  KEY `FK_eval_aprendices` (`idAprendiz_fk`),
  KEY `FK_evaluaciones_fisicas_entrenadores` (`idEntrenador_fk`),
  CONSTRAINT `FK_eval_aprendices` FOREIGN KEY (`idAprendiz_fk`) REFERENCES `aprendices` (`idAprendiz`) ON UPDATE CASCADE,
  CONSTRAINT `FK_evaluaciones_fisicas_entrenadores` FOREIGN KEY (`idEntrenador_fk`) REFERENCES `entrenadores` (`idEntrenador`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.evaluaciones_fisicas: ~13 rows (approximately)
INSERT INTO `evaluaciones_fisicas` (`idEvaluacion`, `idAprendiz_fk`, `idEntrenador_fk`, `fechaEvaluacion`, `peso`, `altura`, `imc`, `frecuenciaCardiaca`, `observaciones`) VALUES
	(1, 1, 1, '2024-08-01', 75.00, 1.75, 24.49, 72, 'Buen estado inicial. Trabajar resistencia cardiovascular.'),
	(2, 1, 1, '2024-10-01', 73.00, 1.75, 23.84, 68, 'Mejora notable. Continuar con hipertrofia.'),
	(3, 2, 1, '2024-08-01', 62.00, 1.63, 23.33, 75, 'Postura a mejorar. Énfasis en espalda y core.'),
	(4, 2, 1, '2024-10-15', 60.50, 1.63, 22.76, 72, 'Progreso positivo en fuerza y postura.'),
	(5, 3, 2, '2024-09-01', 80.00, 1.80, 24.69, 70, 'Buen nivel en tren inferior. Trabajar cardiovascular.'),
	(6, 4, 2, '2024-09-01', 58.00, 1.60, 22.66, 78, 'Estado normal. Rutina de definición recomendada.'),
	(7, 5, 3, '2024-08-15', 90.00, 1.78, 28.41, 80, 'IMC elevado. Priorizar cardio y ajuste de dieta.'),
	(8, 5, 3, '2024-10-15', 87.50, 1.78, 27.62, 76, 'Reducción de peso. Continuar protocolo cardio.'),
	(9, 6, 3, '2024-08-15', 65.00, 1.68, 23.03, 73, 'Condición adecuada. Rutina de tonificación.'),
	(10, 7, 1, '2024-09-10', 70.00, 1.72, 23.67, 71, 'Fuerza en desarrollo. Seguir con full body.'),
	(11, 8, 2, '2024-09-10', 55.00, 1.58, 22.04, 76, 'Bajo peso. Dieta hipercalórica + trabajo de volumen.'),
	(12, 9, 1, '2024-10-01', 85.00, 1.82, 25.66, 69, 'Buen rendimiento. Listo para rutina avanzada.'),
	(13, 10, 3, '2024-10-01', 68.00, 1.70, 23.53, 74, 'Estado físico óptimo. Mantener rutina actual.');

-- Dumping structure for table agrofit.fichas
CREATE TABLE IF NOT EXISTS `fichas` (
  `idFicha` int(11) NOT NULL AUTO_INCREMENT,
  `idPrograma_fk` int(11) DEFAULT NULL,
  `idCentro_fk` int(11) DEFAULT NULL,
  `numFicha` varchar(50) NOT NULL,
  `jornada` enum('MAÑANA','TARDE','NOCHE') DEFAULT NULL,
  `nivelF` enum('TECNICO','TECNOLOGO') DEFAULT NULL,
  `fechaIni` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  PRIMARY KEY (`idFicha`),
  KEY `FK_fichas_programas` (`idPrograma_fk`),
  KEY `FK_fichas_centro_formacion` (`idCentro_fk`),
  CONSTRAINT `FK_fichas_centro_formacion` FOREIGN KEY (`idCentro_fk`) REFERENCES `centro_formacion` (`idCentro`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fichas_programas` FOREIGN KEY (`idPrograma_fk`) REFERENCES `programas` (`idPrograma`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.fichas: ~9 rows (approximately)
INSERT INTO `fichas` (`idFicha`, `idPrograma_fk`, `idCentro_fk`, `numFicha`, `jornada`, `nivelF`, `fechaIni`, `fechaFin`) VALUES
	(1, 1, 1, '2758301', 'MAÑANA', 'TECNICO', '2026-01-15', '2026-06-30'),
	(2, 1, 2, '2758302', 'TARDE', 'TECNICO', '2026-02-01', '2026-07-15'),
	(3, 2, 1, '2758401', 'NOCHE', 'TECNOLOGO', '2026-03-01', '2028-08-31'),
	(4, 2, 1, '2758402', 'MAÑANA', 'TECNOLOGO', '2026-04-01', '2028-09-30'),
	(5, 3, 2, '2758501', 'MAÑANA', 'TECNOLOGO', '2026-05-01', '2028-10-31'),
	(6, 4, 1, '2758601', 'MAÑANA', 'TECNICO', '2026-06-01', '2026-11-30'),
	(7, 5, 1, '2758701', 'MAÑANA', 'TECNOLOGO', '2026-09-01', '2028-12-31'),
	(8, 37, 3, '3387753', 'MAÑANA', 'TECNICO', '2026-07-31', '2026-07-31'),
	(9, 5, 2, '3387754', 'MAÑANA', 'TECNICO', '2026-07-31', '2026-07-31');

-- Dumping structure for table agrofit.funcionarios
CREATE TABLE IF NOT EXISTS `funcionarios` (
  `idFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  `idDependenciaF_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`) USING BTREE,
  KEY `FK_funcionarios_usuarios` (`idUsuario_fk`),
  KEY `FK_funcionarios_dependencias_funcionario` (`idDependenciaF_fk`),
  CONSTRAINT `FK_funcionarios_dependencias_funcionario` FOREIGN KEY (`idDependenciaF_fk`) REFERENCES `dependencias_funcionario` (`idDependenciaF`) ON UPDATE CASCADE,
  CONSTRAINT `FK_funcionarios_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.funcionarios: ~2 rows (approximately)
INSERT INTO `funcionarios` (`idFuncionario`, `idUsuario_fk`, `idDependenciaF_fk`) VALUES
	(1, 3, 4),
	(2, 4, 6);

-- Dumping structure for table agrofit.horarios_instructor
CREATE TABLE IF NOT EXISTS `horarios_instructor` (
  `idHorario` int(11) NOT NULL AUTO_INCREMENT,
  `idEntrenador_fk` int(11) NOT NULL,
  `diaSemana` enum('LUNES','MARTES','MIÉRCOLES','JUEVES','VIERNES','SÁBADO','DOMINGO') NOT NULL,
  `horaInicio` time NOT NULL,
  `horaFin` time NOT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `FK_horarios_instructor_entrenadores` (`idEntrenador_fk`),
  CONSTRAINT `FK_horarios_instructor_entrenadores` FOREIGN KEY (`idEntrenador_fk`) REFERENCES `entrenadores` (`idEntrenador`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.horarios_instructor: ~10 rows (approximately)
INSERT INTO `horarios_instructor` (`idHorario`, `idEntrenador_fk`, `diaSemana`, `horaInicio`, `horaFin`) VALUES
	(1, 1, 'LUNES', '08:00:00', '12:00:00'),
	(2, 1, 'MIÉRCOLES', '08:00:00', '12:00:00'),
	(3, 1, 'VIERNES', '08:00:00', '12:00:00'),
	(4, 2, 'LUNES', '13:00:00', '18:00:00'),
	(5, 2, 'MARTES', '13:00:00', '18:00:00'),
	(6, 2, 'JUEVES', '13:00:00', '18:00:00'),
	(7, 3, 'MARTES', '13:00:00', '18:00:00'),
	(8, 3, 'MIÉRCOLES', '13:00:00', '18:00:00'),
	(9, 3, 'VIERNES', '13:00:00', '18:00:00'),
	(10, 3, 'SÁBADO', '08:00:00', '12:00:00');

-- Dumping structure for table agrofit.maquinas
CREATE TABLE IF NOT EXISTS `maquinas` (
  `idMaquina` int(11) NOT NULL AUTO_INCREMENT,
  `codMaq` varchar(50) NOT NULL,
  `nomMaq` varchar(50) NOT NULL,
  `pesoMax` int(11) DEFAULT NULL,
  `estadoMaq` enum('ACTIVA','FUERA DE SERVICIO','MANTENIMIENTO') NOT NULL DEFAULT 'FUERA DE SERVICIO',
  PRIMARY KEY (`idMaquina`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.maquinas: ~15 rows (approximately)
INSERT INTO `maquinas` (`idMaquina`, `codMaq`, `nomMaq`, `pesoMax`, `estadoMaq`) VALUES
	(1, 'MAQ-001', 'Press de Banca', 200, 'ACTIVA'),
	(2, 'MAQ-002', 'Polea Alta', 150, 'ACTIVA'),
	(3, 'MAQ-003', 'Prensa de Piernas', 400, 'ACTIVA'),
	(4, 'MAQ-004', 'Máquina de Remo', 120, 'ACTIVA'),
	(5, 'MAQ-005', 'Extensión de Cuádriceps', 100, 'ACTIVA'),
	(6, 'MAQ-006', 'Curl de Bíceps', 80, 'ACTIVA'),
	(7, 'MAQ-007', 'Extensión de Tríceps', 80, 'MANTENIMIENTO'),
	(8, 'MAQ-008', 'Máquina Multipower (Smith)', 200, 'ACTIVA'),
	(9, 'MAQ-009', 'Aductores / Abductores', 100, 'MANTENIMIENTO'),
	(10, 'MAQ-010', 'Elevación de Pantorrillas', 150, 'ACTIVA'),
	(11, 'MAQ-011', 'Press de Hombros', 120, 'ACTIVA'),
	(12, 'MAQ-012', 'Cinta de Correr', NULL, 'FUERA DE SERVICIO'),
	(13, 'MAQ-013', 'Bicicleta Estática', NULL, 'ACTIVA'),
	(14, 'MAQ-014', 'Elíptica', NULL, 'FUERA DE SERVICIO'),
	(15, 'MAQ-015', 'Remo Ergómetro', NULL, 'ACTIVA');

-- Dumping structure for table agrofit.musculos
CREATE TABLE IF NOT EXISTS `musculos` (
  `idMusculo` int(11) NOT NULL AUTO_INCREMENT,
  `idParteCuerpo_fk` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idMusculo`),
  KEY `FK_musculos_partes_cuerpo` (`idParteCuerpo_fk`),
  CONSTRAINT `FK_musculos_partes_cuerpo` FOREIGN KEY (`idParteCuerpo_fk`) REFERENCES `partes_cuerpo` (`idParteCuerpo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.musculos: ~20 rows (approximately)
INSERT INTO `musculos` (`idMusculo`, `idParteCuerpo_fk`, `nombre`, `descripcion`) VALUES
	(1, 1, 'Pectoral Mayor', 'Músculo principal del pecho'),
	(2, 1, 'Pectoral Menor', 'Músculo secundario del pecho'),
	(3, 2, 'Dorsal Ancho', 'Músculo más grande de la espalda'),
	(4, 2, 'Trapecio', 'Músculo triangular espalda alta'),
	(5, 2, 'Romboides', 'Músculo entre escápulas'),
	(6, 3, 'Deltoides Anterior', 'Parte frontal del hombro'),
	(7, 3, 'Deltoides Medio', 'Parte lateral del hombro'),
	(8, 3, 'Deltoides Posterior', 'Parte trasera del hombro'),
	(9, 4, 'Bíceps Braquial', 'Músculo flexor del codo'),
	(10, 5, 'Tríceps Braquial', 'Músculo extensor del codo'),
	(11, 6, 'Recto Abdominal', 'Músculo del abdomen central'),
	(12, 6, 'Oblicuos', 'Músculos laterales del abdomen'),
	(13, 7, 'Cuádriceps', 'Grupo muscular frontal del muslo'),
	(14, 7, 'Femoral', 'Grupo muscular posterior del muslo'),
	(15, 7, 'Aductores', 'Músculos internos del muslo'),
	(16, 8, 'Glúteo Mayor', 'Músculo principal de glúteos'),
	(17, 8, 'Glúteo Medio', 'Músculo lateral de la cadera'),
	(18, 9, 'Gemelo', 'Músculo principal pantorrilla'),
	(19, 9, 'Sóleo', 'Músculo profundo pantorrilla'),
	(20, 10, 'Braquiorradial', 'Músculo principal del antebrazo');

-- Dumping structure for table agrofit.partes_cuerpo
CREATE TABLE IF NOT EXISTS `partes_cuerpo` (
  `idParteCuerpo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idParteCuerpo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.partes_cuerpo: ~10 rows (approximately)
INSERT INTO `partes_cuerpo` (`idParteCuerpo`, `nombre`, `descripcion`) VALUES
	(1, 'Pecho', 'Parte anterior del tórax'),
	(2, 'Espalda', 'Parte posterior del tronco'),
	(3, 'Hombros', 'Articulación entre brazo y tronco'),
	(4, 'Bíceps', 'Parte anterior del brazo'),
	(5, 'Tríceps', 'Parte posterior del brazo'),
	(6, 'Abdomen', 'Zona media del cuerpo'),
	(7, 'Piernas', 'Extremidades inferiores'),
	(8, 'Glúteos', 'Región posterior de la cadera'),
	(9, 'Pantorrillas', 'Parte posterior de la pierna baja'),
	(10, 'Antebrazos', 'Segmento entre codo y muñeca');

-- Dumping structure for table agrofit.programas
CREATE TABLE IF NOT EXISTS `programas` (
  `idPrograma` int(11) NOT NULL AUTO_INCREMENT,
  `codProg` varchar(50) NOT NULL,
  `nomProg` varchar(50) NOT NULL,
  PRIMARY KEY (`idPrograma`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.programas: ~50 rows (approximately)
INSERT INTO `programas` (`idPrograma`, `codProg`, `nomProg`) VALUES
	(1, 'ADSO-101', 'Análisis y Desarrollo de Software'),
	(2, 'GDEF-102', 'Gestión Deportiva'),
	(3, 'AFRS-103', 'Actividad Física y Recreación'),
	(4, 'SALB-104', 'Salud y Bienestar'),
	(5, 'ENTO-105', 'Entrenamiento Deportivo'),
	(6, 'NUST-106', 'Nutrición y Salud'),
	(7, 'GEMP-107', 'Gestión Empresarial'),
	(8, 'CONT-108', 'Contabilidad y Finanzas'),
	(9, 'THUM-109', 'Gestión del Talento Humano'),
	(10, 'MKTG-110', 'Mercadeo y Ventas'),
	(11, 'LOGI-111', 'Gestión Logística'),
	(12, 'SISI-112', 'Sistemas e Informática'),
	(13, 'CIBE-113', 'Ciberseguridad'),
	(14, 'REDD-114', 'Redes de Datos y Telecomunicaciones'),
	(15, 'DIWE-115', 'Diseño y Desarrollo Web'),
	(16, 'GAMI-116', 'Desarrollo de Videojuegos'),
	(17, 'DIMU-117', 'Diseño Multimedia'),
	(18, 'MECI-118', 'Mantenimiento Mecrónico Industrial'),
	(19, 'MEAU-119', 'Mecánica Automotriz'),
	(20, 'ELCT-120', 'Electricidad Industrial'),
	(21, 'ELEC-121', 'Electrónica y Automatización'),
	(22, 'SOLD-122', 'Soldadura de Productos Metálicos'),
	(23, 'CONS-123', 'Construcción de Obras Civiles'),
	(24, 'TOPO-124', 'Topografía'),
	(25, 'DICO-125', 'Dibujo Arquitectónico'),
	(26, 'AGRO-126', 'Gestión de Empresas Agropecuarias'),
	(27, 'PAGR-127', 'Producción Agrícola'),
	(28, 'PGAN-128', 'Producción Ganadera'),
	(29, 'AMBI-129', 'Control Ambiental'),
	(30, 'FORE-130', 'Gestión Forestal'),
	(31, 'CALI-131', 'Control de Calidad de Alimentos'),
	(32, 'PRAL-132', 'Procesamiento de Alimentos'),
	(33, 'GAST-133', 'Gastronomía y Arte Culinario'),
	(34, 'SERM-134', 'Servicios de Mesa y Bar'),
	(35, 'TURM-135', 'Guianza Turística'),
	(36, 'HOTL-136', 'Gestión Hotelera'),
	(37, 'DISG-137', 'Diseño Gráfico'),
	(38, 'MODA-138', 'Diseño de Modas y Patronaje'),
	(39, 'PROA-139', 'Producción Audiovisual'),
	(40, 'FOTO-140', 'Fotografía Digital'),
	(41, 'ENFE-141', 'Enfermería'),
	(42, 'SALP-142', 'Salud Pública'),
	(43, 'SAOC-143', 'Seguridad y Salud en el Trabajo'),
	(44, 'REGFA-144', 'Regencia de Farmacia'),
	(45, 'MECI-145', 'Mantenimiento de Equipos Biomédicos'),
	(46, 'GEST-146', 'Gestión Documental'),
	(47, 'COMM-147', 'Comercio Internacional'),
	(48, 'NEGINT-148', 'Negocios Internacionales'),
	(49, 'GESTUR-149', 'Gestión de Servicios Turísticos'),
	(50, 'MECMOT-150', 'Mantenimiento Mecánico de Motocicletas');

-- Dumping structure for table agrofit.progreso
CREATE TABLE IF NOT EXISTS `progreso` (
  `idProgreso` int(11) NOT NULL AUTO_INCREMENT,
  `idAprendizRutina_fk` int(11) DEFAULT NULL,
  `idRutinaEjercicio_fk` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `peso` decimal(20,6) DEFAULT NULL,
  `repeticiones` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProgreso`),
  KEY `FK_progreso_rutina_ejercicios` (`idRutinaEjercicio_fk`),
  KEY `FK_progreso_aprendiz_rutina` (`idAprendizRutina_fk`),
  CONSTRAINT `FK_progreso_aprendiz_rutina` FOREIGN KEY (`idAprendizRutina_fk`) REFERENCES `aprendiz_rutina` (`idAprendizRutina`) ON UPDATE CASCADE,
  CONSTRAINT `FK_progreso_rutina_ejercicios` FOREIGN KEY (`idRutinaEjercicio_fk`) REFERENCES `rutina_ejercicios` (`idRutinaEjercicio`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.progreso: ~7 rows (approximately)
INSERT INTO `progreso` (`idProgreso`, `idAprendizRutina_fk`, `idRutinaEjercicio_fk`, `fecha`, `peso`, `repeticiones`) VALUES
	(1, 1, 7, '2026-07-31', 55.000000, 10),
	(2, 2, 2, '2026-07-31', 60.000000, 12),
	(3, 3, 3, '2026-07-31', 80.000000, 6),
	(4, 4, 13, '2026-07-31', 77.000000, 15),
	(5, 5, 12, '2026-07-31', 61.000000, 11),
	(6, 6, 6, '2026-07-31', 59.000000, 10),
	(7, 7, 11, '2026-07-31', 68.000000, 13);

-- Dumping structure for table agrofit.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `idRol` int(11) NOT NULL AUTO_INCREMENT,
  `nomRol` varchar(50) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.roles: ~4 rows (approximately)
INSERT INTO `roles` (`idRol`, `nomRol`) VALUES
	(1, 'Administrador'),
	(2, 'Entrenador'),
	(3, 'Aprendiz'),
	(4, 'Funcionario');

-- Dumping structure for table agrofit.rutina_ejercicios
CREATE TABLE IF NOT EXISTS `rutina_ejercicios` (
  `idRutinaEjercicio` int(11) NOT NULL AUTO_INCREMENT,
  `idRutina_fk` int(11) DEFAULT NULL,
  `idEjercicio_fk` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 1,
  `series` int(11) NOT NULL DEFAULT 3,
  `repeticiones` int(11) NOT NULL DEFAULT 12,
  `descanso` time DEFAULT NULL,
  PRIMARY KEY (`idRutinaEjercicio`),
  KEY `FK_re_rutinas` (`idRutina_fk`),
  KEY `FK_re_ejercicios` (`idEjercicio_fk`),
  CONSTRAINT `FK_re_ejercicios` FOREIGN KEY (`idEjercicio_fk`) REFERENCES `ejercicios` (`idEjercicio`) ON UPDATE CASCADE,
  CONSTRAINT `FK_re_rutinas` FOREIGN KEY (`idRutina_fk`) REFERENCES `rutinas` (`idRutina`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.rutina_ejercicios: ~32 rows (approximately)
INSERT INTO `rutina_ejercicios` (`idRutinaEjercicio`, `idRutina_fk`, `idEjercicio_fk`, `orden`, `series`, `repeticiones`, `descanso`) VALUES
	(1, 1, 1, 1, 4, 12, '00:01:30'),
	(2, 1, 2, 2, 4, 10, '00:01:30'),
	(3, 1, 1, 3, 3, 12, '00:01:00'),
	(4, 1, 19, 4, 3, 12, '00:01:00'),
	(5, 2, 3, 1, 4, 12, '00:01:30'),
	(6, 2, 4, 2, 3, 10, '00:01:30'),
	(7, 2, 6, 3, 4, 12, '00:01:00'),
	(8, 2, 8, 4, 3, 12, '00:01:00'),
	(9, 2, 18, 5, 3, 12, '00:01:00'),
	(10, 3, 5, 1, 4, 15, '00:02:00'),
	(11, 3, 7, 2, 4, 15, '00:01:00'),
	(12, 3, 14, 3, 4, 12, '00:02:00'),
	(13, 3, 11, 4, 3, 15, '00:01:00'),
	(14, 3, 12, 5, 3, 20, '00:00:45'),
	(15, 4, 13, 1, 4, 12, '00:01:30'),
	(16, 4, 16, 2, 4, 20, '00:00:45'),
	(17, 4, 17, 3, 3, 1, '00:01:00'),
	(18, 5, 20, 1, 1, 1, '00:00:00'),
	(19, 6, 14, 1, 3, 10, '00:02:00'),
	(20, 6, 1, 2, 3, 10, '00:01:30'),
	(21, 6, 3, 3, 3, 10, '00:01:30'),
	(22, 6, 16, 4, 3, 15, '00:00:45'),
	(23, 6, 20, 5, 1, 1, '00:00:00'),
	(24, 7, 15, 1, 5, 5, '00:02:30'),
	(25, 7, 1, 2, 5, 8, '00:02:00'),
	(26, 7, 3, 3, 5, 8, '00:02:00'),
	(27, 7, 14, 4, 5, 8, '00:02:00'),
	(28, 8, 20, 1, 1, 1, '00:00:00'),
	(29, 8, 16, 2, 4, 25, '00:00:30'),
	(30, 8, 17, 3, 4, 1, '00:00:30'),
	(31, 8, 7, 4, 4, 20, '00:00:45'),
	(32, 8, 12, 5, 4, 25, '00:00:30');

-- Dumping structure for table agrofit.rutinas
CREATE TABLE IF NOT EXISTS `rutinas` (
  `idRutina` int(11) NOT NULL AUTO_INCREMENT,
  `idEntrenador_fk` int(11) DEFAULT NULL,
  `nomRutina` varchar(50) NOT NULL,
  `objetivo` enum('HIPERTROFIA','FUERZA','DEFINICION') NOT NULL DEFAULT 'HIPERTROFIA',
  `nivelRutina` enum('PRINCIPIANTE','INTERMEDIO','AVANZADO') DEFAULT NULL,
  `estadoRutina` enum('ACTIVO','INACTIVO') DEFAULT 'INACTIVO',
  PRIMARY KEY (`idRutina`),
  KEY `FK_rutinas_entrenadores` (`idEntrenador_fk`),
  CONSTRAINT `FK_rutinas_entrenadores` FOREIGN KEY (`idEntrenador_fk`) REFERENCES `entrenadores` (`idEntrenador`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.rutinas: ~8 rows (approximately)
INSERT INTO `rutinas` (`idRutina`, `idEntrenador_fk`, `nomRutina`, `objetivo`, `nivelRutina`, `estadoRutina`) VALUES
	(1, 1, 'Pecho y Tríceps', 'FUERZA', 'PRINCIPIANTE', 'ACTIVO'),
	(2, 1, 'Espalda y Bíceps', 'HIPERTROFIA', 'INTERMEDIO', 'ACTIVO'),
	(3, 2, 'Piernas y Glúteos', 'FUERZA', 'PRINCIPIANTE', 'ACTIVO'),
	(4, 2, 'Hombros y Abdomen', 'FUERZA', 'PRINCIPIANTE', 'ACTIVO'),
	(5, 3, 'Cardio y Resistencia', 'DEFINICION', 'INTERMEDIO', 'ACTIVO'),
	(6, 3, 'Full Body Principiantes', 'FUERZA', 'AVANZADO', 'ACTIVO'),
	(7, 1, 'Hipertrofia Avanzada', 'HIPERTROFIA', 'AVANZADO', 'ACTIVO'),
	(8, 2, 'Definición Muscular', 'DEFINICION', 'AVANZADO', 'ACTIVO');

-- Dumping structure for table agrofit.semana_adaptacion
CREATE TABLE IF NOT EXISTS `semana_adaptacion` (
  `idAdaptacion` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario_fk` int(11) DEFAULT NULL,
  `idRutina_fk` int(11) DEFAULT 6,
  `fechaInicio` date NOT NULL,
  `fechaFin` date DEFAULT NULL,
  `estado` enum('EN_PROCESO','COMPLETADA','NO_REQUERIDA') NOT NULL DEFAULT 'EN_PROCESO',
  PRIMARY KEY (`idAdaptacion`),
  KEY `FK_semana_adaptacion_rutinas` (`idRutina_fk`),
  KEY `FK_semana_adaptacion_usuarios` (`idUsuario_fk`),
  CONSTRAINT `FK_semana_adaptacion_rutinas` FOREIGN KEY (`idRutina_fk`) REFERENCES `rutinas` (`idRutina`) ON UPDATE CASCADE,
  CONSTRAINT `FK_semana_adaptacion_usuarios` FOREIGN KEY (`idUsuario_fk`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.semana_adaptacion: ~0 rows (approximately)
INSERT INTO `semana_adaptacion` (`idAdaptacion`, `idUsuario_fk`, `idRutina_fk`, `fechaInicio`, `fechaFin`, `estado`) VALUES
	(3, 31, 6, '2026-09-26', '2026-09-26', 'NO_REQUERIDA');

-- Dumping structure for table agrofit.tipo_documento
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `idTipoDoc` int(11) NOT NULL AUTO_INCREMENT,
  `nomDoc` varchar(50) NOT NULL,
  PRIMARY KEY (`idTipoDoc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.tipo_documento: ~5 rows (approximately)
INSERT INTO `tipo_documento` (`idTipoDoc`, `nomDoc`) VALUES
	(1, 'Cédula de Ciudadanía'),
	(2, 'Tarjeta de Identidad'),
	(3, 'Cédula de Extranjería'),
	(4, 'Pasaporte'),
	(5, 'Permiso Especial de Permanencia');

-- Dumping structure for table agrofit.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idRol_fk` int(11) DEFAULT NULL,
  `idTipoDoc_fk` int(11) DEFAULT NULL,
  `docUsu` varchar(50) NOT NULL,
  `nomUsu` varchar(50) NOT NULL,
  `apellUsu` varchar(50) NOT NULL,
  `numUsu` varchar(50) NOT NULL,
  `correoUsu` varchar(50) NOT NULL,
  `clave` varchar(200) NOT NULL DEFAULT '123456789',
  `estadoU` enum('ACTIVO','INACTIVO') NOT NULL DEFAULT 'INACTIVO',
  `edad` int(11) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `estatura` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `correoUsu` (`correoUsu`),
  UNIQUE KEY `docUsu` (`docUsu`),
  KEY `FK_usuarios_tipo_documento` (`idTipoDoc_fk`),
  KEY `FK_usuarios_roles` (`idRol_fk`),
  CONSTRAINT `FK_usuarios_roles` FOREIGN KEY (`idRol_fk`) REFERENCES `roles` (`idRol`) ON UPDATE CASCADE,
  CONSTRAINT `FK_usuarios_tipo_documento` FOREIGN KEY (`idTipoDoc_fk`) REFERENCES `tipo_documento` (`idTipoDoc`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Dumping data for table agrofit.usuarios: ~18 rows (approximately)
INSERT INTO `usuarios` (`idUsuario`, `idRol_fk`, `idTipoDoc_fk`, `docUsu`, `nomUsu`, `apellUsu`, `numUsu`, `correoUsu`, `clave`, `estadoU`, `edad`, `peso`, `estatura`) VALUES
	(1, 1, 1, '12345678', 'Jonny', 'Chilito', '3135396758', 'jchilito07@agrofit.edu.co', 'pbkdf2_sha256$1500000$HbCojIcE51aFUX4QPDVubC$V20qRnZP6Qt9u5TmaZeZP9LiEBgB7RLVv8+zonlApC0=', 'ACTIVO', 19, 50.00, 1.67),
	(2, 3, 1, '23456789', 'Luisa', 'Martínez', '3012345678', 'luisa.martinez@agrofit.edu.co', '5345215274', 'INACTIVO', 15, 40.00, 1.88),
	(3, 4, 1, '34567890', 'Andrés', 'Gómez', '3023456789', 'andres.gomez@agrofit.edu.co', '47251745227', 'ACTIVO', 16, 100.00, 2.00),
	(4, 4, 1, '45678901', 'Paola', 'Herrera', '3034567890', 'paola.herrera@agrofit.edu.co', '7867854', 'ACTIVO', 18, 90.00, 1.99),
	(5, 2, 1, '56789012', 'Dayana', 'Galvis', '3045678901', 'jhon.perez@agrofit.edu.co', '5257873', 'ACTIVO', 50, 88.00, 1.58),
	(6, 3, 3, '1001234567', 'Santiago', 'López', '3056789012', 'santiago.lopez@sena.edu.co', '538768745', 'ACTIVO', 20, 96.00, 1.65),
	(7, 3, 2, '1001234568', 'Valentina', 'Torres', '3067890123', 'valentina.torres@sena.edu.co', '257416983', 'ACTIVO', 21, 14.00, 1.77),
	(8, 3, 3, '1001234569', 'Sebastián', 'Vargas', '3078901234', 'sebastian.vargas@sena.edu.co', '87978645', 'ACTIVO', 19, 25.00, 1.29),
	(9, 3, 2, '1001234570', 'Camila', 'Ríos', '3089012345', 'camila.rios@sena.edu.co', '45245678', 'ACTIVO', 20, 54.00, 1.78),
	(10, 3, 3, '1001234571', 'Daniel', 'Castillo', '3090123456', 'daniel.castillo@sena.edu.co', '789789745', 'ACTIVO', 23, 69.00, 1.87),
	(11, 3, 2, '1001234572', 'María', 'Jiménez', '3101234567', 'maria.jimenez@sena.edu.co', '1526789', 'ACTIVO', 25, 87.00, 1.69),
	(12, 3, 2, '1001234573', 'Felipe', 'Moreno', '3112345678', 'felipe.moreno@sena.edu.co', '45645167', 'INACTIVO', 35, 58.00, 1.72),
	(13, 3, 3, '1001234574', 'Laura', 'Ruiz', '3123456789', 'laura.ruiz@sena.edu.co', '456789451', 'ACTIVO', 13, 98.00, 1.99),
	(14, 3, 2, '1001234575', 'Mateo', 'Díaz', '3134567890', 'mateo.diaz@sena.edu.co', '459786451', 'ACTIVO', 18, 115.00, 1.82),
	(15, 3, 2, '1001234576', 'Isabella', 'Cruz', '3145678901', 'isabella.cruz@sena.edu.co', '789456415', 'ACTIVO', 28, 99.00, 1.63),
	(27, 3, 1, '1059239740', 'prueba', 'uno', '3135396758', 'prueba@soy.sena.edu.co', '1978719879', 'INACTIVO', 19, NULL, NULL),
	(28, 2, 1, '1059239741', 'prueba', 'dos', '123456789', 'pruebados@sena.edu.co', '1231321654', 'ACTIVO', 19, NULL, NULL),
	(31, 3, 1, '1059239742', 'Prueba', 'Tres', '3135396758', 'pruebatres@soy.sena.edu.co', '879798714', 'INACTIVO', 19, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
