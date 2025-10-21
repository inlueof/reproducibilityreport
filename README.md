# Replication of “Life Satisfaction and Socioeconomic Predictors: An Analysis of the 2017 General Social Survey (GSS)”  

## 1. Overview

This replication report reproduces the linear regression analysis predicting **life satisfaction** from **Aboriginal identity, sex, and marital status** using data from the **2017 Canadian General Social Survey (Cycle 31 – Family)**.

The replication was based on a **master R script** provided by the author; no separate modular program file was included. The analysis was reproduced by following the master script’s annotations, replicating each data cleaning, modeling, and output step.

All numerical results were successfully reproduced. However, a minor methodological issue was identified, the marital status variable (`MARSTAT`) was treated as **numeric** rather than **categorical**, resulting in a conceptually invalid specification despite computational reproducibility.

---

## 2. Files Included

| File Name | Description |
|------------|-------------|
| `Replication_Report_Lanlan.pdf` | Completed replication report following AEA Data Editor template |
| `Replicated Markup.R` | R script used for replication (reconstructed from master annotations) |
| `RRWM_Xin.R`| Lanlan's original script|
| `RRWM_regression_result_Xin.txt` | Text file containing regression summary and ANOVA results |
| `RRWM_model_forest.pdf` | Coefficient plot (95% CI) from linear model |
| `RRWM_assumption_result.pdf` | Intended diagnostic plot file (blank output; diagnostics assessed manually) |
| `README.md` | This file |

---

## 3. Data Source
 
Statistics Canada, *General Social Survey (GSS) 2017 – Family, Cycle 31.  

---

## 4. Requirements

| Component | Specification |
|------------|---------------|
| **RStudio** | Version 2025.09.0 Build 387 (“Cucumberleaf Sunflower”) |
| **R** | Version 4.4.1 |
| **Packages Used** | `dplyr`, `haven`, `skimr`, `gtsummary`, `emmeans`, `broom`, `ggplot2`, `forcats` |

---

## 5. Data Accessibility Statement

Data used in this exercise were obtained through ODESI, a service provided by the Ontario Council of University Libraries (https://search1.odesi.ca/#/

Access is restricted to those users who have a DLI License and can be used for statistical and research purposes. The terms and more information about the license can be viewed here (https://www.statcan.gc.ca/en/microdata/dli

As part of McGill University, the CAnD3 initiative has a license to use the data for the purposes of training. Those outside of McGill university should not use the data provided through CAnD3's training activities for purposes not related to their CAnD3 training.

Fellows who belong to another DLI institution should re-download the data using the ODESI site using the login provided by their institution if they wish to make use of the data for other purposes.

---

## 6. Data Citation

Statistics Canada. 2020. General Social Survey, Cycle 31, 2017 [Canada]: Family (version 2020-09). Statistics Canada [producer and distributor], accessed September 10, 2021. ID: gss-12M0025-E-2017-c-31













