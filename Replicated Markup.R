# Replication (based on master script instructions)

#load packages-----------------------------------------------------------------

library(haven)  
library(dplyr)
library(skimr)
library(gtsummary)
library(emmeans)
library(forcats)
library(ggplot2)
library(broom)

# 1) Read/load dataset ---------------------------------------------------------
gss2017 <- read.csv("gss-12M0025-E-2017-c-31_F1.csv")

# 2) Subset variables needed ---------------------------------------------------
gss_subset <- gss2017[, c("SLM_01", "AMB_01", "SEX", "MARSTAT")]

# 3) Rename variables ----------------------------------------------------------
gss_subset <- gss_subset %>%
  rename(feeling_lf = SLM_01, aboriginal_id = AMB_01)

# 4) Clean data (keep valid codes) ---------------------------------------------
gss_clean <- gss_subset %>%
  filter(
    feeling_lf    %in% 0:10,  # 0–10
    aboriginal_id %in% 1:2,   # 1,2
    SEX           %in% 1:2,   # 1,2
    MARSTAT       %in% 1:6    # 1–6
  )

# 5) Descriptives --------------------------------------------------------------
skim(gss_clean)

tbl_summary(
  gss_clean, by = NULL,
  type = list(
    feeling_lf ~ "continuous",
    aboriginal_id ~ "categorical",
    SEX ~ "categorical",
    MARSTAT ~ "categorical"
  ),
  statistic = list(
    feeling_lf ~ "{mean} ({sd}), Min={min}, Max={max}",
    all_categorical() ~ "{n} ({p}%)"
  )
)

# 6) Q-Q plot for assumption check ------------------------------------------------
par(mfrow = c(2, 2))
plot(lm_model)

# 7) linear regression ---------------------------------------------------------
lm <- lm(feeling_lf ~ aboriginal_id + SEX + MARSTAT, data = gss_clean)


# Save diagnostics to PDF 
pdf("RRWM_assumption_result.pdf", width = 8, height = 6)
par(mfrow = c(2, 2))
plot(lm_model)
dev.off()

# 8) Model outputs (summary/ANOVA) ---------------------------------------------
sink("RRWM_regression_result_Xin.txt")
summary(lm_model)
anova(lm_model)


# 9) Estimated marginal means --------------------------------------------------
emmeans(lm_model, ~ aboriginal_id)
emmeans(lm_model, ~ SEX)
emmeans(lm_model, ~ MARSTAT)

# 10) Relabel factors (as in prior script, after model) ------------------------
gss_clean <- gss_clean %>%
  mutate(
    MARSTAT = factor(
      MARSTAT, levels = 1:6,
      labels = c("Married", "Living common-law", "Widowed",
                 "Separated", "Divorced", "Single, never married")
    ),
    SEX = factor(SEX, levels = c(1, 2), labels = c("Male", "Female")),
    aboriginal_id = factor(aboriginal_id, levels = c(1, 2), labels = c("Yes", "No"))
  )

# 11) Coefficient (forest) plot ------------------------------------------------
coef_df <- tidy(lm_model, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  mutate(term = factor(term, levels = rev(term)))

# On-screen
ggplot(coef_df, aes(x = estimate, y = term)) +
  geom_point(size = 3, color = "red") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  geom_vline(xintercept = 0, linetype = 2, color = "black") +
  labs(x = "Estimate (95% CI)", y = "Term", title = "Coefficient Plot (Linear Model)")

# Save to PDF 
pdf("RRWM_model_forest.pdf", width = 8, height = 6)
ggplot(coef_df, aes(x = estimate, y = term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Estimate (95% CI)", y = "Term", title = "Coefficient Plot (Linear Model)")
dev.off()
