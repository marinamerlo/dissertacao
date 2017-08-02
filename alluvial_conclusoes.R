install.packages("alluvial")
install.packages("ggplot2")
install.packages("data.table")
install.packages("dplyr")

library(alluvial)
library(ggplot2)
library(data.table)
library(dplyr)
library(ggalluvial)

getwd()

dados<- fread("dados.csv")

dados$Ativ.Partidaria  = factor(dados$Ativ.Partidaria, levels=c("Próprio", "Família", "Mov. Estudantil"))
dados$`Decisão Candidatura` = factor(dados$`Decisão Candidatura`, levels=c("Pessoal","Liderança(s) Partidárias(s)"))
dados$`Apoio Candidatura` = factor(dados$`Apoio Candidatura`, levels=c("Outros","Padrinho(s) Político(s)","Dirigentes partidários"))
dados$Vereadora = factor(dados$Vereadora, levels=c("Janaína Lima (NOVO)",
                                                   "Edir Sales (PSD)",
                                                   "Adriana Ramalho (PSDB)",
                                                   "Aline Cardoso (PSDB)",
                                                   "Juliana Cardoso (PT)",
                                                   "Isa Penna (PSOL)",
                                                   "Sâmia Bomfim (PSOL)"))
ord <- list(NULL,NULL,NULL,
            NULL,NULL,NULL,
            NULL)

alluvial(
  select(dados, Vereadora, `Ativ.Politica`,`Ativ.Partidaria`,
         `Filiação`, `Decisão Candidatura`,`Apoio Candidatura`,`Capital Político`),
  freq=dados$n,
  col = ifelse(dados$Vereadora == "Janaína Lima (NOVO)", "darkorange2", 
               ifelse(dados$Vereadora == "Adriana Ramalho (PSDB)", "mediumblue",
                      ifelse(dados$Vereadora == "Aline Cardoso (PSDB)", "royalblue4",
                             ifelse(dados$Vereadora == "Edir Sales (PSD)", "seagreen",
                                    ifelse(dados$Vereadora == "Juliana Cardoso (PT)", "firebrick1",
                                           ifelse(dados$Vereadora == "Sâmia Bomfim (PSOL)", "yellow3",
                                                  ifelse(dados$Vereadora == "Isa Penna (PSOL)", "yellow2","grey"))))))),
  alpha = 0.7,
  blocks=TRUE,
  border = ifelse(dados$Vereadora == "Janaína Lima (NOVO)", "darkorange2", 
                  ifelse(dados$Vereadora == "Adriana Ramalho (PSDB)", "mediumblue",
                         ifelse(dados$Vereadora == "Aline Cardoso (PSDB)", "royalblue3",
                                ifelse(dados$Vereadora == "Edir Sales (PSD)", "seagreen",
                                       ifelse(dados$Vereadora == "Juliana Cardoso (PT)", "firebrick1",
                                              ifelse(dados$Vereadora == "Sâmia Bomfim (PSOL)", "yellow3",
                                                     ifelse(dados$Vereadora == "Isa Penna (PSOL)", "yellow2","grey"))))))),
  ordering=ord,
  gap.width=0.15,
  cex=0.1)
