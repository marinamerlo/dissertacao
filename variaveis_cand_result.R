### criando as variáveis necessárias ##

#usando o banco final com observações por candidato. 

library(ggplot2)
library(dplyr)


################################################################################################
#####################################VARIÁVEIS DE VOTOS E CANDIDATURA###########################
###############################################################################################

dados <- dados %>% 
  mutate(genero = recode(genero, 
                         "MASCULINO" = "Masculino", 
                         "FEMININO" = "Feminino"))

dados <- dados %>% 
  mutate(situ = recode(situ, 
                       "RENÚNCIA" = "Renúncia", 
                       "DEFERIDO" = "Deferido", 
                       "INDEFERIDO" = "Indeferido", 
                       "INDEFERIDO COM RECURSO" ="Indeferido com Recurso"))

dados <- dados %>% 
mutate(result = recode(result,
                     "ELEITO POR MÉDIA" = "Eleito por média", 
                     "ELEITO POR QP" = "Eleito por QP", 
                     "NÃO ELEITO" = "Não Eleito", 
                      "SUPLENTE" ="Suplente"))

 
#variável pra indicar se foi eleito ou não em 2016
dados <- dados %>% 
  mutate(eleito = recode(result, 
                         "Eleito por média" = "Eleito", 
                         "Eleito por QP" = "Eleito", 
                         "Suplente" = "Não Eleito",
                         "Não Eleito" = "Não Eleito"))
dados$eleito <- as.factor(dados$eleito)
summary(dados$eleito)


#deixando gênero como factor
dados$genero.f <- as.factor(dados$genero)
summary(dados$genero.f)

#total de candidaturas 
dados$cand_total <- 1275

#contagem de candidaturas femininas por partido
genero_partido <- dados %>%
  filter(genero == "Feminino") %>%
  group_by(sigla) %>%
  summarise(cand_part_fem = n())

#contagem de candidaturas femininas por coligação
genero_colig <- dados %>%
  filter(genero == "Feminino") %>%
  group_by(colig) %>%
  summarise(cand_colig_fem = n())

#total de candidaturas femininas por situação
genero_situ <- dados %>%
  filter(genero == "Feminino") %>%
  group_by(situ) %>%
  summarise(cand_situ_fem = n())

#total de candidaturas por partido
candidaturas_partido <- dados %>%
  group_by(sigla) %>%
  summarise(cand_part = n())

#total de candidaturas por coligação
candidaturas_colig <- dados %>%
  group_by(colig) %>%
  summarise(cand_colig = n())

#total de candidaturas por situação
candidaturas_situ <- dados %>%
  group_by(situ) %>%
  summarise(cand_situ = n())

##juntando no banco de dados
dados <- dados %>%
  left_join(genero_partido, by = "sigla") %>%
  left_join(genero_colig, by = "colig") %>%
  left_join(genero_situ, by = "situ") %>%
  left_join(candidaturas_partido, by = "sigla") %>%
  left_join(candidaturas_colig, by = "colig") %>%
  left_join(candidaturas_situ, by = "situ")

#fazendo as variáveis de proporção de candidaturas femininas por partido e coligação
dados <- dados %>%
  mutate(cand_part_fem_pct = (cand_part_fem / cand_part)) %>%
  mutate(cand_colig_fem_pct = (cand_colig_fem / cand_colig)) %>%
  mutate(cand_situ_fem_pct = (cand_situ_fem / cand_situ))

dados_votos_eleitas <- dados %>%
  filter(genero == "Feminino" & eleito == "Eleito") %>%
  summarise(soma_votos = sum(votos_total_cand, na.rm = TRUE),
            media_votos = mean(votos_total_cand, na.rm = TRUE),
            mediana_votos = median(votos_total_cand, na.rm = TRUE),
            desvio_votos = sd(votos_total_cand, na.rm = TRUE),
            minimo_votos = min(votos_total_cand, na.rm = TRUE),
            maximo_votos = max(votos_total_cand, na.rm = TRUE))

dados_votos_eleitos <- dados %>%
  filter(genero == "Masculino" & eleito == "Eleito") %>%
  summarise(soma_votos = sum(votos_total_cand, na.rm = TRUE),
            media_votos = mean(votos_total_cand, na.rm = TRUE),
            mediana_votos = median(votos_total_cand, na.rm = TRUE),
            desvio_votos = sd(votos_total_cand, na.rm = TRUE),
            minimo_votos = min(votos_total_cand, na.rm = TRUE),
            maximo_votos = max(votos_total_cand, na.rm = TRUE))

dados_votos_mulheres <- dados %>%
  filter(genero == "Feminino") %>%
  summarise(soma_votos = sum(votos_total_cand, na.rm = TRUE),
            media_votos = mean(votos_total_cand, na.rm = TRUE),
            mediana_votos = median(votos_total_cand, na.rm = TRUE),
            desvio_votos = sd(votos_total_cand, na.rm = TRUE),
            minimo_votos = min(votos_total_cand, na.rm = TRUE),
            maximo_votos = max(votos_total_cand, na.rm = TRUE))

dados_votos_homens <- dados %>%
  filter(genero == "Masculino") %>%
  summarise(soma_votos = sum(votos_total_cand, na.rm = TRUE),
            media_votos = mean(votos_total_cand, na.rm = TRUE),
            mediana_votos = median(votos_total_cand, na.rm = TRUE),
            desvio_votos = sd(votos_total_cand, na.rm = TRUE),
            minimo_votos = min(votos_total_cand, na.rm = TRUE),
            maximo_votos = max(votos_total_cand, na.rm = TRUE))
