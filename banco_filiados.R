#O objetivo desse script é baixar e organizar os dados de filiados da cidade de São Paulo, disponibilizados pelo TSE. Também
#é feita a classificação de gênero dos filiados a partir dos seus nomes.

#indicando a pasta onde ficará salvo
setwd("C:\\Users\\d841255\\Desktop\\filiados")

#carregando os pacotes necessários
library(readr)
library(dplyr)
library(data.table)
library(stringr)
library(stringi)
#install.packages("gender")
library(gender)
library(tidyverse)

#Quando o site "http://www.tse.jus.br/partidos/filiacao-partidaria/relacao-de-filiados" é acessado, é possível ver que a estrutura
#do link para baixar o .zip da relação de filiados é:
#http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_dem_sp.zip
#ou seja, só muda o partido e o estado. Criando um loop para gerar os links  de cada partido, dá pra baixar todos de uma vez sem
#precisar clicar 34 vezes (!) para baixar a relação de todos os partidos.

#criando a relação de partidos para gerar os links. Também seria possível criar uma relação por estados para o loop, 
#mas como estou interessada somente na cidade de São Paulo, não vou fazer para baixar todos. 
partidos <- c("novo",
              "pen",
              "pc_do_b",
              "pcb",
              "pco",
              "pdt",
              "phs",
              "pmdb",
              "pmb",
              "pmn",
              "pp",
              "ppl",
              "pps",
              "pr",
              "prb",
              "pros",
              "prp",
              "prtb",
              "psb",
              "psc",
              "psd",
              "psdb",
              "psdc",
              "psl",
              "psol",
              "pstu",
              "pt",
              "pt_do_b",
              "ptb",
              "ptc",
              "ptn",
              "pv",
              "rede",
              "sd")

#criando o link base
url_base <- "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_PARTIDO_sp.zip"

#loop para criar os links, baixar o .zip em um arquivo temporário e extrair seu conteúdo:
  for (partido in partidos){
  print(partido)
  url <- gsub("PARTIDO", partido, url_base)
  download.file(url, "temp.zip", quiet = F)
  unzip("temp.zip")
  file.remove("temp.zip")
} 

#vendo como ficou a pasta depois de descompactar:
list.dirs()
#pegando a última pasta da árvore, que é onde estão os arquivos .csv
lista.arquivos<- list.files("./aplic/sead/lista_filiados/uf")
print(lista.arquivos)
#os arquivos que estão indicados com _jud_ se referem às pendências judiciais da relação de filiados. 
#Como o interesse é apenas nos filiados regulares, não é preciso trabalhar com esses nomes.
#criando uma lista de arquivos apenas com a relação de filiados normal
lista.banco <- grep(pattern="filiados_", lista.arquivos, value=TRUE)

#juntando todos os arquivos em um só, já filtrando pelo município de SP para acelerar a junção.
#(ainda assim, demora um pouco. pegue um café, dê uma volta!)
for (file in lista.banco) {
  dado <- fread(file) 
  dado <- dado %>%
    filter(`NOME DO MUNICIPIO` == "SÃO PAULO")
  filiados<-bind_rows(filiados, dado)
}

#por alguma razão ele ta criando com linhas repetidas! dando o distinct, o dado fica certo.
#outros ajustes no banco:
filiados <- filiados %>%
#tirando duplicados
  distinct() %>%
#renomeando as variáveis
  rename(ext_data = `DATA DA EXTRACAO`,
         ext_hora_ext = `HORA DA EXTRACAO`,
         insc = `NUMERO DA INSCRICAO`,
         nome = `NOME DO FILIADO`,
         sigla = `SIGLA DO PARTIDO`,
         nome_partido = `NOME DO PARTIDO`,
         uf = UF,
         cod_mun = `CODIGO DO MUNICIPIO`,
         nome_mun = `NOME DO MUNICIPIO`,
         zona = `ZONA ELEITORAL`,
         secao = `SECAO ELEITORAL`,
         data_fili = `DATA DA FILIACAO`,
         situ_reg = `SITUACAO DO REGISTRO`,
         tipo_reg = `TIPO DO REGISTRO`,
         data_proces = `DATA DO PROCESSAMENTO`,
         data_desfili = `DATA DA DESFILIACAO`,
         data_cancel = `DATA DO CANCELAMENTO`,
         data_regula = `DATA DA REGULARIZACAO`,
         motivo_cancel = `MOTIVO DO CANCELAMENTO`) %>%
  #extrai apenas o primeiro nome do nome completo, retira acentos e deixa em minúsculo.
  #essa transformação será utilizada no próximo passo para a classificação de gênero.
  mutate(primeironome = word(nome, 1)) %>%
  mutate(primeironome = tolower(stri_trans_general(primeironome, "Latin-ASCII")))

#salvando o banco gerado até agora
#write.table(filiados, "filiados_SP.csv", sep = ";", fileEncoding ="latin1", row.names = F)

#################################################################
#### CLASSIFICAÇÃO DE GÊNERO DOS FILIADOS PELO PRIMEIRO NOME ####
#################################################################

#Para conseguir classificar o gênero dos filiados, serão feitas duas etapas:
#primeiro, a partir dos dados de candidatura do Brasil todo de 2016
#em segundo, com os nomes que não forem classificados com o primeiro método,
#usando o pacote gender, que classifica os nomes de acordo com os dados do Censo Americano de 1932 a 2012.
#o objetivo desse segundo passo é dar conta de classificar nomes mais incomuns ou estrangeiros que não constem
#na relação de candidatos em 2016.


###pegando os nomes dos candidatos do brasil todo (demora um pouco)
setwd("C:\\Users\\d841255\\Desktop\\candidatos")
#baixando o arquivo com os dados de candidaturas
url_cand <- "http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2016.zip"
download.file(url_cand, "temp.zip", quiet = F)
#descompactando o arquivo e removendo o .zip da pasta
unzip("temp.zip")
file.remove("temp.zip")

#criando uma lista de todos os arquivos contidos na pasta
lista.arquivos <-list.files(file.path(getwd()))
print(lista.arquivos)

#criando uma lista para pegar somente os documentos de votação
lista.candidatos <- grep(pattern="consulta_cand_2016_", lista.arquivos, value=TRUE)
print(lista.candidatos)

#criando o dataframe vazio que receberá os dados
candidatos <- data.frame()

#Loop para coletar os dados que queremos:
#vai abrir cada uma das listas, renomear as colunas de acordo com o indicado no arquivo LEIAME.
#incluir no dataframe vazio
for(arquivo in lista.candidatos){
  print (arquivo)
  d <- read.delim(arquivo, sep = ";", header = F)
  candidatos <-bind_rows(candidatos, d)
} 
#removendo o banco de dados parcial ao final do empilhando
rm(d)

colnames(candidatos)<- c("DATA_GERACAO",
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
                         "DESC_SIT_TOT_TURNO")


#criando um banco que contenha somente o nome e o sexo do candidato
nomes <- candidatos %>%
  select(NOME_CANDIDATO, DESCRICAO_SEXO) %>%
  rename(sexo = DESCRICAO_SEXO,
         nome_comp = NOME_CANDIDATO)


#deixando uma lista única de primeiros nomes por gênero, a ser utilizada para o match
nomes <- nomes %>%
  mutate(primeironome = word(nome_comp, 1)) %>%
  mutate(primeironome = tolower(stri_trans_general(primeironome, "Latin-ASCII"))) %>%
  select(-nome_comp)%>%
  distinct()

#alguns nomes são marcados tanto como FEMININO quanto MASCULINO. Para obter quais são esses nomes:
nomes$duplicado <- duplicated(nomes$primeironome)
unico <- unique(nomes$primeironome)

 
#checando quais são os nomes duplicados
duplicados <- nomes %>%
  filter(duplicado == "TRUE")
#Em checagem aleatória, todos os nomes duplicados marcados como
#TRUE eram classificações de sexo mais incomuns. Por exemplo, o nome "adriana" foi classificado como "FEMININO"; a classificação
#do mesmo nome como "MASCULINO" fica marcada como TRUE quando damos o duplicado.

#removendo os nomes de classificação duplicada. 
nomes <- nomes %>%
  filter(duplicado == FALSE)

#juntando no banco de filiados
filiados <- filiados %>%
  left_join(nomes, by = "primeironome")

#vendo quais nomes faltaram ser classificados
falta <- filiados %>%
  filter(is.na(sexo))

#criando uma lista de nomes que falta verificar o sexo
falta_gen <- falta %>%
  select(insc,primeironome)

#aplicando o algoritmo do pacote gender nesses nomes
gender <- gender(falta_gen$primeironome, method = "ssa")

#vendo se as proporções entre homens e mulheres estão similares entre os dois métodos
table(filiados$sexo)
table(gender$gender)

#deixando o banco de filiados apenas com os casos completos - isto é, com os nomes que foram classificados
#com a lista de candidaturas
filia_cand <- filiados %>%
  filter(complete.cases(.))

#deixando uma lista de primeiros nomes e gênero a partir do pacote gender
genero_gender <- gender %>%
  select(name, gender) %>%
  rename(primeironome = name,
         sexo = gender)

#aplicando a classificação do pacote gender nos nomes que faltaram classificação
filia_gender <- left_join(falta, genero_gender, by ="primeironome")

#limpando o banco para receber os dados da coluna gerada pelo gender
filia_gender <- filia_gender %>%
  select(-sexo.x) %>%
  rename(sexo = sexo.y)

#juntando o banco classificado pelas candidaturas e pelo gender, e limpando repetições
filia_completo <- bind_rows(filia_gender, filia_cand) %>%
  distinct()


#padronizando a codificação da variável, para indicar como "INDETERMINADO" aqueles que não foram classificados
#por nenhum dos métodos
filia_completo <- filia_completo %>%
  mutate(sexo = ifelse(sexo == "female", "FEMININO", sexo)) %>%
  mutate(sexo = ifelse(sexo == "male", "MASCULINO", sexo)) %>%
  mutate(sexo = ifelse(is.na(sexo), "INDETERMINADO", sexo))

#vendo como ficou - 3,22% dos nomes não puderam ser classificados em nenhum dos métodos.
table(filia_completo$sexo)

#salvando a tabela final
write.table(filia_completo, "filiados_SP_completo.csv", sep = ";", fileEncoding ="UTF-8", row.names = F)
