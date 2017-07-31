#configurando a pasta em que os arquivos serão salvos
setwd("C:\\Users\\d841255\\Desktop\\dados")

#abrindo os pacotes que vou usar usar. Eles já estavam instalados. 

#install.packages("readr")
#install.packages("dplyr")

library(readr)
library(dplyr)
library(data.table)

########################################
###### Parte 1 - abrindo os dados ######
########################################

#baixando o arquivo com todos os resultados eleitorais de 2016
url_result <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
download.file(url_result, "temp.zip", quiet = F)
#descompactando o arquivo e removendo o .zip da pasta
unzip("temp.zip")
file.remove("temp.zip")

#baixando o arquivo com os dados de candidaturas
url_cand <- "http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2016.zip"
download.file(url_cand, "temp.zip", quiet = F)
#descompactando o arquivo e removendo o .zip da pasta
unzip("temp.zip")
file.remove("temp.zip")


##selecionando os arquivos do Estado de São Paulo

#criando uma lista de todos os arquivos contidos na pasta
lista.arquivos <-list.files(file.path(getwd()))
print(lista.arquivos)
#criando uma lista para pegar somente os documentos de votação
lista.resultados <- grep(pattern="votacao_candidato_munzona_2016_", lista.arquivos, value=TRUE)
print(lista.resultados)

#pegando somente o arquivo de São Paulo
lista.resultados <- lista.resultados[c(25)]
print(lista.resultados)

#criando o dataframe vazio que receberá os dados
resultados <- data.frame()

#Loop para coletar os dados que queremos:
#vai abrir cada uma das listas, renomear as colunas de acordo com o indicado no arquivo LEIAME.
#incluir no dataframe vazio
for(arquivo in lista.resultados){
  resultados <- fread(file.path(getwd(), arquivo), stringsAsFactors = F, encoding = "Latin-1", header = F)
  names(resultados) <- c("DATA_GERACAO",
                         "HORA_GERACAO",
                         "ANO_ELEICAO", 
                         "NUM_TURNO",
                         "DESCRICAO_ELEICAO",
                         "SIGLA_UF",
                         "SIGLA_UE",
                         "CODIGO_MUNICIPIO",
                         "NOME_MUNICIPIO",
                         "NUMERO_ZONA",
                         "CODIGO_CARGO",
                         "NUMERO_CAND", 
                         "SEQUENCIAL_CANDIDATO",
                         "NOME_CANDIDATO",
                         "NOME_URNA_CANDIDATO",
                         "DESCRICAO_CARGO",
                         "COD_SIT_CAND_SUPERIOR",
                         "DESC_SIT_CAND_SUPERIOR",
                         "CODIGO_SIT_CANDIDATO",
                         "DESC_SIT_CANDIDATO",
                         "CODIGO_SIT_CAND_TOT",
                         "DESC_SIT_CAND_TOT",
                         "NUMERO_PARTIDO",
                         "SIGLA_PARTIDO",
                         "NOME_PARTIDO",
                         "SEQUENCIAL_LEGENDA",
                         "NOME_COLIGACAO",
                         "COMPOSICAO_LEGENDA",
                         "TOTAL_VOTOS",
                         "TRANSITO")
}

#checando se os quatro estados foram empilhados
table(resultados$SIGLA_UF)



##repetindo os passos para criar o arquivo das candidaturas##

#criando uma lista de todos os arquivos contidos na pasta
lista.arquivos <-list.files(file.path(getwd()))
print(lista.arquivos)
#criando uma lista para pegar somente os documentos de votação
lista.candidatos <- grep(pattern="consulta_cand_2016_", lista.arquivos, value=TRUE)
print(lista.candidatos)

#pegando somente o arquivo de São Paulo
lista.candidatos <- lista.candidatos[c(27)]
print(lista.candidatos)

#criando o dataframe vazio que receberá os dados
candidatos <- data.frame()

#Loop para coletar os dados que queremos:
#vai abrir cada uma das listas, renomear as colunas de acordo com o indicado no arquivo LEIAME.
#incluir no dataframe vazio

for(arquivo in lista.candidatos){
  candidatos <- fread(file.path(getwd(), arquivo), stringsAsFactors = F, encoding = "Latin-1", header = F)
  names(candidatos) <-  c("DATA_GERACAO",
                          "HORA_GERACAO",
                          "ANO_ELEICAO",
                          "NUM_TURNO",
                          "DESCRICAO_ELEICAO",
                          "SIGLA_UF",
                          "SIGLA_UE",
                          "DESCRICAO_UE",
                          "CODIGO_CARGO",
                          "DESC_CARGO",
                          "NOME_CANDIDATO",
                          "SEQUENCIAL_CANDIDATO",
                          "NUMERO_CANDIDATO",
                          "CPF_CAND",
                          "NOME_URNA_CANDIDATO",
                          "COD_SITUACAO_CANDIDATURA",
                          "DES_SITUACAO_CANDIDATURA",
                          "NUMERO_PARTIDO",
                          "SIGLA_PARTIDO",
                          "NOME_PARTIDO",
                          "CODIGO_LEGENDA",
                          "SIGLA_LEGENDA",
                          "COMPOSICAO_LEGENDA",
                          "NOME_LEGENDA",
                          "CODIGO_OCUPACAO",
                          "DESCRICAO_OCUPACAO",
                          "DATA_NASCIMENTO",
                          "NUM_TITULO_ELEITORAL_CANDIDATO",
                          "IDADE_DATA_ELEICAO",
                          "CODIGO_SEXO",
                          "DESCRICAO_SEXO",
                          "COD_GRAU_INSTRUCAO",
                          "DESCRICAO_GRAU_INSTRUCAO",
                          "CODIGO_ESTADO_CIVIL",
                          "DESCRICAO_ESTADO_CIVIL",
                          "COD_COR_RACA",
                          "DESC_COR_RACA",
                          "CODIGO_NACIONALIDADE",
                          "DESCRICAO_NACIONALIDADE",
                          "SIGLA_UF_NASCIMENTO",
                          "CODIGO_MUNICIPIO_NASCIMENTO",
                          "NOME_MUNICIPIO_NASCIMENTO",
                          "DESPESA_MAX_CAMPANHA",
                          "COD_SIT_TOT_TURNO",
                          "DESC_SIT_TOT_TURNO",
                          "EMAIL")
}

#checando se os quatro estados foram empilhados
table(candidatos$SIGLA_UF)


############################################
###### Parte 2 - data frame resultados #####
############################################
names(resultados)
#selecionando as linhas que contem resultados para vereador, deixando o banco com as variáveis e renomeando-as
resultados <- resultados %>% 
  filter(DESCRICAO_CARGO == "VEREADOR") %>%
  select(SIGLA_UF, 
         SIGLA_UE, 
         CODIGO_MUNICIPIO,
         NUMERO_ZONA,
         SIGLA_PARTIDO, 
         NUMERO_CAND, 
         SEQUENCIAL_CANDIDATO,
         NOME_CANDIDATO,
         NOME_URNA_CANDIDATO,
         COMPOSICAO_LEGENDA,
         TOTAL_VOTOS,
         NOME_MUNICIPIO) %>%
  rename(uf = SIGLA_UF, 
         ue = SIGLA_UE, 
         cod_mun = CODIGO_MUNICIPIO,
         num_zona = NUMERO_ZONA,
         sigla = SIGLA_PARTIDO, 
         num_cand =NUMERO_CAND, 
         seq = SEQUENCIAL_CANDIDATO,
         nome = NOME_CANDIDATO,
         nome_urna = NOME_URNA_CANDIDATO,
         colig = COMPOSICAO_LEGENDA,
         votos_total = TOTAL_VOTOS,
         nome_mun = NOME_MUNICIPIO)

############################################
###### Parte 3 - data frame candidatos #####
############################################
names(candidatos)
#selecionando as linhas que contem candiadtos para vereador, deixando o banco com as variáveis e renomeando-as
candidatos <- candidatos %>% 
  filter(DESC_CARGO == "VEREADOR") %>%
  select(SEQUENCIAL_CANDIDATO,
         CPF_CAND,
         DES_SITUACAO_CANDIDATURA,
         NOME_LEGENDA,
         NUM_TITULO_ELEITORAL_CANDIDATO,
         IDADE_DATA_ELEICAO,
         DESCRICAO_SEXO,
         DESCRICAO_OCUPACAO, 
         DESCRICAO_GRAU_INSTRUCAO,
         DESCRICAO_ESTADO_CIVIL,
         DESC_COR_RACA,
         DESPESA_MAX_CAMPANHA,
         DESC_SIT_TOT_TURNO) %>%
  rename(
    seq = SEQUENCIAL_CANDIDATO,
    cpf = CPF_CAND,
    situ = DES_SITUACAO_CANDIDATURA,
    colig_nome = NOME_LEGENDA,
    titulo = NUM_TITULO_ELEITORAL_CANDIDATO,
    idade = IDADE_DATA_ELEICAO,
    genero = DESCRICAO_SEXO,
    ocup = DESCRICAO_OCUPACAO, 
    instru = DESCRICAO_GRAU_INSTRUCAO,
    estcivil = DESCRICAO_ESTADO_CIVIL,
    cor = DESC_COR_RACA,
    despmax = DESPESA_MAX_CAMPANHA,
    result = DESC_SIT_TOT_TURNO)

##########################################################
###### Parte 4 - agregando e combinando por município#####
##########################################################

#deixando as variáveis de voto como numérica e a seq, nossa chave, como string
resultados$votos_total <- as.numeric(resultados$votos_total)
resultados$seq <- as.character(resultados$seq)
candidatos$seq <- as.character(candidatos$seq)

#criando um banco que tem o agregado de votos por município
resultado_mun <- resultados %>% 
  group_by(ue) %>% 
  summarise(votos_total_mun = sum(votos_total))

#adicionando o voto total por municipio no banco de resultados
resultados<- right_join(resultados, resultado_mun, by = "ue")

#criando um banco que tem o agregado de votos por candidato
resultado_cand <- resultados %>% 
  group_by(seq) %>% 
  summarise(votos_total_cand = sum(votos_total))

#adicionando o voto total por municipio no banco de resultados e criando uma variável da porcentagem do candidato
resultados <- resultados %>%
  right_join(resultado_cand, by = "seq") %>%
  mutate(prop_mun_cand = votos_total_cand / votos_total_mun)

##########################################################
###### Parte 6 - agregando e combinando por candidato#####
##########################################################

#juntando o banco de candidatos e o de resultados 
#também deixa o banco apenas com as variáveis únicas
resultados_2 <- inner_join(candidatos, resultados, by = c("seq"))

#olhando quais são as variáveis que ficaram no banco pra checar que todas vieram
glimpse(resultados_2)

###############################################################
###### Parte 6 - selecionando apenas a cidade de São Paulo#####
###############################################################

#vendo qual o código da unidade eleitoral de São Paulo para fazer o filtro.
#como é a maior cidade, vamos ordenar o banco pelo maior número de votos totais no municipio

resultados_2 <- resultados_2 %>% arrange(desc(votos_total_mun))
head(resultados_2)

#o número da cidade de SP é 71072

dados_SP <- resultados_2 %>% 
  filter(ue == "71072")

#banco com resultados por candidatos únicos como linha. Seleciona todas as linhas exceto as de voto por zona.
dados_cand <- dados_SP %>%
  select(-votos_total, -num_zona)

#deixa as linhas únicas por candidato.
dados_cand <- distinct(dados_cand) 
dados <- dados_cand

#vendo se tem os números corretos de eleitos
table(dados_cand$result, dados_cand$genero)

#salvando os dois bancos:

#banco com as observações por candidatos
write.table(dados_cand, "result_cand_SP.csv", sep = ";", fileEncoding ="latin1", row.names = F)
#banco com as observações por votação por zona
write.table(dados_SP, "result_candzona_SP.csv", sep = ";", fileEncoding ="latin1", row.names = F)
