echo "Este diário de bordo foi feito para ser visualizado, nao executado assim!"
exit
############### Diario de bordo: tsuru-k3s++/computador-remoto.sh ###############
# Ubuntu 18.04
#
# DESCRIPTION: 
#
# CREATED AT: 2019-06-27 04:19 BRT
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

# Assume que o computador remoto já foi preparado com seu-computador.sh

#### Loga no servidor remoto como sudo _________________________________________
# Troque para seu usuário
ssh root@aguia-pescadora-foxtrot.etica.ai

sudo su

#### Instalação do k3s _________________________________________________________
# @see https://k3s.io/
# @see https://github.com/rancher/k3s

curl -sfL https://get.k3s.io | sh -
## root@vmi274563:~# curl -sfL https://get.k3s.io | sh -
## [INFO]  Finding latest release
## [INFO]  Using v0.6.1 as release
## [INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.6.1/sha256sum-amd64.txt
## [INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v0.6.1/k3s
## [INFO]  Verifying binary download
## [INFO]  Installing k3s to /usr/local/bin/k3s
## [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
## [INFO]  Creating /usr/local/bin/crictl symlink to k3s
## [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
## [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
## [INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
## [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
## [INFO]  systemd: Enabling k3s unit
## Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
## [INFO]  systemd: Starting k3s

netstat -ntulp
## Active Internet connections (only servers)
## Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
## tcp        0      0 127.0.0.1:6445          0.0.0.0:*               LISTEN      2199/k3s            
## tcp        0      0 127.0.0.1:10256         0.0.0.0:*               LISTEN      2199/k3s            
## tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      390/systemd-resolve 
## tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      482/sshd            
## tcp        0      0 167.86.127.225:10010    0.0.0.0:*               LISTEN      2239/containerd     
## tcp        0      0 127.0.0.1:10248         0.0.0.0:*               LISTEN      2199/k3s            
## tcp        0      0 127.0.0.1:10249         0.0.0.0:*               LISTEN      2199/k3s            
## tcp        0      0 127.0.0.1:6444          0.0.0.0:*               LISTEN      2199/k3s            
## tcp6       0      0 :::22                   :::*                    LISTEN      482/sshd            
## tcp6       0      0 :::32189                :::*                    LISTEN      2199/k3s            
## tcp6       0      0 :::31297                :::*                    LISTEN      2199/k3s            
## tcp6       0      0 :::10250                :::*                    LISTEN      2199/k3s            
## tcp6       0      0 :::6443                 :::*                    LISTEN      2199/k3s            
## tcp6       0      0 :::10251                :::*                    LISTEN      2199/k3s            
## tcp6       0      0 :::10252                :::*                    LISTEN      2199/k3s            
## udp        0      0 127.0.0.53:53           0.0.0.0:*                           390/systemd-resolve 
## udp        0      0 0.0.0.0:8472            0.0.0.0:*                           -