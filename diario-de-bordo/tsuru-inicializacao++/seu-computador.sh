echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
############ Diario de bordo: tsuru-inicializacao++/seu-computador #############
# Seu Computador (testado em um Ubuntu 16.04 LTS), acesso à internet (não muito caso você já deixe instalado docker & docker-engine antes)
#
#
# DESCRIPTION: MPV de inicialização de Tsuru ++ (com opções extras)
#
#              AVISO IMPORTANTE: Diferente da documentação na qual este é
#              baseado (diario-de-bordo/tsuru-inicializacao/seu-computador.sh)
#              este guia poderá ter informações extras não tão detalhadamente
#              documentadas. Porém pode servir para entender outras evoluções
#              que o Águia Pescadora passou logo depois do MVP.
#
#              Explica como usar seu computador e o tsuru-client para
#              inicializar um cluster remoto. Provavelmente poderia funcionar
#              feito até mesmo de um computador com Windows, porém os comandos
#              podem precisar ser adaptados.
#
#              Você ainda não tem servidores remoto, mas quer testar? Sim, é
#              possível! veja o arquivo nesta mesma pasta chamado de
#                - diario-de-bordo/tsuru-inicializacao/seu-computador-virtualbox-local.sh
#
#              Você até tem servidores remotos, mas é sua primeira vez? Super
#              recomendo testar primeiro a versão simples do MPV, que está em
#                - diario-de-bordo/tsuru-inicializacao/seu-computador.sh
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
#                1.7++ Customiza Tsuru para instalar em 3 nós
#                1.8++ Ordena instação do Tsuru remotamente
#                1.9++ Cria super administrador e faz um Olá Mundo do Tsuru
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

# ............................................................................ #
#### 1.1a. CHAVES SSH: Criar chave SSH sem senha _______________________________
#### 1.2. CHAVES SSH 2: autorizar chave em todos os nós remotos de Tsuru _______
#### 1.3. DOCKER: Instalar Docker ______________________________________________
#### 1.4. DOCKER: Instalar Docker Engine _______________________________________
#### 1.5. TSURU: Instalar Tsuru Client _________________________________________
#### TSURU 1.6: Gerar configurações com 'tsuru install-config-init' (opcional) _

# NOTA: veja diario-de-bordo/tsuru-inicializacao++/seu-computador.sh para todos
#       os passos comuns entre este guia com opções extras eo guia de produto
#       mínimo viável do Tsuru (fititnt, 2019-06-22 19:23 BRT)
# ............................................................................ #

#### TSURU 1.7a: Customiza Tsuru para instalar em 3 nós ________________________
