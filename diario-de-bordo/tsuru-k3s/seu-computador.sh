echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
############ Diario de bordo: tsuru-k3s++/seu-computador #############
# Seu Computador (testado em um Ubuntu 16.04 LTS), acesso à internet (não muito caso você já deixe instalado docker & docker-engine antes)
#
# DESCRIPTION: Teste inicial de k3s. Nao sei se funciona com Tsuru e neste
#              momento estou preocupado em apenas ver como usar o Tsuru com
#              Kubernetes.
#
#              Veja https://github.com/EticaAI/aguia-pescadora/issues/24
#
# CREATED AT: 2019-06-27 01:48 BRT
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

# NOTA: veja diario-de-bordo/tsuru-inicializacao++/seu-computador.sh para todos
#       os passos comuns entre este guia com opções extras eo guia de produto
#       mínimo viável do Tsuru (fititnt, 2019-06-22 19:23 BRT)
# ............................................................................ #
