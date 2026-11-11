-- Views úteis para o schema dan
-- Execute depois de criar as tabelas e inserir os dados.
-- A ordem importa: algumas views usam outras (vw_endereco_local -> vw_obra_detalhada -> demais).
-- Status_Obraa: 0 = Planejada, 1 = Em andamento, 2 = Concluída

USE `dan`;

-- =====================================================
-- 1) valorobra (versão corrigida): resumo da obra com valor = soma das plantas
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`valorobra` AS
SELECT o.Cd_Obra,
       o.Nm_Obra,
       c.Nm_Cliente,
       o.Dt_InicioO,
       o.Dt_TerminoRf,
       COALESCE(SUM(p.Vl_Planta), 0) AS Valor_Total_Obra,
       CASE o.Status_Obraa
            WHEN 0 THEN 'Planejada'
            WHEN 1 THEN 'Em andamento'
            WHEN 2 THEN 'Concluída'
       END AS Status_Obra
FROM obra o
INNER JOIN cliente c ON c.Cd_Cliente = o.Cd_Cliente
LEFT JOIN planta p ON p.Cd_Obra = o.Cd_Obra
GROUP BY o.Cd_Obra, o.Nm_Obra, c.Nm_Cliente, o.Dt_InicioO, o.Dt_TerminoRf, o.Status_Obraa;

-- =====================================================
-- 2) vw_endereco_local: cada local com tipo e endereço completo
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_endereco_local` AS
SELECT l.Cd_Local,
       l.Nm_Local,
       t.CdTLocal,
       t.Nm_TLocal AS Tipo_Local,
       lg.Desc_Logradouro AS Logradouro,
       lg.Nm_Logradouro AS Numero,
       b.Nm_Bairro,
       ci.Nm_Cidade,
       es.Sigla_Estado,
       pa.Nm_Pais,
       CONCAT(lg.Desc_Logradouro, ', ', lg.Nm_Logradouro, ' - ',
              b.Nm_Bairro, ', ', ci.Nm_Cidade, '/', es.Sigla_Estado) AS Endereco_Completo
FROM `local` l
INNER JOIN tipolocal t ON t.CdTLocal = l.CdTLocal
INNER JOIN logradouro lg ON lg.Cd_Logradouro = l.Cd_Logradouro
LEFT JOIN bairro b ON b.Cd_Bairro = lg.Cd_Bairro
LEFT JOIN cidade ci ON ci.Cd_Cidade = b.Cd_Cidade
LEFT JOIN estado es ON es.Cd_Estado = ci.Cd_Estado
LEFT JOIN pais pa ON pa.Cd_Pais = es.Cd_Pais;

-- =====================================================
-- 3) vw_obra_detalhada: visão completa da obra
--    (cliente, local, endereço, prazo, valor total, qtd de plantas e cômodos)
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_obra_detalhada` AS
SELECT o.Cd_Obra,
       o.Nm_Obra,
       c.Cd_Cliente,
       c.Nm_Cliente,
       c.EmailCliente,
       e.Cd_Local,
       e.Nm_Local,
       e.CdTLocal,
       e.Tipo_Local,
       e.Endereco_Completo,
       e.Nm_Cidade,
       e.Sigla_Estado,
       o.Dt_InicioO,
       o.Dt_TerminoRf,
       DATEDIFF(o.Dt_TerminoRf, o.Dt_InicioO) AS Duracao_Dias,
       CASE o.Status_Obraa
            WHEN 0 THEN 'Planejada'
            WHEN 1 THEN 'Em andamento'
            WHEN 2 THEN 'Concluída'
       END AS Status_Obra,
       COALESCE(pl.Qtd_Plantas, 0) AS Qtd_Plantas,
       COALESCE(pl.Valor_Total, 0) AS Valor_Total_Obra,
       COALESCE(cm.Qtd_Comodos, 0) AS Qtd_Comodos
FROM obra o
INNER JOIN cliente c ON c.Cd_Cliente = o.Cd_Cliente
INNER JOIN vw_endereco_local e ON e.Cd_Local = o.Cd_Local
LEFT JOIN (SELECT Cd_Obra, COUNT(*) AS Qtd_Plantas, SUM(Vl_Planta) AS Valor_Total
           FROM planta
           GROUP BY Cd_Obra) pl ON pl.Cd_Obra = o.Cd_Obra
LEFT JOIN (SELECT FK_Obra, COUNT(*) AS Qtd_Comodos
           FROM comodo
           GROUP BY FK_Obra) cm ON cm.FK_Obra = o.Cd_Obra;

-- =====================================================
-- 4) vw_resumo_cliente: quantas obras e quanto cada cliente tem
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_resumo_cliente` AS
SELECT c.Cd_Cliente,
       c.Nm_Cliente,
       c.EmailCliente,
       COUNT(d.Cd_Obra) AS Qtd_Obras,
       SUM(CASE WHEN d.Status_Obra = 'Em andamento' THEN 1 ELSE 0 END) AS Qtd_Em_Andamento,
       SUM(CASE WHEN d.Status_Obra = 'Concluída' THEN 1 ELSE 0 END) AS Qtd_Concluidas,
       COALESCE(SUM(d.Valor_Total_Obra), 0) AS Valor_Total_Contratado
FROM cliente c
LEFT JOIN vw_obra_detalhada d ON d.Cd_Cliente = c.Cd_Cliente
GROUP BY c.Cd_Cliente, c.Nm_Cliente, c.EmailCliente;

-- =====================================================
-- 5) vw_obras_em_andamento: obras em andamento com dias restantes e situação do prazo
--    (usa a data atual do servidor)
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_obras_em_andamento` AS
SELECT d.Cd_Obra,
       d.Nm_Obra,
       d.Nm_Cliente,
       d.Endereco_Completo,
       d.Dt_InicioO,
       d.Dt_TerminoRf,
       DATEDIFF(d.Dt_TerminoRf, CURDATE()) AS Dias_Restantes,
       CASE WHEN d.Dt_TerminoRf < CURDATE() THEN 'Atrasada' ELSE 'No prazo' END AS Situacao_Prazo,
       d.Valor_Total_Obra
FROM vw_obra_detalhada d
WHERE d.Status_Obra = 'Em andamento';

-- =====================================================
-- 6) vw_plantas_obra: plantas com obra, cliente e valor
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_plantas_obra` AS
SELECT p.Cd_Planta,
       p.Nm_Planta,
       p.Vl_Planta,
       o.Cd_Obra,
       o.Nm_Obra,
       c.Nm_Cliente
FROM planta p
INNER JOIN obra o ON o.Cd_Obra = p.Cd_Obra
INNER JOIN cliente c ON c.Cd_Cliente = o.Cd_Cliente;

-- =====================================================
-- 7) vw_pedidos_obra: pedidos com obra, cliente e duração em dias
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_pedidos_obra` AS
SELECT pe.Cd_Pedido,
       pe.Dt_Abertura,
       pe.Dt_Finalizacao,
       DATEDIFF(pe.Dt_Finalizacao, pe.Dt_Abertura) AS Duracao_Dias,
       o.Cd_Obra,
       o.Nm_Obra,
       c.Nm_Cliente
FROM pedido pe
INNER JOIN obra o ON o.Cd_Obra = pe.Cd_Obra
INNER JOIN cliente c ON c.Cd_Cliente = o.Cd_Cliente;

-- =====================================================
-- 8) vw_comodos_obra: cômodos de cada obra com cliente e local
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_comodos_obra` AS
SELECT cm.Cd_Comodo,
       cm.Nm_Comodo,
       o.Cd_Obra,
       o.Nm_Obra,
       c.Nm_Cliente,
       l.Nm_Local
FROM comodo cm
INNER JOIN obra o ON o.Cd_Obra = cm.FK_Obra
INNER JOIN cliente c ON c.Cd_Cliente = o.Cd_Cliente
INNER JOIN `local` l ON l.Cd_Local = o.Cd_Local;

-- =====================================================
-- 9) vw_obras_por_tipo_local: total de obras e valor por tipo de local
--    (tipos sem obra aparecem com zero)
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_obras_por_tipo_local` AS
SELECT t.CdTLocal,
       t.Nm_TLocal AS Tipo_Local,
       COUNT(d.Cd_Obra) AS Qtd_Obras,
       COALESCE(SUM(d.Valor_Total_Obra), 0) AS Valor_Total
FROM tipolocal t
LEFT JOIN vw_obra_detalhada d ON d.CdTLocal = t.CdTLocal
GROUP BY t.CdTLocal, t.Nm_TLocal;

-- =====================================================
-- 10) vw_obras_por_cidade: total de obras e valor por cidade
-- =====================================================
CREATE OR REPLACE VIEW `dan`.`vw_obras_por_cidade` AS
SELECT d.Nm_Cidade,
       d.Sigla_Estado,
       COUNT(d.Cd_Obra) AS Qtd_Obras,
       SUM(d.Valor_Total_Obra) AS Valor_Total
FROM vw_obra_detalhada d
GROUP BY d.Nm_Cidade, d.Sigla_Estado;


-- =====================================================
-- EXEMPLOS DE USO
-- =====================================================
SELECT * FROM vw_obra_detalhada ORDER BY Cd_Obra;
SELECT * FROM vw_resumo_cliente ORDER BY Valor_Total_Contratado DESC;
SELECT * FROM vw_obras_em_andamento ORDER BY Dias_Restantes;
SELECT * FROM vw_obras_por_tipo_local;
SELECT * FROM vw_obras_por_cidade ORDER BY Valor_Total DESC;