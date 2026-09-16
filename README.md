# Living Model — Plataforma de Comunicação entre Arquiteto e Técnico

Projeto Integrado II (PI-II) desenvolvido em parceria com a **Flex Automation**, como parte do curso de Ciência de Dados e Negócios da ESPM.

## Sobre o projeto

No segmento de automação residencial, grande parte das informações de projetos é registrada em planilhas e documentos avulsos, dificultando a comunicação entre quem projeta a automação (arquiteto) e quem executa a instalação (técnico). Após a aprovação do projeto, a equipe técnica frequentemente precisa reconstruir parte desse conhecimento, gerando retrabalho.

O **Living Model** propõe uma plataforma que funciona como meio de comunicação entre o arquiteto e o técnico do projeto: o arquiteto cadastra as informações do projeto (cliente, planta, ambientes, dispositivos e protocolos), e o técnico consulta essas informações para facilitar a instalação — sem necessidade de reconstruir o conhecimento do projeto do zero.

## Personas

- **Arquiteto** — cadastra cliente, planta do imóvel, ambientes, dispositivos e protocolos do projeto de automação.
- **Técnico** — visualiza as informações cadastradas pelo arquiteto (planta, ambientes, dispositivos, protocolos) para facilitar a comunicação e a execução da instalação.

## Produto esperado

Protótipo funcional contendo cadastro (pelo arquiteto) de clientes, plantas, ambientes, dispositivos e protocolos, e visualização (pelo técnico) dessas informações, com representação visual do projeto e indicadores gerenciais.

> Não fazem parte do escopo: geração de orçamento/proposta comercial e implementação de backend. O protótipo é estático — a persistência dos dados não é implementada.

## Interdisciplinaridade

O projeto integra entregas de 8 componentes curriculares, evoluindo ao longo dos deliverables 2 e 3:

| Componente Curricular | Deliverable 2 | Deliverable 3 |
|---|---|---|
| Engenharia de Software | Casos de Uso, Modelo de Domínio, Diagrama de Classes, protótipo | Documentação consolidada, UML atualizada, rastreabilidade dos requisitos |
| Programação Web | Interface responsiva em HTML/CSS | Interface completa integrada aos formulários |
| Laboratório de Programação (Python) | Regras de negócio (cálculos, validações, persistência simples) | Aplicação Python consolidada |
| Banco de Dados Analítico | Modelo lógico, scripts SQL, carga inicial | Banco integrado, consultas e indicadores |
| Estatística | Cálculos estatísticos e gráficos | Dashboard integrado |
| UX/UI | Protótipo de alta fidelidade e testes de usabilidade | Interface refinada |
| Fundamentos de Marketing | Estrutura da comunicação visual | Apresentação da solução |
| Projeto Integrado | MVP funcional integrando os componentes | Produto integrado, demonstração e defesa da solução |

*Observação: o quadro reflete a estrutura oficial do desafio proposto pela ESPM/Flex Automation. Nossa equipe restringiu o escopo do MVP à comunicação arquiteto-técnico, sem orçamento comercial e sem backend — os itens de "proposta comercial" das disciplinas de Marketing e Projeto Integrado foram adaptados para "comunicação/apresentação da solução".*

**Restrições técnicas:** Python, HTML, CSS, JavaScript, modelagem de banco de dados (MySQL ou PostgreSQL) e GitHub. **Sem backend implementado** — MER é modelo teórico, scripts Python rodam separados via terminal, e o protótipo web é estático (HTML puro, sem integração entre as camadas).


## Links do projeto

- **Google Drive:** https://drive.google.com/drive/folders/1af0-xccMKk5_9_Yyigh0PgUvibDKrNUv?usp=drive_link
- **Jira (backlog e sprints):** https://pedrohlrs.atlassian.net/jira/software/projects/SM/boards/69/backlog?atlOrigin=eyJpIjoiMDE1NTRlNGQyMDk5NDY5MTkxMWJjODliMTA3MmNmOTgiLCJwIjoiaiJ9

## Protótipo de referência (exemplo)

Os arquivos `index.html`, `styles.css` e `app.js` anexados são um protótipo de exemplo de interface (com alternância Comercial/Técnico e geração de proposta) usado como referência visual para a etapa de Programação Web. Como o escopo do projeto foi redefinido para cadastro (arquiteto) + visualização (técnico), sem orçamento/comercial, esse exemplo servirá apenas de inspiração de layout — as telas e fluxos reais do protótipo final devem seguir as personas Arquiteto e Técnico descritas acima.

## Cronograma (resumo)

- **Sprint 0 — Descoberta:** imersão no desafio, levantamento inicial de requisitos, Product Vision, Personas e Backlog inicial.
- **Sprint 1 — Planejamento e MVP (v1):** Documento de Visão, requisitos, MER, wireframes, arquitetura inicial e protótipo navegável → **Deliverable 1 (20%)**.
- **Sprints 2–3:** desenvolvimento e validação parcial → **Deliverable 2 (20%)**.
- **Sprints 4–5:** consolidação e demonstração final → **Deliverable 3 (60%)**.

**Período:** 03/08/2026 a 16/11/2026
**Empresa parceira:** Flex Automation

## Empresa parceira

**Flex Automation** — https://flexautomation.com.br/
Contato principal: Pedro
