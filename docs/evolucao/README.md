# Evolução do Águia Pescadora

> **NOTA: considere a situação desta página atual como um rascunho até que este comentário seja removido (fititnt, 2019-07-14 22:59 BRT)**

<!-- TOC depthFrom:1 -->

- [Evolução do Águia Pescadora](#evolução-do-águia-pescadora)
    - [Mudança de versões do Águia Pescadora](#mudança-de-versões-do-águia-pescadora)
        - [Águia Pescadora 2.5-alpha](#águia-pescadora-25-alpha)
        - [Águia Pescadora 2.0-alpha](#águia-pescadora-20-alpha)
        - [Águia Pescadora 1.5-alpha](#águia-pescadora-15-alpha)
        - [Águia Pescadora 1.0-alpha](#águia-pescadora-10-alpha)

<!-- /TOC -->

## Mudança de versões do Águia Pescadora

### Águia Pescadora 2.5-alpha
> Aviso: Ainda em desenvolvimento.

Principais diferenças:

- Documentação de como recriar do zero com Ansible
- Inicio de testes com Kubernetes
- Domínio "https://etica.dev" comprado.

- Repositórios:
  - <https://github.com/EticaAI/aguia-pescadora-ansible-playbooks>
  - <https://github.com/EticaAI/aguia-pescadora>
- VPSs
  - Delta
    - <https://github.com/fititnt/cplp-aiops/issues/63>
    - <https://github.com/EticaAI/forum/issues/80>
  - Echo
    - <https://github.com/fititnt/cplp-aiops/issues/64>
    - <https://github.com/EticaAI/forum/issues/86>
  - Foxtrot
    - <https://github.com/fititnt/cplp-aiops/issues/65>
    - <https://github.com/EticaAI/forum/issues/87>

### Águia Pescadora 2.0-alpha

Evolução dos testes com a Charlie. Principal diferença:

- usa Tsuru (docker diretamente, não através de Kubernetes ou k3s)
- documentação de como replicar ainda não era feita usando Ansible

- Repositórios:
  - <https://github.com/EticaAI/aguia-pescadora>
- VPSs
  - Delta
    - <https://github.com/fititnt/cplp-aiops/issues/63>
    - <https://github.com/EticaAI/forum/issues/80>
  - Echo
    - <https://github.com/fititnt/cplp-aiops/issues/64>
    - <https://github.com/EticaAI/forum/issues/86>
  - Foxtrot
    - <https://github.com/fititnt/cplp-aiops/issues/65>
    - <https://github.com/EticaAI/forum/issues/87>

### Águia Pescadora 1.5-alpha

Primeira tentativa de usar docker não diretamente, via [Tsuru](https://github.com/fititnt/cplp-aiops/issues/59)

- Repositórios:
  - <https://github.com/fititnt/cplp-aiops>
- VPSs
  - Charlie
    - https://github.com/fititnt/cplp-aiops/issues/58

### Águia Pescadora 1.0-alpha
Provavelmente uma evolução direta da [VPS mamba [2vCPU / 1GB / 20GB]](https://github.com/EticaAI/forum/issues/72) não implementava conteiners como as versões mais recentes. Nem mesmo Docker como o projeto anterior, o [ChatOps for non-DevOps people Working Group 2018/01](https://github.com/fititnt/chatops-wg).

- Repositórios:
  - <https://github.com/fititnt/cplp-aiops>
- VPSs
  - Alpha
    - <https://github.com/fititnt/cplp-aiops/issues/17>
    - <https://github.com/EticaAI/forum/issues/77>
  - Bravo
    - <https://github.com/fititnt/cplp-aiops/issues/16>
    - <https://github.com/EticaAI/forum/issues/78>


---

Edição:

- De 3.0-alpha para 2.5-alpha
  - Os objetivos da 3.0 ainda não estão completamente definidos, ainda se trata de mudança de versão