-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dan
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dan
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dan` DEFAULT CHARACTER SET utf8mb3 ;
USE `dan` ;

-- -----------------------------------------------------
-- Table `dan`.`continente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`continente` (
  `Cd_Continente` INT NOT NULL,
  `Nm_Continente` VARCHAR(45) NULL DEFAULT NULL,
  `Sigla_Continete` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Cd_Continente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`pais` (
  `Nm_Pais` VARCHAR(45) NOT NULL,
  `Cd_Pais` INT NOT NULL,
  `Sigla_Pais` VARCHAR(45) NULL DEFAULT NULL,
  `Cd_Continente` INT NOT NULL,
  PRIMARY KEY (`Cd_Pais`),
  INDEX `Cd_Continente_idx` (`Cd_Continente` ASC) VISIBLE,
  CONSTRAINT `Cd_Continente`
    FOREIGN KEY (`Cd_Continente`)
    REFERENCES `dan`.`continente` (`Cd_Continente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`estado` (
  `Cd_Estado` INT NOT NULL,
  `Nm_Estado` VARCHAR(45) NOT NULL,
  `Sigla_Estado` VARCHAR(3) NOT NULL,
  `Cd_Pais` INT NOT NULL,
  PRIMARY KEY (`Cd_Estado`),
  INDEX `Cd_Pais_idx` (`Cd_Pais` ASC) VISIBLE,
  CONSTRAINT `Cd_Pais`
    FOREIGN KEY (`Cd_Pais`)
    REFERENCES `dan`.`pais` (`Cd_Pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`cidade` (
  `Cd_Cidade` INT NOT NULL,
  `Nm_Cidade` VARCHAR(45) NOT NULL,
  `Sigla_Cidade` VARCHAR(45) NOT NULL,
  `Cd_Estado` INT NOT NULL,
  PRIMARY KEY (`Cd_Cidade`),
  UNIQUE INDEX `Cd_Cidade_UNIQUE` (`Cd_Cidade` ASC) VISIBLE,
  INDEX `Cd_Estado_idx` (`Cd_Estado` ASC) VISIBLE,
  CONSTRAINT `Cd_Estado`
    FOREIGN KEY (`Cd_Estado`)
    REFERENCES `dan`.`estado` (`Cd_Estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`bairro` (
  `Cd_Bairro` INT NOT NULL,
  `Nm_Bairro` VARCHAR(45) NULL DEFAULT NULL,
  `Cd_Cidade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Cd_Bairro`),
  INDEX `Cd_Cidade_idx` (`Cd_Cidade` ASC) VISIBLE,
  CONSTRAINT `Cd_Cidade`
    FOREIGN KEY (`Cd_Cidade`)
    REFERENCES `dan`.`cidade` (`Cd_Cidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`cliente` (
  `Cd_Cliente` INT NOT NULL,
  `Doc_Cliente` VARCHAR(45) NOT NULL,
  `DocI_Cliente` VARCHAR(45) NOT NULL,
  `DocDFN_Cliente` VARCHAR(45) NOT NULL,
  `Nm_Cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cd_Cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`logradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`logradouro` (
  `Cd_Logradouro` INT NOT NULL,
  `Desc_Logradouro` VARCHAR(45) NOT NULL,
  `Nm_Logradouro` INT NOT NULL,
  `Cd_Bairro` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Cd_Logradouro`),
  INDEX `Cd_Bairro_idx` (`Cd_Bairro` ASC) VISIBLE,
  CONSTRAINT `Cd_Bairro`
    FOREIGN KEY (`Cd_Bairro`)
    REFERENCES `dan`.`bairro` (`Cd_Bairro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`tipolocal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`tipolocal` (
  `CdTLocal` INT NOT NULL,
  `Nm_TLocal` VARCHAR(45) NOT NULL,
  `Desc_TLocal` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`CdTLocal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`local` (
  `Cd_Local` INT NOT NULL,
  `Nm_Local` VARCHAR(45) NOT NULL,
  `CdTLocal` INT NOT NULL,
  `Cd_Logradouro` INT NOT NULL,
  PRIMARY KEY (`Cd_Local`),
  INDEX `Cd_Logradouro_idx` (`Cd_Logradouro` ASC) VISIBLE,
  INDEX `CdTLocal_idx` (`CdTLocal` ASC) VISIBLE,
  CONSTRAINT `Cd_Logradouro`
    FOREIGN KEY (`Cd_Logradouro`)
    REFERENCES `dan`.`logradouro` (`Cd_Logradouro`),
  CONSTRAINT `fk_Local_TipoLocal`
    FOREIGN KEY (`CdTLocal`)
    REFERENCES `dan`.`tipolocal` (`CdTLocal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`obra` (
  `Cd_Obra` INT NOT NULL,
  `Cd_Cliente` INT NOT NULL,
  `Dt_InicioO` DATE NOT NULL,
  `Dt_TerminoRf` DATE NOT NULL,
  `VlCusto_Servico` FLOAT NOT NULL,
  `Status_Obraa` TINYINT NOT NULL,
  `Cd_Local` INT NOT NULL,
  `Nm_Obra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cd_Obra`),
  INDEX `Cd_Cliente_idx` (`Cd_Cliente` ASC) VISIBLE,
  INDEX `Cd_Local_idx` (`Cd_Local` ASC) VISIBLE,
  CONSTRAINT `Cd_Cliente`
    FOREIGN KEY (`Cd_Cliente`)
    REFERENCES `dan`.`cliente` (`Cd_Cliente`),
  CONSTRAINT `Cd_Local`
    FOREIGN KEY (`Cd_Local`)
    REFERENCES `dan`.`local` (`Cd_Local`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`comodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`comodo` (
  `Cd_Comodo` INT NOT NULL,
  `Nm_Comodo` VARCHAR(45) NOT NULL,
  `FK_Obra` INT NOT NULL,
  PRIMARY KEY (`Cd_Comodo`),
  INDEX `Cd_Imovel_idx` (`FK_Obra` ASC) VISIBLE,
  CONSTRAINT `FK_Obra`
    FOREIGN KEY (`FK_Obra`)
    REFERENCES `dan`.`obra` (`Cd_Obra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`pedido` (
  `Cd_Pedido` INT NOT NULL,
  `Dt_Abertura` DATE NOT NULL,
  `Dt_Finalizacao` DATE NOT NULL,
  `Cd_Obra` INT NOT NULL,
  PRIMARY KEY (`Cd_Pedido`),
  INDEX `Cd_Obra_idx` (`Cd_Obra` ASC) VISIBLE,
  CONSTRAINT `Cd_Obra`
    FOREIGN KEY (`Cd_Obra`)
    REFERENCES `dan`.`obra` (`Cd_Obra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`planta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`planta` (
  `Cd_Planta` INT NOT NULL,
  `Cd_Obra` INT NOT NULL,
  `Nm_Planta` VARCHAR(45) NOT NULL,
  `Vl_Planta` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`Cd_Planta`),
  INDEX `Cd_Reforma_idx` (`Cd_Obra` ASC) VISIBLE,
  CONSTRAINT `Cd_Reforma`
    FOREIGN KEY (`Cd_Obra`)
    REFERENCES `dan`.`obra` (`Cd_Obra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `dan` ;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`valorobra` (`id` INT);

-- -----------------------------------------------------
-- View `dan`.`valorobra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`valorobra`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ERRADO`.`valorobra` AS select `o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`o`.`Dt_InicioO` AS `Dt_InicioO`,`o`.`Dt_TerminoRf` AS `Dt_TerminoRf`,`o`.`VlCusto_Servico` AS `Valor_Total_Obra`,(case when (`o`.`Status_Obraa` = 0) then 'Planejada' when (`o`.`Status_Obraa` = 1) then 'Em andamento' when (`o`.`Status_Obraa` = 2) then 'Concluída' end) AS `Status_Obra` from (ERRADOn`.`obra` `o` join ERRADOn`.`cliente` `c` on((`o`.`Cd_Cliente` = `c`.`Cd_Cliente`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
