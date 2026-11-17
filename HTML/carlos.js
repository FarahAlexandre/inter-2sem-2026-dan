// ===== carlos.js — página do Carlos (Técnico instalador) =====

let modeloEditado = -1;       // -1 = cadastrando modelo novo; 0, 1, 2... = editando esse modelo
let protocoloEditado = -1;    // o mesmo, para protocolos

// ---------- Listas de nomes (usadas nas janelas) ----------
function nomesModelos() {
  const nomes = [];
  for (let i = 0; i < dados.modelos.length; i++) { nomes.push(dados.modelos[i].nome); }
  return nomes;
}
function nomesProtocolos() {
  const nomes = [];
  for (let i = 0; i < dados.protocolos.length; i++) { nomes.push(dados.protocolos[i].nome); }
  return nomes;
}

// Quais modelos aceitam um protocolo (a informação fica guardada dentro de cada modelo)
function modelosDoProtocolo(nomeProtocolo) {
  const lista = [];
  for (let i = 0; i < dados.modelos.length; i++) {
    if (dados.modelos[i].protocolos.includes(nomeProtocolo)) { lista.push(dados.modelos[i].nome); }
  }
  return lista;
}

// ---------- Desenha as partes que só existem nesta página ----------
function desenharPagina() {
  desenharModelos();
  desenharProtocolos();
  desenharObra();
}

function desenharModelos() {
  const caixa = pegar('linhas-modelos');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.modelos.length; i++) {
    const m = dados.modelos[i];
    html += '<div class="row c-mod"><span>' + esc(m.nome) + '</span><span>' + esc(m.fabricante) + '</span><span>' + esc(m.categoria) + '</span>' +
      '<span>' + esc(m.funcoes) + '</span><span>' + esc(m.limites) + '</span><span>' + esc(m.protocolos.join(' · ')) + '</span></div>';
    if (i < dados.modelos.length - 1) { html += '<div class="line"></div>'; }
  }
  caixa.innerHTML = html;
}

function desenharProtocolos() {
  const caixa = pegar('linhas-protocolos');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.protocolos.length; i++) {
    const p = dados.protocolos[i];
    const modelos = modelosDoProtocolo(p.nome);
    html += '<div class="row c-pro"><span>' + esc(p.nome) + '</span><span>' + esc(p.descricao) + '</span>' +
      '<span>' + (modelos.length > 0 ? esc(modelos.join(' · ')) : '—') + '</span></div>';
    if (i < dados.protocolos.length - 1) { html += '<div class="line"></div>'; }
  }
  caixa.innerHTML = html;
}

// ---------- Caixinhas de escolha (chips) usadas nas janelas ----------
// opcoes = todas as opções; marcados = as que começam marcadas
function desenharChips(idCaixa, prefixo, opcoes, marcados) {
  let html = '';
  for (let i = 0; i < opcoes.length; i++) {
    html += '<span class="ck"><input type="checkbox" id="' + prefixo + i + '"' + (marcados.includes(opcoes[i]) ? ' checked' : '') + '>' +
      '<label for="' + prefixo + i + '">' + esc(opcoes[i]) + '</label></span>';
  }
  pegar(idCaixa).innerHTML = html;
}
// Devolve quais chips estão marcados
function chipsMarcados(prefixo, opcoes) {
  const marcados = [];
  for (let i = 0; i < opcoes.length; i++) {
    if (pegar(prefixo + i).checked) { marcados.push(opcoes[i]); }
  }
  return marcados;
}

// ---------- Janela do dispositivo (modelo do catálogo) ----------
function abrirModelo(indice) {
  modeloEditado = indice;
  pegar('mod-erro').textContent = '';
  preencherSelect('mod-cat', dados.categorias);

  if (indice === -1) {
    pegar('mod-titulo').textContent = 'Cadastrar dispositivo';
    pegar('mod-escolha-caixa').hidden = true;
    pegar('mod-nome').value = '';
    pegar('mod-fab').value = '';
    pegar('mod-fun').value = '';
    pegar('mod-lim').value = '';
    desenharChips('mod-protos', 'mp-', nomesProtocolos(), []);
  } else {
    pegar('mod-titulo').textContent = 'Editar dispositivo';
    pegar('mod-escolha-caixa').hidden = false;
    preencherSelect('mod-escolha', nomesModelos(), indice);
    preencherCamposModelo(indice);
  }
  abrirModal('modal-modelo');
}

// Coloca os dados do modelo escolhido nos campos da janela
function preencherCamposModelo(indice) {
  const m = dados.modelos[indice];
  pegar('mod-nome').value = m.nome;
  pegar('mod-fab').value = m.fabricante;
  pegar('mod-fun').value = m.funcoes;
  pegar('mod-lim').value = m.limites;
  pegar('mod-cat').selectedIndex = dados.categorias.indexOf(m.categoria);
  desenharChips('mod-protos', 'mp-', nomesProtocolos(), m.protocolos);
}

// Quando o técnico troca o dispositivo na lista da janela
function trocarModelo() {
  modeloEditado = pegar('mod-escolha').selectedIndex;
  preencherCamposModelo(modeloEditado);
}

function salvarModelo() {
  const nome = pegar('mod-nome').value.trim();
  if (nome === '') {
    pegar('mod-erro').textContent = 'Informe o nome do modelo.';
    return;
  }
  const modelo = {
    nome: nome,
    fabricante: pegar('mod-fab').value.trim() || '—',
    categoria: pegar('mod-cat').value,
    funcoes: pegar('mod-fun').value.trim() || '—',
    limites: pegar('mod-lim').value.trim() || '—',
    protocolos: chipsMarcados('mp-', nomesProtocolos())
  };

  if (modeloEditado === -1) {
    dados.modelos.push(modelo);
  } else {
    dados.modelos[modeloEditado] = modelo;
  }
  salvarTudo();
  fecharModal('modal-modelo');
  aviso('Dispositivo salvo no catálogo.');
}

// ---------- Janela do protocolo ----------
function abrirProtocolo(indice) {
  protocoloEditado = indice;
  pegar('pro-erro').textContent = '';
  preencherSelect('pro-situacao', ['Ativo', 'Inativo']);

  if (indice === -1) {
    pegar('pro-titulo').textContent = 'Cadastrar protocolo';
    pegar('pro-escolha-caixa').hidden = true;
    pegar('pro-nome').value = '';
    pegar('pro-desc').value = '';
    desenharChips('pro-modelos', 'pm-', nomesModelos(), []);
  } else {
    pegar('pro-titulo').textContent = 'Editar protocolo';
    pegar('pro-escolha-caixa').hidden = false;
    preencherSelect('pro-escolha', nomesProtocolos(), indice);
    preencherCamposProtocolo(indice);
  }
  abrirModal('modal-protocolo');
}

function preencherCamposProtocolo(indice) {
  const p = dados.protocolos[indice];
  pegar('pro-nome').value = p.nome;
  pegar('pro-desc').value = p.descricao;
  pegar('pro-situacao').selectedIndex = p.situacao === 'Ativo' ? 0 : 1;
  desenharChips('pro-modelos', 'pm-', nomesModelos(), modelosDoProtocolo(p.nome));
}

function trocarProtocolo() {
  protocoloEditado = pegar('pro-escolha').selectedIndex;
  preencherCamposProtocolo(protocoloEditado);
}

function salvarProtocolo() {
  const nome = pegar('pro-nome').value.trim();
  if (nome === '') {
    pegar('pro-erro').textContent = 'Informe o nome do protocolo.';
    return;
  }
  const marcados = chipsMarcados('pm-', nomesModelos());   // modelos que devem aceitar este protocolo

  if (protocoloEditado === -1) {
    dados.protocolos.push({ nome: nome, descricao: pegar('pro-desc').value.trim() || '—', situacao: pegar('pro-situacao').value });
  } else {
    const nomeAntigo = dados.protocolos[protocoloEditado].nome;
    dados.protocolos[protocoloEditado] = { nome: nome, descricao: pegar('pro-desc').value.trim() || '—', situacao: pegar('pro-situacao').value };
    // se o nome mudou, troca também dentro dos modelos
    for (let i = 0; i < dados.modelos.length; i++) {
      const posicao = dados.modelos[i].protocolos.indexOf(nomeAntigo);
      if (posicao !== -1) { dados.modelos[i].protocolos[posicao] = nome; }
    }
  }

  // Atualiza cada modelo: aceita ou deixa de aceitar este protocolo
  for (let i = 0; i < dados.modelos.length; i++) {
    const modelo = dados.modelos[i];
    const aceita = marcados.includes(modelo.nome);
    const posicao = modelo.protocolos.indexOf(nome);
    if (aceita && posicao === -1) { modelo.protocolos.push(nome); }
    if (!aceita && posicao !== -1) { modelo.protocolos.splice(posicao, 1); }
  }

  salvarTudo();
  fecharModal('modal-protocolo');
  aviso('Protocolo salvo.');
}

// ---------- Status da obra ----------
function desenharObra() {
  const caixa = pegar('linhas-obra');
  if (!caixa) { return; }

  let html = '';
  const contagem = { 'Não iniciado': 0, 'Em andamento': 0, 'Em verificação': 0, 'Concluído': 0 };
  let aprovadas = 0;

  for (let i = 0; i < dados.obra.length; i++) {
    const etapa = dados.obra[i];
    contagem[etapa.status]++;
    if (etapa.aprovado) { aprovadas++; }

    let opcoes = '';
    for (let j = 0; j < STATUS_OBRA.length; j++) {
      opcoes += '<option' + (STATUS_OBRA[j] === etapa.status ? ' selected' : '') + '>' + STATUS_OBRA[j] + '</option>';
    }
    // a aprovação só pode ser marcada quando a etapa está "Concluído"
    const podeAprovar = etapa.status === 'Concluído';
    html += '<div class="row c-obra"><span>' + esc(etapa.ambiente) + '</span>' +
      '<select class="sel s" onchange="mudarStatus(' + i + ', this.value)">' + opcoes + '</select>' +
      '<label class="tg"><input type="checkbox"' + (etapa.aprovado ? ' checked' : '') + (podeAprovar ? '' : ' disabled') + ' onchange="mudarAprovacao(' + i + ', this.checked)"><i></i></label></div>';
    if (i < dados.obra.length - 1) { html += '<div class="line"></div>'; }
  }
  caixa.innerHTML = html;

  // Resumo no topo da página
  pegar('resumo-obra').innerHTML =
    '<div class="metric"><small>Concluídos</small><b class="bg">' + contagem['Concluído'] + '</b><small class="r">Etapas finalizadas</small></div><i class="sep"></i>' +
    '<div class="metric"><small>Em andamento</small><b class="bg">' + contagem['Em andamento'] + '</b><small class="r">Em execução</small></div><i class="sep"></i>' +
    '<div class="metric"><small>Em verificação</small><b class="bg">' + contagem['Em verificação'] + '</b><small class="r">Aguardando conferência</small></div><i class="sep"></i>' +
    '<div class="metric"><small>Não iniciados</small><b class="bg">' + contagem['Não iniciado'] + '</b><small class="r">Ainda na fila</small></div>' +
    '<div class="valor"><i></i><div><small style="font:500 12px/15px Inter;color:#5b6472">Etapas aprovadas</small><b class="bg">' + aprovadas + ' de ' + dados.obra.length + '</b><small style="font:400 12px/15px Inter;color:#5b6472">Aprovação por ambiente</small></div></div>';
}

function mudarStatus(indice, novoStatus) {
  dados.obra[indice].status = novoStatus;
  if (novoStatus !== 'Concluído') { dados.obra[indice].aprovado = false; }   // sem concluir, não dá para aprovar
  salvarTudo();
}

function mudarAprovacao(indice, marcado) {
  dados.obra[indice].aprovado = marcado;
  salvarTudo();
}

// ---------- Ajustes: o Carlos registra, o Rafael vê na página dele ----------
function registrarAjuste() {
  const onde = pegar('ajuste-onde').value.trim();
  const texto = pegar('ajuste-texto').value.trim();
  if (onde === '' || texto === '') {
    aviso('Preencha o ambiente/dispositivo e a descrição.');
    return;
  }
  dados.ajustes.unshift({ onde: onde, texto: texto, quem: 'Carlos · agora', revisado: false });
  pegar('ajuste-onde').value = '';
  pegar('ajuste-texto').value = '';
  salvarTudo();
  aviso('Ajuste registrado — o arquiteto já pode vê-lo.');
}

// ---------- Ao abrir a página ----------
desenharTudo();
