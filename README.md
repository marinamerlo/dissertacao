# Arquivos para replicação dos dados, tabelas e gráficos

## Informações da dissertação

Repositório dos scripts utilizados na dissertação apresentada ao Programa de Pós-graduação do Departamento de Ciência Política da Universidade de São Paulo como requisito parcial para a obtenção do título de Mestre em Ciência Política.

**Autora:** Marina Merlo

**Título:** Mulheres tomando partido e partidos fazendo candidatas: a atuação partidária na trajetória das eleitas 

**Orientador:** Prof. Dr. Glauco Peres da Silva

**Linguagem:** R

**Link para download:** http://www.teses.usp.br/teses/disponiveis/8/8131/tde-21052018-171334/pt-br.php

## Resumo da dissertação
> As mulheres são a maioria do eleitorado brasileiro, quase metade da/os filiados a algum partido político e, mesmo com a lei de cotas de gênero que obriga o registro de pelo menos 30% de candidaturas femininas, elas ainda perfazem pouco mais de 10% da/os eleita/os. A literatura aponta diversas barreiras para essas mulheres, como o processo de socialização voltado para a esfera privada da vida, uma suposta falta de interesse em seguir uma carreira política e a falta de recursos para conduzir uma campanha eleitoral. Analisando a trajetória das vereadoras eleitas nas eleições municipais de 2016 da cidade de São Paulo, esse trabalho
investiga quais foram os meios encontrados ou utilizados pelas candidatas para superar estes obstáculos comumente impostos às mulheres, com um interesse específico e investigar a atuação dos partidos e lideranças partidárias no fomento ou bloqueio desse caminho até a vitória. Utilizando principalmente entrevistas em profundidade com as vereadoras, a dissertação percorre o momento do primeiro envolvimento político, da decisão da candidatura e a campanha eleitoral para ponderar, à luz das teorias e evidências acumuladas pela literatura sobre cada um desses estágios, a narrativa dessas mulheres sobre o seu sucesso eleitoral e os dados empíricos disponíveis sobre sua candidatura e campanha. O questionamento comum feito em cada uma dessas etapas de suas carreiras é o quanto a organização e as lideranças partidárias atuaram, direta ou indiretamente, para tornar efetiva a participação e o sucesso eleitoral destas candidatas; ao mesmo tempo, ponderar o quanto e como essas mulheres se aproveitaram, se utilizaram ou criaram oportunidades para participar. Os resultados apontam que, embora nem sempre estejam presentes nas primeiras atividades políticas das vereadoras, o partido político e suas lideranças – muitas vezes, na figura de familiares das candidatas – aparecem de forma decisiva no momento da decisão da candidatura e no suporte ao longo da campanha eleitoral, especialmente por darem legitimidade e o acesso às redes de contato com outras figuras políticas já bem estabelecidas. Com esses indícios, é possível questionar a crença de que os partidos não têm relevância ou influência na arena eleitoral e na baixa
representação feminina em cargos eletivos, bem como requalificar os argumentos e propostas pela maior inclusão de mulheres na política.

> **Palavras-chave:** Partidos Políticos. Eleições. Mulheres. Trajetória política. Gênero

## Bancos de dados brutos utilizados na dissertação

- 1) [Relação de filiados](http://www.tse.jus.br/partidos/filiacao-partidaria/relacao-de-filiados)
- 2) [Relação de candidaturas das eleições municipais de 2016](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/candidatos_anos/2016.html)
- 3) [Resultados das eleições de 2016](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/resultados_anos/2016.html)
- 4) [Prestação de contas dos candidatos](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/prestacao_contas_anos/2016.html)

## Principais operações e objetivos em cada banco

### 1) Banco da relação de filiados (utilizado no capítulo 1)
#### 1.1) Operações
- Juntar num único banco a relação de filiados de cada partido, considerando apenas o munício de São Paulo
- Renomear as variáveis
- Classificar os filiados por gênero, uma vez que esse dado foi declarado como sigilioso pelo TSE em pedido via LAI

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/banco_filiados.R))
#### 1.2) Objetivos
- Obter a porcentagem de mulheres e homens filiados por partido
- Gerar tabelas e gráficos com essa informação

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/variaveis_graficos_filiados.R))

### 2) Banco de candidaturas (utilizado no capítulo 2)
#### 2.1) Operações
- Criar um banco de candidaturas à vereador do município de São Paulo
- Renomear as variáveis
- Preparar para juntar com o banco dos resultados

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/banco_candidaturas_resultados.R))

#### 2.2) Objetivos
- Obter a porcentagem de mulheres e homens que se candidataram, por lista partidária e coligada

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/variaveis_cand_result.R))
- Gerar tabelas e gráficos com essas informações

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/graficos.R))

### 3) Banco de resultados (utilizado no capítulo 2)
#### 3.1) Operações
- Criar um banco com os resultados eleitorais para vereador do município de São Paulo
- Preparar para juntar com o banco de candidaturas

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/banco_candidaturas_resultados.R))

#### 3.2) Objetivos
- Obter estatísticas descritivas dos votos recebidos e resultado final, por gênero

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/variaveis_cand_result.R))
- Gerar tabelas e gráficos com essas informações

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/graficos.R))

### 4) Banco de prestação de contas dos candidatos (utilizado no capítulo 3)
#### 4.1) Operações
- Criar um banco com a prestação de contas dos cadidatos para vereador do município de São Paulo
- Agregar as receitas por candidato, indicando o tipo e origem delas. 

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/banco_receitas.R))
- Preparar para juntar com o banco de candidaturas e resultados

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/join_receitas_candidaturas_resultados.R))

#### 4.2) Objetivos
- Obter estatísticas descritivas das receitas recebidas, por gênero e resultado
- Obter o perfil de financiamento, separando por tipo e origem da receita, por gênero e resultado
- Gerar tabelas e gráficos com essas informações

([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/variaveis_graficos_recursos.R))


## Outros códigos e dados (Conclusão)
- Banco com o resumo das entrevistas realizadas
([Ver banco](https://github.com/marinamerlo/dissertacao/blob/master/dados.csv))
- Criação de um *alluvial diagram* para indicar a trajetória das vereadoras
([Ver script](https://github.com/marinamerlo/dissertacao/blob/master/alluvial_conclusoes.R))


## Pacotes utilizados

- data.table
- tidyverse
- gender
- readr
- stringr
- stringi
- dplyr
- reshape2
- ggplot2
- ggrepel
- gridExtra
- alluvial


