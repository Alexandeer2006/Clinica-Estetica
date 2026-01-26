-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--

CREATE DATABASE IF NOT EXISTS clinica;
USE clinica;

-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--


-- SET @@GLOBAL.GTID_PURGED='uuid:1-87';



--
-- Table structure for table `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidades` (
  `id_especialidad` int NOT NULL AUTO_INCREMENT,
  `nombre_esp` varchar(35) NOT NULL,
  `descripcion_esp` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id_especialidad`),
  CONSTRAINT `especialidades_chk_1` CHECK (regexp_like(`nombre_esp`,_utf8mb4'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidades`
--

LOCK TABLES `especialidades` WRITE;
/*!40000 ALTER TABLE `especialidades` DISABLE KEYS */;
INSERT INTO `especialidades` VALUES (1,'Dermatologia','Piel'),(2,'Cirugia Plastica','Cirugia estetica'),(3,'Medicina Estetica','Tratamientos esteticos'),(4,'Odontologia','Salud dental'),(5,'Ginecologia','Salud femenina'),(6,'Traumatologia','Huesos y musculos'),(7,'Cardiologia','Corazon'),(8,'Neurologia','Sistema nervioso'),(9,'Nutricion','Alimentacion'),(10,'Cosmetologia','Belleza y cuidado');
/*!40000 ALTER TABLE `especialidades` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `tratamientos`
--

DROP TABLE IF EXISTS `tratamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamientos` (
  `id_tratamiento` int NOT NULL AUTO_INCREMENT,
  `costo` decimal(10,2) NOT NULL,
  `nombre_tratamiento` varchar(50) NOT NULL,
  `tipo_tratamiento` enum('Quirurgico','No quirurgico') NOT NULL,
  `especialidad` int NOT NULL,
  PRIMARY KEY (`id_tratamiento`),
  KEY `especialidad` (`especialidad`),
  CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`especialidad`) REFERENCES `especialidades` (`id_especialidad`),
  CONSTRAINT `tratamientos_chk_1` CHECK ((`costo` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratamientos`
--

LOCK TABLES `tratamientos` WRITE;
/*!40000 ALTER TABLE `tratamientos` DISABLE KEYS */;
INSERT INTO `tratamientos` VALUES (31,500.00,'Botox Facial','No quirurgico',10),(32,1200.00,'Liposuccion','Quirurgico',2),(33,300.00,'Peeling Quimico','No quirurgico',1),(34,250.00,'Limpieza Facial','No quirurgico',10),(35,2000.00,'Rinoplastia','Quirurgico',2),(36,150.00,'Hidratacion Facial','No quirurgico',3),(37,1800.00,'Abdominoplastia','Quirurgico',2),(38,400.00,'Rejuvenecimiento','No quirurgico',3),(39,2200.00,'Cirugia Ocular','Quirurgico',2),(40,350.00,'Tratamiento Acne','No quirurgico',1);
/*!40000 ALTER TABLE `tratamientos` ENABLE KEYS */;
UNLOCK TABLES;






--
-- Table structure for table `enfermeras`
--

DROP TABLE IF EXISTS `enfermeras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enfermeras` (
  `id_enfermera` int NOT NULL,
  `nombre_enfermera` varchar(35) NOT NULL,
  `apellido_enfermera` varchar(35) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo_enfermera` varchar(35) NOT NULL,
  `telefono` int NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_enfermera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `enfermeras` VALUES
(1,'Laura','Gomez','1990-05-10','laura.gomez@clinica.com',987111111,1500.00),
(2,'Paula','Rios','1992-08-20','paula.rios@clinica.com',987222222,1600.00),
(3,'Andrea','Lopez','1988-03-15','andrea.lopez@clinica.com',987333333,1550.00),
(4,'Camila','Vera','1991-11-02','camila.vera@clinica.com',987444444,1450.00),
(5,'Daniela','Mora','1989-07-25','daniela.mora@clinica.com',987555555,1580.00),
(6,'Sofia','Paredes','1993-01-18','sofia.paredes@clinica.com',987666666,1620.00),
(7,'Natalia','Cruz','1987-09-30','natalia.cruz@clinica.com',987777777,1700.00),
(8,'Valeria','Ortega','1994-06-12','valeria.ortega@clinica.com',987888888,1480.00),
(9,'Mariana','Flores','1990-12-05','mariana.flores@clinica.com',987999999,1520.00),
(10,'Lucia','Benitez','1995-04-22','lucia.benitez@clinica.com',987000000,1490.00);




--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL,
  `nombre_producto` varchar(20) NOT NULL,
  `precio_unitario` int NOT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `categoria` varchar(20) NOT NULL,
  `disponibilidad` int NOT NULL,
  `expiracion` date NOT NULL,
  `elaboracion` date DEFAULT NULL,
  `id_enfermera` int NOT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `enfermera_revisa` FOREIGN KEY (`id_enfermera`) REFERENCES `enfermeras` (`id_enfermera`),
  CONSTRAINT `productos_chk_1` CHECK ((`precio_unitario` > 0)),
  CONSTRAINT `productos_chk_2` CHECK ((`disponibilidad` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;





--
-- Dumping data for table `productos`
--


LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES
(1,'Botox',120,NULL,'Inyeccion',50,'2026-12-31','2024-01-10',1),
(2,'Acido Hialuronico',150,'Juvederm','Inyeccion',40,'2026-11-30','2024-02-05',1),
(3,'Anestesia',80,'Medica','Medicamento',100,'2027-05-20','2024-03-01',1),
(4,'Crema Facial',30,'SkinCare','Crema',60,'2025-08-15','2024-01-20',1),
(5,'Guantes',10,'SafeMed','Insumo',500,'2028-01-01','2024-01-01',1),
(6,'Mascarillas',5,'SafeMed','Insumo',800,'2027-06-30','2024-02-10',1),
(7,'Jeringas',2,'Inject','Insumo',1000,'2029-12-31','2024-01-05',1),
(8,'Laser Gel',45,'LaserPro','Gel',70,'2026-09-30','2024-03-15',1),
(9,'Vitamina C',25,'NutriSkin','Suplemento',90,'2026-04-10','2024-02-25',1),
(10,'Peeling',60,'DermaPlus','Quimico',55,'2026-07-07','2024-03-30',2);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;







--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL,
  `lote` int NOT NULL,
  `nombre_proveedor` varchar(50) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  CONSTRAINT `proveedor_chk_1` CHECK ((`id_proveedor` > 0)),
  CONSTRAINT `proveedor_chk_2` CHECK ((`lote` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,101,'BioMed Supply'),(2,102,'Estetica Plus'),(3,103,'Medical Corp'),(4,104,'Salud Total'),(5,105,'Clinica Pharma'),(6,106,'CosmoCare'),(7,107,'VitalMed'),(8,108,'Dermalab'),(9,109,'NeoHealth'),(10,110,'ProEstetica');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL AUTO_INCREMENT,
  `fecha_nacimiento` date NOT NULL,
  `nombre_paciente` varchar(30) NOT NULL,
  `apellido_paciente` varchar(30) NOT NULL,
  `telefono` int DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'2000-05-12','Juan','Pérez',987654321,'Av. Central','juan@mail.com'),(2,'1998-03-20','Ana','Gómez',987654322,'Calle 1','ana@mail.com'),(3,'2001-07-15','Luis','Torres',987654323,'Calle 2','luis@mail.com'),(4,'1995-11-30','María','López',987654324,'Av. Norte','maria@mail.com'),(5,'2003-01-10','Carlos','Ruiz',987654325,'Av. Sur','carlos@mail.com'),(6,'1999-09-09','Sofía','Mora',987654326,'Calle 3','sofia@mail.com'),(7,'2002-02-18','Pedro','Vega',987654327,'Calle 4','pedro@mail.com'),(8,'1997-06-25','Lucía','Reyes',987654328,'Av. Este','lucia@mail.com'),(9,'2004-12-05','Jorge','León',987654329,'Calle 5','jorge@mail.com'),(10,'1996-08-14','Daniela','Cruz',987654330,'Av. Oeste','daniela@mail.com');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `recepcionista`
--

DROP TABLE IF EXISTS `recepcionista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recepcionista` (
  `id_recepcionista` int NOT NULL,
  `nombre_recepcionista` varchar(50) NOT NULL,
  PRIMARY KEY (`id_recepcionista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recepcionista`
--

LOCK TABLES `recepcionista` WRITE;
/*!40000 ALTER TABLE `recepcionista` DISABLE KEYS */;
INSERT INTO `recepcionista` VALUES (1,'Ana Torres'),(2,'Luis Gómez'),(3,'María Pérez'),(4,'Carlos Ruiz'),(5,'Sofía López'),(6,'Pedro Andrade'),(7,'Lucía Molina'),(8,'Jorge Vélez'),(9,'Daniela Cruz'),(10,'Miguel Flores');
/*!40000 ALTER TABLE `recepcionista` ENABLE KEYS */;
UNLOCK TABLES;







--
-- Table structure for table `profesionales`
--

DROP TABLE IF EXISTS `profesionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesionales` (
  `id_profesional` int NOT NULL,
  `nombre_prof` varchar(35) NOT NULL,
  `apellido_prof` varchar(35) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo_profesional` varchar(35) NOT NULL,
  `telefono` int NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `tipo_prof` enum('doctor','cosmetologo') NOT NULL,
  PRIMARY KEY (`id_profesional`),
  CONSTRAINT `profesionales_chk_1` CHECK ((`telefono` > 0)),
  CONSTRAINT `profesionales_chk_2` CHECK ((`salario` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesionales`
--


LOCK TABLES `profesionales` WRITE;
/*!40000 ALTER TABLE profesionales DISABLE KEYS */;
INSERT INTO `profesionales` VALUES (1,'Carlos','Mendoza','1980-05-12','cmendoza@clinica.com',987654321,2500.00,'doctor'),(2,'Ana','Torres','1985-08-20','atorres@clinica.com',987654322,2300.00,'doctor'),(3,'Luis','Vera','1990-03-15','lvera@clinica.com',987654323,1800.00,'cosmetologo'),(4,'Maria','Paz','1992-07-01','mpaz@clinica.com',987654324,1800.00,'cosmetologo'),(5,'Jorge','Rios','1988-11-10','jrios@clinica.com',987654325,2600.00,'doctor'),(6,'Paula','Leon','1991-01-05','pleon@clinica.com',987654326,2000.00,'cosmetologo'),(7,'Ricardo','Salas','1983-04-18','rsalas@clinica.com',987654327,2700.00,'doctor'),(8,'Diana','Moreno','1994-09-22','dmoreno@clinica.com',987654328,1900.00,'cosmetologo'),(9,'Fernando','Cruz','1987-06-30','fcruz@clinica.com',987654329,2550.00,'doctor'),(10,'Lucia','Benitez','1993-12-14','lbenitez@clinica.com',987654330,1850.00,'cosmetologo');
/*!40000 ALTER TABLE profesionales ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `id_doctor` int NOT NULL,
  `nombre` varchar(35),
  `apellido` varchar(35),
  PRIMARY KEY (`id_doctor`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`id_doctor`) REFERENCES `profesionales` (`id_profesional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE doctor DISABLE KEYS */;
INSERT INTO `doctor` (id_doctor, nombre, apellido) VALUES 
(1, 'Carlos', 'Mendoza'),
(2, 'Ana', 'Torres'),
(5, 'Jorge', 'Rios'),
(7, 'Ricardo', 'Salas'),
(9, 'Fernando', 'Cruz');
/*!40000 ALTER TABLE doctor ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `cosmetologo`
--

DROP TABLE IF EXISTS `cosmetologo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cosmetologo` (
  `id_cosmetologo` int NOT NULL,
  `nombre` varchar(35),
  `apellido` varchar(35),
  PRIMARY KEY (`id_cosmetologo`),
  CONSTRAINT `cosmetologo_ibfk_1` FOREIGN KEY (`id_cosmetologo`) REFERENCES `profesionales` (`id_profesional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cosmetologo`
--

LOCK TABLES `cosmetologo` WRITE;
/*!40000 ALTER TABLE cosmetologo DISABLE KEYS */;
INSERT INTO `cosmetologo` (id_cosmetologo, nombre, apellido) VALUES 
(3, 'Luis', 'Vera'),
(4, 'Maria', 'Paz'),
(6, 'Paula', 'Leon'),
(8, 'Diana', 'Moreno'),
(10, 'Lucia', 'Benitez');
/*!40000 ALTER TABLE cosmetologo ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `descuento` int DEFAULT NULL,
  `metodo_pago` varchar(20) DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `estado_pago` varchar(20) DEFAULT NULL,
  `id_recepcionista` int DEFAULT NULL,
  `id_paciente` int DEFAULT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `id_recepcionista` (`id_recepcionista`),
  KEY `id_paciente` (`id_paciente`),
  CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`id_recepcionista`) REFERENCES `recepcionista` (`id_recepcionista`),
  CONSTRAINT `facturas_ibfk_2` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,'2025-01-10',10,'Efectivo',100.00,'Pagado',1,1),(2,'2025-01-11',0,'Tarjeta',150.00,'Pendiente',2,2),(3,'2025-01-12',5,'Efectivo',120.00,'Pagado',3,3),(4,'2025-01-13',0,'Transferencia',200.00,'Pagado',4,4),(5,'2025-01-14',15,'Tarjeta',180.00,'Pendiente',5,5),(6,'2025-01-15',0,'Efectivo',90.00,'Pagado',6,6),(7,'2025-01-16',10,'Tarjeta',110.00,'Pagado',7,7),(8,'2025-01-17',0,'Transferencia',130.00,'Pendiente',8,8),(9,'2025-01-18',20,'Efectivo',160.00,'Pagado',9,9),(10,'2025-01-19',0,'Tarjeta',140.00,'Pagado',10,10);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;





--
-- Table structure for table `procedimientos`
--

DROP TABLE IF EXISTS `procedimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedimientos` (
  `id_procedimiento` int NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `duracion` decimal(10,2) DEFAULT NULL,
  `detalles` varchar(200) DEFAULT NULL,
  `id_factura` int DEFAULT NULL,
  `id_tratamiento` int DEFAULT NULL,
  `id_enfermera` int DEFAULT NULL,
  PRIMARY KEY (`id_procedimiento`),
  KEY `id_factura` (`id_factura`),
  KEY `fk_procedimientos_tratamiento` (`id_tratamiento`),
  KEY `fk_procedimientos_enfermera` (`id_enfermera`),
  CONSTRAINT `fk_procedimientos_enfermera` FOREIGN KEY (`id_enfermera`) REFERENCES `enfermeras` (`id_enfermera`),
  CONSTRAINT `fk_procedimientos_tratamiento` FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamientos` (`id_tratamiento`),
  CONSTRAINT `procedimientos_ibfk_1` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedimientos`
--

LOCK TABLES `procedimientos` WRITE;
/*!40000 ALTER TABLE `procedimientos` DISABLE KEYS */;
INSERT INTO `procedimientos` VALUES (1,'2025-01-10','08:00:00',1.50,'Consulta general',1,31,1),(2,'2025-01-11','09:00:00',2.00,'Examen médico',2,32,2),(3,'2025-01-12','10:00:00',1.00,'Control',3,33,3),(4,'2025-01-13','11:00:00',1.75,'Tratamiento',4,34,4),(5,'2025-01-14','12:00:00',2.50,'Evaluación',5,35,5),(6,'2025-01-15','13:00:00',1.25,'Seguimiento',6,36,6),(7,'2025-01-16','14:00:00',1.00,'Revisión',7,37,7),(8,'2025-01-17','15:00:00',1.80,'Diagnóstico',8,38,8),(9,'2025-01-18','16:00:00',2.20,'Procedimiento',9,39,9),(10,'2025-01-19','17:00:00',1.40,'Consulta final',10,40,2);
/*!40000 ALTER TABLE `procedimientos` ENABLE KEYS */;
UNLOCK TABLES;






--
-- Table structure for table `problemas_salud`
--

DROP TABLE IF EXISTS `problemas_salud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `problemas_salud` (
  `problema_salud` int NOT NULL,
  `nombre_problema` varchar(35) NOT NULL,
  `categoria` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`problema_salud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problemas_salud`
--

LOCK TABLES `problemas_salud` WRITE;
/*!40000 ALTER TABLE `problemas_salud` DISABLE KEYS */;
INSERT INTO `problemas_salud` VALUES (1,'Hipertensión','Cardiología'),(2,'Diabetes','Endocrinología'),(3,'Asma','Neumología'),(4,'Migraña','Neurología'),(5,'Gastritis','Gastroenterología'),(6,'Anemia','Hematología'),(7,'Alergia','Inmunología'),(8,'Dolor lumbar','Traumatología'),(9,'Insomnio','Psiquiatría'),(10,'Ansiedad','Psicología');
/*!40000 ALTER TABLE `problemas_salud` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `estado_cita` enum('Pendiente','Confirmada','Cancelada','Atendida') NOT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `id_paciente` int DEFAULT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `id_paciente` (`id_paciente`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,'2025-02-01','08:00:00','Pendiente','Primera cita',1),(2,'2025-02-02','09:00:00','Confirmada','Revisión',2),(3,'2025-02-03','10:00:00','Atendida','Control',3),(4,'2025-02-04','11:00:00','Cancelada','No asistió',4),(5,'2025-02-05','12:00:00','Pendiente','Consulta',5),(6,'2025-02-06','13:00:00','Confirmada','Seguimiento',6),(7,'2025-02-07','14:00:00','Atendida','Tratamiento',7),(8,'2025-02-08','15:00:00','Pendiente','Evaluación',8),(9,'2025-02-09','16:00:00','Confirmada','Control',9),(10,'2025-02-10','17:00:00','Atendida','Final',10);
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `asignacion`
--

DROP TABLE IF EXISTS `asignacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion` (
  `id_asignacion` int NOT NULL,
  `unidad` int NOT NULL,
  `id_producto` int NOT NULL,
  `id_tratamiento` int NOT NULL,
  PRIMARY KEY (`id_asignacion`),
  KEY `id_producto` (`id_producto`),
  KEY `id_tratamiento` (`id_tratamiento`),
  CONSTRAINT `asignacion_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `asignacion_ibfk_3` FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamientos` (`id_tratamiento`),
  CONSTRAINT `asignacion_chk_1` CHECK ((`unidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion`
--

LOCK TABLES `asignacion` WRITE;
/*!40000 ALTER TABLE `asignacion` DISABLE KEYS */;
INSERT INTO `asignacion` VALUES
(1,11,2,31),
(2,12,1,32),
(3,13,3,33),
(4,14,2,34),
(5,15,1,35),
(6,16,4,36),
(7,17,2,37),
(8,18,3,38),
(9,19,1,39),
(10,20,2,40);
/*!40000 ALTER TABLE `asignacion` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `citas_procedimientos`
--

DROP TABLE IF EXISTS `citas_procedimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas_procedimientos` (
  `id_cita` int NOT NULL,
  `id_procedimiento` int NOT NULL,
  `hora_realizacion` time DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_cita`,`id_procedimiento`),
  KEY `id_procedimiento` (`id_procedimiento`),
  CONSTRAINT `citas_procedimientos_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`),
  CONSTRAINT `citas_procedimientos_ibfk_2` FOREIGN KEY (`id_procedimiento`) REFERENCES `procedimientos` (`id_procedimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;




--
-- Dumping data for table `citas_procedimientos`
--

LOCK TABLES `citas_procedimientos` WRITE;
/*!40000 ALTER TABLE `citas_procedimientos` DISABLE KEYS */;
INSERT INTO `citas_procedimientos` VALUES (1,1,'08:10:00',1),(2,2,'09:10:00',1),(3,3,'10:10:00',1),(4,4,'11:10:00',1),(5,5,'12:10:00',1),(6,6,'13:10:00',1),(7,7,'14:10:00',1),(8,8,'15:10:00',1),(9,9,'16:10:00',1),(10,10,'17:10:00',1);
/*!40000 ALTER TABLE `citas_procedimientos` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `detalle_entrega`
--

DROP TABLE IF EXISTS `detalle_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_entrega` (
  `id_surtir` int NOT NULL,
  `id_producto` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `observaciones_producto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_surtir`),
  KEY `id_producto` (`id_producto`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `detalle_entrega_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `detalle_entrega_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `detalle_entrega_chk_1` CHECK ((`id_surtir` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_entrega`
--

LOCK TABLES `detalle_entrega` WRITE;
/*!40000 ALTER TABLE `detalle_entrega` DISABLE KEYS */;
INSERT INTO `detalle_entrega` VALUES (1,1,1,'2024-04-01','Entrega inicial'),(2,2,2,'2024-04-02','Stock mensual'),(3,3,3,'2024-04-03',NULL),(4,4,4,'2024-04-04','Producto delicado'),(5,5,5,'2024-04-05',NULL),(6,6,6,'2024-04-06','Entrega completa'),(7,7,7,'2024-04-07',NULL),(8,8,8,'2024-04-08','Refrigerar'),(9,9,9,'2024-04-09',NULL),(10,10,10,'2024-04-10','Uso inmediato');
/*!40000 ALTER TABLE `detalle_entrega` ENABLE KEYS */;
UNLOCK TABLES;






--
-- Table structure for table `no_quirurgico`
--

DROP TABLE IF EXISTS `no_quirurgico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `no_quirurgico` (
  `id_no_quirurgico` int NOT NULL,
  `tipo_no_quirurgico` varchar(30) NOT NULL,
  PRIMARY KEY (`id_no_quirurgico`),
  CONSTRAINT `no_quirurgico_ibfk_1` FOREIGN KEY (`id_no_quirurgico`) REFERENCES `tratamientos` (`id_tratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `no_quirurgico`
--

LOCK TABLES `no_quirurgico` WRITE;
/*!40000 ALTER TABLE `no_quirurgico` DISABLE KEYS */;
INSERT INTO `no_quirurgico` VALUES (31,'Estetico'),(33,'Dermatologico'),(34,'Limpieza'),(36,'Hidratacion'),(38,'Rejuvenecimiento'),(40,'Acne');
/*!40000 ALTER TABLE `no_quirurgico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente_problema`
--

DROP TABLE IF EXISTS `paciente_problema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente_problema` (
  `problema_salud` int NOT NULL,
  `id_paciente` int NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`problema_salud`,`id_paciente`),
  KEY `id_paciente` (`id_paciente`),
  CONSTRAINT `paciente_problema_ibfk_1` FOREIGN KEY (`problema_salud`) REFERENCES `problemas_salud` (`problema_salud`),
  CONSTRAINT `paciente_problema_ibfk_2` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente_problema`
--

LOCK TABLES `paciente_problema` WRITE;
/*!40000 ALTER TABLE `paciente_problema` DISABLE KEYS */;
INSERT INTO `paciente_problema` VALUES (1,1,'Control periódico'),(2,2,'Tratamiento continuo'),(3,3,'Uso de inhalador'),(4,4,'Dolor frecuente'),(5,5,'Dieta especial'),(6,6,'Déficit de hierro'),(7,7,'Reacción alérgica'),(8,8,'Dolor crónico'),(9,9,'Problemas de sueño'),(10,10,'Estrés constante');
/*!40000 ALTER TABLE `paciente_problema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente_procedimiento`
--

DROP TABLE IF EXISTS `paciente_procedimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente_procedimiento` (
  `id_procedimiento` int NOT NULL,
  `id_paciente` int NOT NULL,
  `observacion` varchar(500) DEFAULT NULL,
  `consentimiento` enum('si','no') NOT NULL,
  PRIMARY KEY (`id_procedimiento`,`id_paciente`),
  KEY `id_paciente` (`id_paciente`),
  CONSTRAINT `paciente_procedimiento_ibfk_1` FOREIGN KEY (`id_procedimiento`) REFERENCES `procedimientos` (`id_procedimiento`),
  CONSTRAINT `paciente_procedimiento_ibfk_2` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente_procedimiento`
--

LOCK TABLES `paciente_procedimiento` WRITE;
/*!40000 ALTER TABLE `paciente_procedimiento` DISABLE KEYS */;
INSERT INTO `paciente_procedimiento` VALUES (1,1,'Sin novedades','si'),(2,2,'Buen estado','si'),(3,3,'Requiere control','si'),(4,4,'Observación leve','si'),(5,5,'Procedimiento largo','no'),(6,6,'Todo correcto','si'),(7,7,'Leve molestia','si'),(8,8,'Dolor moderado','si'),(9,9,'Requiere seguimiento','no'),(10,10,'Finalizado','si');
/*!40000 ALTER TABLE `paciente_procedimiento` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `profesionales_especialidades`
--

DROP TABLE IF EXISTS `profesionales_especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesionales_especialidades` (
  `especialidad` int NOT NULL,
  `profesional` int NOT NULL,
  `fecha_asociacion` date NOT NULL,
  PRIMARY KEY (`especialidad`,`profesional`),
  KEY `profesional` (`profesional`),
  CONSTRAINT `profesionales_especialidades_ibfk_1` FOREIGN KEY (`especialidad`) REFERENCES `especialidades` (`id_especialidad`),
  CONSTRAINT `profesionales_especialidades_ibfk_2` FOREIGN KEY (`profesional`) REFERENCES `profesionales` (`id_profesional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesionales_especialidades`
--

LOCK TABLES `profesionales_especialidades` WRITE;
/*!40000 ALTER TABLE `profesionales_especialidades` DISABLE KEYS */;
INSERT INTO `profesionales_especialidades` VALUES (1,1,'2015-01-10'),(1,7,'2013-08-05'),(2,2,'2016-02-12'),(2,5,'2014-06-18'),(2,9,'2012-10-30'),(3,3,'2018-03-15'),(3,6,'2020-07-10'),(3,10,'2022-11-12'),(10,4,'2019-04-20'),(10,8,'2021-09-22');
/*!40000 ALTER TABLE `profesionales_especialidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesionales_tratamientos`
--

DROP TABLE IF EXISTS `profesionales_tratamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesionales_tratamientos` (
  `id_tratamiento` int NOT NULL,
  `id_profesional` int NOT NULL,
  `rol` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tratamiento`,`id_profesional`),
  KEY `id_profesional` (`id_profesional`),
  CONSTRAINT `profesionales_tratamientos_ibfk_1` FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamientos` (`id_tratamiento`),
  CONSTRAINT `profesionales_tratamientos_ibfk_2` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`),
  CONSTRAINT `profesionales_tratamientos_chk_1` CHECK (regexp_like(`rol`,_utf8mb4'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesionales_tratamientos`
--

LOCK TABLES `profesionales_tratamientos` WRITE;
/*!40000 ALTER TABLE `profesionales_tratamientos` DISABLE KEYS */;
INSERT INTO `profesionales_tratamientos` VALUES (31,1,'Titular'),(32,2,'Titular'),(33,3,'Asistente'),(34,4,'Supervisor'),(35,5,'Titular'),(36,6,'Asistente'),(37,7,'Titular'),(38,8,'Supervisor'),(39,9,'Titular'),(40,10,'Asistente');
/*!40000 ALTER TABLE `profesionales_tratamientos` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `quirurgico`
--

DROP TABLE IF EXISTS `quirurgico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quirurgico` (
  `id_quirurgico` int NOT NULL,
  `tipo_quirurgico` varchar(30) NOT NULL,
  PRIMARY KEY (`id_quirurgico`),
  CONSTRAINT `quirurgico_ibfk_1` FOREIGN KEY (`id_quirurgico`) REFERENCES `tratamientos` (`id_tratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quirurgico`
--

LOCK TABLES `quirurgico` WRITE;
/*!40000 ALTER TABLE `quirurgico` DISABLE KEYS */;
INSERT INTO `quirurgico` VALUES (32,'Alta'),(35,'Alta'),(37,'Alta'),(39,'Media');
/*!40000 ALTER TABLE `quirurgico` ENABLE KEYS */;
UNLOCK TABLES;


-- 1.  ÍNDICES

CREATE INDEX idx_paciente_apellido ON pacientes(apellido_paciente);
CREATE INDEX idx_paciente_nombre ON pacientes(nombre_paciente);
CREATE INDEX idx_producto_nombre ON productos(nombre_producto);
CREATE INDEX idx_producto_enfermera ON productos(id_enfermera);
CREATE INDEX idx_citas_fecha ON citas(fecha_cita);


-- 2. TRIGGERS
DROP TRIGGER IF EXISTS tr_actualizar_stock_entrega;
DROP TRIGGER IF EXISTS tr_validar_precio_tratamiento;

DELIMITER //

-- Trigger 1: Actualizar stock de productos (Tabla: productos, Columna: stock)
CREATE TRIGGER tr_actualizar_stock_entrega
AFTER INSERT ON detalle_entrega
FOR EACH ROW
BEGIN
    UPDATE productos 
    SET disponibilidad = disponibilidad + 1 
    WHERE id_producto = NEW.id_producto;
END //

-- Trigger 2: Validar que el precio de un tratamiento no sea negativo al actualizar


CREATE TRIGGER tr_validar_precio_tratamiento
BEFORE UPDATE ON tratamientos
FOR EACH ROW
BEGIN
    IF NEW.costo <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El costo debe ser mayor que 0.';
    END IF;
END//

DELIMITER ;

-- Trigger para cuando INSERTAS un nuevo profesional
DELIMITER //
CREATE TRIGGER tras_insertar_profesional
AFTER INSERT ON profesionales
FOR EACH ROW
BEGIN
    IF NEW.tipo_prof = 'doctor' THEN
        INSERT INTO doctor (id_doctor, nombre, apellido) 
        VALUES (NEW.id_profesional, NEW.nombre_prof, NEW.apellido_prof);
    ELSEIF NEW.tipo_prof = 'cosmetologo' THEN
        INSERT INTO cosmetologo (id_cosmetologo, nombre, apellido) 
        VALUES (NEW.id_profesional, NEW.nombre_prof, NEW.apellido_prof);
    END IF;
END//
-- Trigger para cuando EDITAS (Update) un profesional existente
DROP TRIGGER IF EXISTS tras_actualizar_profesional;

DELIMITER //
CREATE TRIGGER tras_actualizar_profesional
AFTER UPDATE ON profesionales
FOR EACH ROW
BEGIN
    -- CASO 1: El tipo de profesional CAMBIÓ (Ej: de cosmetologo a doctor)
    IF OLD.tipo_prof <> NEW.tipo_prof THEN
        -- Borramos de la tabla donde estaba antes
        IF OLD.tipo_prof = 'doctor' THEN DELETE FROM doctor WHERE id_doctor = OLD.id_profesional;
        ELSEIF OLD.tipo_prof = 'cosmetologo' THEN DELETE FROM cosmetologo WHERE id_cosmetologo = OLD.id_profesional;
        END IF;

        -- Insertamos en la nueva tabla con los datos actuales
        IF NEW.tipo_prof = 'doctor' THEN 
            INSERT INTO doctor (id_doctor, nombre, apellido) VALUES (NEW.id_profesional, NEW.nombre_prof, NEW.apellido_prof);
        ELSEIF NEW.tipo_prof = 'cosmetologo' THEN 
            INSERT INTO cosmetologo (id_cosmetologo, nombre, apellido) VALUES (NEW.id_profesional, NEW.nombre_prof, NEW.apellido_prof);
        END IF;

    -- CASO 2: El tipo es el MISMO, pero cambiaron nombre o apellido
    ELSE
        IF NEW.tipo_prof = 'doctor' THEN
            UPDATE doctor SET nombre = NEW.nombre_prof, apellido = NEW.apellido_prof WHERE id_doctor = NEW.id_profesional;
        ELSEIF NEW.tipo_prof = 'cosmetologo' THEN
            UPDATE cosmetologo SET nombre = NEW.nombre_prof, apellido = NEW.apellido_prof WHERE id_cosmetologo = NEW.id_profesional;
        END IF;
    END IF;
END//
DELIMITER ;


-- Trigger para evitar datos basura
DELIMITER //
CREATE TRIGGER tras_eliminar_profesional
AFTER DELETE ON profesionales
FOR EACH ROW
BEGIN
    DELETE FROM doctor WHERE id_doctor = OLD.id_profesional;
    DELETE FROM cosmetologo WHERE id_cosmetologo = OLD.id_profesional;
END//
DELIMITER ;
-- =========================
-- PROCEDURE: PACIENTES
-- =========================
DROP PROCEDURE IF EXISTS sp_gestion_pacientes;

DELIMITER //

CREATE PROCEDURE sp_gestion_pacientes(
    IN p_accion VARCHAR(10),
    IN p_id INT,
    IN p_fecha_nac DATE,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_telefono INT,
    IN p_direccion VARCHAR(100),
    IN p_correo VARCHAR(50)
)
BEGIN
    -- Handler: si algo falla, revierte toda la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Operación fallida. Verifique los datos.';
    END;

    START TRANSACTION;

    IF p_accion = 'INSERT' THEN
        INSERT INTO pacientes (fecha_nacimiento, nombre_paciente, apellido_paciente, telefono, direccion, correo)
        VALUES (p_fecha_nac, p_nombre, p_apellido, p_telefono, p_direccion, p_correo);

    ELSEIF p_accion = 'UPDATE' THEN
        IF NOT EXISTS (SELECT 1 FROM pacientes WHERE id_paciente = p_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID del paciente no existe.';
        END IF;

        UPDATE pacientes
        SET fecha_nacimiento = p_fecha_nac,
            nombre_paciente = p_nombre,
            apellido_paciente = p_apellido,
            telefono = p_telefono,
            direccion = p_direccion,
            correo = p_correo
        WHERE id_paciente = p_id;

    ELSEIF p_accion = 'DELETE' THEN
        IF NOT EXISTS (SELECT 1 FROM pacientes WHERE id_paciente = p_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID del paciente no existe.';
        END IF;

        DELETE FROM pacientes WHERE id_paciente = p_id;

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Acción no reconocida (Use INSERT, UPDATE o DELETE).';
    END IF;

    COMMIT;
END //
DELIMITER ;

-- 4. REPORTES 

-- Reporte 1: Citas con nombres de Pacientes y Profesionales

CREATE OR REPLACE VIEW view_reporte_citas AS
SELECT c.id_cita, p.nombre_paciente AS nombre_paciente, p.apellido_paciente AS apellido_paciente, 
       prof.nombre_prof AS nombre_profesional, c.fecha_cita, c.estado_cita
FROM citas c
JOIN pacientes p
    ON p.id_paciente = c.id_paciente
JOIN citas_procedimientos cp
    ON cp.id_cita = c.id_cita
JOIN procedimientos pr
    ON pr.id_procedimiento = cp.id_procedimiento
JOIN tratamientos t
    ON t.id_tratamiento = pr.id_tratamiento
JOIN profesionales_tratamientos pt
    ON pt.id_tratamiento = t.id_tratamiento AND pt.rol = 'Titular'
JOIN profesionales prof
    ON prof.id_profesional = pt.id_profesional;



-- Reporte 2: Facturación detallada
CREATE OR REPLACE VIEW view_reporte_facturas AS
SELECT f.id_factura, p.nombre_paciente, p.apellido_paciente, f.subtotal, f.metodo_pago, f.estado_pago
FROM facturas f
JOIN pacientes p ON f.id_paciente = p.id_paciente;


-- Reporte 3: Inventario Detallado 

CREATE OR REPLACE VIEW view_reporte_inventario AS
SELECT
    pr.id_producto,
    pr.nombre_producto,
    pr.disponibilidad,
    pr.marca,
    pr.categoria,
    prov.nombre_proveedor AS proveedor,
    de.fecha_ingreso,
    de.observaciones_producto
FROM productos pr
JOIN detalle_entrega de
    ON de.id_producto = pr.id_producto
JOIN proveedor prov
    ON prov.id_proveedor = de.id_proveedor;

-- Reporte 4: Problemas de salud por paciente
CREATE OR REPLACE VIEW view_reporte_salud_paciente AS
SELECT p.nombre_paciente, p.apellido_paciente, ps.nombre_problema AS problema, ps.categoria
FROM pacientes p
JOIN paciente_problema pp ON p.id_paciente = pp.id_paciente
JOIN problemas_salud ps ON pp.problema_salud = ps.problema_salud;

-- 6. Creación de usuarios y permisos 
-- ------USUARIOS--------------
CREATE USER IF NOT EXISTS 'administrador'@'localhost' IDENTIFIED BY 'Admin123'; -- Usuario 1 
CREATE USER IF NOT EXISTS 'recepcionista'@'localhost' IDENTIFIED BY 'Recep123'; -- Usuario 2
CREATE USER IF NOT EXISTS 'medico'@'localhost' IDENTIFIED BY 'Medico123'; -- Usuario 3
CREATE USER IF NOT EXISTS 'proveedor'@'localhost' IDENTIFIED BY 'Proveedor123' PASSWORD EXPIRE; -- Usuario 4
CREATE USER IF NOT EXISTS 'auditor'@'localhost' IDENTIFIED BY 'Auditor123' PASSWORD EXPIRE; -- -- Usuario 5

-- ------PERMISOS DEL ADMINISTRADOR ( Usuario 1 )------
GRANT ALL PRIVILEGES ON clinica.* TO 'administrador'@'localhost';

-- ------ PERMISOS DEL RECEPCIONISTA (Usuario 2) -----
GRANT SELECT, INSERT, UPDATE ON clinica.pacientes TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE ON clinica.citas TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE ON clinica.facturas TO 'recepcionista'@'localhost';
-- Permiso a Stored Procedure :
GRANT EXECUTE ON PROCEDURE clinica.sp_gestion_pacientes TO 'recepcionista'@'localhost';
-- Permiso a Vista:
GRANT SELECT ON clinica.view_reporte_citas TO 'recepcionista'@'localhost';

-- --------PERMISOS DEL MÉDICO / ESPECIALISTA ( Usuario 3)-----
GRANT SELECT, UPDATE ON clinica.pacientes TO 'medico'@'localhost';
GRANT SELECT, UPDATE ON clinica.tratamientos TO 'medico'@'localhost';
-- Permisos a Vistas:
GRANT SELECT ON clinica.view_reporte_citas TO 'medico'@'localhost';
GRANT SELECT ON clinica.view_reporte_salud_paciente TO 'medico'@'localhost';
-- ----------PERMISOS DEL ENCARGADO PROVEEDOR(Usuario 4)-----------
GRANT SELECT, UPDATE ON clinica.productos TO 'proveedor'@'localhost';
GRANT SELECT, UPDATE ON clinica.proveedor TO 'proveedor'@'localhost';
-- Permiso a Vista:
GRANT SELECT ON clinica.view_reporte_inventario TO 'proveedor'@'localhost';

-- -------------PERMISOS DEL AUDITOR(Usuario 5)---------
GRANT SELECT ON clinica.view_reporte_facturas TO 'auditor'@'localhost';
GRANT SELECT ON clinica.view_reporte_inventario TO 'auditor'@'localhost';

FLUSH PRIVILEGES;


SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-13 17:30:00

