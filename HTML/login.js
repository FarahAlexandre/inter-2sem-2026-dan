// ===== login.js — entrar com login e senha =====
// ATENÇÃO: isto serve para a demonstração do projeto. As senhas ficam escritas neste arquivo,
// então qualquer pessoa que abrir o arquivo consegue lê-las. Um login de verdade precisa de servidor.

// Cada linha é uma conta: login, senha, qual perfil ela abre e qual página
const USUARIOS = [
  { login: 'rafael@dan.com', senha: 'rafael123', perfil: 'rafael', pagina: 'Pagina_Rafael.html' },
  { login: 'carlos@dan.com', senha: 'carlos123', perfil: 'carlos', pagina: 'Pagina_Carlos.html' },
  { login: 'ana@dan.com', senha: 'ana123', perfil: 'ana', pagina: 'Pagina_Ana.html' }
];

// Chamada quando a pessoa clica em "Entrar"
function entrar(evento) {
  evento.preventDefault();   // impede a página de recarregar sozinha

  const login = document.getElementById('emailInput').value.trim().toLowerCase();
  const senha = document.getElementById('passwordInput').value;
  const lembrar = document.getElementById('rememberMe').checked;

  for (let i = 0; i < USUARIOS.length; i++) {
    const u = USUARIOS[i];
    if (u.login === login && u.senha === senha) {
      // "Lembrar de mim" guarda por mais tempo; sem ele, vale só enquanto a aba estiver aberta
      const gaveta = lembrar ? localStorage : sessionStorage;
      gaveta.setItem('usuarioLogado', u.perfil);
      location.href = u.pagina;
      return false;
    }
  }

  document.getElementById('erro-login').textContent = 'Login ou senha incorretos.';
  return false;
}
