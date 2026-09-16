

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Continente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Continente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Continente` (
  `Cd_Continente` INT NOT NULL,
  `Nm_Continente` VARCHAR(45) NULL,
  `Sigla_Continete` VARCHAR(45) NULL,
  PRIMARY KEY (`Cd_Continente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pais` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pais` (
  `Nm_Pais` VARCHAR(45) NOT NULL,
  `Cd_Pais` INT NOT NULL,
  `Sigla_Pais` VARCHAR(45) NULL,
  `Cd_Continente` INT NOT NULL,
  PRIMARY KEY (`Cd_Pais`),
  INDEX `Cd_Continente_idx` (`Cd_Continente` ASC) VISIBLE,
  CONSTRAINT `Cd_Continente`
    FOREIGN KEY (`Cd_Continente`)
    REFERENCES `mydb`.`Continente` (`Cd_Continente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `Cd_Estado` INT NOT NULL,
  `Nm_Estado` VARCHAR(45) NOT NULL,
  `Sigla_Estado` VARCHAR(3) NOT NULL,
  `Cd_Pais` INT NOT NULL,
  INDEX `Cd_Pais_idx` (`Cd_Pais` ASC) VISIBLE,
  PRIMARY KEY (`Cd_Estado`),
  CONSTRAINT `Cd_Pais`
    FOREIGN KEY (`Cd_Pais`)
    REFERENCES `mydb`.`Pais` (`Cd_Pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cidade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cidade` (
  `Cd_Cidade` INT NOT NULL,
  `Nm_Cidade` VARCHAR(45) NOT NULL,
  `Sigla_Cidade` VARCHAR(45) NOT NULL,
  `Cd_Estado` INT NOT NULL,
  PRIMARY KEY (`Cd_Cidade`),
  UNIQUE INDEX `Cd_Cidade_UNIQUE` (`Cd_Cidade` ASC) VISIBLE,
  INDEX `Cd_Estado_idx` (`Cd_Estado` ASC) VISIBLE,
  CONSTRAINT `Cd_Estado`
    FOREIGN KEY (`Cd_Estado`)
    REFERENCES `mydb`.`Estado` (`Cd_Estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `Cd_Cliente` INT NOT NULL,
  `Doc_Cliente` VARCHAR(45) NOT NULL,
  `DocI_Cliente` VARCHAR(45) NOT NULL,
  `DocDFN_Cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cd_Cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bairro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Bairro` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Bairro` (
  `Cd_Bairro` INT NOT NULL,
  `Nm_Bairro` VARCHAR(45) NULL,
  `Cd_Cidade` INT NULL,
  PRIMARY KEY (`Cd_Bairro`),
  INDEX `Cd_Cidade_idx` (`Cd_Cidade` ASC) VISIBLE,
  CONSTRAINT `Cd_Cidade`
    FOREIGN KEY (`Cd_Cidade`)
    REFERENCES `mydb`.`Cidade` (`Cd_Cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Logradouro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Logradouro` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Logradouro` (
  `Cd_Logradouro` INT NOT NULL,
  `Desc_Logradouro` VARCHAR(45) NOT NULL,
  `Nm_Logradouro` INT NOT NULL,
  `Cd_Bairro` INT NULL,
  PRIMARY KEY (`Cd_Logradouro`),
  INDEX `Cd_Bairro_idx` (`Cd_Bairro` ASC) VISIBLE,
  CONSTRAINT `Cd_Bairro`
    FOREIGN KEY (`Cd_Bairro`)
    REFERENCES `mydb`.`Bairro` (`Cd_Bairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Local` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Local` (
  `Cd_Local` INT NOT NULL,
  `Nm_Local` VARCHAR(45) NOT NULL,
  `CdTLocal` INT NOT NULL,
  `Cd_Logradouro` INT NOT NULL,
  PRIMARY KEY (`Cd_Local`),
  INDEX `Cd_Logradouro_idx` (`Cd_Logradouro` ASC) VISIBLE,
  CONSTRAINT `Cd_Logradouro`
    FOREIGN KEY (`Cd_Logradouro`)
    REFERENCES `mydb`.`Logradouro` (`Cd_Logradouro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reforma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Reforma` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Reforma` (
  `Cd_Reforma` INT NOT NULL,
  `Cd_Cliente` INT NOT NULL,
  `Dt_InicioRf` DATE NOT NULL,
  `Dt_TerminoRf` DATE NOT NULL,
  `VlCusto_Servico` FLOAT NOT NULL,
  `Status_Reforma` TINYINT NOT NULL,
  `Cd_Local` INT NOT NULL,
  `Reformacol` VARCHAR(45) NULL,
  PRIMARY KEY (`Cd_Reforma`),
  INDEX `Cd_Cliente_idx` (`Cd_Cliente` ASC) VISIBLE,
  INDEX `Cd_Local_idx` (`Cd_Local` ASC) VISIBLE,
  CONSTRAINT `Cd_Cliente`
    FOREIGN KEY (`Cd_Cliente`)
    REFERENCES `mydb`.`Cliente` (`Cd_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cd_Local`
    FOREIGN KEY (`Cd_Local`)
    REFERENCES `mydb`.`Local` (`Cd_Local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plantas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Plantas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Plantas` (
  `Cd_Plantas` INT NOT NULL,
  `Cd_Cliente` INT NOT NULL,
  `Cd_Reforma` INT NOT NULL,
  PRIMARY KEY (`Cd_Plantas`, `Cd_Cliente`),
  INDEX `Cd_Cliente_idx` (`Cd_Cliente` ASC) VISIBLE,
  INDEX `Cd_Reforma_idx` (`Cd_Reforma` ASC) VISIBLE,
  CONSTRAINT `Cd_Cliente`
    FOREIGN KEY (`Cd_Cliente`)
    REFERENCES `mydb`.`Cliente` (`Cd_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cd_Reforma`
    FOREIGN KEY (`Cd_Reforma`)
    REFERENCES `mydb`.`Reforma` (`Cd_Reforma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
