# 📘 Replication Report

**Title:** Replication of “Life Satisfaction and Socioeconomic Predictors: An Analysis of the 2017 General Social Survey (GSS)”  
**Replicator:** [Your Name]  
**Date:** [Insert submission date]  
**Software:** RStudio (Version 2025.09.0 Build 387 — “Cucumberleaf Sunflower”)  
**Operating System:** Windows 11  
**Language:** R  
**Total Lines of Code:** 128  

---

## 1. Overview

This replication report reproduces the linear regression analysis predicting **life satisfaction** from **Aboriginal identity, sex, and marital status** using data from the **2017 Canadian General Social Survey (Cycle 31 – Family)**.

The replication was based on a **master R script** provided by the author; no separate modular program file was included. The analysis was reproduced by following the master script’s annotations, replicating each data cleaning, modeling, and output step.

All numerical results were successfully reproduced. However, a minor methodological issue was identified — the marital status variable (`MARSTAT`) was treated as **numeric** rather than **categorical**, resulting in a conceptually invalid specification despite computational reproducibility.

---

## 2. Files Included

| File Name | Description |
|------------|-------------|
| `Replication_Report_[YourLastName].pdf` | Completed replication report following AEA Data Editor template |
| `RRWM_master_script.R` | R script used for replication (reconstructed from master annotations) |
| `RRWM_regression_result_Xin.txt` | Text file containing regression summary and ANOVA results |
| `RRWM_model_forest.pdf` | Coefficient plot (95% CI) from linear model |
| `RRWM_assumption_result_Xin.pdf` | Intended diagnostic plot file (blank output; diagnostics assessed manually) |
| `README.md` | This file |

---

## 3. Data Description

**Data Source:**  
Statistics Canada, *General Social Survey (GSS) 2017 – Family, Cycle 31*.  
File name: `gss-12M0025-E-2017-c-31_F1.csv`  

**Access:**  
Data were retrieved from the **CAnD3 online learning portal**.  
This dataset contains publicly available variables on social and family characteristics for Canadian respondents aged 15+.

**Variables Used:**

| Variable | Description | Notes |
|-----------|--------------|-------|
| `SLM_01` | Self-rated life satisfaction (0–10) | Treated as continuous |
| `AMB_01` | Aboriginal identity (1 = Yes, 2 = No) | Recoded as factor |
| `SEX` | Gender (1 = Male, 2 = Female) | Recoded as factor |
| `MARSTAT` | Marital status (1–6) | Treated as numeric in original; should be factor-coded |

---

## 4. Replication Steps

1. Imported raw data using `read.csv()`.  
2. Subsetted required variables (`SLM_01`, `AMB_01`, `SEX`, `MARSTAT`).  
3. Renamed variables (`feeling_lf`, `aboriginal_id`, `SEX`, `MARSTAT`).  
4. Filtered invalid or missing codes.  
5. Generated descriptive statistics (`skim()` and `tbl_summary()`).  
6. Fit linear regression model:  
   ```r
   lm(feeling_lf ~ aboriginal_id + SEX + MARSTAT, data = gss_clean)
