# ============================================================
# Teoria do Aprendizado Estatístico
# Rodolfo Vinicius Cima Takemoto
# ============================================================

# --- PASSO 0: Limpeza e Preparação ---
rm(list=ls())

library(ISLR)
library(ISLR2)

# Definindo o diretório de trabalho
setwd("C:/Users/takem/Documents/Projeto Integrador")

# Carregando a base de dados
dados001 <- Carseats

# Visualizando a estrutura dos dados
names(dados001)
str(dados001)

# --- PASSO 1: Modelo Completo ---
# Incluímos todas as variáveis para identificar quais não são significativas
modelo001 <- lm(Sales ~ CompPrice + Income + Advertising + Population + Price + 
                  ShelveLoc + Age + Education + Urban + US, data = dados001)

summary(modelo001)
# OBSERVAÇÃO: A variável 'Population' tem o maior p-valor (0,913), muito acima de 0,05.
# Ela será a primeira a ser excluída.

# --- PASSO 2: Removendo 'Population' ---
modelo002 <- lm(Sales ~ CompPrice + Income + Advertising + Price + 
                  ShelveLoc + Age + Education + Urban + US, data = dados001)

summary(modelo002)
# OBSERVAÇÃO: Agora, a variável 'Education' apresenta p-valor de 0,828. 
# Como é maior que 0,05, vamos removê-la.

# --- PASSO 3: Removendo 'Population' e 'Education' ---
modelo003 <- lm(Sales ~ CompPrice + Income + Advertising + Price + 
                  ShelveLoc + Age + Urban + US, data = dados001)

summary(modelo003)
# OBSERVAÇÃO: A variável 'Urban' (p-valor 0,93) continua não sendo significativa.
# Vamos excluí-la no próximo passo.

# --- PASSO 4: Removendo 'Population', 'Education' e 'Urban' ---
modelo004 <- lm(Sales ~ CompPrice + Income + Advertising + Price + 
                  ShelveLoc + Age + US, data = dados001)

summary(modelo004)
# OBSERVAÇÃO: A variável 'US' (p-valor 0,11) ainda está acima do limite de 0,05.
# Vamos retirá-la para chegar ao modelo ideal.

# --- PASSO 5: Modelo Final Otimizado ---
# Removendo: Population, Education, Urban e US
modelo005 <- lm(Sales ~ CompPrice + Income + Advertising + Price + 
                  ShelveLoc + Age, data = dados001)

# Resultado Final
summary(modelo005)

# --- CONCLUSÃO ---
# No modelo005, todas as variáveis possuem p-valor extremamente baixo (com estrelinhas ***).
# Isso significa que CompPrice, Income, Advertising, Price, ShelveLoc e Age 
# são os fatores que realmente impactam nas vendas (Sales).


rm(list=ls())
library(ISLR)

# 1. Carregar os dados
dados001 <- Carseats

# 2. Criar o modelo COMPLETO (o ponto de partida)
# O "~ ." diz ao R para usar TODAS as outras colunas como preditores
modelo_completo <- lm(Sales ~ ., data = dados001)

# 3. Executar a seleção automática (Backward Elimination)
# direction = "backward" faz exatamente o que fizemos: começa com tudo e vai tirando
modelo_automatico <- step(modelo_completo, direction = "backward")

# 4. Ver o resultado final
summary(modelo_automatico)
