devtools::install_github("mbojan/alluvial")


install.packages("data.table")

library(alluvial)
library(ggplot2)
library(data.table)
library(dplyr)

tit <- as.data.frame(Titanic)

# only two variables: class and survival status
tit2d <- aggregate( Freq ~ Class + Survived, data=tit, sum)

alluvial( tit2d[,1:2], freq=tit2d$Freq, xw=0.0, alpha=0.8,
          gap.width=0.1, col= "steelblue", border="white",
          layer = tit2d$Survived != "Yes" )

alluvial( tit[,1:4], freq=tit$Freq, border=NA,
          hide = tit$Freq < quantile(tit$Freq, .50),
          col=ifelse( tit$Survived == "No", "red", "gray") )

tit <- tibble::as_data_frame(Titanic)

tit %>% head() %>% knitr::kable()

alluvial(
  select(tit, Survived, Sex, Age, Class),
  freq=tit$n,
  col = ifelse(tit$Class == "Crew", "orange", 
  ifelse(tit$Class == "3rd", "red",
  ifelse(tit$Class == "2nd", "black",
  ifelse(tit$Class == "1st", "green", "grey")))),
  border = ifelse(tit$Survived == "Yes", "orange", "grey"),
  layer = tit$Survived != "Yes",
  alpha = 0.8,
  blocks=FALSE
)

getwd()
write.table(tit, "dados.csv", sep = ";", fileEncoding ="UTF-8", row.names = F)
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
            NULL,NULL,with(dados, order(partido)),
            NULL)



alluvial(
  select(dados, Vereadora, `Ativ.Politica`,`Ativ.Partidaria`,
         `Filiação`, `Decisão Candidatura`,`Apoio Candidatura`,`Capital Político`),
  freq=dados$n,
  col = ifelse(dados$Vereadora == "Janaína Lima (NOVO)", "orange", 
               ifelse(dados$Vereadora == "Adriana Ramalho (PSDB)", "blue",
                      ifelse(dados$Vereadora == "Aline Cardoso (PSDB)", "black",
                             ifelse(dados$Vereadora == "Edir Sales (PSD)", "seagreen",
                                    ifelse(dados$Vereadora == "Juliana Cardoso (PT)", "red",
                                           ifelse(dados$Vereadora == "Sâmia Bomfim (PSOL)", "yellow",
                                                  ifelse(dados$Vereadora == "Isa Penna (PSOL)", "yellow","grey"))))))),
  alpha = 0.5,
  blocks=TRUE,
  border = ifelse(dados$Vereadora == "Janaína Lima (NOVO)", "orange", 
                  ifelse(dados$Vereadora == "Adriana Ramalho (PSDB)", "blue",
                         ifelse(dados$Vereadora == "Aline Cardoso (PSDB)", "black",
                                ifelse(dados$Vereadora == "Edir Sales (PSD)", "seagreen",
                                       ifelse(dados$Vereadora == "Juliana Cardoso (PT)", "red",
                                              ifelse(dados$Vereadora == "Sâmia Bomfim (PSOL)", "yellow",
                                                     ifelse(dados$Vereadora == "Isa Penna (PSOL)", "yellow","grey"))))))),
  #ordering=ord,
  gap.width=0.1,
  layer=dados$partido

  
)

edit(dados)
