// ===== rafael.js — página do Rafael (Arquiteto) =====

const SERVICOS = ['Instalação padrão', 'Configuração de cena', 'Visita técnica extra'];
let ambienteEditado = -1;   // -1 = criando um ambiente novo; 0, 1, 2... = editando esse ambiente

// ---------- Desenha as partes que só existem nesta página ----------
function desenharPagina() {
  desenharMensagens();
  desenharListaAmbientes();
  desenharAjustes();
}

// Lista da aba "Ambientes"
function desenharListaAmbientes() {
  const caixa = pegar('lista-amb-rows');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.ambientes.length; i++) {
    const a = dados.ambientes[i];
    html += '<div class="env"><i style="background:' + a.cor + '"></i><b>' + esc(a.nome) + '</b>' +
      '<span>' + a.dispositivos.length + ' dispositivos</span></div>';
  }
  caixa.innerHTML = html;
}

// Lista de ajustes pedidos pelo técnico (com a caixinha "revisado")
function desenharAjustes() {
  const caixa = pegar('lista-ajustes');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.ajustes.length; i++) {
    const x = dados.ajustes[i];
    html += '<label class="ajuste rv"><input type="checkbox" id="rev-' + i + '"' + (x.revisado ? ' checked' : '') + '><i class="box"></i>' +
      '<div><b>' + esc(x.onde) + '</b><span>' + esc(x.texto) + '</span><small>' + esc(x.quem) + '</small></div><em>Revisado</em></label>';
  }
  caixa.innerHTML = html;
}

// ---------- Janela "Novo ambiente" / "Editar ambiente" ----------
function abrirAmbiente(indice) {
  ambienteEditado = indice;
  pegar('amb-erro').textContent = '';

  if (indice === -1) {
    // criando um ambiente novo
    pegar('amb-titulo').textContent = 'Novo ambiente';
    pegar('amb-escolha-caixa').hidden = true;
    pegar('amb-icone-caixa').hidden = false;
    pegar('amb-nome').value = '';
    const rotulos = [];
    for (let i = 0; i < ICONES.length; i++) { rotulos.push(ICONES[i].rotulo); }
    preencherSelect('amb-icone', rotulos);
  } else {
    // editando um ambiente que já existe
    pegar('amb-titulo').textContent = 'Editar ambiente';
    pegar('amb-escolha-caixa').hidden = false;
    pegar('amb-icone-caixa').hidden = true;
    const nomes = [];
    for (let i = 0; i < dados.ambientes.length; i++) { nomes.push(dados.ambientes[i].nome); }
    preencherSelect('amb-escolha', nomes, indice);
    pegar('amb-nome').value = dados.ambientes[indice].nome;
  }
  abrirModal('modal-ambiente');
}

// Quando o Rafael troca o ambiente na lista da janela
function trocarAmbienteEditado() {
  ambienteEditado = pegar('amb-escolha').selectedIndex;
  pegar('amb-nome').value = dados.ambientes[ambienteEditado].nome;
}

function salvarAmbiente() {
  const nome = pegar('amb-nome').value.trim();
  if (nome === '') {
    pegar('amb-erro').textContent = 'Informe o nome do ambiente.';
    return;
  }

  if (ambienteEditado === -1) {
    const icone = ICONES[pegar('amb-icone').selectedIndex];
    dados.ambientes.push({ nome: nome, img: icone.img, cor: icone.cor, dispositivos: [] });
    dados.obra.push({ ambiente: nome, status: 'Não iniciado', aprovado: false });   // aparece também no Status da Obra
  } else {
    const nomeAntigo = dados.ambientes[ambienteEditado].nome;
    dados.ambientes[ambienteEditado].nome = nome;
    for (let i = 0; i < dados.obra.length; i++) {
      if (dados.obra[i].ambiente === nomeAntigo) { dados.obra[i].ambiente = nome; }
    }
  }

  salvarTudo();
  fecharModal('modal-ambiente');
  aviso('Ambiente salvo.');
}

// ---------- Janela "Novo dispositivo" ----------
function abrirDispositivo() {
  const ambientes = [], modelos = [], protocolos = [];
  for (let i = 0; i < dados.ambientes.length; i++) { ambientes.push(dados.ambientes[i].nome); }
  for (let i = 0; i < dados.modelos.length; i++) { modelos.push(dados.modelos[i].nome); }
  for (let i = 0; i < dados.protocolos.length; i++) { protocolos.push(dados.protocolos[i].nome); }
  preencherSelect('disp-amb', ambientes);
  preencherSelect('disp-modelo', modelos);
  preencherSelect('disp-protocolo', protocolos);
  pegar('disp-nome').value = '';
  pegar('disp-erro').textContent = '';
  abrirModal('modal-dispositivo');
}

function salvarDispositivo() {
  const ambiente = dados.ambientes[pegar('disp-amb').selectedIndex];
  const modelo = dados.modelos[pegar('disp-modelo').selectedIndex];
  const protocolo = dados.protocolos[pegar('disp-protocolo').selectedIndex].nome;
  const nome = pegar('disp-nome').value.trim();

  if (nome === '') {
    pegar('disp-erro').textContent = 'Informe o nome de identificação.';
    return;
  }
  // Regra: o protocolo precisa ser um dos que o modelo aceita
  if (!modelo.protocolos.includes(protocolo)) {
    pegar('disp-erro').textContent = 'O modelo ' + modelo.nome + ' só aceita: ' + modelo.protocolos.join(' · ') + '.';
    return;
  }

  ambiente.dispositivos.push(nome);
  salvarTudo();
  fecharModal('modal-dispositivo');
  aviso('Dispositivo adicionado em ' + ambiente.nome + '.');
}

// ---------- Cadastro do cliente ----------
// Botão "Cadastrar cliente e imóvel" (formulário da aba Cadastro)
function cadastrarCliente() {
  const nome = pegar('cad-nome').value.trim();
  if (nome === '') {
    aviso('Informe o nome do cliente.');
    return;
  }
  dados.cliente.nome = nome;
  dados.cliente.email = pegar('cad-email').value.trim();
  if (pegar('cad-endereco').value.trim() !== '') { dados.cliente.endereco = pegar('cad-endereco').value.trim(); }
  dados.cliente.tipo = pegar('t-casa').checked ? 'Casa' : 'Apartamento';
  salvarTudo();
  aviso('Cliente cadastrado.');
  location.hash = '#view-dash';
}

// Janela "Editar cadastro"
function abrirCadastro() {
  const c = dados.cliente;
  preencherSelect('ed-escolha', [c.nome + ' — ' + c.endereco]);
  pegar('ed-nome').value = c.nome;
  pegar('ed-email').value = c.email;
  pegar('ed-endereco').value = c.endereco;
  preencherSelect('ed-tipo', ['Casa', 'Apartamento'], c.tipo === 'Casa' ? 0 : 1);
  preencherSelect('ed-servico', SERVICOS, SERVICOS.indexOf(c.servico));
  pegar('ed-erro').textContent = '';
  abrirModal('modal-cadastro');
}

function salvarCadastro() {
  const nome = pegar('ed-nome').value.trim();
  if (nome === '') {
    pegar('ed-erro').textContent = 'Informe o nome do cliente.';
    return;
  }
  dados.cliente.nome = nome;
  dados.cliente.email = pegar('ed-email').value.trim();
  dados.cliente.endereco = pegar('ed-endereco').value.trim();
  dados.cliente.tipo = pegar('ed-tipo').value;
  dados.cliente.servico = pegar('ed-servico').value;
  salvarTudo();
  fecharModal('modal-cadastro');
  aviso('Cadastro atualizado.');
}

// ---------- Ajustes e verificação ----------
// Abre a janela "Executar nova verificação" (a lista de ambientes vem dos dados)
function abrirVerificacao() {
  const nomes = ['Todos os ambientes'];
  for (let i = 0; i < dados.ambientes.length; i++) { nomes.push(dados.ambientes[i].nome); }
  preencherSelect('ver-amb', nomes);
  abrirModal('modal-verificacao');
}

// Botão "Salvar revisões": guarda quais ajustes estão marcados como revisados
function salvarRevisoes() {
  for (let i = 0; i < dados.ajustes.length; i++) {
    dados.ajustes[i].revisado = pegar('rev-' + i).checked;
  }
  salvarTudo();
  aviso('Revisões salvas.');
}

// Janela "Executar nova verificação": adiciona uma linha no histórico
function executarVerificacao() {
  const numero = dados.historico.length + 1;
  const agora = new Date().toLocaleString('pt-BR', { dateStyle: 'short', timeStyle: 'short' }).replace(',', '');
  dados.historico.unshift({
    numero: '#' + numero,
    data: agora,
    quem: 'Rafael',
    versao: 'v' + (2 * numero + 1),
    resultado: '1 OK · 2 pendências · 1 análise técnica'
  });
  salvarTudo();
  fecharModal('modal-verificacao');
  aviso('Verificação executada.');
}

// ---------- Planta baixa ----------
// Quando o Rafael escolhe um arquivo, guardamos no navegador para o Carlos ver
function importarPlanta(campo) {
  const arquivo = campo.files[0];
  if (!arquivo) { return; }
  const leitor = new FileReader();
  leitor.onload = function () {
    try {
      localStorage.setItem('planta', JSON.stringify({ url: leitor.result, tipo: arquivo.type, nome: arquivo.name }));
      mostrarPlanta();
      aviso('Planta enviada — o técnico já pode consultá-la.');
    } catch (erro) {
      aviso('Arquivo grande demais para guardar no navegador.');
    }
  };
  leitor.readAsDataURL(arquivo);
}

// ---------- Ao abrir a página ----------
desenharTudo();
