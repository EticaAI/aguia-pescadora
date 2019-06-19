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
#              Nesta documentação, resumidamente, você precisará instalar na sua
#              sua máquina local:
#                1.1 Par de chave SSH sem senha (isso é necessário em 2.1!)
#                1.2 Instalar Docker
#                1.3 Instalar Docker Engine
#
#              Nesta documentação, resumidamente, você precisará preparar o
#              seguinte em todos os servidores remotos
#                2.1 Ter uma chave privada (sem senha) previamente autorizada
#
# -----------------------------------------------------------------------------#
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

#### 1.1. CHAVES SSH: Par de chave SSH sem senha _______________________________
### @see https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html

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

# **************** COMO PEDIR AJUDA SE A ETAPA 1.1. DER ERRADO *************** #
# Em fóruns ou no Bing (que diferente do google até tem via free basics)
# você pode procurar por 'como criar chave SSH + NomeDoMeuSistemaOperacional'
#
# Nota: JAMAIS compartilhe com outras pessoas o arquivo que na primeira linha
#       dele tem '-----BEGIN RSA PRIVATE KEY-----'. Este arquivo deve ser
#       secreto e jamais sair do seu computador. Se você sem querer compartilhou
#       ele, precisará refazer sua chave e remover todos os locais que a versão
#       publica dele davam acesso
#

#### 1.2. DOCKER: Instalar Docker ______________________________________________
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

# **************** COMO PEDIR AJUDA SE A ETAPA 1.2. DER ERRADO *************** #
# Em fóruns de ajuda, pergunte:
# Como instalo docker no 'NOME DO SEU SISTEMA OPERACIONAL'? Tentei desse modo...

#### 1.3. DOCKER: Instalar Docker Engine _______________________________________
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

# **************** COMO PEDIR AJUDA SE A ETAPA 1.3. DER ERRADO *************** #
# Em fóruns de ajuda, pergunte:
# Como instalo Docker Engine no 'NOME DO SEU SISTEMA OPERACIONAL'? Tentei desse modo...



#.....
#### CHAVE SSH: adiciona em aguia-pescadora.etica.ai ___________________________

cat ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub
# Copie o conteúdo, logue em charlie
ssh root@aguia-pescadora-charlie.etica.ai

# cole o conteúdo ao final da ~/.ssh/authorized_keys
vim ~/.ssh/authorized_keys
exit

# Teste se a chave está funcionando. O Seguinte comando deve funcionar
# SEM pedir senha (nem de servidor remoto, nem de chave SSH)
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-charlie.etica.ai