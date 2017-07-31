# Códigos para dissertação



## Informações Básicas

Autora: Marina Merlo

Título: [a definir] 

Orientador: Prof. Dr. Glauco Peres da Silva

## Bancos de dados utilizados na dissertação

- 1) [Relação de filiados](http://www.tse.jus.br/partidos/filiacao-partidaria/relacao-de-filiados)
- 2) [Relação de candidaturas das eleições municipais de 2016](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/candidatos_anos/2016.html)
- 3) [Resultados das eleições de 2016](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/resultados_anos/2016.html)
- 4) [Prestação de contas dos candidatos](http://www.tse.jus.br/hotSites/pesquisas-eleitorais/prestacao_contas_anos/2016.html)

## Principais operações feitas em cada arquivo de dados brutos

### - 1) Banco da relação de filiados
#### 1.1) Operações
- Juntar num único banco a relação de filiados de cada partido, considerando apenas o munício de São Paulo
- Renomear as variáveis
- Classificar os filiados por gênero, uma vez que esse dado foi declarado como sigilioso pelo TSE em pedido via LAI
#### 1.2) Objetivos
- Obter a porcentagem de mulheres e homens filiados por partido
- Gerar tabelas e gráficos com essa informação

### - 2) Banco de candidaturas
#### 2.1) Operações
- Criar um banco de candidaturas à vereador do município de São Paulo
- Renomear as variáveis
- Preparar para juntar com o banco dos resultados
#### 2.2) Objetivos
- Relação


### - 3) Banco de resultados
- Criar um banco com os resultados eleitorais para vereador do município de São Paulo
- Preparar para juntar com o banco de candidaturas

### -4) Banco de prestação de contas dos candidatos
- Criar um banco com a prestação de contas dos cadidatos para vereador do município de São Paulo
- Agregar as receitas por candidato, indicando o tipo e origem delas. 


