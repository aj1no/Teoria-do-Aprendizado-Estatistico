# Teoria do Aprendizado Estatístico (TAE) 🧠📈

Repositório contendo os laboratórios e projetos práticos desenvolvidos na linguagem **R** (com o suporte do RStudio) para a disciplina de **Teoria do Aprendizado Estatístico** da FATEC.

Autor: **Rodolfo Vinicius Cima Takemoto**  
GitHub: [aj1no](https://github.com/aj1no)

---

## 🛠️ Tecnologias e Pacotes Utilizados

Para rodar os scripts deste repositório, você precisará da linguagem **R** configurada e das seguintes bibliotecas:
* `ISLR` & `ISLR2` (Bases de dados para aprendizado de máquina clássico)
* `caret` (Interface unificada para classificação e regressão)
* `pROC` (Análise de curvas ROC e otimização de limiares)
* `ggplot2` (Visualizações e gráficos avançados)
* `mlbench` (Datasets de benchmark como o Sonar)
* `palmerpenguins` (Dados ecológicos dos pinguins de Palmer)
* `rpart` & `rpart.plot` (Modelagem de árvores de decisão e sua plotagem)
* `nnet` (Ajuste de modelos logísticos multinomiais)

Para instalar todos os pacotes necessários de uma vez no console do R:
```R
install.packages(c("ISLR", "ISLR2", "caret", "pROC", "ggplot2", "mlbench", "palmerpenguins", "rpart", "rpart.plot", "nnet"))
```

---

## 📂 Organização dos Scripts (TAEs)

| Script | Tema Principal | Algoritmos e Métodos | Datasets Utilizados |
| :--- | :--- | :--- | :--- |
| [TAEs001.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs001.R) | Regressão Linear Múltipla | Eliminação Regressiva (Backward Elimination) manual e automática (`step`) | `Carseats` (`ISLR`/`ISLR2`) |
| [TAEs002.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs002.R) | Predição e Formulação Matemática | Construção manual da equação de predição com os coeficientes estimados vs `predict()` do R | `Auto`, `Carseats`, `Credit` |
| [TAEs003.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs003.R) | Seleção de Atributos (Feature Selection) | Stepwise: Forward, Backward e Both (Ambos os sentidos) | `mtcars`, `Auto`, `Carseats`, `Hitters` |
| [TAEs004.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs004.R) | Classificação Binária | Regressão Logística, cálculo manual de Acurácia, Sensibilidade e Especificidade | `Smarket`, `Default`, `Weekly`, `Caravan` |
| [TAEs005.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs005.R) | Otimização de Limiares (Thresholds) | Curvas ROC, cálculo de AUC e busca pelo limiar ótimo via Youden's Index | `Smarket` (`ISLR`/`ISLR2`) |
| [TAEs006.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs006.R) | Script Mestre / Automação | Funções reutilizáveis para automação de Stepwise e otimização ROC em lotes | `mtcars`, `Auto`, `Carseats`, `Hitters`, `Default`, `Weekly`, `Caravan` |
| [TAEs007.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs007.R) | Modelagem com Dados Externos | Importação, limpeza e escala corretiva de dados em arquivos CSV personalizados | `autos.csv`, `boston_housing.csv`, `heart_disease_uci.csv` |
| [TAEs008.R](file:///c:/Users/takem/OneDrive/Documentos/FATEC/TAE/TAEs008.R) | Modelos Não-Lineares & Multiclasse | Árvores de Regressão e Classificação com Poda por Cp (Cost-Complexity) e Regressão Logística Multinomial | `diamonds`, `Sonar`, `penguins` |

---

## 🔍 Resumo Detalhado dos Trabalhos

### 📈 TAEs001 a TAEs003: Modelagem Linear e Seleção de Atributos
* **Eliminação Regressiva e Stepwise**: Estudo sistemático sobre a redução de dimensionalidade. Foram analisados os p-valores e a métrica AIC (Akaike Information Criterion) para remover variáveis não significativas (como `Population`, `Education` e `Urban` na predição de `Sales` do dataset `Carseats`).
* **Cálculo da Equação de Regressão**: Implementação manual de funções preditoras usando coeficientes $\beta$ individuais para entender de forma transparente os bastidores do modelo linear comparado à predição padrão do R.

### 📊 TAEs004 e TAEs005: Modelagem de Classificação Binária
* **Regressão Logística**: Modelagem matemática de variáveis categóricas usando a função de ligação logit (família binomial).
* **Curvas ROC e Youden's Index**: Desenvolvimento de análises gráficas para balancear a taxa de verdadeiros positivos (Sensibilidade) e falsos positivos (Especificidade). Uso do Índice de Youden para definir limiares ótimos de decisão em vez do padrão fixo de $0.5$.

### ⚡ TAEs006: Consolidação e Engenharia de Código
* Criação de um pipeline robusto com funções auxiliares automatizadas (como `otimizar_modelo`), reduzindo redundâncias de código e unificando a modelagem e validação estatística em múltiplos datasets de uma vez.

### 📁 TAEs007: ETL e Modelagem Real com CSVs
* Tratamento de problemas práticos de formatação numérica em datasets do mundo real (remoção de pontos de milhar, ajuste de escala flutuante) e aplicação de modelos lineares e logísticos sobre dados de saúde (doenças cardíacas), imobiliário (Boston) e automobilístico. Os arquivos de dados originais estão localizados na pasta `DataFrame/`.

### 🌳 TAEs008: Árvores de Decisão e Regressão Multiclasse
* **Árvores com Poda (Pruning)**: Uso do pacote `rpart` para gerar árvores de decisão complexas e depois aplicar poda utilizando o parâmetro de complexidade (CP) otimizado por validação cruzada para evitar sobreajuste (overfitting) no dataset `Sonar`.
* **Regressão Logística Multinomial**: Classificação multiclasse utilizando o pacote `nnet` para predição da espécie de pinguins no dataset `palmerpenguins`.

---

## 🚀 Como Executar
1. Certifique-se de ter os pacotes listados acima instalados.
2. No RStudio, defina o diretório de trabalho para a pasta raiz deste projeto:
   ```R
   setwd("c:/Users/takem/OneDrive/Documentos/FATEC/TAE")
   ```
3. Abra e execute os scripts de interesse.

---
*Desenvolvido por Rodolfo Vinicius Cima Takemoto como portfólio prático de Teoria do Aprendizado Estatístico.*
