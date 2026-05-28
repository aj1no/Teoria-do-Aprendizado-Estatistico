# Statistical Learning Theory (TAE)

*[Ler em Português](README.pt-br.md)*

[![R](https://img.shields.io/badge/R-%3E%3D%204.0-blue?style=flat-square&logo=r&logoColor=white)](https://www.r-project.org/)
[![License MIT](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![CI](https://img.shields.io/github/actions/workflow/status/aj1no/Teoria-do-Aprendizado-Estatistico/ci.yml?branch=main&label=CI&style=flat-square)](https://github.com/aj1no/Teoria-do-Aprendizado-Estatistico/actions)

Repository containing labs and practical projects developed in R (with RStudio support) for the Statistical Learning Theory course at FATEC.

* **Author:** Rodolfo Vinicius Cima Takemoto  
* **Professor:** Douglas Paes Mação  
* **GitHub:** [aj1no](https://github.com/aj1no)

---

## Technologies and Packages Used

To run the scripts in this repository, you will need the R language configured and the following libraries:
* `ISLR` & `ISLR2` (Databases for classic machine learning)
* `caret` (Unified interface for classification and regression)
* `pROC` (ROC curves analysis and threshold optimization)
* `ggplot2` (Advanced visualizations and charts)
* `mlbench` (Benchmark datasets like Sonar)
* `palmerpenguins` (Ecological data of Palmer penguins)
* `rpart` & `rpart.plot` (Decision tree modeling and plotting)
* `nnet` (Fitting multinomial logistic regression models)

To install all required packages at once in the R console:
```R
install.packages(c("ISLR", "ISLR2", "caret", "pROC", "ggplot2", "mlbench", "palmerpenguins", "rpart", "rpart.plot", "nnet"))
```

---

## Scripts Organization (TAEs)

| Script | Main Subject | Algorithms and Methods | Datasets Used |
| :--- | :--- | :--- | :--- |
| [TAEs001.R](TAEs001.R) | Multiple Linear Regression | Manual and automatic (`step`) Backward Elimination | `Carseats` (`ISLR`/`ISLR2`) |
| [TAEs002.R](TAEs002.R) | Prediction and Mathematical Formulation | Manual prediction equation using estimated coefficients vs R's `predict()` | `Auto`, `Carseats`, `Credit` |
| [TAEs003.R](TAEs003.R) | Feature Selection | Stepwise: Forward, Backward, and Both directions | `mtcars`, `Auto`, `Carseats`, `Hitters` |
| [TAEs004.R](TAEs004.R) | Binary Classification | Logistic Regression, manual calculation of Accuracy, Sensitivity, and Specificity | `Smarket`, `Default`, `Weekly`, `Caravan` |
| [TAEs005.R](TAEs005.R) | Threshold Optimization | ROC Curves, AUC calculation, and optimal threshold search via Youden's Index | `Smarket` (`ISLR`/`ISLR2`) |
| [TAEs006.R](TAEs006.R) | Master Script / Automation | Reusable helper functions for automating Stepwise and ROC optimization in batches | `mtcars`, `Auto`, `Carseats`, `Hitters`, `Default`, `Weekly`, `Caravan` |
| [TAEs007.R](TAEs007.R) | Modeling with External Data | Import, cleaning, and scale correction of custom CSV files | `autos.csv`, `boston_housing.csv`, `heart_disease_uci.csv` |
| [TAEs008.R](TAEs008.R) | Non-Linear & Multiclass Models | Regression and Classification Trees with CP (Cost-Complexity) Pruning and Multinomial Logistic Regression | `diamonds`, `Sonar`, `penguins` |

---

## Detailed Summary of Labs

### TAEs001 to TAEs003: Linear Modeling and Feature Selection
* **Backward Elimination and Stepwise**: Systematic study on dimensionality reduction. Analyzed p-values and AIC (Akaike Information Criterion) metrics to remove non-significant variables (such as `Population`, `Education`, and `Urban` in predicting `Sales` on the `Carseats` dataset).
* **Regression Equation Calculation**: Manual implementation of prediction functions using individual beta coefficients to transparently understand the inner workings of linear models compared to standard R predictions.

### TAEs004 and TAEs005: Binary Classification Modeling
* **Logistic Regression**: Mathematical modeling of categorical variables using the logit link function (binomial family).
* **ROC Curves and Youden's Index**: Visual analysis development to balance the true positive rate (Sensitivity) and false positive rate (Specificity). Utilized Youden's Index to define optimal decision thresholds instead of the fixed 0.5 default.

### TAEs006: Code Consolidation and Engineering
* Created a robust pipeline with automated helper functions (such as `otimizar_modelo`), reducing code redundancy and unifying statistical modeling and validation across multiple datasets simultaneously.

### TAEs007: ETL and Real-World CSV Modeling
* Handling practical numeric formatting issues in real-world datasets (removing thousand separators, adjusting floating scales) and applying linear and logistic models on health (heart disease), real estate (Boston), and automotive data. Original data files are located in the `DataFrame/` directory.

### TAEs008: Decision Trees and Multiclass Regression
* **Pruned Trees**: Used the `rpart` package to generate complex decision trees and then applied pruning utilizing the complexity parameter (CP) optimized by cross-validation to prevent overfitting on the `Sonar` dataset.
* **Multinomial Logistic Regression**: Multiclass classification using the `nnet` package to predict penguin species in the `palmerpenguins` dataset.

---

## How to Run
1. Ensure you have the packages listed above installed.
2. In RStudio, set the working directory to the root of this project:
   ```R
   setwd("c:/Users/takem/OneDrive/Documentos/FATEC/TAE")
   ```
3. Open and run the scripts of interest.

---
*Developed by Rodolfo Vinicius Cima Takemoto for the Statistical Learning Theory course.*
