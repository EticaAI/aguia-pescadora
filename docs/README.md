# Águia Pescadora

[![Website: aguia-pescadora.etica.ai](img/badges/website.svg)](https://aguia-pescadora.etica.ai) [![GitHub: EticaAI/aguia-pescadora](img/badges/github.svg)](https://github.com/EticaAI/aguia-pescadora) [![GitHub: EticaAI/aguia-pescadora-ansible-playbooks](img/badges/github-aguia-pescadora-ansible-playbooks.svg)](https://github.com/EticaAI/aguia-pescadora-ansible-playbooks)

**_"Águia Pescadora"_ é codinome atual usado pela [Etica.AI](https://etica.ai)
tanto da implementação da núvem pública desta como da própria documentação de
como pode ser recriada por terceiros.** [Também é inspirada em iniciativas anteriores](evolucao/#pré-águia-pescadora).

<!--
documentação/código dedicada ao domínio publico como da própria implementação de solução completa da
nuvem pública da [Etica.AI](https://etica.ai)**.

**Águia Pescadora é o nome dado ao projeto da Etica.AI de Plataforma Como Serviço
(_"PaaS"_) oferecida gratuitamente a quem da apoio em comunidades de base nas
quais participamos.** Nas próximas semanas devemos ter um ambiente
aceitavelmente pronto para uso em produção e com controle automatizado de
[etica.dev](https://etica.dev), sendo um dos nossos maiores desafios o processo
de documentação e otimização para permitir uso simples.
-->

Veja também: [pt.etica.ai](https://pt.etica.ai) \| [docs.etica.ai/pt](https://docs.etica.ai/pt) \| [cplp.etica.ai](https://cplp.etica.ai) \| [inclusao.etica.ai](https://inclusao.etica.ai) 

---

<!--
<figure class="image">
  <img src="img/aguia-pescadora-banner.jpg" alt="{{ include.description }}">
  <figcaption>Águia Pescadora © Andy Morffew</figcaption>
</figure>
-->

> _"Se não puder voar, corra. Se não puder correr, ande. Se não puder andar,
> rasteje, mas continue em frente de qualquer jeito"_
> — [Martin Luther King Jr](https://pt.wikipedia.org/wiki/Martin_Luther_King_Jr.), vencedor do Prêmio Nobel da Paz em 1964

---

## Índice de conteúdo

- [Guia de Usuário](guia-de-usuario/)
- [Guia de suporte: informações extras para quem ajuda usuários](./guia-de-suporte/)
- [Filosofia: das decisões que levaram a escolha da pilha de soluções a dicas de o que considerar ao criar sua própria](filosofia/)
- [Evolução: saiba diferença entre as versões do Águia Pescadora](evolucao/)

<!--
- Sites extras da Etica.AI relacionados ao Águia Pescadora
  - [Inclusão Digital - Etica.AI: Recursos gratuitos de apoio à inclusão digital de pessoas desenvolvedoras de tecnologia](https://inclusao.etica.ai/)
  - [Contexto tecnológico para fomento de Ética na Inteligência Artificial na CPLP](https://cplp.etica.ai/)
-->

---

## Perguntas frequentes

### O PaaS da Águia Pescadora já está operacional?
**Resposta curta**: o servidor de testes Águia Pescadora Charlie, sim. Veja:
_Tsuru #59 <https://github.com/fititnt/cplp-aiops/issues/59>_ e _Servidor Águia
Pescadora Charlie #58 <https://github.com/fititnt/cplp-aiops/issues/58>_.

**Resposta longa**: ao menos em 2019-06-17, não ainda. O repositório
[github.com/EticaAI/aguia-pescadora](https://github.com/EticaAI/aguia-pescadora)
e o site público [aguia-pescadora.etica.ai](https://aguia-pescadora.etica.ai/)
foram inspirados no fititnt/cplp-aiops e agora agora é projeto focado apenas no
PaaS da Etica.AI que visa ter um lugar de baixo custo mensal mas que possa ser
usado em produção.

> _Atualização em 2019-07-07 21:23 BRT: nosso diário de bordo está sendo
convertido para "Infrastrutura Como Código" em
[Ansible Playbooks da Águia Pescadora](https://github.com/EticaAI/aguia-pescadora-ansible-playbooks)
para facilitar replicação de outros clusters inclusive por responsáveis
diferentes. **Percebemos também que um dos desafios de adoção de PaaS tenderá a
ser não apenas sua configuração, mas principalmente documentação de quem usa**;
isto é: apenas redução de custos para manter um cluster sem fins lucrativos pode
não ser suficiente. Um rascunho de documentação do "ajuda.etica.dev"
está em <https://ajuda-dev.etica.ai/>._

### Quais as especificações da Águia Pescadora?
<!--
  - Águia Pescadora Alpha não tem previsão de ser desativada (custa pouco)
  - Águia Pescadora Bravo e Águia Pescadora Charlie não serão renovadas (Estão na OVH)
  - As 3 VPSs VPS Elefante Bornéu YUL não serão renovadas (Estão na OVH)
    - No futuro, caso haja necessidade, poderão ser recriadas _dentro_ da Águia Pescadora
  - aaa
-->

> _Atualização em 2019-07-22 03:41 BRT: é provável que a versão de nuvem pública
que use Kubernetes para orquestração do Águia Pescadora acabe tendo que usar
pelo menos em torno do dobro da a quantidade de 3 nós de modo que seja tolerante
a falhas de máquinas e falhas humanas. Esta nova versão provavelmente será
chamada de "v3.0" (atualmente tem-se "v2.0.x-alpha"). Se Delta (que tem 16GB de
RAM) for aposentada em prol de menores de 8GB a 4.99EUR/mês ainda seria possível
ter 3+2 VPSs ([Nodes: 5][CPU: 20][RAM: 40GB][Disk: 1.000GB]) a um custo em torno
de 100 BRL. Kubernetes é complexo de permitir uso simples, então o PaaS público
da Águia Pescadora está planejado para início de 2020. **Aplicações de colegas
serão executadas em versões privadas até lá**._

A meta é _**[Tsuru Nodes: 3][CPU: 14][RAM: 32GB][Disk: 800GB][Custo Mensal: < 100 Reais]**_.
Pela cotação de EURO a 4.37 as as especificações acima são 82,79 Reais
brasileiros, o que permitiria uma folga para até mesmo ter um lugar extra para
guardar backups.

Seria possível (e isso é uma opção daqui alguns meses) reduzir para o uso
de apenas um nó (como a Delta) e manter os custos em < 40,00 Reais brasileiros e
ainda assim ter uma especificação de _[6vCPU / 16GB RAM / 400GB] [8.99 EUR/month]_.

Para mais detalhes, veja [Etica.AI Infrastructure: Clusters & VPS](https://github.com/orgs/EticaAI/projects/2).

### Quem paga para manter os servidores no ar é uma empresa?
Não. São custo-eficiente suficiente para serem pagas como indivídio que não
só o faz, como documenta como outros poderiam fazer. Em
<https://github.com/EticaAI/forum/labels/infra-vps> <sup>Destino em Inglês</sup>
pode ver de forma transparente mais sobre.

Note também que não há interesse de doação de dinheiro. Se tem interesse, doe
para o [Comitê Internacional da Cruz Vermelha](https://www.icrc.org/pt).


# Licença

[![Domínio Público](img/dominio-publico.png)](UNLICENSE)

Na medida do possível segundo a lei, [EticaAI](https://github.com/EticaAI)
renunciou a todos os direitos autorais e direitos conexos ou vizinhos a este
trabalho para o [Domínio Público](UNLICENSE).
