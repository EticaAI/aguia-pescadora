# Pilha de soluções usadas na Águia Pesquisadora comentada

## Provedor de infraestrutura de servidores

- Escolha atual
  - Contabo: <https://contabo.com/?show=vps>
    - É barato. Menos de 100 reais brasileiros por mês para ter um cluster de 3
      nós, totalizando 14 vCPUs, 32 GB RAM e 800 GB SSD de disco.

## Sistema operacional

Nota: este é o sistema operacional escolhido no hospedeiro dos conteiners. Não
necessariamente é a escolha para imagens base usadas em Docker.

### Ubuntu Server 18.04 LTS
- Mais fácil de encontrar pacotes aceitavelmente atualizados do que alternativas
  sem correr _muitos_ riscos
- Por ter também um numero grande de usuários de versões baseadas no Ubuntu
  Desktop também possúi muita documentação e apoio
- **É mais fácil ensinar alguém novo a recriar/dar manutenção na Águia Pescadora
  se ubuntu for escolhido**

## Plataforma Como Serviço open source

### Tsuru
- <https://tsuru.io/>

#### Razões na escolha do Tsuru
1. É usado em ambientes em produção há muitos anos mesmo antes da existência de
   Docker swarm e Kubernetes e apesar de todo esse tempo ainda continua
   recebendo atualizações
2. Uma implementação mínima completa pode ser feita em um hospedeiro (seja VPS
   ou hardware dedicado) usando muito menos recursos do que Kubernetes ou
   Openshift
