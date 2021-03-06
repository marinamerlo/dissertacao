############################################################################
#####JUNTANDO O BANCO DE CANDIDATURAS/RESULTADOS COM O DE RECEITAS##########
############################################################################

#juntando com o banco de candidaturas e resultados
receitas <- fread("receitas_2016_unico.csv")
dados_cand <- fread("result_cand_SP.csv")
#juntando com o banco de candidaturas e resultados
glimpse(dados_cand) #ver arquivo banco_candidaturas_resultados.R
glimpse(receitas) #ver o script banco_receitas.R

#deixando a variável chave dos dois bancos, o número sequencial do candidato, como numérico
receitas$seq <- as.numeric(receitas$seq)
dados_cand$seq <- as.numeric(dados_cand$seq)

#leftjoin, para que os dados do receitas que têm equivalência ao dados_SP sejam adicionados ao dados_SP
dados <- left_join(dados_cand, receitas, by="seq")

##Checando o banco final com o que consta no TSE

##vendo o número único de candidatos e comparando com o que tem no TSE hoje (28/04)
seq <- as.data.frame(unique(dados$seq))
colnames(seq) <- c("seq")

#Temos 1275 candidatos - no site do TSE, são 1315.

#checando se essa diferença de 40 candidatos apresenta viés de gênero
unidados <- left_join(seq, dados, by="seq")
unidados <- unidados %>%
  select(seq, genero, result) %>%
  distinct(seq, genero, result) 

#checando se os dados contém os 55 eleitos
table(unidados$genero, unidados$result)

#teste qui quadrado pra diferença de proporções pra saber se os candidatos faltantes
#são independentes do gênero
#o primeiro número é o que contém nos dados, o segundo é o que consta no TSE
prop.dif.f <- 393/418
print(prop.dif.f)
prop.dif.m <- 882/919
print(prop.dif.m)
prop.dif.t <- 1275/1315

prop.dif <-as.data.frame(cbind(prop.dif.f, prop.dif.m))
chisq.test(prop.dif)

#	Chi-squared test for given probabilities
#data:  prop.dif
#X-squared = 0.00020111, df = 1, p-value = 0.9887

#limpando pra deixar as variáveis que interessam:
dados <- dados %>%
  select(-codeleicao, -desceleicao, -datahora)

write.table(dados, file="dados_final_unico.csv", sep=";", row.names=FALSE)
