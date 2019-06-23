echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit

##################### Diario de bordo: aguia-pescadora-echo ####################
# VPS (KVM), 4 vCPUs, 8GB RAM, 200GB SSD, Ubuntu Server 18.04 64bit, Contabo (Germany)
#
# Datacenter: Contabo, Germany
# Type: Virtual Machine, KVM
# OS: Ubuntu Server 18.04 LTS 64bit
# CPU: 4 vCPUs
# RAM: 7976 MB
# Disk: 200 GB
#
# IPv4: 167.86.127.220
# IPv6: 
# Domain:
#   Full: aguia-pescadora-echo.etica.ai (TTL: 15 min)
#   Short: ape.etica.ai (TTL: 15 min)
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

### Primeiro login______________________________________________________________
# Você, seja por usuario + senha, ou por Chave SSH, normlamente terá que acessar
# diretamente como root. Excessões a esta regra (como VMs na AWS) geralmente
# implicam em logar em um usuario não-root e executar como sudo. Mas nesta da
# é por root mesmo nesse momento.
ssh root@167.86.127.220
ssh root@aguia-pescadora-echo.etica.ai

### Atualizar o sistema operacional_____________________________________________
# O sistema operacional (neste caso, Ubuntu) normalmente não vai estar 100%
# atualizado. Os comandos abaixo são uma boa prática pra fazer imediatamente
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

### Define um hostname personalizado____________________________________________
# O hostname padrão geralmente não faz muito sentido pra você e os usuparios
# da VPS. No nosso caso, era vps240016, como em root@vps240016.
# Nota: o domínio 'aguia-pescadora-bravo.etica.ai' já aponta para 192.99.247.117
sudo hostnamectl set-hostname aguia-pescadora-echo.etica.ai

# Edite /etc/hosts e adicione o hostname também apontando para 127.0.0.1
sudo vi /etc/hosts
## Adicione
# 127.0.0.1 aguia-pescadora-echo.etica.ai  aguia-pescadora-echo

### Define horário padrão de sistema_____________________________________________
# Vamos definir como horário padrão de servidor o UTC.
# Motivo 1: para aplicações de usuário, é mais fácil calcular a partir do horário
#           Zulu
# Motivo 2: Este servidor será acessado por pessoas de diversos países, não
#           apenas falantes de português que são do Brasil (e que, aliás, o
#           próprio Brasil tem mais de um fuso horário)
sudo timedatectl set-timezone UTC

### Adiciona ao menos uma chave de administrador _______________________________
# Para fazer acesso sem senha de root (e uma chave extra além da usada 
# inicialmente pelo Tsuru)

## O comando a seguir é executado da sua maquina local, não no servidor!
ssh-copy-id -i ~/.ssh/id_rsa-rocha-eticaai-2019.pub root@aguia-pescadora-echo.etica.ai

### Criar Swap & ajusta Swappiness______________________________________________
## TODO: setup swap from 2GB (defalt from Contabo) to 8GB (fititnt, 2019-06-16 01:44 BRT)

## Já temos uma Swap de 2GB
# root@aguia-pescadora-delta:/# ls -lh /swapfile
# -rw------- 1 root root 2.0G Jun 12 11:05 /swapfile

## @see https://bogdancornianu.com/change-swap-size-in-ubuntu/
## @see https://askubuntu.com/questions/1075505/how-do-i-increase-swapfile-in-ubuntu-18-04/1075516#1075516

## Cria um /swapfile de 4GB
# @see https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-18-04
# @see https://askubuntu.com/questions/1075505/how-do-i-increase-swapfile-in-ubuntu-18-04/1075516#1075516

# TODO: descobrir configurações para rodar Tsuru em produção que estejam
#       relacionadas a swap. Numa olhada rápida ao menos quando usado
#        Kubernetes (que NÃO é nosso caso) os desenvolvedores desativam
#        funcionamento em sistemas com Swap sem parametro especial, vide
#        https://github.com/kubernetes/kubernetes/issues/53533
#        (fititnt, 2019-06-17 02:16 BRT)

#------------------------------------------------------------------------------#
# SEÇÃO TSURU: ADIÇÃO DA CHAVE SSH PARA SER CONFIGURADO REMOTAMENTE            #
#                                                                              #
# AVISO: veja devel-fititnt-bravo.sh para saber como a chave foi criada        #
#------------------------------------------------------------------------------#
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7erwMfyTSO7xn8axjAp2NTbBHjDVdu+6J17ZjX3Rs55dy3Vsqmq4kBIq3qxShabfY6h5nW3ccc86hGy8coXjPCblyloAKlG0RKkRo7/sGjsl3jv8i0gZVLU/H8pjaLLGhRWca2ToJAPJTlnFk/VrCMvH6PCHca7X70j88uE6UR5W1nax94kzcyOf/65mQDx7dHYVVyBL+Rgn0CHS4Di8Z0PSbwn1dVA0S4JW1z1DZ/5AYdhOBCfPkDvj4trTr9lmJIn/6KnOX+MIMzViHtxZw3dg8VHcZxd2PeiJ/THZZ3Z34Bv60jEwyjZMNKB6fqz4mAGkHH8bAXMS4m6gZXw6TaPZk84x3t9rJnzWhPaUYOkPL9dgcZ8m+FmeUxKkJgdo10AqZAMVdboYEKhL4Uv9JvZrt/VdkM6C2FqIDEddm6TWnqZiteeLtCl0EU5PMxsfQUncHkRihya6R1Brysu5lvTGEvW1qoobONowT3ED2F5aDTPlyscTr4ogKXAJda+jI5oIGxkf2QaKzhdJlt76KktQRVlOQVYJeKcVOB853IVMSJvIpP09YReaibrxdSYeazu+SswqNK7ux7S3Xb82PtSu7jtJtiiCdU6zfCLkWPAmoqP8N3m1q2lw4VvXxvLeUp79n3cv+kabG0UpE2csyJArSX/eyUF7+6F9QWQo4ow== aguia-pescadora-tsuru.no-reply@etica.ai" >> ~/.ssh/authorized_keys

## Reveja as chaves em /root/.ssh/authorized_keys e tenha certeza que esta tudo
## como deveria
sudo cat /root/.ssh/authorized_keys

#------------------------------------------------------------------------------#
# SEÇÃO TSURU: DEPENDENCIAS DO DOCKER MACHINE (É USADO PELO TSURU)             #
#------------------------------------------------------------------------------#
## Resolve o erro do Docker Machine
# Setting Docker configuration on the remote daemon... \n Error running SSH command: ssh command error: \n command : netstat -tln \n err     : exit status 127 \n output  : bash: netstat: command not found
sudo apt install net-tools

#------------------------------------------------------------------------------#
# SEÇÃO OpenResty & HTTPS:                                                     #
#------------------------------------------------------------------------------#
# @see https://github.com/EticaAI/aguia-pescadora/issues/15
# @see http://openresty.org/en/linux-packages.html

# Nota: em sistemas que já tem NGinx instalado, será necessário o seguinte:
# sudo systemctl disable nginx
# sudo systemctl stop nginx

#### OpenResty, repositório padrão e instalação básica _________________________
### @see http://openresty.org/en/linux-packages.html
# import our GPG key:
wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

# for installing the add-apt-repository command
# (you can remove this package and its dependencies later):
sudo apt-get -y install software-properties-common

# add the our official APT repository:
sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"

# to update the APT index:
sudo apt-get update

# Then you can install a package, say, openresty, like this:
sudo apt-get install -y openresty

## Acesse o servidor. No caso de bravo, seria estas URLs
# - http://tsuru-dashboard.173.249.10.99.nip.io/
# - http://173.249.10.99/
## E você vera 'Welcome to OpenResty!', pagina padrão.

#### OpenResty + GUI/lua-resty-auto-ssl, instalação básica _____________________
# @see https://github.com/GUI/lua-resty-auto-ssl#installation

# NOTA: sobre instalação do luarocks para o lua-resty-auto-ssl
# Não tenho certeza se a versão que tem no Ubuntu 18.04 do LuaRocks é suficiente
# O link da documentaçãodo Lua Resty Auto SSL manda para documentação padrão
# do OpenResty.org, que diz que instalar o Lua padrão é desaconselhado pois
# o OpenResty ja tem um package manager. Na documentação, falam que existia
# uma versão do lua 2.3.0, mas que usariam a 2.0.13 por questão de
# compatibilidade. Na documetnação do Luarocks eles dizem que a versão estável
# é 3.1.3 (vide https://github.com/luarocks/luarocks/wiki/Download).
#
# No nosso caso aqui, O padrão do Ubuntu 18.04 cita 2.4.2+dfsg-1.
# Vou usar essa padrão do ubuntu e apenas se der problema vou atrás.
# (fititnt, 2019-06-22 21:33 BRT)
sudo apt install -y luarocks

# Instala o lua-resty-auto-ssl
sudo luarocks install lua-resty-auto-ssl

## Específico para Ubuntu 18.04. Talvez se aplique a outros sistemas.
# @see https://github.com/openssl/openssl/issues/7754#issuecomment-444063355
# Caso ocorra erros ao usar o comando openssl seja para criar chave de fallback
# ou o resty-auto-ssl:
# "err: Can't load ./.rnd into RNG" pode ser necessário comentar a linha
# que tenha 'RANDFILE' em /etc/ssl/openssl.cnf.
# Você pode usar 'vim /etc/ssl/openssl.cnf' ou executar o comando seguinte uma vez
sed -i '/RANDFILE/s/^/#/g' /etc/ssl/openssl.cnf

# Create /etc/resty-auto-ssl and make sure it's writable by whichever user your
# nginx workers run as (in this example, "www-data").
sudo mkdir /etc/resty-auto-ssl
sudo chown www-data /etc/resty-auto-ssl
# Caso tenha problemas com permissão: 
# sudo chown www-data -R /etc/resty-auto-ssl

#### OpenResty + GUI/lua-resty-auto-ssl, configuração mínima ___________________
# Edite o arquivo do NGinx para ficar conforme https://github.com/GUI/lua-resty-auto-ssl#installation
# Uma copia deste arquivo está em diario
# de-bordo/delta/usr/local/openresty/nginx/conf/nginx.conf
sudo vim /usr/local/openresty/nginx/conf/nginx.conf

# É preciso criar um certificado padrão para o NGinx pelo menos poder iniciar sem erro
sudo openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
  -subj '/CN=sni-support-required-for-valid-ssl' \
  -keyout /etc/ssl/resty-auto-ssl-fallback.key \
  -out /etc/ssl/resty-auto-ssl-fallback.crt

# Reinicie o Openresty
sudo systemctl status openresty
sudo systemctl reload openresty

# Para ver erros
tail -f /usr/local/openresty/nginx/logs/error.log

#------------------------------------------------------------------------------#
# SEÇÃO ARQUIVOS PADRÕES POR SERVIDOR                                          #
#------------------------------------------------------------------------------#
# Reduz mensagens de erro/acesso 404 nos logs
## Você pode criar com touch
# sudo touch /usr/local/openresty/nginx/html/favicon.ico
# sudo touch /usr/local/openresty/nginx/html/robots.txt

# Ou usar o comando scp
scp -r /alligo/code/eticaai/aguia-pescadora/diario-de-bordo/echo/usr/local/openresty/nginx/html root@aguia-pescadora-echo.etica.ai:/usr/local/openresty/nginx/
scp -r /alligo/code/eticaai/aguia-pescadora/diario-de-bordo/echo/usr/local/openresty/nginx/conf root@aguia-pescadora-echo.etica.ai:/usr/local/openresty/nginx/

sudo systemctl status openresty
sudo systemctl reload openresty

# Para ver erros
tail -f /usr/local/openresty/nginx/logs/error.log