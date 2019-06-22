echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
############## Diario de bordo: tsuru-inicializacao/seu-computador #############
# Seu Computador (testado em um Ubuntu 16.04 LTS), acesso à internet (não muito caso você já deixe instalado docker & docker-engine antes)
#
# DESCRIPTION: Explica como usar seu computador e o tsuru-client para
#              inicializar um cluster remoto. Provavelmente poderia funcionar
#              feito até mesmo de um computador com Windows, porém os comandos
#              podem precisar ser adaptados.
#
#              Você ainda não tem servidores remoto, mas quer testar? Sim, é
#              possível! veja o arquivo nesta mesma pasta chamado de
#                - seu-computador-virtualbox-local.sh
#
#              Baseado no arquivo que instalou a Águia Pescadora Charlie:
#                - https://github.com/fititnt/cplp-aiops/blob/master/logbook/devel-fititnt-bravo.sh
#
#              Caso você queira instalar em 1 servidor (em vez de 3, como nosso
#              exemplo) recomendamos que veja o fititnt/cplp-aiops ou o
#              arquivo config-charlie(uma-maquina-remota-com-tudo).yml
#
#              Nesta documentação, resumidamente, você fará os seguintes passos:
#                1.1a Criar chave SSH sem senha
#                1.2 Autorizar chave em todos os nós remotos de Tsuru
#                1.3 Instalar Docker
#                1.4 Instalar Docker Engine
#                1.5 Instalar Tsuru Client
#                1.6 Gerar configurações com 'tsuru install-config-init' (opcional)
#                1.7a Customiza Tsuru para instalar em 3 nós
#                1.8a Ordena instação do Tsuru remotamente
#                1.9 Cria super administrador e faz um Olá Mundo do Tsuru
#
#              O arquivo a seguir assume 3 máquinas remotas (nosso caso)
#                config.yml
#              Este outro arquivo assume que você teria interesse em um nó com
#              tudo
#                config-charlie(uma-maquina-remota-com-tudo).yml
#
# ---------------------------------------------------------------------------- #
# Tsuru Cluster
# - 3 VPSs [CPU: 14][RAM: 32GB][Disco: 800GB SSD][Custo Mesal: < 100 BRL]
# - Nó com Tsuru: Delta (não exclusivo)
#     - Um dos motivos de escolher Delta (que tem dobro de potencia das demais)
#       é também que se eventualmente o cluster tiver que ser reduzido (ex.
#       ainda não ser tão usado para justificar tanta potencia) a gente poderia
#       permanecer apenas com a Delta e só recriar outras no futuro)
#
# VPSs
# - Águia Pescadora Delta: aguia-pescadora-delta.etica.ai
#     - VPS (KVM), 6 vCPUs, 16GB RAM, 400GB SSD, Ubuntu Server 18.04 64bit, Contabo (Germany)
#     - Diário de Bordo: https://github.com/EticaAI/aguia-pescadora/blob/master/diario-de-bordo/delta.sh
# - Águia Pescadora Echo: aguia-pescadora-echo.etica.ai
#     - VPS (KVM), 4 vCPUs, 8GB RAM, 200GB SSD, Ubuntu Server 18.04 64bit, Contabo (Germany)
#     - Diário de Bordo: https://github.com/EticaAI/aguia-pescadora/blob/master/diario-de-bordo/echo.sh
# - Águia Pescadora Foxtrot: aguia-pescadora-foxtrot.etica.ai
#     - VPS (KVM), 4 vCPUs, 8GB RAM, 200GB SSD, Ubuntu Server 18.04 64bit, Contabo (Germany)
#     - Diário de Bordo: https://github.com/EticaAI/aguia-pescadora/blob/master/diario-de-bordo/foxtrot.sh
#
# ---------------------------------------------------------------------------- #
# LICENSE: Public Domain
#   Except where otherwise noted, content on this server configuration and to
#   the extent possible under law, Emerson Rocha has waived all copyright and
#   related or neighboring rights to this work to Public Domain
#
# MAINTAINER: Emerson Rocha <rocha(at)ieee.org>
#   Keep in mind that several people help with suggestions, testing, bugfixes
#   and inspiration without get names noted in places that most software
#   developers look. I'm saying this in special for people who help over
#   Facebook discussions. Even the ones without a personal computer yet and/or
#   with limited access to internet.
#
# SECURITY:
#   Reporting a Vulnerability:
#   Send e-mail to Emerson Rocha: rocha(at)ieee.org.
################################################################################

#### 1.1a. CHAVES SSH: Criar chave SSH sem senha ________________________________
### @see https://www.digitalocean.com/community/tutorials/como-configurar-chaves-ssh-no-ubuntu-18-04-pt
### @see https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# O Tsuru por padrão tem suporte mais facilitado para alguns IaaS mais populares
# do mercado, como a Amazon Web Services e a Digital Ocean. Porém em especial
# a AWS e Azure podem ser muito, mas muito caros, tão caros que manter servidor
# ligado o tempo todo, sem autoscaling, é mais barato. Por isso vamos usar
# a forma "generica" que serve para IaaS que não tem API pronta no Tsuru

# Assumindo que você queira criar um par de chaves exclusivo para iniciar
# seu cluster em vez de reusar uma que já esteja em ~/.ssh/id_rsa.pub, os
# passos a seguir explicam como a da Aguia Pesquisadora foram criadas.

# Note: troque "aguia-pescadora-tsuru.no-reply@etica.ai" e id_rsa-aguia-pescadora-tsuru
#       para algo diferente. Mas esta chave não pode ser senha.
#       mais tarde (após o tsuru terminar de configurar a máquina) você pode
#       remover ela do servidor remoto e só usar alguma outra pessoal para fazer
#       ssh no dia a dia
ssh-keygen -t rsa -b 4096 -C "aguia-pescadora-tsuru.no-reply@etica.ai" -f ~/.ssh/id_rsa-aguia-pescadora-tsuru

# O comando acima irá gerar arquivos nos locais
# Private key: ~/.ssh/id_rsa-aguia-pescadora-tsuru
# Public key: ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub

# **************** COMO PEDIR AJUDA SE A ETAPA 1.1a. DER ERRADO *************** #
# Em fóruns ou no Bing (que diferente do google até tem via free basics)
# você pode procurar por 'como criar chave SSH + NomeDoMeuSistemaOperacional'
#
# Nota: JAMAIS compartilhe com outras pessoas o arquivo que na primeira linha
#       dele tem '-----BEGIN RSA PRIVATE KEY-----'. Este arquivo deve ser
#       secreto e jamais sair do seu computador. Se você sem querer compartilhou
#       ele, precisará refazer sua chave e remover todos os locais que a versão
#       publica dele davam acesso

#### 1.2. CHAVES SSH 2: autorizar chave em todos os nós remotos de Tsuru _______
### @see https://www.digitalocean.com/community/tutorials/como-configurar-chaves-ssh-no-ubuntu-18-04-pt
### @see https://linux.die.net/man/1/ssh-copy-id
### @see Execute o comando 'man ssh-copy-id' para ler o manual

# O conteúdo da chave pública (geralmente termina com .pub) deve estar em todos
# os servidores que você quer que o tsuru acesse mais tarde no arquivo
# /root/.ssh/authorized_keys

# Uma forma de copiar sua chave publica é usando o programa ssh-copy-id.
# Troque 'aguia-pescadora-tsuru' e root@aguia-pescadora-XXXXXX.etica.ai para
# sua respectiva chave publica e servidor remoto

ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-delta.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-echo.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-foxtrot.etica.ai

# Teste se a chave está funcionando. O Seguinte comando deve funcionar
# SEM pedir senha para cada um dos servidores remotos que você quer instalar
# o Tsuru. Aqui nosso exemplo

ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-delta.etica.ai
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-echo.etica.ai
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-foxtrot.etica.ai

# **************** COMO PEDIR AJUDA SE A ETAPA 1.2. DER ERRADO *************** #
# Suas perguntas tenderão a ser "SSH sem senha". Esse tipo de coisa pelo menos
# em grupos maiores tende a ter alguém para ajudar você. Assim como dito
# no passo 1.1, não deixe o arquivo '-----BEGIN RSA PRIVATE KEY-----' sair
# do seu computador.
#
# Um erro que talvez você tenha é ter copiado a chave publica errada. Por isso
# compare o arquivo /root/.ssh/authorized_keys em todos os servidores remotos.
# Em alguns casos, talvez o arquivo seja "authorized_keys2" em vez de
# "authorized_keys"

#### 1.3. DOCKER: Instalar Docker ______________________________________________
### @see https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Remova versões antigas de docker. Ok se o comando seguinte der erros de
# pacotes não encontrados
sudo apt remove docker docker-engine docker.io containerd runc

# Passo a passo de instalar docker, conforme
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli

# Ao final, você deve ter algo como isto aqui no seu terminal:
docker -v # Docker version 18.09.6, build 481bc77

# Outra forma melhor de testar se você tem docker é... rodando o hello world!
sudo docker run hello-world
# Exemplo de resposta:
# fititnt at bravo in /alligo/code/eticaai/aguia-pescadora on git:master o [22:50:15]
#    $ sudo docker run hello-world
#    [sudo] senha para fititnt:
#    Unable to find image 'hello-world:latest' locally
#    latest: Pulling from library/hello-world
#    1b930d010525: Pull complete
#    Digest: sha256:41a65640635299bab090f783209c1e3a3f11934cf7756b09cb2f1e02147c6ed8
#    Status: Downloaded newer image for hello-world:latest
#
#    Hello from Docker!
#    This message shows that your installation appears to be working correctly.
#
#    To generate this message, Docker took the following steps:
#     1. The Docker client contacted the Docker daemon.
#     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
#        (amd64)
#     3. The Docker daemon created a new container from that image which runs the
#        executable that produces the output you are currently reading.
#     4. The Docker daemon streamed that output to the Docker client, which sent it
#        to your terminal.
#
#    To try something more ambitious, you can run an Ubuntu container with:
#     $ docker run -it ubuntu bash
#
#    Share images, automate workflows, and more with a free Docker ID:
#     https://hub.docker.com/
#
#    For more examples and ideas, visit:
#     https://docs.docker.com/get-started/

# **************** COMO PEDIR AJUDA SE A ETAPA 1.3. DER ERRADO *************** #
# Em fóruns de ajuda, pergunte:
# Como instalo docker no 'NOME DO SEU SISTEMA OPERACIONAL'? Tentei desse modo...

#### 1.4. DOCKER: Instalar Docker Engine _______________________________________
### @see https://docs.docker.com/machine/install-machine/
### @see https://github.com/docker/machine/releases/

# SUPER DICA PAR USUÁRIOS MAC E WINDOWS: Diferente de Ubuntu, talvez seu tipo
# de instalação Docker já tenha instalado o docker-machine. Então esse
# passo seria opcional para você.
# Aparentemente usuários de Windows e de Mac já vem com docker-machine
# instalado, mas não os de Ubuntu (meu caso aqui).

# Veja https://github.com/docker/machine/releases/ e instale a ultima versão.
# A seguir os comandos executados na versão mais atual em que se escreveu este
# guia

curl -L https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
  chmod +x /tmp/docker-machine &&
  sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

# Nota: o comando acima não funciona de primeira no terminal fish (use bash e zsh)
#       se você não sabe o que é fish ou zsh, provavelmente está usando bash
#       que é o padrão do Ubuntu.

# Execute o comando a seguir para ver se tem está com docker-machine operacional
docker-machine -v  # docker-machine version 0.16.1, build cce350d7

# **************** COMO PEDIR AJUDA SE A ETAPA 1.4. DER ERRADO *************** #
# Em fóruns de ajuda, pergunte:
# Como instalo Docker Engine no 'NOME DO SEU SISTEMA OPERACIONAL'? Tentei desse modo...

#### 1.5. TSURU: Instalar Tsuru Client _________________________________________
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html
### @see https://tsuru-client.readthedocs.io/en/latest/installing.html
### @see https://github.com/tsuru/tsuru-client/releases

# É aqui que a máquica começa! Um usuário de Tsuru comum precisaria apenas
# do tsuru client (ou mesmo quem faz via git, nem mesmo tsuru client) mas você
# já deixou chaves prontas em servidores remotos, instalou docker e
# docker-machine porque você não é apenas um usuário comum, você está criando
# seu próprio cluster!

# Vá para uma pasta temporaria qualquer no seu computador local. nesse exemplo
# usamos ~/tmp
cd ~/tmp

# Conforme https://tsuru-client.readthedocs.io/en/latest/installing.html
# a documentação dará várias alternativas de como instalar o Tsuru client
# em seu sistema operacional. Em https://github.com/tsuru/tsuru-client/releases
# tem até mesmo executável para windows. No caso específico deste guia
# está sendo usado localmente um Ubuntu 16.04, e, ao menos neste momento,
# uma das opções recomendadas do Tsuru Client via uso de
# 'sudo apt-add-repository ppa:tsuru/ppa' está desatualziada o suficiente
# para recomendarmos que baixe o binário. Talvez ele mude no futuro, então
# se faz muito tempo desde que esse guia foi criado pode valer a pena
# olhar documentação oficial.

# Comentarios feitos, neste momento exato, 2019-06-19 01:00 BRT, em
# https://github.com/tsuru/tsuru-client/releases é escolhido o seguinte
## wget https://github.com/tsuru/tsuru-client/releases/download/1.6.0/tsuru_1.6.0_linux_amd64.tar.gz
wget https://github.com/tsuru/tsuru-client/releases/download/1.7.0-rc1/tsuru_1.7.0-rc1_linux_amd64.tar.gz

# O comando a seguir descompacta o arquivo baixado
# tar -vzxf tsuru_1.6.0_linux_amd64.tar.gz
tar -vzxf tsuru_1.7.0-rc1_linux_amd64.tar.gz

## fititnt at bravo in ~/tmp [1:04:49]
# $ tree
# .
# ├── misc
# │   ├── bash-completion
# │   └── zsh-completion
# ├── tsuru

# O arquivo 'tsuru' deve ser adicionado ao seu PATH. No caso do Ubuntu, pode
# simplesmente mover ele para algum outro lugar, como /usr/local/bin, com
# o segunte comando
sudo mv tsuru /usr/local/bin

# Feito isso, teste com o seguinte comando qual versão do seu tsuru client
tsuru --version
# tsuru version 1.7.0-rc1.

# Opcional: se quiser pode adicionar misc/bash-completion para autocompletar
#           alguns comandos caso seu terminal seja bash e misc/zsh-completion
#           se for zsh. Na maioria das distribuições linux tende a ser bash

# **************** COMO PEDIR AJUDA SE A ETAPA 1.5. DER ERRADO *************** #
# Diferente de docker e outros passos, o número de pessoas que tem experiencia
# mínima com Tsuru ao ponto de crar algo como você está fazendo é menor.
# Além da documentação oficial (e também com alguém da Etica.AI) como
# Emerson Rocha, você pode ver os canais oficiais em https://tsuru.io/. Um nesse
# caso é o Gitter em https://gitter.im/tsuru/tsuru. A maioria das pessoas lá
# irá falar em inglês, porém a maioria dos criadores do Tsuru também fala
# português pois são do Brasil.

#### TSURU 1.6: Gerar configurações com 'tsuru install-config-init' (opcional) _
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html#installing-on-already-provisioned-or-physical-hosts
### @see https://docs.docker.com/machine/drivers/generic/

# Vá para uma pasta temporaria qualquer no seu computador local. nesse exemplo
# usamos ~/tmp
cd ~/tmp

tsuru install-config-init
# Dois arquivos serão gerados, vide
# $ tree
# .
# ├── install-compose.yml
# └── install-config.yml

# Tradução rapida da documentação oficial sobre os arquivos
#   "Isso gerará dois arquivos no diretório atual: install-config.yml e
#   install-compose.yml. No primeiro, você pode definir o driver da máquina de
#   encaixe e configurações como a CPU e a memória da máquina e configurações
#   específicas de tsuru, como o aprovisionador padrão, portas HTTP / HTTPS,
#   cotas de usuários e ativar ou desativar o painel. O segundo arquivo inclui
#   configurações para cada componente tsuru, como redis e gandalf. Você pode
#   alterar configurações como versão, porta e montagens para cada um."

# DICA: caso queira ver os arquivos que a minha versão criou e não foram
#       customizados eles estão em
#       diario-de-bordo/tsuru-inicializacao/config-init-padrao-sem-edicao

# DICA: caso queira ver outros exemplos de arquivos, veja a própria documentação
#       em https://docs.tsuru.io/stable/installing/using-tsuru-installer.html
#       Ela tem pelo menos 3 exemplos, um deles assume que você usa o IaaS
#       Amazon Web Servces e o outro que usa a Digital Ocean. No nosso caso
#       O melhor exemplo que você deve se basear é o
#       "Installing on already provisioned (or physical) hosts" e os links:
#       - https://docs.tsuru.io/stable/installing/using-tsuru-installer.html#installing-on-already-provisioned-or-physical-hosts
#       - https://docs.docker.com/machine/drivers/generic/

#### TSURU 1.7a: Customiza Tsuru para instalar em 3 nós ________________________
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html#installing-on-already-provisioned-or-physical-hosts

# Por favor, veja o arquivo config.yml. Ele contém informações adicionais que
# não estão neste arquivo.
vim config.yml

# Dica 1: se você estiver procurando instalar apenas em uma máquina remota veja
# config-charlie(uma-maquina-remota-com-tudo).yml

# Dica 2: se nem mesmo tem uma máquina remota, veja
# seu-computador-virtualbox-local.sh

#### TSURU 1.8a: Ordena instação do Tsuru remotamente __________________________
tsuru install-create -c config.yml

# Veja arquivo tsuru-inicializacao.log nesta mesma pasta para ver log completo
# Demorou em torno de 22 min (o tempo pode ser bem diferente, em especial
# conforme a velocidade da internet do servidor remoto)

#
# Resultado:
#
#   (uma lista grande de comandos. Aqui apenas o que aparece no final.)
#
#   --- Installation Overview ---
#   Core Hosts:
#   +---------------+-------+---------+
#   | IP            | State | Manager |
#   +---------------+-------+---------+
#   | 173.249.10.99 | ready | true    |
#   +---------------+-------+---------+
#   
#   Core Components:
#   +----------------+-------+----------+
#   | Component      | Ports | Replicas |
#   +----------------+-------+----------+
#   | tsuru_mongo    |       | 1        |
#   +----------------+-------+----------+
#   | tsuru_tsuru    | 8080  | 1        |
#   +----------------+-------+----------+
#   | tsuru_planb    | 80    | 1        |
#   +----------------+-------+----------+
#   | tsuru_redis    |       | 1        |
#   +----------------+-------+----------+
#   | tsuru_registry | 5000  | 1        |
#   +----------------+-------+----------+
#   Configured default user:
#   Username: admin@example.com
#   Password: %I6edx(senhade50caracterescomplexaaqui)oau8XC"t9#r
#   Apps Hosts:
#   +-----------------------------+---------+---------+----------------------------------+
#   | Address                     | IaaS ID | Status  | Metadata                         |
#   +-----------------------------+---------+---------+----------------------------------+
#   | https://167.86.127.220:2376 |         | ready   | LastSuccess=2019-06-22T06:07:37Z |
#   |                             |         |         | pool=theonepool                  |
#   +-----------------------------+---------+---------+----------------------------------+
#   | https://167.86.127.225:2376 |         | waiting | pool=theonepool                  |
#   +-----------------------------+---------+---------+----------------------------------+
#   | https://173.249.10.99:2376  |         | waiting | pool=theonepool                  |
#   +-----------------------------+---------+---------+----------------------------------+
#   Apps:
#   +-----------------+------------+--------------------------------------+
#   | Application     | Units      | Address                              |
#   +-----------------+------------+--------------------------------------+
#   | tsuru-dashboard | 1 starting | tsuru-dashboard.173.249.10.99.nip.io |
#   +-----------------+------------+--------------------------------------+

# Neste momento você pode entrar em uma URL que será parecida com a
# tsuru-dashboard.173.249.10.99.nip.io, com usuário admin@example.com
# e senha informada no final da instalação do usupario admin de exemplo

# No próximo passo você irá criar pelo menos um usuário administrador e fazer
# testes básicos na plataforma. Eventualmente poderá fazer outras customizações
# que vão além deste guia inicial, porém pelo menos você saberá que sim, é
# possível

#### TSURU 1.9: Cria super administrador e faz um Olá Mundo do Tsuru ___________

## TODO: as instruções nesta etapa provavelmente podem ser simplificadas
##       ou no mínimo deveriam ser revisadas por pessoas com mais experiência
##       no Tsuru. Se este aviso aidna estiver aqui, quer dizer que
##       não houve revisão por pelo menos outra pessoa diferente de Rocha
##       ou que as pessoas acreditaram ser aceitáveis para um setup inicial
##       do Tsuru.
##       (fititnt, 2019-06-24 02:48 BRT)

# Na porta 8080 do seu IP (no meu caso http://173.249.10.99:8080/) é possível
# ver um guia rápido de como usar o Tsuru (ele está em inglês). Uma versão
# arquivada do que eu pude ver está em http://archive.is/UhpSl.

# Como você acabou de criar um cluster de Tsuru por padrão estará autenticado
# com o usuário admin@example.com. Use o comando a seguir para ter certeza

tsuru user-info
# Resposta
#   Email: admin@example.com
#   Roles:
#   	AllowAll(global)
#   Permissions:
#   	*(global)

# Vamos trocar a senha padrão desse 'admin@example.com' (deletar esse usuário
# depois de criar um novo poderia ser opção melhor). Note que o comando a seguir
# vai pedir primeiro sua senha atual ('Current password'), que provavelmente
# será 'admin@example.com' (sem aspas). Depois disso você precisa colocar
# uma senha nova duas vezes.
tsuru change-password
# Resposta
#   Current password:
#   New password:
#   Confirm:
#   Password successfully updated!

# Vamos criar ao menos um super administrador (troque 'rocha@ieee.org' para o
# SEU seu e-mail a partir daqui)
tsuru user-create rocha@ieee.org
# Resultado:
#   Password:
#   Confirm:
#   User "rocha@ieee.org" successfully created!

# Vamos colocar esse administrador também com permissões liberadas
tsuru role-assign AllowAll rocha@ieee.org
# Resultado:
#   Role successfully assigned!

## TODO: talvez a melhor forma de fazer isso seria adicionar rocha@ieee.org
##       ao grupo admin? Checar com outras pessoas.
##       (fititnt, 2019-06-21 02:52 BRT)

## O próximo comando adiciona o user rocha@ieee.org ao time 'admin'. Conforma
## TODO anterior, talvez isso seja redundante.
# tsuru team-user-add admin rocha@ieee.org
## Não, o Comando acima não funciona no tsuru 1.6. Até o momento em que esse
## guia é escrito, o mantenedor ainda não entendeu a fundo gerenciamento
## de times, e alguns comandos que funcionavam em versões antigas do Tsuru
## foram alterados/simplificados
##
## De qualquer forma, o comando 'tsuru role-assign AllowAll rocha@ieee.org'
## pelo menos permite que a gente siga em frente neste guia inicial.

## NOTA: parece que 'tsuru role-assign AllowAll rocha@ieee.org' implicitamente
##       adicionou o usuario ao team admin, conforme o que é exibido a seguir
##       (fititnt, 2019-06-21 03:10 BRT)
#
# $ tsuru team-info admin
# Team: admin
# Tags: []
# 
# Users: 2
# +-------------------+------------------+
# | User              | Roles            |
# +-------------------+------------------+
# | admin@example.com | AllowAll(global) |
# +-------------------+------------------+
# | rocha@ieee.org    | AllowAll(global) |
# +-------------------+------------------+
# 
# Applications: 1
# +-----------------+-----------+--------------------------------------+
# | Application     | Units     | Address                              |
# +-----------------+-----------+--------------------------------------+
# | tsuru-dashboard | 1 started | tsuru-dashboard.173.249.10.99.nip.io |
# +-----------------+-----------+--------------------------------------+

# Perfeito. Agora vamos logar com o novo usuario (que, note, este usuário
# antes de você logar já tem permissões liberadas) e a partir dele vamos
# gerenciar outras ações no Tsuru.
tsuru login rocha@ieee.org
tsuru user-info


#### TSURU 1.10: Prepara conta usuário de Tsuru ________________________________

## TODO: documentar o que deve ser feito para que outra pessoa que siga o que
#        é dito em computador-de-usuario.sh possa fazer o que for necessário
#        (fititnt, 2019-06-21 03:40 BRT)
