
# TODO: organizar melhor esse diario de bordo... (fititnt, 2019-06-20 03:30 BRT)

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