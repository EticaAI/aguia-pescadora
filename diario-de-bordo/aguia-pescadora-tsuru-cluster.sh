# TODO: organizar melhor esse diario de bordo... (fititnt, 2019-06-20 03:30 BRT)

# Delta: 173.249.10.99
# Echo: 167.86.127.220
# Foxtrot: 167.86.127.225

## Ao menos de um administrador
ssh-copy-id -i ~/.ssh/id_rsa-rocha-eticaai-2019.pub root@aguia-pescadora-delta.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-rocha-eticaai-2019.pub root@aguia-pescadora-echo.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-rocha-eticaai-2019.pub root@aguia-pescadora-foxtrot.etica.ai

## Key do Tsuru
ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-delta.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-echo.etica.ai
ssh-copy-id -i ~/.ssh/id_rsa-aguia-pescadora-tsuru.pub root@aguia-pescadora-foxtrot.etica.ai

## Teste Key do Tsuru
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-delta.etica.ai
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-echo.etica.ai
ssh -i ~/.ssh/id_rsa-aguia-pescadora-tsuru root@aguia-pescadora-foxtrot.etica.ai

## diario-de-bordo/tsuru-inicializacao/seu-computador.sh
# Depois de preparar todas as etapas, este comando inicializa um cluster
tsuru install-create -c config.yml

#------------------------------------------------------------------------------#
# SEÇÃO TSURU: PLATAFORMAS                                                     #
#------------------------------------------------------------------------------#
# @see Lista de plataformas padrões do Tsuru: https://github.com/tsuru/platforms
# @see Exemplos de uso destas: https://github.com/tsuru/platforms/tree/master/examples

## Prepara plataforma Cordova
tsuru platform-add cordova

## Prepara plataforma Elixir
tsuru platform-add elixir

## Prepara plataforma Go
tsuru platform-add go

## Prepara plataforma Java
tsuru platform-add java

## Prepara plataforma NodeJS
tsuru platform-add nodejs

## Prepara plataforma PHP
tsuru platform-add php

## Prepara plataforma Python
tsuru platform-add python

## Prepara plataforma Ruby
tsuru platform-add ruby

## Prepara plataforma static
tsuru platform-add static


#------------------------------------------------------------------------------#
# SEÇÃO MVP DE HTTPS DE *.ETICA.DEV                                            #
#------------------------------------------------------------------------------#
# @see https://github.com/EticaAI/aguia-pescadora/issues/10
# @see https://github.com/EticaAI/aguia-pescadora/issues/14
# @see https://certbot.eff.org/docs/using.html#manual
# @see https://github.com/certbot/certbot/issues/5724#issuecomment-373018527

#### Let's Encrypt Wildcard SSL para *.etica.dev _______________________________

# Os comandos dessa sesão são executados em uma maquina que tenha Docker
# instalado. No caso estou usando meu Notebook e (ao menos neste momento)
# salvando em uma pasta que não é salva no repositório do git.
# Troque as pastas do computador local ou volume docker que guardarão os
# arquivos (primeira parte do -v) para o seu caso e adapte os
# valores -d "etica.dev" -d "*.etica.dev" para o seu caso

docker run -it --rm --name certbot \
-v "/alligo/code/eticaai/aguia-pescadora/segredos/certbot/etc/letsencrypt:/etc/letsencrypt" \
-v "/alligo/code/eticaai/aguia-pescadora/segredos/certbot/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/certbot \
certonly --manual --preferred-challenges dns-01 --agree-tos --server https://acme-v02.api.letsencrypt.org/directory \
-d "etica.dev" -d "*.etica.dev"


## ATENÇÃO! Como são 2 domínios o desafio na primeira vez irá pedir para
#           adicionar duas entradas para o registro do tipo TXT do seu DNS.
#           Sim, é possível fazer isso, porém a interface do seu provedor
#           pode ter uma forma diferente das outras.

## ATENÇÂO 2: se puder colocar um TTL, procure colocar baixo, visto que se errar
#             testando pode demorar para limpar os caches de DNS. No meu caso
#             tive que esperar pelo menos ns 90 segundos

# O comando a seguir poderia ser usado para depurar quais valores o DNS server
# estaria retornando. Os servidores do Let's Encrypt potencialmente podem usar
# outros com cache mais baixo
dig _acme-challenge.etica.dev txt

### temporario, documentar depois ______________________________________________
# Testes rapidos aqui

tsuru cname-add tsuru-dashboard.app.etica.dev -a tsuru-dashboard
# cname successfully defined.
# fititnt at bravo in /alligo/code/eticaai/aguia-pescadora/diario-de-bordo/tsuru-inicializacao on git:master x [1:32:31]
tsuru app list                                                  
##+-----------------+-----------+--------------------------------------+
##| Application     | Units     | Address                              |
##+-----------------+-----------+--------------------------------------+
##| tsuru-dashboard | 1 started | tsuru-dashboard.app.etica.dev        |
##|                 |           | tsuru-dashboard.173.249.10.99.nip.io |
##+-----------------+-----------+--------------------------------------+

## Visite https://tsuru-dashboard.app.etica.dev/