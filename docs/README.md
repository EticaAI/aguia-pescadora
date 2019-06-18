# Águia Pescadora

[![Website: aguia-pescadora.etica.ai](img/badges/website.svg)](https://aguia-pescadora.etica.ai) [![GitHub: EticaAI/aguia-pescadora](img/badges/github.svg)](https://github.com/EticaAI/aguia-pescadora)

**Águia Pescadora é o nome dado ao projeto da Etica.AI de Plataforma Como Serviço
(_"PaaS"_) oferecida gratuitamente a quem da apoio em comunidades de base nas
quais participamos.** Nas próximas semanas devemos ter um ambiente
aceitavelmente pronto para uso em produção e com controle automatizado de
[etica.dev](https://etica.dev), sendo um dos nossos maiores desafios o processo
de documentação e otimização para permitir uso simples.

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

### Quais as especificações da Águia Pescadora?
<!--
  - Águia Pescadora Alpha não tem previsão de ser desativada (custa pouco)
  - Águia Pescadora Bravo e Águia Pescadora Charlie não serão renovadas (Estão na OVH)
  - As 3 VPSs VPS Elefante Bornéu YUL não serão renovadas (Estão na OVH)
    - No futuro, caso haja necessidade, poderão ser recriadas _dentro_ da Águia Pescadora
  - aaa
-->

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
