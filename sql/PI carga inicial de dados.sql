-- -----------------------------------------------------
INSERT INTO `Continente` (`Cd_Continente`, `Nm_Continente`, `Sigla_Continete`) VALUES
(1, 'América do Sul', 'AMS'),
(2, 'América do Norte', 'AMN'),
(3, 'Europa', 'EUR'),
(4, 'Ásia', 'ASI'),
(5, 'África', 'AFR');
 
-- -----------------------------------------------------
-- Pais
-- -----------------------------------------------------
INSERT INTO `Pais` (`Nm_Pais`, `Cd_Pais`, `Sigla_Pais`, `Cd_Continente`) VALUES
('Brasil', 1, 'BR', 1),
('Argentina', 2, 'AR', 1),
('Estados Unidos', 3, 'US', 2),
('Portugal', 4, 'PT', 3),
('Japão', 5, 'JP', 4),
('África do Sul', 6, 'ZA', 5);
 
-- -----------------------------------------------------
-- Estado
-- -----------------------------------------------------
INSERT INTO `Estado` (`Cd_Estado`, `Nm_Estado`, `Sigla_Estado`, `Cd_Pais`) VALUES
(1, 'São Paulo', 'SP', 1),
(2, 'Rio de Janeiro', 'RJ', 1),
(3, 'Minas Gerais', 'MG', 1),
(4, 'Paraná', 'PR', 1),
(5, 'Buenos Aires', 'BA', 2),
(6, 'Califórnia', 'CA', 3);
 
-- -----------------------------------------------------
-- Cidade
-- -----------------------------------------------------
INSERT INTO `Cidade` (`Cd_Cidade`, `Nm_Cidade`, `Sigla_Cidade`, `Cd_Estado`) VALUES
(1, 'São Paulo', 'SPO', 1),
(2, 'Campinas', 'CPS', 1),
(3, 'Rio de Janeiro', 'RIO', 2),
(4, 'Belo Horizonte', 'BHZ', 3),
(5, 'Curitiba', 'CWB', 4),
(6, 'Los Angeles', 'LAX', 6);
 
-- -----------------------------------------------------
-- Bairro
-- -----------------------------------------------------
INSERT INTO `Bairro` (`Cd_Bairro`, `Nm_Bairro`, `Cd_Cidade`) VALUES
(1, 'Vila Mariana', 1),
(2, 'Pinheiros', 1),
(3, 'Cambuí', 2),
(4, 'Copacabana', 3),
(5, 'Savassi', 4),
(6, 'Batel', 5);
 
-- -----------------------------------------------------
-- Logradouro  (Nm_Logradouro é INT: usado como número do endereço)
-- -----------------------------------------------------
INSERT INTO `Logradouro` (`Cd_Logradouro`, `Desc_Logradouro`, `Nm_Logradouro`, `Cd_Bairro`) VALUES
(1, 'Rua Domingos de Morais', 1200, 1),
(2, 'Avenida Faria Lima', 3500, 2),
(3, 'Rua Coronel Quirino', 450, 3),
(4, 'Avenida Atlântica', 2000, 4),
(5, 'Rua Pernambuco', 780, 5),
(6, 'Avenida do Batel', 1500, 6);
 
-- -----------------------------------------------------
-- Local  (CdTLocal: 1 = Apartamento, 2 = Comercial, 3 = Casa)
-- -----------------------------------------------------
INSERT INTO `Local` (`Cd_Local`, `Nm_Local`, `CdTLocal`, `Cd_Logradouro`) VALUES
(1, 'Apartamento 101 - Edifício Aurora', 1, 1),
(2, 'Sala Comercial 22 - Torre Faria Lima', 2, 2),
(3, 'Casa Residencial Cambuí', 3, 3),
(4, 'Cobertura Edifício Mar Azul', 1, 4),
(5, 'Loja Térrea Savassi', 2, 5),
(6, 'Apartamento 803 - Edifício Batel Prime', 1, 6);
 
-- -----------------------------------------------------
-- Cliente
-- -----------------------------------------------------
INSERT INTO `Cliente` (`Cd_Cliente`, `Nm_Cliente`, `Doc_Cliente`, `DocI_Cliente`, `DocDFN_Cliente`) VALUES
(1, 'Marina Albuquerque Souza', '123.456.789-09', '12.345.678-9', '2018-05-10'),
(2, 'Carlos Eduardo Mendonça', '987.654.321-00', '98.765.432-1', '2019-11-22'),
(3, 'Fernanda Ribeiro Lima', '111.222.333-96', '11.222.333-4', '2020-02-15'),
(4, 'Ricardo Tavares Nogueira', '444.555.666-81', '44.555.666-7', '2021-07-03'),
(5, 'Juliana Prado Cavalcante', '777.888.999-35', '77.888.999-0', '2022-09-30');
 
-- -----------------------------------------------------
-- Obra  (agora com Nm_Obra)
-- Status_Obraa: 0 = Planejada, 1 = Em andamento, 2 = Concluída
-- VlCusto_Servico = soma dos Vl_Planta das planta da obra
-- -----------------------------------------------------
INSERT INTO `Obra` (`Cd_Obra`, `Nm_Obra`, `Cd_Cliente`, `Dt_InicioO`, `Dt_TerminoRf`, `VlCusto_Servico`, `Status_Obraa`, `Cd_Local`) VALUES
(1, 'Reforma Apartamento Aurora', 1, '2026-01-10', '2026-04-10', 45000.00, 2, 1),
(2, 'Retrofit Sala Comercial Faria Lima', 2, '2026-02-01', '2026-06-30', 120000.50, 2, 2),
(3, 'Reforma Casa Cambuí', 3, '2026-05-15', '2026-11-15', 85000.75, 1, 3),
(4, 'Reforma Cobertura Mar Azul', 4, '2026-08-01', '2026-12-20', 230000.00, 1, 4),
(5, 'Adequação Loja Savassi', 5, '2026-11-01', '2027-02-28', 60000.00, 0, 5);
 
-- -----------------------------------------------------
-- planta  (agora com Vl_Planta)
-- Obra 1: 18000.00 + 27000.00           = 45000.00
-- Obra 2: 120000.50                     = 120000.50
-- Obra 3: 55000.75 + 30000.00           = 85000.75
-- Obra 4: 230000.00                     = 230000.00
-- Obra 5: 60000.00                      = 60000.00
-- -----------------------------------------------------
INSERT INTO `Planta` (`Cd_planta`, `Cd_Obra`, `Nm_Planta`, `Vl_Planta`) VALUES
(1, 1, 'Planta Baixa - Apartamento 101', 18000.00),
(2, 1, 'Planta de Layout - Apartamento 101', 27000.00),
(3, 2, 'Planta Baixa - Sala Comercial 22', 120000.50),
(4, 3, 'Planta Baixa - Casa Cambuí', 55000.75),
(5, 3, 'Planta Hidráulica - Casa Cambuí', 30000.00),
(6, 4, 'Planta Baixa - Cobertura Mar Azul', 230000.00),
(7, 5, 'Planta de Layout - Loja Savassi', 60000.00);
 
-- -----------------------------------------------------
-- Pedido
-- -----------------------------------------------------
INSERT INTO `Pedido` (`Cd_Pedido`, `Dt_Abertura`, `Dt_Finalizacao`, `Cd_Obra`) VALUES
(1, '2026-01-05', '2026-01-09', 1),
(2, '2026-01-20', '2026-01-28', 2),
(3, '2026-05-10', '2026-05-14', 3),
(4, '2026-07-25', '2026-07-31', 4),
(5, '2026-10-20', '2026-10-30', 5);
 
-- -----------------------------------------------------
-- Comodo
-- -----------------------------------------------------
INSERT INTO `Comodo` (`Cd_Comodo`, `Nm_Comodo`, `FK_Obra`) VALUES
(1, 'Sala de Estar', 1),
(2, 'Cozinha', 1),
(3, 'Escritório', 2),
(4, 'Banheiro Social', 3),
(5, 'Quarto Principal', 3),
(6, 'Varanda Gourmet', 4),
(7, 'Área de Serviço', 4),
(8, 'Recepção', 5);

-- ------------------------------------------------------
-- Tipo Local
-- ------------------------------------------------------
INSERT INTO `TipoLocal` (`CdTLocal`, `Nm_TLocal`, `Desc_TLocal`) VALUES
(1, 'Apartamento', 'Unidade residencial em edifício'),
(2, 'Comercial', 'Sala, loja ou espaço de uso comercial'),
(3, 'Casa', 'Residência unifamiliar térrea ou sobrado'),
(4, 'Cobertura', 'Unidade no último pavimento do edifício'),
(5, 'Galpão', 'Espaço amplo de uso industrial ou de armazenagem');