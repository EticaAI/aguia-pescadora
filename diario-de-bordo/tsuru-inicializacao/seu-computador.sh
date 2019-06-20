echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
######################## Diario de bordo: seu-computador #######################
# Seu Computador (testado em um Ubuntu 16.04 LTS), acesso á internet (não muito caso você já deixe instalado docker & docker-engine antes)
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
#                1.9 Ordena instação do Tsuru remotamente
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

ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-charlie.etica.ai
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
wget https://github.com/tsuru/tsuru-client/releases/download/1.7.0-rc1/tsuru_1.7.0-rc1_linux_amd64.tar.gz

# O comando a seguir descompacta o arquivo baixado
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
# No seu caso já pode ser uma versão diferente.
#   tsuru version 1.7.0-rc1.
# No seu pode ser diferente

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

# Veja o arquivo tsuru-inicializacao.log nesta mesma pasta para ver o log que
# gerou a instalação inicial.

#### TSURU 1.9: Primeiro login administrativo no Tsuru _________________________

# Ao acessar a página http://173.249.10.99:8080/, tivemos este resultado a
# seguir. Ele está em inglês, mas vou comentar em português caso você não saiba
# e não tenha tradutor automático neste momento.

# ............................................................................ #
##
## Welcome to tsuru!
## tsuru is an open source PaaS, that aims to make it easier for developers to run their code in production.
##
## Installing
## Our documentation contains a guide for installing tsuru clients using package managers on Mac OS X, Ubuntu and ArchLinux, or build from source on any platform supported by Go: docs.tsuru.io/en/stable/using/install-client.html.
##
## Please ensure that you install the tsuru client, and then continue this guide with the configuration, user and team creation and the optional SSH key handling.
##
## Configuring
## In order to use this tsuru server, you need to add it to your set of targets:
##
## $ tsuru target-add default http://173.249.10.99:8080 -s
## tsuru supports multiple targets, the -s flag tells the client to add and set the given endpoint as the current target.
##
## Create a user
## After configuring the tsuru target that you wanna use, it's now needed to create a user:
##
## $ tsuru user-create <your-email>
## The command will as for your password twice, and then register your user in the tsuru server.
##
## After creating your user, you need to authenticate with tsuru, using the tsuru login command.
##
## $ tsuru login
## It will ask for your email and password, you can optionally provide your email as a parameter to the command.
##
## Ensure you're member of at least one team
## In order to create an application, a user must be member of at least one team. You can see the teams that you are a member of by running the team-list command:
##
## $ tsuru team-list
## If this command doesn't return any team for you, it means that you have to create a new team before creating your first application:
##
## $ tsuru team-create <team-name>
## Build and deploy your application
## Now you're ready to deploy an application to this tsuru server, please refer to the tsuru documentation for more details: docs.tsuru.io/en/stable/using/python.html.
# ............................................................................ #

# No meu caso, como admin, provavelmente o Tsuru já fez isso por mim, porém
# outros usuários talvez teriam que fazê-lo. Creio que é algo que teremos
# que documentar para o Águia Pescadora. A seguir o aviso que eu tenho
# fititnt at bravo in /alligo/code/eticaai/aguia-pescadora/diario-de-bordo/tsuru-inicializacao on git:master x [20:39:36]
# $ tsuru target-add default http://173.249.10.99:8080 -s
# Error: Target label provided already exists

# O comando a seguir cria o primeiro usuario. Vou usar meu e-mail, mas você
# deveria usar o seu. Ele vai pedir senha e reconfirmação
tsuru user-create rocha@ieee.org
# Resultado:
#  Password:
#  Confirm:
#  User "rocha@ieee.org" successfully created!

# O próximo comando é para se logar no Tsuru remoto padrão (no caso temos apenas
# um, a Charlie movi para outra pasta no meu ~/.tsuru). O comando 'tsuru login'
# Também pode aceitar o e-mail como parâmetro, mas vou usar sem nesse momento
tsuru login
# Resultado
#   Email: rocha@ieee.org
#   Password:
#   Successfully logged in!

# Vamos ver se já existe algum time criado
tsuru team-list
# Resposta: vazio (não tem times existentes)

# Conforme documentação, seria necessario criar um time, porém tenho erro sem
# informação extra além de 'Error:'
tsuru team-create EticaAI
# Resultado
#   Error:

# E sim, também estou documentando meu passo a passo porque pode servir para
# reportar depois para o time do Tsuru o que pode ser melhorado na documentação
# da versão atual

# Tentando dar permissão total para meu usuário, talvez seja isso que esteja
# impedindo seguir adiante.
tsuru role-assign AllowAll rocha@ieee.org
# Error: You don't have permission to do this action

# Humm... isso funcionou com a Charlie em https://github.com/fititnt/cplp-aiops/blob/master/logbook/aguia-pescadora-charlie.sh
# porém a versão do Tsuru era a stable 1.6.0. A atual 1.7.0-rc1.