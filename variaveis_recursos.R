#usando o banco que tem as observações por votos por zona e por recurso recebido (obs = 957000 linhas)
#junta o banco de resultados e votos direto com o banco de recursos, sem fazer o aggregate e reshape
#é melhor para fazer os gráficos de recursos!

##########################
### TOTAL DE RECURSOS ###

#variável que tem o total de recursos recebidos por candidato
valor_total_cand <- dadosfull %>% 
  group_by(nome) %>% 
  summarise(valor_total_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_total_cand, by = "nome")
#variável que tem o total de recursos recebidos por partido (soma dos candidatos)
valor_total_partido <- dadosfull %>% 
  group_by(sigla) %>% 
  summarise(valor_total_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_total_partido, by = "sigla")
#variável que tem o total de recursos recebidos por coligação (soma dos candidatos)
valor_total_colig <- dadosfull %>% 
  group_by(colig) %>% 
  summarise(valor_total_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_total_colig, by = "colig")


###############################
### ORIGEM FUNDO PARTIDÁRIO ###

#total de origem fundo partidário por candidato
valor_origem_fundo_cand <- dadosfull %>% 
  filter(fonte == "Fundo Partidario") %>%
  group_by(nome) %>% 
  summarise(valor_origem_fundo_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_origem_fundo_cand, by = "nome")
#total de origem fundo partidário por partido (soma dos candidatos)
valor_origem_fundo_partido <- dadosfull %>% 
  filter(fonte == "Fundo Partidario") %>%
  group_by(sigla) %>% 
  summarise(valor_origem_fundo_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_origem_fundo_partido, by = "sigla")
#total de origem fundo partidário por coligação (soma dos candidatos)
valor_origem_fundo_colig <- dadosfull %>% 
  filter(fonte == "Fundo Partidario") %>%
  group_by(colig) %>% 
  summarise(valor_origem_fundo_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_origem_fundo_colig, by = "colig")


##############################
### TIPO RECURSOS PRÓPRIOS ###

#total do tipo recursos próprios por candidato
valor_tipo_proprio_cand <- dadosfull %>% 
  filter(tipo == "Recursos próprios") %>%
  group_by(nome) %>% 
  summarise(valor_tipo_proprio_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_proprio_cand, by = "nome") 
#total do tipo recursos próprios por partido (soma dos candidatos)
valor_tipo_proprio_partido <- dadosfull %>% 
  filter(tipo == "Recursos próprios") %>%
  group_by(sigla) %>% 
  summarise(valor_tipo_proprio_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_proprio_partido, by = "sigla") 
#total do tipo recursos próprios por coligação (soma dos candidatos)
valor_tipo_proprio_colig <- dadosfull %>% 
  filter(tipo == "Recursos próprios") %>%
  group_by(colig) %>% 
  summarise(valor_tipo_proprio_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_proprio_colig, by = "colig") 


############################
### TIPO RECURSOS OUTROS ###

#especificando quais são os tipos de recursos operacionalizados como "Outros"
outros <- c("Doações pela Internet", 
            "Comercialização de bens ou realização de eventos", 
            "Recursos de origens não identificadas", 
            "Rendimentos de aplicações financeiras")

#total do tipo outros por candidato
valor_tipo_outros_cand <- dadosfull %>% 
  filter(tipo %in% outros) %>%
  group_by(nome) %>% 
  summarise(valor_tipo_outros_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_outros_cand, by = "nome") 
#total do tipo outros por partido (soma dos candidatos)
valor_tipo_outros_partido <- dadosfull %>% 
  filter(tipo %in% outros) %>%
  group_by(sigla) %>% 
  summarise(valor_tipo_outros_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_outros_partido, by = "sigla") 
#total do tipo outros por coligação (soma dos candidatos)
valor_tipo_outros_colig <- dadosfull %>% 
  filter(tipo %in% outros) %>%
  group_by(colig) %>% 
  summarise(valor_tipo_outros_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_outros_colig, by = "colig") 


#######################################
### TIPO RECURSOS OUTROS CANDIDATOS ###

#total do tipo recursos próprios por candidato
valor_tipo_candidatos_cand <- dadosfull %>% 
  filter(tipo == "Recursos de outros candidatos") %>%
  group_by(nome) %>% 
  summarise(valor_tipo_candidatos_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_candidatos_cand, by = "nome") 
#total do tipo recursos próprios por partido (soma dos candidatos)
valor_tipo_candidatos_partido <- dadosfull %>% 
  filter(tipo == "Recursos de outros candidatos") %>%
  group_by(sigla) %>% 
  summarise(valor_tipo_candidatos_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_candidatos_partido, by = "sigla") 
#total do tipo recursos próprios por coligação (soma dos candidatos)
valor_tipo_candidatos_colig <- dadosfull %>% 
  filter(tipo == "Recursos de outros candidatos") %>%
  group_by(colig) %>% 
  summarise(valor_tipo_candidatos_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_candidatos_colig, by = "colig") 


########################################
### TIPO RECURSOS PARTIDOS POLÍTICOS ###

#total do tipo recursos do partido por candidato
valor_tipo_partidos_cand <- dadosfull %>% 
  filter(tipo == "Recursos de partido político") %>%
  group_by(nome) %>% 
  summarise(valor_tipo_partidos_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_partidos_cand, by = "nome") 
#total do tipo recursos do partido por partido (soma dos candidatos)
valor_tipo_partidos_partido <- dadosfull %>% 
  filter(tipo == "Recursos de partido político") %>%
  group_by(sigla) %>% 
  summarise(valor_tipo_partidos_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_partidos_partido, by = "sigla") 
#total do tipo recursos do partido por coligação (soma dos candidatos)
valor_tipo_partidos_colig <- dadosfull %>% 
  filter(tipo == "Recursos de partido político") %>%
  group_by(colig) %>% 
  summarise(valor_tipo_partidos_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_partidos_colig, by = "colig") 


###################################
### TIPO RECURSOS PESSOA FÍSICA ###

#total do tipo recursos do partido por candidato
valor_tipo_pfisica_cand <- dadosfull %>% 
  filter(tipo == "Recursos de pessoas físicas") %>%
  group_by(nome) %>% 
  summarise(valor_tipo_pfisica_cand = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_pfisica_cand, by = "nome") 
#total do tipo recursos do partido por partido (soma dos candidatos)
valor_tipo_pfisica_partido <- dadosfull %>% 
  filter(tipo == "Recursos de pessoas físicas") %>%
  group_by(sigla) %>% 
  summarise(valor_tipo_pfisica_partido = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_pfisica_partido, by = "sigla") 
#total do tipo recursos do partido por coligação (soma dos candidatos)
valor_tipo_pfisica_colig <- dadosfull %>% 
  filter(tipo == "Recursos de pessoas físicas") %>%
  group_by(colig) %>% 
  summarise(valor_tipo_pfisica_colig = sum(as.numeric(valor), na.rm=TRUE))
dadosfull <- dadosfull %>%
  left_join(valor_tipo_pfisica_colig, by = "colig") 


## porcentagens de recursos por tipo e origem por candidato ##
dadosfull <- dadosfull %>%
  mutate(valor_origem_fundo_cand_pct = (valor_origem_fundo_cand / valor_total_cand)*100) %>%
  mutate(valor_tipo_proprio_cand_pct = (valor_tipo_proprio_cand / valor_total_cand)*100) %>%
  mutate(valor_tipo_outros_cand_pct = (valor_tipo_outros_cand / valor_total_cand)*100) %>%
  mutate(valor_tipo_candidatos_cand_pct = (valor_tipo_candidatos_cand / valor_total_cand)*100) %>%
  mutate(valor_tipo_partidos_cand_pct = (valor_tipo_partidos_cand / valor_total_cand)*100) %>%
  mutate(valor_tipo_pfisica_cand_pct = (valor_tipo_pfisica_cand / valor_total_cand)*100)
