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

#### TSURU 1.7++: Customiza Tsuru para instalar em 3 nós _______________________
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html
### @see https://docs.tsuru.io/stable/installing/using-tsuru-installer.html#installing-on-already-provisioned-or-physical-hosts

# Dessa vez, vamos alterar portas usadas no Tsuru. Por isso apenas o arquivo
# config.yml / install-config.yml não seria suficiente
tsuru install-config-init
# $ tree
# .
# ├── install-compose.yml
# ├── install-config.yml
# └── seu-computador.sh



#### TSURU 1.8a: Ordena instação do Tsuru remotamente __________________________
tsuru install-create -c install-config.yml -e install-compose.yml
# NOTA: o tsuru não permite tentar recrear algo com mesmo nome das anteriores.
#       caso você REALMENTE não vai precisar de mais nada da anterior e já
#       deletou os servidores remotos e está recomeçando do zero, terá que
#       rodar o comando exato anterior, so que em vez de '-create' trocar por
#       '-remove'. Isto é, terá que usar 'tsuru install-remove -c config.yml'
#       Este comando apagará arquivos que estão em ~/.tsuru/installs com dados
#       de como acessar as máquinas antigas.

# Veja arquivo logs/tsuru-inicializacao++.log nesta mesma pasta para ver log
# completo. Demorou em torno de 47 min (o tempo pode ser bem diferente,
# em especial conforme a velocidade da internet do servidor remoto)

# NOTA MENTAL: Estranho. Eu lembro que anteriores chegou a demorar 22min.
#              dessa vez demorou mais. Além da versão do Tsuru Client
#              a principal alteração foi ter usado o arquivo
#              'install-compose.yml' explicito. (fititnt, 2019-06-22 20:49)

#
# Resultado:
#
#   (..lista longa...)
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
#   | tsuru_tsuru    | 8080  | 1        |
#   +----------------+-------+----------+
#   | tsuru_redis    |       | 1        |
#   +----------------+-------+----------+
#   | tsuru_mongo    |       | 1        |
#   +----------------+-------+----------+
#   | tsuru_registry | 5000  | 1        |
#   +----------------+-------+----------+
#   | tsuru_planb    | 82    | 1        |
#   +----------------+-------+----------+
#   Configured default user:
#   Username: admin@example.com
#   Password: <XGByem(Uma-Senha-Complexa-Aqui)lH8w)15zpi
#   Apps Hosts:
#   +-----------------------------+---------+---------+----------------------------------+
#   | Address                     | IaaS ID | Status  | Metadata                         |
#   +-----------------------------+---------+---------+----------------------------------+
#   | https://167.86.127.220:2376 |         | ready   | LastSuccess=2019-06-22T23:37:29Z |
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
# http://tsuru-dashboard.173.249.10.99.nip.io:82, com usuário admin@example.com
# e senha informada no final da instalação do usupario admin de exemplo

# NOTA: repare que nesta configuração, o PlanB está na porta 82, e não na 80.
#       como ainda não configuramos um proxy reverso, se quiser ver terá que
#       especificar a porta. Em breve vamos permitir também a porta 80.

# No próximo passo você irá criar pelo menos um usuário administrador e fazer
# testes básicos na plataforma. Eventualmente poderá fazer outras customizações
# que vão além deste guia inicial, porém pelo menos você saberá que sim, é
# possível

#### TSURU 1.9: Cria super administrador e faz um Olá Mundo do Tsuru ___________

# Na porta 8080 do seu IP (no meu caso http://173.249.10.99:8080/) é possível
# ver um guia rápido de como usar o Tsuru (ele está em inglês).

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

# O comando a seguir lista informações sobre o grupo admin
tsuru team-info admin
# Resposta:
#   Team: admin
#   Tags: []
#
#   Users: 2
#   +-------------------+------------------+
#   | User              | Roles            |
#   +-------------------+------------------+
#   | admin@example.com | AllowAll(global) |
#   +-------------------+------------------+
#   | rocha@ieee.org    | AllowAll(global) |
#   +-------------------+------------------+
#
#   Applications: 1
#   +-----------------+-----------+--------------------------------------+
#   | Application     | Units     | Address                              |
#   +-----------------+-----------+--------------------------------------+
#   | tsuru-dashboard | 1 started | tsuru-dashboard.173.249.10.99.nip.io |
#   +-----------------+-----------+--------------------------------------+

# Perfeito. Agora vamos logar com o novo usuario (que, note, este usuário
# antes de você logar já tem permissões liberadas) e a partir dele vamos
# gerenciar outras ações no Tsuru.
tsuru login rocha@ieee.org
tsuru user-info

#### TSURU 1.10: Prepara conta usuário de Tsuru ________________________________

## TODO: documentar o que deve ser feito para que outra pessoa que siga o que
#        é dito em computador-de-usuario.sh possa fazer o que for necessário
#        (fititnt, 2019-06-21 03:40 BRT)
