document.getElementById('loginForm')?.addEventListener('submit', async e => {
  e.preventDefault();
  const email = document.getElementById('email').value;
  const senha = document.getElementById('senha').value;
  console.log(`Tentando login com ${email}`);

  // Aqui você faria a chamada para backend para autenticar
});
