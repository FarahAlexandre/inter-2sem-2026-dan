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
  `Nm_Cliente` VARCHAR(45) NOT NULL,
  `EmailCliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cd_Cliente`),
  UNIQUE INDEX `EmailCliente_UNIQUE` (`EmailCliente` ASC) VISIBLE)
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
-- Table `dan`.`dispositivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`dispositivo` (
  `Cd_Dispositivo` INT NOT NULL,
  `Nm_Dispositivo` VARCHAR(45) NOT NULL,
  `Marca_Dispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `Modelo_Dispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `Cd_Comodo` INT NOT NULL,
  PRIMARY KEY (`Cd_Dispositivo`),
  INDEX `Cd_Comodo_idx` (`Cd_Comodo` ASC) VISIBLE,
  CONSTRAINT `fk_dispositivo_comodo`
    FOREIGN KEY (`Cd_Comodo`)
    REFERENCES `dan`.`comodo` (`Cd_Comodo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`protocolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`protocolo` (
  `Cd_Protocolo` INT NOT NULL,
  `Nm_Protocolo` VARCHAR(45) NOT NULL,
  `Desc_Protocolo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`Cd_Protocolo`),
  UNIQUE INDEX `Nm_Protocolo_UNIQUE` (`Nm_Protocolo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dan`.`dispositivo_protocolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`dispositivo_protocolo` (
  `Cd_Dispositivo` INT NOT NULL,
  `Cd_Protocolo` INT NOT NULL,
  PRIMARY KEY (`Cd_Dispositivo`, `Cd_Protocolo`),
  INDEX `Cd_Protocolo_idx` (`Cd_Protocolo` ASC) VISIBLE,
  CONSTRAINT `fk_dispprot_dispositivo`
    FOREIGN KEY (`Cd_Dispositivo`)
    REFERENCES `dan`.`dispositivo` (`Cd_Dispositivo`),
  CONSTRAINT `fk_dispprot_protocolo`
    FOREIGN KEY (`Cd_Protocolo`)
    REFERENCES `dan`.`protocolo` (`Cd_Protocolo`))
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
-- Placeholder table for view `dan`.`valorobra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`valorobra` (`Cd_Obra` INT, `Nm_Obra` INT, `Nm_Cliente` INT, `Dt_InicioO` INT, `Dt_TerminoRf` INT, `Valor_Total_Obra` INT, `Status_Obra` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_comodos_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_comodos_obra` (`Cd_Comodo` INT, `Nm_Comodo` INT, `Cd_Obra` INT, `Nm_Obra` INT, `Nm_Cliente` INT, `Nm_Local` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_endereco_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_endereco_local` (`Cd_Local` INT, `Nm_Local` INT, `CdTLocal` INT, `Tipo_Local` INT, `Logradouro` INT, `Numero` INT, `Nm_Bairro` INT, `Nm_Cidade` INT, `Sigla_Estado` INT, `Nm_Pais` INT, `Endereco_Completo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_obra_detalhada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_obra_detalhada` (`Cd_Obra` INT, `Nm_Obra` INT, `Cd_Cliente` INT, `Nm_Cliente` INT, `EmailCliente` INT, `Cd_Local` INT, `Nm_Local` INT, `CdTLocal` INT, `Tipo_Local` INT, `Endereco_Completo` INT, `Nm_Cidade` INT, `Sigla_Estado` INT, `Dt_InicioO` INT, `Dt_TerminoRf` INT, `Duracao_Dias` INT, `Status_Obra` INT, `Qtd_Plantas` INT, `Valor_Total_Obra` INT, `Qtd_Comodos` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_obras_em_andamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_obras_em_andamento` (`Cd_Obra` INT, `Nm_Obra` INT, `Nm_Cliente` INT, `Endereco_Completo` INT, `Dt_InicioO` INT, `Dt_TerminoRf` INT, `Dias_Restantes` INT, `Situacao_Prazo` INT, `Valor_Total_Obra` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_obras_por_cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_obras_por_cidade` (`Nm_Cidade` INT, `Sigla_Estado` INT, `Qtd_Obras` INT, `Valor_Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_obras_por_tipo_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_obras_por_tipo_local` (`CdTLocal` INT, `Tipo_Local` INT, `Qtd_Obras` INT, `Valor_Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_pedidos_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_pedidos_obra` (`Cd_Pedido` INT, `Dt_Abertura` INT, `Dt_Finalizacao` INT, `Duracao_Dias` INT, `Cd_Obra` INT, `Nm_Obra` INT, `Nm_Cliente` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_plantas_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_plantas_obra` (`Cd_Planta` INT, `Nm_Planta` INT, `Vl_Planta` INT, `Cd_Obra` INT, `Nm_Obra` INT, `Nm_Cliente` INT);

-- -----------------------------------------------------
-- Placeholder table for view `dan`.`vw_resumo_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dan`.`vw_resumo_cliente` (`Cd_Cliente` INT, `Nm_Cliente` INT, `EmailCliente` INT, `Qtd_Obras` INT, `Qtd_Em_Andamento` INT, `Qtd_Concluidas` INT, `Valor_Total_Contratado` INT);

-- -----------------------------------------------------
-- View `dan`.`valorobra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`valorobra`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`valorobra` AS select `o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`o`.`Dt_InicioO` AS `Dt_InicioO`,`o`.`Dt_TerminoRf` AS `Dt_TerminoRf`,coalesce(sum(`p`.`Vl_Planta`),0) AS `Valor_Total_Obra`,(case `o`.`Status_Obraa` when 0 then 'Planejada' when 1 then 'Em andamento' when 2 then 'Concluída' end) AS `Status_Obra` from ((`dan`.`obra` `o` join `dan`.`cliente` `c` on((`c`.`Cd_Cliente` = `o`.`Cd_Cliente`))) left join `dan`.`planta` `p` on((`p`.`Cd_Obra` = `o`.`Cd_Obra`))) group by `o`.`Cd_Obra`,`o`.`Nm_Obra`,`c`.`Nm_Cliente`,`o`.`Dt_InicioO`,`o`.`Dt_TerminoRf`,`o`.`Status_Obraa`;

-- -----------------------------------------------------
-- View `dan`.`vw_comodos_obra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_comodos_obra`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_comodos_obra` AS select `cm`.`Cd_Comodo` AS `Cd_Comodo`,`cm`.`Nm_Comodo` AS `Nm_Comodo`,`o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`l`.`Nm_Local` AS `Nm_Local` from (((`dan`.`comodo` `cm` join `dan`.`obra` `o` on((`o`.`Cd_Obra` = `cm`.`FK_Obra`))) join `dan`.`cliente` `c` on((`c`.`Cd_Cliente` = `o`.`Cd_Cliente`))) join `dan`.`local` `l` on((`l`.`Cd_Local` = `o`.`Cd_Local`)));

-- -----------------------------------------------------
-- View `dan`.`vw_endereco_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_endereco_local`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_endereco_local` AS select `l`.`Cd_Local` AS `Cd_Local`,`l`.`Nm_Local` AS `Nm_Local`,`t`.`CdTLocal` AS `CdTLocal`,`t`.`Nm_TLocal` AS `Tipo_Local`,`lg`.`Desc_Logradouro` AS `Logradouro`,`lg`.`Nm_Logradouro` AS `Numero`,`b`.`Nm_Bairro` AS `Nm_Bairro`,`ci`.`Nm_Cidade` AS `Nm_Cidade`,`es`.`Sigla_Estado` AS `Sigla_Estado`,`pa`.`Nm_Pais` AS `Nm_Pais`,concat(`lg`.`Desc_Logradouro`,', ',`lg`.`Nm_Logradouro`,' - ',`b`.`Nm_Bairro`,', ',`ci`.`Nm_Cidade`,'/',`es`.`Sigla_Estado`) AS `Endereco_Completo` from ((((((`dan`.`local` `l` join `dan`.`tipolocal` `t` on((`t`.`CdTLocal` = `l`.`CdTLocal`))) join `dan`.`logradouro` `lg` on((`lg`.`Cd_Logradouro` = `l`.`Cd_Logradouro`))) left join `dan`.`bairro` `b` on((`b`.`Cd_Bairro` = `lg`.`Cd_Bairro`))) left join `dan`.`cidade` `ci` on((`ci`.`Cd_Cidade` = `b`.`Cd_Cidade`))) left join `dan`.`estado` `es` on((`es`.`Cd_Estado` = `ci`.`Cd_Estado`))) left join `dan`.`pais` `pa` on((`pa`.`Cd_Pais` = `es`.`Cd_Pais`)));

-- -----------------------------------------------------
-- View `dan`.`vw_obra_detalhada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_obra_detalhada`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_obra_detalhada` AS select `o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Cd_Cliente` AS `Cd_Cliente`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`c`.`EmailCliente` AS `EmailCliente`,`dan`.`e`.`Cd_Local` AS `Cd_Local`,`dan`.`e`.`Nm_Local` AS `Nm_Local`,`dan`.`e`.`CdTLocal` AS `CdTLocal`,`dan`.`e`.`Tipo_Local` AS `Tipo_Local`,`dan`.`e`.`Endereco_Completo` AS `Endereco_Completo`,`dan`.`e`.`Nm_Cidade` AS `Nm_Cidade`,`dan`.`e`.`Sigla_Estado` AS `Sigla_Estado`,`o`.`Dt_InicioO` AS `Dt_InicioO`,`o`.`Dt_TerminoRf` AS `Dt_TerminoRf`,(to_days(`o`.`Dt_TerminoRf`) - to_days(`o`.`Dt_InicioO`)) AS `Duracao_Dias`,(case `o`.`Status_Obraa` when 0 then 'Planejada' when 1 then 'Em andamento' when 2 then 'Concluída' end) AS `Status_Obra`,coalesce(`pl`.`Qtd_Plantas`,0) AS `Qtd_Plantas`,coalesce(`pl`.`Valor_Total`,0) AS `Valor_Total_Obra`,coalesce(`cm`.`Qtd_Comodos`,0) AS `Qtd_Comodos` from ((((`dan`.`obra` `o` join `dan`.`cliente` `c` on((`c`.`Cd_Cliente` = `o`.`Cd_Cliente`))) join `dan`.`vw_endereco_local` `e` on((`dan`.`e`.`Cd_Local` = `o`.`Cd_Local`))) left join (select `dan`.`planta`.`Cd_Obra` AS `Cd_Obra`,count(0) AS `Qtd_Plantas`,sum(`dan`.`planta`.`Vl_Planta`) AS `Valor_Total` from `dan`.`planta` group by `dan`.`planta`.`Cd_Obra`) `pl` on((`pl`.`Cd_Obra` = `o`.`Cd_Obra`))) left join (select `dan`.`comodo`.`FK_Obra` AS `FK_Obra`,count(0) AS `Qtd_Comodos` from `dan`.`comodo` group by `dan`.`comodo`.`FK_Obra`) `cm` on((`cm`.`FK_Obra` = `o`.`Cd_Obra`)));

-- -----------------------------------------------------
-- View `dan`.`vw_obras_em_andamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_obras_em_andamento`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_obras_em_andamento` AS select `dan`.`d`.`Cd_Obra` AS `Cd_Obra`,`dan`.`d`.`Nm_Obra` AS `Nm_Obra`,`dan`.`d`.`Nm_Cliente` AS `Nm_Cliente`,`dan`.`d`.`Endereco_Completo` AS `Endereco_Completo`,`dan`.`d`.`Dt_InicioO` AS `Dt_InicioO`,`dan`.`d`.`Dt_TerminoRf` AS `Dt_TerminoRf`,(to_days(`dan`.`d`.`Dt_TerminoRf`) - to_days(curdate())) AS `Dias_Restantes`,(case when (`dan`.`d`.`Dt_TerminoRf` < curdate()) then 'Atrasada' else 'No prazo' end) AS `Situacao_Prazo`,`dan`.`d`.`Valor_Total_Obra` AS `Valor_Total_Obra` from `dan`.`vw_obra_detalhada` `d` where (`dan`.`d`.`Status_Obra` = 'Em andamento');

-- -----------------------------------------------------
-- View `dan`.`vw_obras_por_cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_obras_por_cidade`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_obras_por_cidade` AS select `dan`.`d`.`Nm_Cidade` AS `Nm_Cidade`,`dan`.`d`.`Sigla_Estado` AS `Sigla_Estado`,count(`dan`.`d`.`Cd_Obra`) AS `Qtd_Obras`,sum(`dan`.`d`.`Valor_Total_Obra`) AS `Valor_Total` from `dan`.`vw_obra_detalhada` `d` group by `dan`.`d`.`Nm_Cidade`,`dan`.`d`.`Sigla_Estado`;

-- -----------------------------------------------------
-- View `dan`.`vw_obras_por_tipo_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_obras_por_tipo_local`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_obras_por_tipo_local` AS select `t`.`CdTLocal` AS `CdTLocal`,`t`.`Nm_TLocal` AS `Tipo_Local`,count(`dan`.`d`.`Cd_Obra`) AS `Qtd_Obras`,coalesce(sum(`dan`.`d`.`Valor_Total_Obra`),0) AS `Valor_Total` from (`dan`.`tipolocal` `t` left join `dan`.`vw_obra_detalhada` `d` on((`dan`.`d`.`CdTLocal` = `t`.`CdTLocal`))) group by `t`.`CdTLocal`,`t`.`Nm_TLocal`;

-- -----------------------------------------------------
-- View `dan`.`vw_pedidos_obra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_pedidos_obra`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_pedidos_obra` AS select `pe`.`Cd_Pedido` AS `Cd_Pedido`,`pe`.`Dt_Abertura` AS `Dt_Abertura`,`pe`.`Dt_Finalizacao` AS `Dt_Finalizacao`,(to_days(`pe`.`Dt_Finalizacao`) - to_days(`pe`.`Dt_Abertura`)) AS `Duracao_Dias`,`o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente` from ((`dan`.`pedido` `pe` join `dan`.`obra` `o` on((`o`.`Cd_Obra` = `pe`.`Cd_Obra`))) join `dan`.`cliente` `c` on((`c`.`Cd_Cliente` = `o`.`Cd_Cliente`)));

-- -----------------------------------------------------
-- View `dan`.`vw_plantas_obra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_plantas_obra`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_plantas_obra` AS select `p`.`Cd_Planta` AS `Cd_Planta`,`p`.`Nm_Planta` AS `Nm_Planta`,`p`.`Vl_Planta` AS `Vl_Planta`,`o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente` from ((`dan`.`planta` `p` join `dan`.`obra` `o` on((`o`.`Cd_Obra` = `p`.`Cd_Obra`))) join `dan`.`cliente` `c` on((`c`.`Cd_Cliente` = `o`.`Cd_Cliente`)));

-- -----------------------------------------------------
-- View `dan`.`vw_resumo_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dan`.`vw_resumo_cliente`;
USE `dan`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dan`.`vw_resumo_cliente` AS select `c`.`Cd_Cliente` AS `Cd_Cliente`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`c`.`EmailCliente` AS `EmailCliente`,count(`dan`.`d`.`Cd_Obra`) AS `Qtd_Obras`,sum((case when (`dan`.`d`.`Status_Obra` = 'Em andamento') then 1 else 0 end)) AS `Qtd_Em_Andamento`,sum((case when (`dan`.`d`.`Status_Obra` = 'Concluída') then 1 else 0 end)) AS `Qtd_Concluidas`,coalesce(sum(`dan`.`d`.`Valor_Total_Obra`),0) AS `Valor_Total_Contratado` from (`dan`.`cliente` `c` left join `dan`.`vw_obra_detalhada` `d` on((`dan`.`d`.`Cd_Cliente` = `c`.`Cd_Cliente`))) group by `c`.`Cd_Cliente`,`c`.`Nm_Cliente`,`c`.`EmailCliente`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
