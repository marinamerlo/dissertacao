# Arquivos para replicação dos dados, tabelas e gráficos

## Informações Básicas

Repositório dos scripts utilizados na dissertação apresentada ao Programa de Pós-graduação do Departamento de Ciência Política da Universidade de São Paulo como requisito parcial para a obtenção do título de Mestre em Ciência Política.

Autora: Marina Merlo

Título: [a definir] 

Orientador: Prof. Dr. Glauco Peres da Silva

Linguagem: R

## Resumo da dissertação
As mulheres são a maioria do eleitorado brasileiro, quase metade dos filiados a algum partido político e, mesmo sendo um terço dos candidatos, elas ainda perfazem pouco mais de 10% dos eleitos. A legislação atual dispõe de pelo menos três medidas que têm como objetivo o aumento da participação política feminina. Uma delas é a Lei de Cotas , que estabelece que ao menos 30% das candidaturas de um partido em eleições proporcionais devem ser do gênero minoritário no grupo – o que normalmente é representado pelas mulheres. A outra medida determina que 5% dos recursos obtidos via fundo partidário deve ser aplicado “na criação e manutenção de programas de promoção e difusão da participação política das mulheres” . Por fim, a terceira regra estabelece que o partido político deve usar pelo menos 10% do seu acesso gratuito a rádio e televisão na promoção da participação política feminina. Assim, era de se esperar que com esses incentivos específicos, a participação das mulheres nas instâncias representativas estivesse aumentando, porém, a persistência do baixo número de mulheres eleitas e evidências de que suas chances de eleição são menores que as dos homens abrem uma seara específica de investigação para determinar as razões dessa sub-representação. 
A partir da investigação da disputa eleitoral de 2016 para a Câmara Municipal da cidade de São Paulo, buscar-se-á avaliar como a trajetória pessoal e política das candidatas eleitas pode dar pistas sobre quais foram os momentos e experiências que as tornaram candidaturas potenciais aos olhos dos partidos e suas lideranças partidárias. A observação da trajetória das candidatas eleitas tem como ganho principal indicar elementos que as diferenciaram o suficiente enquanto candidatas para que conseguissem vencer as barreiras que a literatura tem apontado como causas da subrepresentação feminina nos postos eletivos. O questionamento comum feito em cada uma dessas etapas da trajetória política e ao longo da dissertação é o quanto a organização partidária e as lideranças partidárias atuaram, direta ou indiretamente, para tornar possível a participação política e o sucesso eleitoral destas candidatas; ao mesmo tempo, ponderar o quanto e como essas mulheres se aproveitaram, se utilizaram ou criaram oportunidades para atuar. 
A caracterização das etapas das trajetórias se utiliza de dados qualitativos e quantitativos para situar e qualificar e analisar a presença feminina nos processos formais de participação política: a filiação a um partido político, a candidatura e a eleição. Os dados quantitativos são aqueles disponibilizados pelo TSE referentes à relação de filiados a um partido político, as informações das candidaturas e da prestação de contas da campanha eleitoral. Embora apresentados apenas de forma descritiva, esses dados permitem contextualizar as narrativas das entrevistas dentro do quadro da competição eleitoral como um todo, permitindo avaliar seu desempenho e recursos obtidos em comparação com outras candidaturas, bem como permitir comparar o caso das eleições municipais de 2016 em São Paulo com os achados de outros estudos empíricos sobre mulheres na política.Os dados qualitativos foram entrevistas em profundidade conduzidas com as vereadoras eleitas. 
 

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


