# Arquivos para replicação dos dados, tabelas e gráficos

## Informações Básicas

Dissertação apresentada ao Programa de Pós-graduação do Departamento deCiência Política da Universidade de São Paulo como requisito parcial para a obtenção do título de Mestre em Ciência Política.

Autora: Marina Merlo

Título: [a definir] 

Orientador: Prof. Dr. Glauco Peres da Silva

Linguagem: R

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

### Pacotes utilizados

#### Manipulando os bancos de dados
- data.table
- tidyverse
- gender
- readr
- stringr
- stringi
- reshape2

#### Para os gráficos
- dplyr
- ggplot2
- ggrepel
- gridExtra


