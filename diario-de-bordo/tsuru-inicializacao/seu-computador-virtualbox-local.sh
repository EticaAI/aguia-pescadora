echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
############### Diario de bordo: seu-computador-virtualbox-local ###############
# Seu computador, requer tsuru-client, requer virtualbox, acesso internet
#
# @see https://github.com/fititnt/cplp-aiops/issues/59
#
# DESCRIPTION: explica que, além da opção de instalar o tsuru já em servidores
#              remotos o tsuru-client (sem parametros extras) tentará detectar
#              se você tem VirtualBox na sua máquina e, se tiver, irá instalar
#              ele sem precisar contratar servidor remoto. Isto pode ser uma
#              ótima opção se você tem memória RAM suficiente e seu dispositivo
#              permite virtualbox (talvez isso não seja possível em um telefone
#              com Android, por exemplo, porém talvez, e só talvez, um Android
#              com muita RAM, pelo menos uns 2G, talvez 3GB, muito espaço em
#              disco, e com Debian instalado conseguiria).
#
#              Nesta documentação, resumidamente, você fará os seguintes passos:
#                1.1b Instalar VirtualBox
#                1.2 (não precisa)
#                1.3 Instalar Docker
#                1.4 Instalar Docker Engine
#                1.5 Instalar Tsuru Client
#                1.6 Gerar configurações com 'tsuru install-config-init' (opcional)
#                1.7b Customiza Tsuru que será instalado localmente no Virtualbox
#                1.8b: Ordena instalação do Tsuru em Virtualbox local
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
################################################################################

# Este arquivo existe apenas para explicar que, enquanto o arquivo
# diario-de-bordo/tsuru-inicializacao/seu-computador.sh assume que já contratou
# 3 servidores remotos o Tsuru também pode ser executado no seu computador
# caso ele tenha suporte a VirtualBox!!!

# O autor inicial (Emerson Rocha) não vai testar 100% essa opção e se focar
# em ter um MVP do seu-computador.sh porque tem pessoas realmente precisando
# Tsuru Cluster no ar, porém outras pessoas no futuro podem enviar pull requests
# e melhorar isto aqui. Isto também explica porque não colocarei o passo
# a passo (para copiar e colar) neste momento

# Nota importante: esta documentação vai gastar mais internet comparado ao
# seu-computador.sh no momento que rodar o comando 'tsuru install-create'
# pois seu computador será usado em vez de um remoto! A versão seu-computador.sh
# (pelo menos depois de já ter o docker, docker-machine e o tsuru-client)
# exige pouca internet, pois todos os comandos pesados ocorrem remotamente.
# Só não digo que a seu-computador.sh pode ser feita até mesmo de um Android
# porque neste momento (2019-06-18) o Tsuru não tem pacote pre-compilado
# para o Termux, por exemplo. Talvez isso mude nos próximos meses.

##### VIRTUALBOX 1.1b: Instalar VirtualBox _____________________________________
# @see https://www.virtualbox.org/
# @see https://www.diolinux.com.br/2019/02/como-instalar-o-virtualbox-6-no-linux.html
# Antes de tentar este método, você precisará de VirtualBox instalado na sua
# máquina. Veja https://www.virtualbox.org/.

#### 1.2. (não precisa) ________________________________________________________
# Ignore isto

#### 1.3. DOCKER: Instalar Docker ______________________________________________
# Siga os passos de 1.3 do arquivo seu-computador.sh

#### 1.4. DOCKER: Instalar Docker Engine _______________________________________
# Siga os passos de 1.4 do arquivo seu-computador.sh

#### 1.5. TSURU: Instalar Tsuru Client _________________________________________
# Siga os passos de 1.5 do arquivo seu-computador.sh

#### TSURU 1.6: Gerar configurações com 'tsuru install-config-init' (opcional) _
# Siga os passos de 1.5 do arquivo seu-computador.sh

#### TSURU 1.7b:  Customiza Tsuru que será instalado localmente no Virtualbox (opcional) __
# É possível customizar alguns parametros antes de instalar o Tsuru localmente
# no virtualbox. Como o passo 1.8 tem padrões razoáveis se você não escolher
# instalar em servidores remotos é possível que ignore completamente não tanto
# os passos 1.6 como 1.7.b

#### TSURU 1.8: Ordena instalação do Tsuru em Virtualbox local _________________

# Simplesmente execute o comando a seguir que o tsuru tentará usar virtualbox
# e configurações padrões que ele teria gerado usando
# 'tsuru install-config-init' sem ediçõex extras suas

tsuru install-create

# Se você não ignorou o passo 1.7b e customizou os arquivos, seu comando seria
# tsuru install-create -c install-config.yml -e install-compose.yml

# Pronto! Se os requisitos já estavam instalados, dependendo de sua velocidade
# de internet logo você terá como testar o Tsuru localmente!
