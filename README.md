# Replication Report

**Title:** Replication of “Life Satisfaction and Socioeconomic Predictors: An Analysis of the 2017 General Social Survey (GSS)”  
**Replicator:** Ruth  
**Software:** RStudio (Version 2025.09.0 Build 387 “Cucumberleaf Sunflower”)  
**Operating System:** Windows 11  
**Language:** R  


---

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

## 3. Data Description

**Data Source:**  
Statistics Canada, *General Social Survey (GSS) 2017 – Family, Cycle 31*.  
File name: `gss-12M0025-E-2017-c-31_F1.csv`  

**Access:**  
Data were retrieved from the **CAnD3 online learning portal**.  

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
   ```
7. Performed model diagnostics and ANOVA (`plot(lm_model)`, `anova(lm_model)`).  
8. Created and saved coefficient plot (`RRWM_model_forest.pdf`).  
9. Exported regression output to text file using `sink()`.  

---

## 5. Replication Findings

- **Computational reproduction:** Achieved - all model outputs matched exactly.  
- **Methodological validity:** Partially met - the variable `MARSTAT` was mis-specified (numeric instead of categorical).  
- **Diagnostics:** Residual plots show acceptable patterns, though not all regression assumptions were explicitly discussed by the author.  
- **Classification:** *Full reproduction with minor issues* - all numerical results were identical, but variable treatment and program completeness were imperfect.

---

## 6. Recommended Corrections

1. Recode `MARSTAT` as a categorical factor before model estimation.  
2. Re-run diagnostics and interpret factor contrasts relative to a reference group (e.g., “Married”).  
3. Provide a separate, well-documented program file for future replication rather than embedding all steps in a single master script.  

---

## 7. Computing Environment

| Component | Specification |
|------------|---------------|
| **RStudio** | Version 2025.09.0 Build 387 (“Cucumberleaf Sunflower”) |
| **R** | Version 4.4.1 |
| **Operating System** | Windows 11 Home |
| **Packages Used** | `dplyr`, `haven`, `skimr`, `gtsummary`, `emmeans`, `broom`, `ggplot2`, `forcats` |
| **Replicate Weighting** | Not applied (unweighted linear regression) |

---

## 8. Acknowledgments

This replication exercise was completed as part of the **CAnD3 Training Program in Data-Driven Decision-Making**, under the module *Reproducible Research Workflows in R*.  
All data remain the property of **Statistics Canada**.  
Analytical interpretations are solely those of the replicator.

---








