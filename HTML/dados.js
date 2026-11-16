// ===== dados.js — os dados do projeto =====
// Tudo o que as páginas mostram (ambientes, protocolos, ajustes...) fica guardado aqui.
// Os dados ficam salvos no próprio navegador (localStorage), então não precisa de banco de dados.

const CHAVE = 'livingModelDados';   // nome da "gaveta" do navegador onde guardamos tudo

// Ícones que podem ser escolhidos ao criar um ambiente
const ICONES = [
  { rotulo: 'Sala', img: 'Sala.svg', cor: '#ffc933' },
  { rotulo: 'Cozinha', img: 'cozinha.svg', cor: '#f2703c' },
  { rotulo: 'Quarto', img: 'quartos.svg', cor: '#8b5cf6' },
  { rotulo: 'Banheiro', img: 'banheiro.svg', cor: '#2aa198' },
  { rotulo: 'Área de serviço', img: 'area de serviço.svg', cor: '#4c9a5b' }
];

const STATUS_OBRA = ['Não iniciado', 'Em andamento', 'Em verificação', 'Concluído'];

// Dados que aparecem quando o navegador ainda não guardou nada
const DADOS_INICIAIS = {
  cliente: { nome: 'Ana', email: '', endereco: 'Rua das Palmeiras, 245, São Paulo/SP', tipo: 'Casa', servico: 'Instalação padrão' },

  ambientes: [
    { nome: 'Sala de estar', img: 'Sala.svg', cor: '#ffc933', dispositivos: ['Iluminação inteligente', 'Sensor de Presença', 'Controle de cortina'] },
    { nome: 'Cozinha', img: 'cozinha.svg', cor: '#f2703c', dispositivos: ['Iluminação inteligente', 'Sensor de gás', 'Tomada inteligente'] },
    { nome: 'Suíte', img: 'quartos.svg', cor: '#5b5fef', dispositivos: ['Iluminação inteligente', 'Sensor de Presença', 'Controle de cortina'] },
    { nome: 'Quarto', img: 'quartos.svg', cor: '#8b5cf6', dispositivos: ['Iluminação inteligente', 'Sensor de Presença', 'Controle de cortina'] },
    { nome: 'Banheiro', img: 'banheiro.svg', cor: '#2aa198', dispositivos: ['Iluminação inteligente', 'Sensor de Presença', 'Controle de cortina'] },
    { nome: 'Área de serviço', img: 'area de serviço.svg', cor: '#4c9a5b', dispositivos: ['Iluminação inteligente', 'Sensor de Presença', 'Controle de cortina'] }
  ],

  // Catálogo técnico: cada modelo guarda os protocolos que ele aceita
  modelos: [
    { nome: 'Sensor PIR X200', fabricante: 'SensorTech', categoria: 'Presença', funcoes: 'Detecção de presença', limites: 'Alcance 8 m', protocolos: ['Z-Wave', 'Zigbee'] },
    { nome: 'Válvula G-Safe', fabricante: 'SafeHome', categoria: 'Segurança', funcoes: 'Abrir/fechar, alerta de gás', limites: 'Pressão 0,5–4 bar', protocolos: ['Wi-Fi'] },
    { nome: 'Dimmer Smart D1', fabricante: 'LumeTech', categoria: 'Iluminação', funcoes: 'Liga/desliga, intensidade', limites: 'Carga até 400 W', protocolos: ['Wi-Fi', 'Bluetooth'] },
    { nome: 'Atuador R-Move', fabricante: 'MoveTech', categoria: 'Cortina', funcoes: 'Abrir/fechar, posição', limites: 'Motor até 60 kg', protocolos: ['Z-Wave'] },
    { nome: 'Termostato T-Climate', fabricante: 'ClimaTech', categoria: 'Climatização', funcoes: 'Liga/desliga, temperatura', limites: '16 °C a 30 °C', protocolos: ['Wi-Fi', 'Modbus'] }
  ],
  categorias: ['Presença', 'Segurança', 'Iluminação', 'Cortina', 'Climatização', 'Outro'],

  protocolos: [
    { nome: 'Wi-Fi', descricao: 'Rede local do imóvel; maior alcance e largura de banda.', situacao: 'Ativo' },
    { nome: 'Z-Wave', descricao: 'Malha dedicada de automação, baixo consumo.', situacao: 'Ativo' },
    { nome: 'Zigbee', descricao: 'Malha de baixa potência para sensores.', situacao: 'Ativo' },
    { nome: 'Bluetooth', descricao: 'Curto alcance, pareamento direto.', situacao: 'Ativo' },
    { nome: 'Modbus', descricao: 'Protocolo industrial para controladores.', situacao: 'Ativo' }
  ],

  ajustes: [
    { onde: 'Quarto — Luminária de cabeceira', texto: 'Sensor sem limite de operação cadastrado no catálogo.', quem: 'Carlos · há 2 dias', revisado: false },
    { onde: 'Banheiro — Controle de chuveiro', texto: 'Gateway Modbus não está previsto no projeto.', quem: 'Carlos · há 1 dia', revisado: false },
    { onde: 'Cozinha — Sensor de gás', texto: 'Informação insuficiente para confirmar a compatibilidade Wi-Fi.', quem: 'Carlos · hoje', revisado: false }
  ],

  obra: [
    { ambiente: 'Sala de estar', status: 'Concluído', aprovado: true },
    { ambiente: 'Cozinha', status: 'Em andamento', aprovado: false },
    { ambiente: 'Suíte', status: 'Em verificação', aprovado: false },
    { ambiente: 'Quarto', status: 'Em andamento', aprovado: false },
    { ambiente: 'Banheiro', status: 'Concluído', aprovado: false },
    { ambiente: 'Área de serviço', status: 'Não iniciado', aprovado: false }
  ],

  historico: [
    { numero: '#3', data: '08/10/2026 14:10', quem: 'Rafael', versao: 'v7', resultado: '1 OK · 2 pendências · 1 análise técnica' },
    { numero: '#2', data: '05/10/2026 09:42', quem: 'Rafael', versao: 'v5', resultado: '4 pendências' },
    { numero: '#1', data: '02/10/2026 16:20', quem: 'Rafael', versao: 'v3', resultado: '6 pendências' }
  ]
};

// Lê os dados guardados no navegador. Se não houver nada, usa os dados iniciais.
function carregar() {
  const texto = localStorage.getItem(CHAVE);
  if (texto) {
    return JSON.parse(texto);
  }
  return JSON.parse(JSON.stringify(DADOS_INICIAIS));   // (isso faz uma cópia dos dados iniciais)
}

// Guarda os dados no navegador
function guardar(d) {
  localStorage.setItem(CHAVE, JSON.stringify(d));
}

// "dados" é a variável que as páginas usam. Quando mudamos algo nela, chamamos salvarTudo().
let dados = carregar();
