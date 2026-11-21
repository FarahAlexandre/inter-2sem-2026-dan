// ===== landing.js — o único JavaScript da landing page =====
// 1) Abre e fecha o menu no celular.
// 2) Fecha o menu quando a pessoa clica em um link.
// 3) Escreve o ano atual no rodapé.

const botaoMenu = document.getElementById('menu-botao');
const menu = document.getElementById('menu');

// Clique no botão "hambúrguer": abre ou fecha o menu
botaoMenu.addEventListener('click', function () {
  const aberto = menu.classList.toggle('aberto');          // liga/desliga a classe "aberto"
  botaoMenu.setAttribute('aria-expanded', aberto);         // avisa leitores de tela
  botaoMenu.setAttribute('aria-label', aberto ? 'Fechar menu' : 'Abrir menu');
});

// Clique em qualquer link do menu: fecha o menu
const linksDoMenu = menu.querySelectorAll('a');
for (let i = 0; i < linksDoMenu.length; i++) {
  linksDoMenu[i].addEventListener('click', function () {
    menu.classList.remove('aberto');
    botaoMenu.setAttribute('aria-expanded', 'false');
    botaoMenu.setAttribute('aria-label', 'Abrir menu');
  });
}

// Ano do rodapé
document.getElementById('ano').textContent = new Date().getFullYear();
