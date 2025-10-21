library(haven)
library(dplyr)

# read the whole dataset which I downloaded
gss2017 <- read.csv ("/Users/lanlanxin/Desktop/CAND3/RRWM-Sep/CAND3 Data/GSS 2017 - Family, Cycle 31/gss-12M0025-E-2017-c-31_F1.csv")

# select variables i needed
gss_subset <-gss2017[,c("SLM_01", "AMB_01", "SEX","MARSTAT")]

# check the table
head(gss_subset)

#rename variables
gss_subset <- gss_subset %>%
  rename(feeling_lf = SLM_01, aboriginal_id = AMB_01) 
names(gss_subset)

#clean data
gss_clean <- gss_subset %>%
  filter(
    feeling_lf    %in% 0:10,   # only keep 0–10
    aboriginal_id %in% 1:2,    # only keep 1, 2
    SEX           %in% 1:2,    # only keep 1, 2
    MARSTAT       %in% 1:6     # only keep 1–6
  )

# Basic descriptive stats
library(skimr)
install.packages("gtsummary")
library(gtsummary)
install.packages("emmeans")
library(emmeans)

skim(gss_clean)

tbl_summary( gss_clean, by = NULL,  # overall description only
             type = list(
               feeling_lf ~ "continuous",   # numeric variable
               aboriginal_id ~ "categorical",
               SEX ~ "categorical",
               MARSTAT ~ "categorical"
             ),
             statistic = list(
               feeling_lf ~ "{mean} ({sd}), Min={min}, Max={max}",
               all_categorical() ~ "{n} ({p}%)"
             )
)

# test assumption
lm_model <- lm(feeling_lf ~ aboriginal_id + SEX + MARSTAT, data = gss_clean)

par(mfrow=c(2,2))
plot(lm_model)

# linear regression
summary(lm_model)

anova(lm_model)

emmeans(lm_model,~ aboriginal_id)
emmeans(lm_model, ~SEX)
emmeans(lm_model,~ MARSTAT)

# save plot result in a PDF file
pdf("RRWM_assumption_result_Xin.pdf")
par(mfrow=c(2,2))
dev.off()

#save other results in a TEXT file
sink("RRWM_regression_result_Xin.txt") 
summary(lm_model)
anova(lm_model)
sink() 

# Rename the labels
gss_clean <- gss_clean %>%
  mutate(
    MARSTAT = factor(MARSTAT,
                     levels = 1:6,
                     labels = c("Married",
                                "Living common-law",
                                "Widowed",
                                "Separated",
                                "Divorced",
                                "Single, never married")),
    SEX = factor(SEX, levels = c(1, 2), labels = c("Male", "Female")),
    aboriginal_id = factor(aboriginal_id, levels = c(1, 2), labels = c("Yes", "No"))
  )

table(gss_clean$MARSTAT)

install.packages("forcats")  
library(forcats)

gss_plot <- gss_clean %>%
  mutate(MARSTAT = fct_relevel(MARSTAT,
                               "Single, never married",
                               "Married",
                               "Living common-law",
                               "Separated",
                               "Divorced",
                               "Widowed"))
# visalization
library(ggplot2)
library(broom)
library(dplyr)

# forest graph
coef_df <- tidy(lm_model, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  mutate(term = factor(term, levels = rev(term))) 
print(coef_df)

ggplot(coef_df, aes(x = estimate, y = term)) +
  geom_point(size = 3, color = "orange") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  geom_vline(xintercept = 0, linetype = 2, color = "darkgrey") +
  labs(x = "Estimate (95% CI)", y = "Term", title = "Coefficient Plot (Linear Model)")

# save the figures
pdf("RRWM_model_forest.pdf", width = 8, height = 6)
ggplot(coef_df, aes(x = estimate, y = term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  geom_vline(xintercept = 0, linetype = 2) +
  labs(x = "Estimate (95% CI)", y = "Term", title = "Coefficient Plot (Linear Model)")

dev.off()

