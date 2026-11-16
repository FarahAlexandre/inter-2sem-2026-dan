// ===== ana.js — página da Ana (moradora) =====
// A Ana só visualiza: aqui só desenhamos a lista da aba "Meu Projeto".

function desenharPagina() {
  const caixa = pegar('lista-projeto');
  if (!caixa) { return; }
  let html = '';
  for (let i = 0; i < dados.ambientes.length; i++) {
    const a = dados.ambientes[i];
    const qtd = a.dispositivos.length;
    html += '<div class="envrow"><b>' + esc(a.nome) + '</b><span class="pill neu">' + qtd + (qtd === 1 ? ' dispositivo autorizado' : ' dispositivos autorizados') + '</span></div>';
  }
  caixa.innerHTML = html;
}

// ---------- Ao abrir a página ----------
desenharTudo();
