# BeonSafe - Sistema de Configuração Automatizada

## Descrição

O BeonSafe é um sistema de configuração automatizada que facilita a instalação e configuração de ambientes de desenvolvimento com Docker e ferramentas relacionadas. O sistema é composto por dois scripts principais que trabalham em conjunto para fornecer uma experiência de configuração segura e eficiente.

## Requisitos do Sistema

- Ubuntu 20.04 (recomendado)
- Acesso root ou sudo
- Conexão com a internet
- 2GB de RAM (mínimo)
- 20GB de espaço em disco (mínimo)

## Estrutura do Projeto

```
BeonSafe/
├── SetupBeonsafe          # Script principal com menu interativo
├── beonsafe_script.sh     # Script de inicialização
└── README.md             # Este arquivo de documentação
```

## Scripts

### 1. beonsafe_script.sh

Este é o script de inicialização que prepara o ambiente para a instalação.

#### Funcionalidades:

- Verifica a versão do Ubuntu
- Instala dependências básicas:
  - sudo
  - apt-utils
  - dialog
  - jq
  - apache2-utils
  - git
  - python3
  - neofetch
- Realiza atualizações do sistema
- Baixa e executa o script principal

### 2. SetupBeonsafe

Este é o script principal que oferece um menu interativo para instalação de componentes.

#### Opções do Menu:

1. **Instalar Docker**

   - Instala o Docker Engine
   - Configura repositórios oficiais
   - Adiciona usuário ao grupo docker

2. **Instalar Portainer**

   - Instala o Portainer CE
   - Configura volumes persistentes
   - Expõe portas 8000 e 9443

3. **Instalar Watchtower**

   - Instala o Watchtower
   - Configura atualizações automáticas
   - Define intervalo de verificação (24 horas)

4. **Instalar Pacotes Essenciais**

   - curl
   - wget
   - git
   - htop
   - net-tools
   - zip
   - unzip
   - nano
   - vim
   - python3
   - python3-pip
   - jq

5. **Instalar Todos**
   - Executa todas as instalações acima em sequência

## Como Usar

1. Clone o repositório:

```bash
git clone https://github.com/beonsafe/SetupBeonsafe.git
```

2. Execute o script de inicialização:

```bash
cd SetupBeonsafe
chmod +x beonsafe_script.sh
./beonsafe_script.sh
```

3. Siga as instruções na tela para instalar os componentes desejados.

## Recursos de Segurança

- Verificação de versão do sistema operacional
- Instalação de pacotes apenas de repositórios oficiais
- Configuração segura do Docker
- Atualizações automáticas via Watchtower

## Suporte

Para suporte, abra uma issue no repositório do GitHub ou entre em contato com a equipe BeonSafe.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.

## Contribuição

Contribuições são bem-vindas! Por favor, leia o arquivo CONTRIBUTING.md para detalhes sobre nosso código de conduta e o processo para enviar pull requests.
