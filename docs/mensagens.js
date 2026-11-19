// ===== mensagens.js — canal de mensagens entre a Ana e o arquiteto (Rafael) =====
// Usado só nas páginas do Rafael e da Ana.
// Cada mensagem guarda: { id, de, para, assunto, texto, data, lida }
// "de" e "para" são 'rafael' ou 'ana'. As mensagens ficam em dados.mensagens (a mais nova primeiro).

const NOMES = { rafael: 'Rafael · Arquiteto', ana: 'Ana · Moradora' };
let pastaAtual = 'entrada';    // 'entrada' (recebidas) ou 'enviadas'
let mensagemAberta = null;     // id da mensagem que está aberta para leitura

// Quem é a outra pessoa da conversa
function outroPerfil() {
  return perfilDaPagina === 'rafael' ? 'ana' : 'rafael';
}

// Desenha a lista, o leitor e os números (mensagens não lidas)
function desenharMensagens() {
  if (!pegar('lista-msg')) { return; }     // esta página não tem a aba Mensagens
  const eu = perfilDaPagina;

  let naoLidas = 0;
  let html = '';
  for (let i = 0; i < dados.mensagens.length; i++) {
    const m = dados.mensagens[i];
    if (m.para === eu && !m.lida) { naoLidas++; }

    // a lista mostra só as mensagens da pasta escolhida
    const naPasta = pastaAtual === 'entrada' ? m.para === eu : m.de === eu;
    if (!naPasta) { continue; }

    const outro = pastaAtual === 'entrada' ? 'De: ' + NOMES[m.de] : 'Para: ' + NOMES[m.para];
    const classes = 'msg-item' + (m.para === eu && !m.lida ? ' naolida' : '') + (m.id === mensagemAberta ? ' aberta' : '');
    html += '<div class="' + classes + '" onclick="abrirMensagem(' + m.id + ')">' +
      '<b>' + esc(m.assunto) + '</b><span>' + esc(outro) + '</span><small>' + esc(m.data) + '</small></div>';
  }
  if (html === '') { html = '<div class="msg-vazio">Nenhuma mensagem aqui.</div>'; }
  pegar('lista-msg').innerHTML = html;

  // Botões das pastas
  pegar('pasta-entrada').textContent = 'Caixa de entrada' + (naoLidas > 0 ? ' (' + naoLidas + ')' : '');
  pegar('pasta-entrada').classList.toggle('ativo', pastaAtual === 'entrada');
  pegar('pasta-enviadas').classList.toggle('ativo', pastaAtual === 'enviadas');

  // Aba "Mensagens" no topo mostra quantas não lidas
  const abas = document.querySelectorAll('a[href="#view-msg"]');
  for (let i = 0; i < abas.length; i++) {
    abas[i].textContent = naoLidas > 0 ? 'Mensagens (' + naoLidas + ')' : 'Mensagens';
  }

  desenharLeitor();
}

// Mostra a mensagem aberta (ou um aviso, se nenhuma estiver aberta)
function desenharLeitor() {
  const leitor = pegar('leitor-msg');
  let mensagem = null;
  for (let i = 0; i < dados.mensagens.length; i++) {
    if (dados.mensagens[i].id === mensagemAberta) { mensagem = dados.mensagens[i]; }
  }
  if (mensagem === null) {
    leitor.innerHTML = '<div class="msg-vazio">Selecione uma mensagem para ler.</div>';
    return;
  }
  let botao = '';
  if (mensagem.para === perfilDaPagina) {
    botao = '<div><button type="button" class="btn p" onclick="novaMensagem(' + mensagem.id + ')">Responder</button></div>';
  }
  leitor.innerHTML = '<h2>' + esc(mensagem.assunto) + '</h2>' +
    '<div class="meta"><div><small>De</small><b>' + esc(NOMES[mensagem.de]) + '</b></div>' +
    '<div><small>Para</small><b>' + esc(NOMES[mensagem.para]) + '</b></div>' +
    '<div><small>Data</small><b>' + esc(mensagem.data) + '</b></div></div>' +
    '<div class="msg-texto">' + esc(mensagem.texto).replace(/\n/g, '<br>') + '</div>' + botao;
}

// Troca entre "Caixa de entrada" e "Enviadas"
function mostrarPasta(pasta) {
  pastaAtual = pasta;
  mensagemAberta = null;
  desenharMensagens();
}

// Abre uma mensagem para ler. Se ela chegou para mim e estava não lida, vira "lida".
function abrirMensagem(id) {
  mensagemAberta = id;
  for (let i = 0; i < dados.mensagens.length; i++) {
    const m = dados.mensagens[i];
    if (m.id === id && m.para === perfilDaPagina && !m.lida) { m.lida = true; }
  }
  salvarTudo();
}

// Abre a janela "Nova mensagem". Se vier um id, é uma resposta a essa mensagem.
function novaMensagem(idResposta) {
  let assunto = '';
  if (idResposta) {
    for (let i = 0; i < dados.mensagens.length; i++) {
      if (dados.mensagens[i].id === idResposta) {
        const original = dados.mensagens[i].assunto;
        assunto = original.startsWith('Re: ') ? original : 'Re: ' + original;
      }
    }
  }
  pegar('msg-para').value = NOMES[outroPerfil()];
  pegar('msg-assunto').value = assunto;
  pegar('msg-texto').value = '';
  pegar('msg-erro').textContent = '';
  abrirModal('modal-mensagem');
}

// Botão "Enviar" da janela
function enviarMensagem() {
  const assunto = pegar('msg-assunto').value.trim();
  const texto = pegar('msg-texto').value.trim();
  if (assunto === '' || texto === '') {
    pegar('msg-erro').textContent = 'Preencha o assunto e a mensagem.';
    return;
  }
  const agora = new Date().toLocaleString('pt-BR', { dateStyle: 'short', timeStyle: 'short' }).replace(',', '');
  dados.mensagens.unshift({
    id: Date.now(),              // um número único para identificar a mensagem
    de: perfilDaPagina,
    para: outroPerfil(),
    assunto: assunto,
    texto: texto,
    data: agora,
    lida: false
  });
  salvarTudo();
  fecharModal('modal-mensagem');
  aviso('Mensagem enviada para ' + NOMES[outroPerfil()] + '.');
}
