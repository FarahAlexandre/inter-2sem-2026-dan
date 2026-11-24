// ===== comum.js — funções usadas por TODAS as páginas =====

// ----- Login: cada página só abre para o seu perfil -----
// Quem está logado fica guardado em "usuarioLogado" (veja login.js)
function perfilLogado() {
  return sessionStorage.getItem('usuarioLogado') || localStorage.getItem('usuarioLogado');
}

// Botão "Sair": esquece o login e volta para a página de login
function sair() {
  sessionStorage.removeItem('usuarioLogado');
  localStorage.removeItem('usuarioLogado');
  location.href = 'pagina_de_login.html';
}

// Cada página diz qual é o seu perfil em <body data-perfil="...">.
// Se quem está logado não for esse perfil, volta para o login. Senão, mostra a página.
const perfilDaPagina = document.body.dataset.perfil;
if (perfilDaPagina && perfilLogado() !== perfilDaPagina) {
  location.replace('pagina_de_login.html');
} else {
  document.body.style.visibility = 'visible';
}

// Atalho para pegar um elemento da página pelo id
function pegar(id) {
  return document.getElementById(id);
}

// Evita que um texto digitado quebre o HTML (ex.: se alguém digitar "<")
function esc(texto) {
  return String(texto).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

// Deixa o nome de uma imagem no padrão (minúsculo, sem espaço e sem acento).
// Serve para dados antigos já guardados no navegador, como "Sala.svg" ou "area de serviço.svg".
function arquivoImagem(nome) {
  return nome.toLowerCase().replace(/ç/g, 'c').replace(/ /g, '_');
}

// Transforma uma cor "#ffc933" em uma versão bem clarinha (para o fundo das etiquetas)
function clarear(cor) {
  const r = parseInt(cor.slice(1, 3), 16);
  const g = parseInt(cor.slice(3, 5), 16);
  const b = parseInt(cor.slice(5, 7), 16);
  return 'rgba(' + r + ',' + g + ',' + b + ',0.12)';
}

// ----- Janelas (modais) -----
function abrirModal(id) {
  pegar(id).classList.add('aberto');
}
function fecharModal(id) {
  pegar(id).classList.remove('aberto');
}

// ----- Aviso rápido no rodapé -----
function aviso(texto) {
  pegar('flash').innerHTML = '<div class="aviso">' + esc(texto) + '</div>';
  setTimeout(function () { pegar('flash').innerHTML = ''; }, 2500);
}

// ----- Preenche uma lista de opções (<select>) -----
// id = qual select; textos = lista de opções; escolhido = número da opção que fica marcada
function preencherSelect(id, textos, escolhido) {
  let html = '';
  for (let i = 0; i < textos.length; i++) {
    html += '<option>' + esc(textos[i]) + '</option>';
  }
  pegar(id).innerHTML = html;
  pegar(id).selectedIndex = escolhido || 0;
}

// ----- Salvar e atualizar a tela -----
// Sempre que mudamos "dados", chamamos esta função: ela guarda no navegador e desenha de novo.
function salvarTudo() {
  guardar(dados);
  desenharTudo();
}

// ----- Dashboard: cards dos ambientes e números -----
function desenharDashboard() {
  if (!pegar('lista-ambientes')) { return; }   // esta tela não tem dashboard

  let html = '';
  let totalDispositivos = 0;

  for (let i = 0; i < dados.ambientes.length; i++) {
    const a = dados.ambientes[i];
    let tags = '';
    for (let j = 0; j < a.dispositivos.length; j++) {
      tags += '<span class="t" style="background:' + clarear(a.cor) + '">' + esc(a.dispositivos[j]) + '</span>';
    }
    totalDispositivos += a.dispositivos.length;

    html += '<article class="room">' +
      '<div class="room-top"><span class="ic" style="background:' + a.cor + '"><img src="' + arquivoImagem(a.img) + '" alt=""></span><span class="on-pill">Ativo</span></div>' +
      '<div><h3>' + esc(a.nome) + '</h3><p>' + a.dispositivos.length + ' dispositivos associados</p></div>' +
      '<div class="tags"><div class="tag-row">' + tags + '</div></div>' +
      '</article>';
  }

  pegar('lista-ambientes').innerHTML = html;
  pegar('qtd-amb').textContent = dados.ambientes.length;
  pegar('qtd-disp').textContent = totalDispositivos;
  pegar('cliente-nome').textContent = dados.cliente.nome;
  if (pegar('cliente-proposta')) { pegar('cliente-proposta').textContent = dados.cliente.nome; }
  filtrarAmbientes();
}

// ----- Campo "Buscar ambiente": esconde os cards que não combinam -----
function filtrarAmbientes() {
  const busca = pegar('busca-ambiente');
  if (!busca) { return; }
  const texto = busca.value.toLowerCase();
  const cards = document.querySelectorAll('#lista-ambientes .room');
  for (let i = 0; i < cards.length; i++) {
    const nome = cards[i].querySelector('h3').textContent.toLowerCase();
    cards[i].hidden = !nome.includes(texto);
  }
}

// ----- Histórico de verificações (Rafael e Carlos) -----
function desenharHistorico() {
  const caixa = pegar('linhas-historico');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.historico.length; i++) {
    const h = dados.historico[i];
    html += '<div class="row c-his"><span>' + esc(h.numero) + '</span><span>' + esc(h.data) + '</span><span>' + esc(h.quem) + '</span><span>' + esc(h.versao) + '</span><span>' + esc(h.resultado) + '</span></div>';
    if (i < dados.historico.length - 1) { html += '<div class="line"></div>'; }
  }
  caixa.innerHTML = html;
}

// ----- Plantas baixas: o Rafael envia (uma ou várias), o Carlos consulta -----
// As plantas ficam numa lista guardada no navegador, na gaveta "plantas".
let plantaPadrao = null;   // desenho padrão da página, usado quando ainda não há nenhuma planta

function carregarPlantas() {
  try {
    const texto = localStorage.getItem('plantas');
    if (texto) { return JSON.parse(texto); }
    const antiga = localStorage.getItem('planta');      // versão antiga: uma planta só
    if (antiga) { return [JSON.parse(antiga)]; }
  } catch (erro) { }
  return [];
}

function guardarPlantas(lista) {
  localStorage.setItem('plantas', JSON.stringify(lista));
  localStorage.removeItem('planta');                    // a lista nova substitui a antiga
}

// Botão "Remover" (só aparece para o Rafael)
function removerPlanta(indice) {
  const lista = carregarPlantas();
  lista.splice(indice, 1);
  guardarPlantas(lista);
  mostrarPlanta();
  aviso('Planta removida.');
}

function mostrarPlanta() {
  const area = pegar('area-planta');
  if (!area) { return; }
  if (plantaPadrao === null) { plantaPadrao = area.innerHTML; }

  const plantas = carregarPlantas();
  if (plantas.length === 0) { area.innerHTML = plantaPadrao; return; }   // ainda não enviaram: fica o desenho padrão

  let html = '';
  for (let i = 0; i < plantas.length; i++) {
    const p = plantas[i];
    const remover = perfilDaPagina === 'rafael'
      ? '<button type="button" class="btn e s" onclick="removerPlanta(' + i + ')">Remover</button>' : '';
    const conteudo = (p.tipo || '').startsWith('image')
      ? '<img src="' + p.url + '" alt="' + esc(p.nome || 'Planta baixa') + '" style="max-width:100%;border-radius:12px">'
      : '<embed src="' + p.url + '" type="application/pdf" style="width:100%;height:480px">';
    html += '<div class="planta-item"><div class="planta-cab"><b>Planta ' + (i + 1) + ' · ' + esc(p.nome || 'sem nome') + '</b>' + remover + '</div>' + conteudo + '</div>';
  }
  area.innerHTML = html;
}

// ----- Desenha tudo que a página atual tiver -----
function desenharTudo() {
  desenharDashboard();
  desenharHistorico();
  mostrarPlanta();
  if (typeof desenharPagina === 'function') {
    desenharPagina();                          // cada página tem a sua (rafael.js, carlos.js, ana.js)
  }
}

// Se outra página/aba mudar os dados, esta página atualiza sozinha
window.addEventListener('storage', function () {
  dados = carregar();
  desenharTudo();
});
