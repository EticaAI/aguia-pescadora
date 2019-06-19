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
#              com Android, por exemplo).
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

##### VirtualBox _______________________________________________________________
# @see https://www.virtualbox.org/
# @see https://www.diolinux.com.br/2019/02/como-instalar-o-virtualbox-6-no-linux.html
# Antes de tentar este método, você precisará de VirtualBox instalado na sua
# máquina. Veja https://www.virtualbox.org/.

##### Tsuru Client _____________________________________________________________
# @see https://tsuru-client.readthedocs.io/en/latest/
# @see https://github.com/tsuru/tsuru-client/releases

# TODO: documentar copiando do seu-computador.sh (fititnt, 2019-06-18 22:29 BRT)


##### Instalar Tsuru em VirtualBox local _______________________________________
# Simplesmente execute o seguinte comando e aguarde alguns minutos
tsuru install-create

# Pronto! A maior dificuldade deste método é conseguir ter instalado os
# requisitos (VirtualBox e tsuru-client) em sua plataforma.