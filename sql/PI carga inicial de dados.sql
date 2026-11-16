-- TODOS os dados fictícios do schema dan (versões mais recentes)
-- Somente INSERTs, na ordem das chaves estrangeiras.
-- Pré-requisito: as tabelas já criadas (obra, planta, cliente, tipolocal,
-- protocolo, dispositivo, dispositivo_protocolo etc.), todas vazias.

USE `dan`;

-- -----------------------------------------------------
-- continente
-- -----------------------------------------------------
INSERT INTO `continente` (`Cd_Continente`, `Nm_Continente`, `Sigla_Continete`) VALUES
(1, 'América do Sul', 'AMS'),
(2, 'América do Norte', 'AMN'),
(3, 'Europa', 'EUR'),
(4, 'Ásia', 'ASI'),
(5, 'África', 'AFR');

-- -----------------------------------------------------
-- pais
-- -----------------------------------------------------
INSERT INTO `pais` (`Nm_Pais`, `Cd_Pais`, `Sigla_Pais`, `Cd_Continente`) VALUES
('Brasil', 1, 'BR', 1),
('Argentina', 2, 'AR', 1),
('Estados Unidos', 3, 'US', 2),
('Portugal', 4, 'PT', 3),
('Japão', 5, 'JP', 4),
('África do Sul', 6, 'ZA', 5);

-- -----------------------------------------------------
-- estado
-- -----------------------------------------------------
INSERT INTO `estado` (`Cd_Estado`, `Nm_Estado`, `Sigla_Estado`, `Cd_Pais`) VALUES
(1, 'São Paulo', 'SP', 1),
(2, 'Rio de Janeiro', 'RJ', 1),
(3, 'Minas Gerais', 'MG', 1),
(4, 'Paraná', 'PR', 1),
(5, 'Buenos Aires', 'BA', 2),
(6, 'Califórnia', 'CA', 3);

-- -----------------------------------------------------
-- cidade
-- -----------------------------------------------------
INSERT INTO `cidade` (`Cd_Cidade`, `Nm_Cidade`, `Sigla_Cidade`, `Cd_Estado`) VALUES
(1, 'São Paulo', 'SPO', 1),
(2, 'Campinas', 'CPS', 1),
(3, 'Rio de Janeiro', 'RIO', 2),
(4, 'Belo Horizonte', 'BHZ', 3),
(5, 'Curitiba', 'CWB', 4),
(6, 'Los Angeles', 'LAX', 6);

-- -----------------------------------------------------
-- bairro
-- -----------------------------------------------------
INSERT INTO `bairro` (`Cd_Bairro`, `Nm_Bairro`, `Cd_Cidade`) VALUES
(1, 'Vila Mariana', 1),
(2, 'Pinheiros', 1),
(3, 'Cambuí', 2),
(4, 'Copacabana', 3),
(5, 'Savassi', 4),
(6, 'Batel', 5);

-- -----------------------------------------------------
-- cliente
-- -----------------------------------------------------
INSERT INTO `cliente` (`Cd_Cliente`, `Doc_Cliente`, `Nm_Cliente`, `EmailCliente`) VALUES
(1, '123.456.789-09', 'Marina Albuquerque Souza', 'marina.souza@exemplo.com'),
(2, '987.654.321-00', 'Carlos Eduardo Mendonça', 'carlos.mendonca@exemplo.com'),
(3, '111.222.333-96', 'Fernanda Ribeiro Lima', 'fernanda.lima@exemplo.com'),
(4, '444.555.666-81', 'Ricardo Tavares Nogueira', 'ricardo.nogueira@exemplo.com'),
(5, '777.888.999-35', 'Juliana Prado Cavalcante', 'juliana.cavalcante@exemplo.com');

-- -----------------------------------------------------
-- logradouro  (Nm_Logradouro é INT: usado como número do endereço)
-- -----------------------------------------------------
INSERT INTO `logradouro` (`Cd_Logradouro`, `Desc_Logradouro`, `Nm_Logradouro`, `Cd_Bairro`) VALUES
(1, 'Rua Domingos de Morais', 1200, 1),
(2, 'Avenida Faria Lima', 3500, 2),
(3, 'Rua Coronel Quirino', 450, 3),
(4, 'Avenida Atlântica', 2000, 4),
(5, 'Rua Pernambuco', 780, 5),
(6, 'Avenida do Batel', 1500, 6);

-- -----------------------------------------------------
-- tipolocal
-- -----------------------------------------------------
INSERT INTO `tipolocal` (`CdTLocal`, `Nm_TLocal`, `Desc_TLocal`) VALUES
(1, 'Apartamento', 'Unidade residencial em edifício'),
(2, 'Comercial', 'Sala, loja ou espaço de uso comercial'),
(3, 'Casa', 'Residência unifamiliar térrea ou sobrado'),
(4, 'Cobertura', 'Unidade no último pavimento do edifício'),
(5, 'Galpão', 'Espaço amplo de uso industrial ou de armazenagem');

-- -----------------------------------------------------
-- local
-- -----------------------------------------------------
INSERT INTO `local` (`Cd_Local`, `Nm_Local`, `CdTLocal`, `Cd_Logradouro`) VALUES
(1, 'Apartamento 101 - Edifício Aurora', 1, 1),
(2, 'Sala Comercial 22 - Torre Faria Lima', 2, 2),
(3, 'Casa Residencial Cambuí', 3, 3),
(4, 'Cobertura Edifício Mar Azul', 4, 4),
(5, 'Loja Térrea Savassi', 2, 5),
(6, 'Apartamento 803 - Edifício Batel Prime', 1, 6);

-- -----------------------------------------------------
-- obra
-- Status_Obraa: 0 = Planejada, 1 = Em andamento, 2 = Concluída
-- VlCusto_Servico = soma dos Vl_Planta das plantas da obra
-- -----------------------------------------------------
INSERT INTO `obra` (`Cd_Obra`, `Cd_Cliente`, `Dt_InicioO`, `Dt_TerminoRf`, `VlCusto_Servico`, `Status_Obraa`, `Cd_Local`, `Nm_Obra`) VALUES
(1, 1, '2026-01-10', '2026-04-10', 45000, 2, 1, 'Reforma Apartamento Aurora'),
(2, 2, '2026-02-01', '2026-06-30', 120000, 2, 2, 'Retrofit Sala Comercial Faria Lima'),
(3, 3, '2026-05-15', '2026-11-15', 85000, 1, 3, 'Reforma Casa Cambuí'),
(4, 4, '2026-08-01', '2026-12-20', 230000, 1, 4, 'Reforma Cobertura Mar Azul'),
(5, 5, '2026-11-01', '2027-02-28', 60000, 0, 5, 'Adequação Loja Savassi');

-- -----------------------------------------------------
-- comodo
-- -----------------------------------------------------
INSERT INTO `comodo` (`Cd_Comodo`, `Nm_Comodo`, `FK_Obra`) VALUES
(1, 'Sala de Estar', 1),
(2, 'Cozinha', 1),
(3, 'Escritório', 2),
(4, 'Banheiro Social', 3),
(5, 'Quarto Principal', 3),
(6, 'Varanda Gourmet', 4),
(7, 'Área de Serviço', 4),
(8, 'Recepção', 5);

-- -----------------------------------------------------
-- pedido
-- -----------------------------------------------------
INSERT INTO `pedido` (`Cd_Pedido`, `Dt_Abertura`, `Dt_Finalizacao`, `Cd_Obra`) VALUES
(1, '2026-01-05', '2026-01-09', 1),
(2, '2026-01-20', '2026-01-28', 2),
(3, '2026-05-10', '2026-05-14', 3),
(4, '2026-07-25', '2026-07-31', 4),
(5, '2026-10-20', '2026-10-30', 5);

-- -----------------------------------------------------
-- planta  (Vl_Planta é DECIMAL(10,0): valores inteiros)
-- -----------------------------------------------------
INSERT INTO `planta` (`Cd_Planta`, `Cd_Obra`, `Nm_Planta`, `Vl_Planta`) VALUES
(1, 1, 'Planta Baixa - Apartamento 101', 18000),
(2, 1, 'Planta de Layout - Apartamento 101', 27000),
(3, 2, 'Planta Baixa - Sala Comercial 22', 120000),
(4, 3, 'Planta Baixa - Casa Cambuí', 55000),
(5, 3, 'Planta Hidráulica - Casa Cambuí', 30000),
(6, 4, 'Planta Baixa - Cobertura Mar Azul', 230000),
(7, 5, 'Planta de Layout - Loja Savassi', 60000);

-- -----------------------------------------------------
-- protocolo
-- -----------------------------------------------------
INSERT INTO `protocolo` (`Cd_Protocolo`, `Nm_Protocolo`, `Desc_Protocolo`) VALUES
(1, 'Wi-Fi', 'Rede sem fio (configuração e controle por aplicativo)'),
(2, 'Bluetooth', 'Comunicação sem fio de curto alcance (usada em setup via app)'),
(3, 'Z-Wave', 'Rede mesh sem fio para automação (Z-Wave Plus / chip 800)'),
(4, 'Zigbee', 'Rede mesh sem fio de baixo consumo'),
(5, 'Ethernet', 'Rede cabeada IP (TCP/IP, UDP, MQTT)'),
(6, 'RS-485', 'Barramento serial cabeado (Modbus RTU)'),
(7, 'RF433', 'Radiofrequência 433 MHz para motores e acessórios'),
(8, 'IR', 'Infravermelho (controle de ar condicionado e equipamentos)'),
(9, 'DALI', 'Protocolo digital de controle de iluminação'),
(10, 'LoRaWAN', 'Rádio de longo alcance 915 MHz');

-- -----------------------------------------------------
-- dispositivo  (dispositivos de automação Flex Automation)
-- -----------------------------------------------------
INSERT INTO `dispositivo` (`Cd_Dispositivo`, `Nm_Dispositivo`, `Marca_Dispositivo`, `Modelo_Dispositivo`, `Cd_Comodo`) VALUES
(1, 'Termostato FC Smart Knob Rotativo', 'Flex Automation', 'FX-FC2-SK', 5),
(2, 'Termostato FC Z-Wave', 'Flex Automation', 'FX-FC5-220', 1),
(3, 'Blaster de IR para Ar Condicionado Split', 'Flex Automation', 'FX-T2900', 3),
(4, 'Processadora Multi I/O DINBOX Plus', 'Flex Automation', 'DBX-Mio1012Plus', 7),
(5, 'Controladora de Leds Digitais RGB', 'Flex Automation', 'DLD-201-WRS', 6),
(6, 'Dali Application Controller', 'Flex Automation', 'DAL-202-RS1', 1),
(7, 'IRF Flexbox Bridge (IR + RF + IP)', 'Flex Automation', 'IRF-302-400', 8),
(8, 'AirCon IR Dongle + IP', 'Flex Automation', 'FX-Air1', 5),
(9, 'Micro Módulo Z-Wave Dimmer', 'Flex Automation', 'FX-D211', 8),
(10, 'Micro Módulo Z-Wave Combo ON/OFF', 'Flex Automation', 'FX-C222', 2),
(11, 'Medidor Trifásico Direct CutOFF 3x80A', 'Flex Automation', 'FXS-126-3D80-RS/Z', 7),
(12, 'Modbus LoraWAN Bridge', 'Flex Automation', 'DRF-201-LRW', 7);

-- -----------------------------------------------------
-- dispositivo_protocolo
-- -----------------------------------------------------
INSERT INTO `dispositivo_protocolo` (`Cd_Dispositivo`, `Cd_Protocolo`) VALUES
(1, 6),
(2, 3),
(3, 3), (3, 2), (3, 1), (3, 8),
(4, 5), (4, 6), (4, 8),
(5, 1), (5, 6),
(6, 9),
(7, 5), (7, 1), (7, 7), (7, 8), (7, 6),
(8, 5), (8, 1), (8, 8),
(9, 3),
(10, 3),
(11, 6), (11, 4),
(12, 10), (12, 1), (12, 6);