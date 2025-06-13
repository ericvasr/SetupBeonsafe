#!/bin/bash

# Cores para output
VERDE="\e[32m"
VERMELHO="\e[31m"
AMARELO="\e[33m"
RESET="\e[0m"

# Função para exibir mensagens de erro
erro() {
    echo -e "${VERMELHO}[ERRO] $1${RESET}"
    exit 1
}

# Função para exibir mensagens de sucesso
sucesso() {
    echo -e "${VERDE}[SUCESSO] $1${RESET}"
}

# Função para exibir mensagens de aviso
aviso() {
    echo -e "${AMARELO}[AVISO] $1${RESET}"
}

# Verificar se está rodando como root
if [ "$(id -u)" -ne 0 ]; then
    erro "Este script precisa ser executado como root"
fi

# Verificar se o sistema é Ubuntu 20.04
if ! grep -q "Ubuntu 20.04" /etc/os-release; then
    aviso "Este script foi testado apenas em Ubuntu 20.04"
fi

# Atualizar o sistema
aviso "Atualizando o sistema..."
apt update && apt upgrade -y || erro "Falha ao atualizar o sistema"

# Instalar dependências
aviso "Instalando dependências..."
apt install -y nginx git curl wget || erro "Falha ao instalar dependências"

# Configurar Nginx
aviso "Configurando Nginx..."
cat > /etc/nginx/sites-available/beonsafe << 'EOF'
server {
    listen 80;
    server_name setup.beonsafe.com.br;

    root /var/www/setup.beonsafe.com.br;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location /beonsafe_script.sh {
        alias /var/www/setup.beonsafe.com.br/beonsafe_script.sh;
        default_type application/octet-stream;
    }
}
EOF

# Ativar o site
ln -sf /etc/nginx/sites-available/beonsafe /etc/nginx/sites-enabled/
nginx -t || erro "Configuração do Nginx inválida"
systemctl restart nginx || erro "Falha ao reiniciar Nginx"

# Criar diretório do site
aviso "Criando estrutura de diretórios..."
mkdir -p /var/www/setup.beonsafe.com.br || erro "Falha ao criar diretório"

# Copiar arquivos
aviso "Copiando arquivos..."
cp Beonsafesetup/beonsafe_script.sh /var/www/setup.beonsafe.com.br/ || erro "Falha ao copiar script"
cp -r Beonsafesetup/SetupBeonsafe /var/www/setup.beonsafe.com.br/ || erro "Falha ao copiar SetupBeonsafe"
cp index.html /var/www/setup.beonsafe.com.br/ || erro "Falha ao copiar index.html"

# Configurar permissões
aviso "Configurando permissões..."
chmod +x /var/www/setup.beonsafe.com.br/beonsafe_script.sh
chmod +x /var/www/setup.beonsafe.com.br/SetupBeonsafe/SetupBeonsafe
chown -R www-data:www-data /var/www/setup.beonsafe.com.br

# Configurar SSL (opcional)
aviso "Deseja configurar SSL com Let's Encrypt? (s/n)"
read -r resposta
if [ "$resposta" = "s" ]; then
    apt install -y certbot python3-certbot-nginx
    certbot --nginx -d setup.beonsafe.com.br
fi

sucesso "Deploy concluído com sucesso!"
aviso "Acesse http://setup.beonsafe.com.br para verificar a instalação"
