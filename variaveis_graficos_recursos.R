#usando o banco que tem as observações por votos por zona e por recurso recebido (obs = 957000 linhas)
#junta o banco de resultados e votos direto com o banco de recursos, sem fazer o aggregate e reshape
#é melhor para fazer os gráficos de recursos!

library(readr)
library(tidyverse)
library(data.table)

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


############### Usando agora os dados de resultados por candidato (obs. = 1275) ############ 
############### Fica mais fácil pra fazer os gráficos das vereadoras eleitas! ##############

#banco de resultados e candidaturas
dados2 <- fread("result_cand_SP.csv")
#banco de receitas
dados3 <- fread("receitas_2016.csv")

#juntando os dois
dados4 <- left_join(dados2, dados3, by ="seq")

#renomeando algumas variáveis
dados4 <- dados4 %>% 
  mutate(genero = recode(genero, 
                         "MASCULINO" = "Masculino", 
                         "FEMININO" = "Feminino")) %>%
  mutate(result = recode(result,
                         "ELEITO POR MÉDIA" = "Eleito por média", 
                         "ELEITO POR QP" = "Eleito por QP", 
                         "NÃO ELEITO" = "Não Eleito", 
                         "SUPLENTE" ="Suplente")) %>%
  mutate(eleito = recode(result, 
                         "Eleito por média" = "Eleito", 
                         "Eleito por QP" = "Eleito", 
                         "Suplente" = "Não Eleito",
                         "Não Eleito" = "Não Eleito"))

#criando o total de receita
dados4 <- dados4 %>%
  group_by(seq) %>%
  mutate(valor_total_cand = sum(valor, na.rm=T))

#criando o total de receita por coligação
valor_colig <- dados %>%
  group_by(colig) %>%
  summarise(valor_total_colig = sum(valor_total_cand, na.rm=T))

#criando o total de receita por partido
valor_partido <- dados %>%
  group_by(sigla) %>%
  summarise(valor_total_partido = sum(valor_total_cand, na.rm=T))

#juntando os dois valores acima no banco
dados4 <- dados4 %>%
  left_join(valor_colig, by ="colig") %>%
  left_join(valor_partido, by ="sigla")

#criando o total do fundo partidário recebido
total_fundo <- dados4 %>%
  filter(fonte == "Fundo Partidario") %>%
  group_by(seq) %>%
  summarise(valor_total_fundo_cand = sum(valor, na.rm=T))

#juntando no banco
dados4 <- dados4 %>%
  left_join(total_fundo, by ="seq")

#criando novas variáveis de porcentagem recebida de cada tipo de recurso ou origem
dados4 <- dados4 %>%
  mutate(pct_valor_total_partido_cand = valor_total_cand / valor_total_partido) %>%
  mutate(pct_valor_total_colig_cand = valor_total_cand / valor_total_colig) %>%
  mutate(pct_valor_total_fundo_cand = valor_total_fundo_cand / valor_total_cand) %>%
  mutate(pct_valor_total_fundo_cand, 
         pct_valor_total_fundo_cand = ifelse(is.na(pct_valor_total_fundo_cand) == TRUE, 0, pct_valor_total_fundo_cand))

dados4$tipo <- ifelse(dados4$tipo == "Comercialização de bens ou realização de eventos" | dados4$tipo == "Recursos de origens não identificadas" |dados4$tipo == "Rendimentos de aplicações financeiras",
                      "Outros", dados4$tipo)


#################################################################################
############################## GRÁFICOS E TABELAS ###############################
#################################################################################


#gráfico de barras do tipo de receita recebida por gênero e resultado
  ggplot(dadosfull, aes(genero, valor, fill=tipo)) +
geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") + 
  facet_grid(. ~eleito)
ggsave("stacked_bar_plot_genero_eleito_tipo.png", width = 10, height = 5)


#gráfico de barras do tipo e da fonte de receita recebida por gênero e resultado
ggplot(dadosfull, aes(fonte, valor, fill=tipo)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(palette = "Set1") + 
  facet_grid(. ~eleito~genero)
ggsave("stacked_bar_plot_genero_eleito_fonte_tipo.png", width = 10, height = 5)


##Criando a variável rendimento/ custo por voto:
rendimento <- dados %>%
  mutate(valor_total_cand = valor_origem_fundo_cand + valor_origem_outros_cand) %>%
  filter(valor_total_cand > 0 & votos_total_cand > 0) %>%
  mutate(rendimento = valor_total_cand / votos_total_cand)

#vendo como ficou
summary(rendimento$rendimento)

#gerando a tabela com as estatísticas dessa medida
rendimento_stats <- rendimento %>%
  group_by(eleito, genero) %>%
  mutate(rendimento = as.numeric(rendimento)) %>%
  summarise(soma_rendimento = sum(rendimento, na.rm = TRUE),
            media_rendimento = mean(rendimento, na.rm = TRUE),
            mediana_rendimento = median(rendimento, na.rm = TRUE),
            desvio_rendimento = sd(rendimento, na.rm = TRUE),
            minimo_rendimento = min(rendimento, na.rm = TRUE),
            maximo_rendimento = max(rendimento, na.rm = TRUE))
write.table(rendimento_stats, "rendimento_stats.csv", row.names = F, sep = ";", dec =",")

#boxplot do rendimento por gênero e resultado
ggplot()+ 
  geom_boxplot(aes(x = eleito, y = rendimento, fill=genero), data = rendimento) +
  scale_y_continuous(limits = c(0, 100)) + #tira o Suplicy do gráfico, pq ele distorce
  theme_minimal() +
  scale_fill_brewer(name = "Gênero", palette = "Set1") + 
  labs(title = "Custo por voto",
       y ="Custo por voto por resultado eleitoral e gênero",
       x = "Resultado")+
  theme(legend.box.background = element_rect(),
        legend.position = c(.25, .80),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.box.margin = margin(3, 3, 3, 3),
        plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x=element_text(angle=45, hjust=1)) +
ggsave("boxplot_rendimento.png", width = 10, height = 5)


#gerando a tabela de estatísticas do valor total de receita recebido
valor_stats <- dadosfull %>%
  group_by(eleito, genero) %>%
  mutate(valor_total_cand = as.numeric(valor_total_cand)) %>%
  summarise(soma_valor = sum(valor_total_cand, na.rm = TRUE),
            media_valor = mean(valor_total_cand, na.rm = TRUE),
            mediana_valor = median(valor_total_cand, na.rm = TRUE),
            desvio_valor = sd(valor_total_cand, na.rm = TRUE),
            minimo_valor = min(valor_total_cand, na.rm = TRUE),
            maximo_valor = max(valor_total_cand, na.rm = TRUE))
write.table(valor_stats, "valor_stats.csv", row.names = F, sep = ";", dec =",")

#gerando a tabela de estatísticas dos votos recebidos
votos_stats <- dadosfull %>%
  group_by(eleito, genero) %>%
  mutate(votos_total_cand = as.numeric(votos_total_cand)) %>%
summarise(soma_votos = sum(votos_total_cand, na.rm = TRUE),
          media_votos = mean(votos_total_cand, na.rm = TRUE),
          mediana_votos = median(votos_total_cand, na.rm = TRUE),
          desvio_votos = sd(votos_total_cand, na.rm = TRUE),
          minimo_votos = min(votos_total_cand, na.rm = TRUE),
          maximo_votos = max(votos_total_cand, na.rm = TRUE))
write.table(votos_stats, "votos_stats.csv", row.names = F, sep = ";", dec =",")



#criando um banco separado só para as eleitas e Isa Penna, que também ocupou o cargo e foi entrevistada.
#esse banco servirá para fazer os gráficos relativos somente às vereadoras que ocuparam o cargo
eleitas <- dados4 %>%
  filter(eleito == "Eleito" & genero == "Feminino" | nome_urna == "ISA PENNA")  %>%
  mutate(rendimento = valor_total_cand / votos_total_cand)

#agrupando os tipos de receita mais incomuns na categoria "Outros"
eleitas$tipo <- ifelse(eleitas$tipo == "Comercialização de bens ou realização de eventos" |eleitas$tipo == "Recursos de origens não identificadas" |eleitas$tipo == "Rendimentos de aplicações financeiras",
                       "Outros", eleitas$tipo)

#alterando a ordem do banco para que fique por total do fundo partidário recebido
eleitas <- eleitas %>%
  mutate(fonte = factor(fonte,levels=c("Fundo Partidario", "Outros Recursos"), ordered = T)) %>%
  arrange(fonte, pct_valor_total_fundo_cand) 

#vendo o total de receitas recebidas por outros candidatos
total_candidato <- eleitas %>%
  filter(tipo == "Recursos de outros candidatos") %>%
  group_by(seq) %>%
  summarise(valor_total_outrocand = sum(valor, na.rm=T))
#juntando no banco
eleitas <- eleitas %>%
  left_join(total_candidato, by ="seq")
#criando a porcentagem de receitas recebidas por outros candidatos
eleitas <- eleitas %>%
  mutate(pct_outrocand = valor_total_cand/valor_total_outrocand) %>%
  mutate(pct_outrocand, 
         pct_outrocand = ifelse(is.na(pct_outrocand) == TRUE, 0.0, pct_outrocand))

#salvando o banco apenas de eleitas
write.table(eleitas, "receitas_eleitas.csv", row.names = F, sep = ";", dec =",")


##porcentagem do fundo partidário - eleitas
ggplot(data = eleitas, aes(x = reorder(nome_urna, pct_valor_total_fundo_cand), y = valor, 
                           fill=factor(fonte))) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name = "Origem da receita",palette = "Set2") + 
  coord_flip() + 
  labs(title = "Porcentagem do Fundo Partidário nas Receitas Totais",
       x = "Nome da candidata",
       y = "Porcentagem da receita total") + 
  scale_y_reverse(breaks = c(0, 0.25, 0.5, 0.75, 1),
                  labels = c("100%","75%","50%", "25%", "0%"))+
  theme(axis.text.x=element_text(angle=50, hjust=1))
ggsave("barplot_origem_receita_eleitas_v2.png", width = 10, height = 5)


## pra ordenar por coligação quando for fazer o gráfico
colig_rank <-fread("colig_rank.csv")
dados4 <- left_join(dados4, colig_rank, by = "colig")


#porcentagem por tipo de receita - eleitas
ggplot(eleitas, aes(reorder(nome_urna, nome_urna), valor, fill=tipo)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name="Tipo da receita",palette = "Set1") + 
  coord_flip() +
  labs(title = "Tipo de Receitas",
       x = "Nome da candidata",
       y = "Porcentagem da receita total") + 
  theme(axis.text.x=element_text(angle=50, hjust=1))
ggsave("barplot_tipo_receita_eleitas.png", width = 10, height = 5)

#criando uma tabela separada das eleitas para ver o custo por voto 
rendimento_eleitas <- eleitas %>%
  group_by(nome_urna, sigla, colig, rendimento)%>%
  distinct()
write.table(rendimento_eleitas, "rendimento_eleitas.csv", row.names = F, sep = ";", dec =",")

#tabela das estatísticas dos valores recebidos apenas para as eleitas
valor_stats <- dados %>%
  group_by(eleito, genero) %>%
  mutate(valor_total_cand = as.numeric(valor_total_cand)) %>%
  summarise(soma_valor = sum(valor_total_cand, na.rm = TRUE),
            media_valor = mean(valor_total_cand, na.rm = TRUE),
            mediana_valor = median(valor_total_cand, na.rm = TRUE),
            desvio_valor = sd(valor_total_cand, na.rm = TRUE),
            minimo_valor = min(valor_total_cand, na.rm = TRUE),
            maximo_valor = max(valor_total_cand, na.rm = TRUE))
write.table(valor_stats, "recursos_stats.csv", row.names = F, sep = ";", dec =",")  


#boxplot do total de recursos recebidos por gênero e resultado
ggplot()+ 
  geom_boxplot(aes(x = eleito, y = valor, fill=genero), data = dados4) +
  theme_minimal() +
  scale_y_log10() +
  scale_fill_brewer(name = "Gênero", palette = "Set1") + 
  labs(title = "Recursos por gênero e resultado",
       y ="Recursos",
       x = "Resultado") + 
  theme(axis.text.x=element_text(angle=50, hjust=1))
ggsave("boxplot_recursos_genero_eleito.png", width = 10, height = 5)


#porcentagem do fundo partidário - total
ggplot(data = dados4, aes(x = genero, y = valor, fill=fonte)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name = "Origem da receita",palette = "Set2") + 
  coord_flip() + 
  labs(title = "Porcentagem do Fundo Partidário nas Receitas Totais por resultado e gênero",
       x = "Gênero",
       y = "Porcentagem da receita total")+ 
  theme(axis.text.x=element_text(angle=50, hjust=1)) + 
  scale_y_reverse(breaks = c(0, 0.25, 0.5, 0.75, 1),
                  labels = c("100%","75%","50%", "25%", "0%"))+
  facet_grid(. ~eleito)
ggsave("barplot_origem_receita_total_v2.png", width = 10, height = 5)


#porcentagem por tipo de receita 
ggplot(dados4, aes(genero, valor, fill=tipo)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name="Tipo da receita",palette = "Set1") + 
  coord_flip() +
  labs(title = "Tipo de Receitas",
       x = "Nome da candidata",
       y = "Porcentagem da receita total") + 
  theme(axis.text.x=element_text(angle=50, hjust=1)) + 
  facet_grid(. ~eleito)
ggsave("barplot_tipo_receita_total.png", width = 10, height = 5)

#dados só com eleites
dados4 <- dados4 %>% 
  mutate(eleito_dummy = recode(result, 
                               "Eleito por média" = 1, 
                               "Eleito por QP" = 1, 
                               "Suplente" = 0,
                               "Não Eleito" = 0))
#fazendo a variável vereadores, que indica quanto cada coligação elegeu no total
summary(dados$eleito_dummy)
dados_colig <- dados4 %>%
  group_by(colig, eleito_dummy) %>%
  summarise(vereadores = sum(eleito_dummy)) %>%
  filter(eleito_dummy == 1)

#criando um banco que só tenha os candidatos que estão em coligações que elegeram ao menos um vereador
colig <- dados4 %>%
  right_join(dados_colig, by = "colig")



##porcentagem do fundo partidário - coligação
ggplot(data = colig, aes(x = genero, y = valor, fill=fonte)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name = "Origem da receita",palette = "Set2") + 
  coord_flip() + 
  labs(title = "Porcentagem do Fundo Partidário nas Receitas Totais por resultado e gênero",
       x = "Gênero",
       y = "Porcentagem da receita total")+ 
  theme(axis.text.x=element_text(angle=50, hjust=1)) + 
  facet_grid(. ~colig) + 
  coord_flip()
ggsave("barplot_origem_receita_total.png", width = 10, height = 5)


#porcentagem por tipo de receita - coligação
ggplot(colig, aes(genero, valor, fill=tipo)) +
  geom_col(position = "fill") + 
  theme_minimal() +
  scale_fill_brewer(name="Tipo da receita",palette = "Set1") + 
  coord_flip() +
  labs(title = "Tipo de Receitas",
       x = "Nome da candidata",
       y = "Porcentagem da receita total") + 
  theme(axis.text.x=element_text(angle=50, hjust=1)) + 
  facet_grid(. ~colig)
ggsave("barplot_tipo_receita_total.png", width = 10, height = 5)


