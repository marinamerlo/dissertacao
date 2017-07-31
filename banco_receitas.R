setwd("C:/Users/Marina/Desktop/Financiamento")

#descompactando o arquivo e removendo o .zip
url_financiamento <-"http://agencia.tse.jus.br/estatistica/sead/odsele/prestacao_contas/prestacao_contas_final_2016.zip"
download.file(url_financiamento,"prestacao_contas_final_2016.zip")
unzip("prestacao_contas_final_2016.zip")
file.remove("prestacao_contas_final_2016.zip")

#listando os documentos com os dados
lista.arquivos <-list.files(file.path(getwd()))
print(lista.arquivos)
#pegando somente os documentos somente das receitas
lista.arquivos <- grep(pattern="receitas_candidatos_", lista.arquivos, value=TRUE)
lista.arquivos
#excluindo o arquivo BR
lista.arquivos <- lista.arquivos[c(26)]
lista.arquivos
#abrindo o dataframe
for(arquivo in lista.arquivos){
  dados <- fread(file.path(getwd(), arquivo), stringsAsFactors = F, encoding = "Latin-1", header = T)
}
#checando como os dados ficaram por variavel
head(dados)

receitas <- dados %>%
  filter(`Sigla da UE` =="71072" & Cargo == "Vereador") %>%
  rename(
    codeleicao =  `Cód. Eleição`,
    desceleicao = `Desc. Eleição`,
    datahora = `Data e hora`,
    cnpjprest = `CNPJ Prestador Conta`,
    seq = `Sequencial Candidato`,
    uf = UF,
    ue = `Sigla da UE`,
    nomeue = `Nome da UE`,
    sigla = `Sigla  Partido`,
    num_cand = `Numero candidato`,
    cargo = Cargo,
    nome = `Nome candidato`,
    cpf = `CPF do candidato`,
    cpf_vice = `CPF do vice/suplente`,
    num_recibo = `Numero Recibo Eleitoral`,
    num_doc = `Numero do documento`,
    cpf_doador = `CPF/CNPJ do doador`,
    nome_doador = `Nome do doador`,
    nome_doador_receita = `Nome do doador (Receita Federal)`,
    ue_doador = `Sigla UE doador`,
    num_part_doador = `Número partido doador`,
    num_cand_doador = `Número candidato doador`,
    setor_doador = `Setor econômico do doador`,
    cod_setor_doador = `Cod setor econômico do doador`,
    data_receita = `Data da receita`,
    valor = `Valor receita`,
    tipo = `Tipo receita`,
    fonte = `Fonte recurso`,
    especie = `Especie recurso`,
    desc_receita = `Descricao da receita`,
    cpf_doador_origem = `CPF/CNPJ do doador originário`,
    nome_doador_origem = `Nome do doador originário`,
    nome_doador_origem_receita = `Nome do doador originário (Receita Federal)`,
    tipo_origem = `Tipo doador originário`,
    setor_origem = `Setor econômico do doador originário`) %>%

receitas <- receitas %>%
  mutate(valor = as.numeric(sub(",", ".", valor)))%>%
  select(-cpf,-uf,-ue,-sigla,-num_cand,-nome)

#salvando o banco com as observações por receita recebida
write.table(receitas, file="receitas_2016.csv", sep=";", row.names=FALSE)

#agregando as receitas pelo CPF dos candidatos e pelo tipo de receita recebida
receitas1 <- aggregate(receitas$valor, by = list(receitas$seq, receitas$tipo), FUN="sum")
#renomeando as variaveis
names(receitas1) <- c("seq", "tipo", "valor")
#deixando observacoes unicas pra cada candidato por CPF
receitas1 <- reshape(receitas1, timevar = "tipo", idvar = "seq", direction = "wide")

#agregando as receitas pelo CPF dos candidatos e pelo tipo de receita recebida
receitas2 <- aggregate(receitas$valor, by = list(receitas$seq, receitas$fonte), FUN="sum")
#renomeando as variaveis
names(receitas2) <- c("seq", "fonte", "valor")
#deixando observacoes unicas pra cada candidato por CPF
receitas2 <- reshape(receitas2, timevar = "fonte", idvar = "seq", direction = "wide")

receitas <- receitas1 %>%
  left_join(receitas2, by ="seq") %>%
  rename(valor_tipo_internet_cand = `valor.Doações pela Internet`,
         valor_tipo_eventos_cand =`valor.Comercialização de bens ou realização de eventos`,
         valor_tipo_candidatos_cand = `valor.Recursos de outros candidatos`,
         valor_tipo_partidos_cand = `valor.Recursos de partido político`,
         valor_tipo_ni_cand = `valor.Recursos de origens não identificadas`,
         valor_tipo_pfisica_cand = `valor.Recursos de pessoas físicas`,
         valor_tipo_proprio_cand = `valor.Recursos próprios`,
         valor_tipo_aplic_cand = `valor.Rendimentos de aplicações financeiras`,
         valor_origem_fundo_cand = `valor.Fundo Partidario`,
         valor_origem_outros_cand =`valor.Outros Recursos`)

#salvando os arquivos com as observações por candidato
write.table(receitas, file="receitas_2016_unico.csv", sep=";", row.names=FALSE)
