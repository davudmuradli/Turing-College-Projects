# Predicting 10-Year Risk of Coronary Heart Disease (CHD)

## Project Overview
This project focuses on predicting the **10-year risk of coronary heart disease (CHD)** using clinical, demographic, and behavioral data from the **Framingham Heart Study**. The task is framed as a **binary classification problem**, where the goal is to identify individuals at higher risk of developing CHD within ten years.

The analysis follows a structured, end-to-end data science workflow including data cleaning, exploratory data analysis, feature preprocessing, model building, evaluation, and interpretation.

---

## Dataset
The dataset contains **3390 patient records** and **17 variables**, including:
- Demographic features (age, sex, education)
- Behavioral risk factors (smoking status, cigarettes per day)
- Clinical measurements (blood pressure, cholesterol, BMI, glucose)
- Medical history indicators (hypertension, diabetes, stroke)
- Target variable: `TenYearCHD` (0 = No CHD, 1 = CHD within 10 years)

The target variable is **imbalanced**, with approximately **15% positive CHD cases**, which significantly influences model evaluation choices.

---

## Data Cleaning and Preprocessing
Several features contain missing values, particularly clinical measurements such as glucose, cholesterol, BMI, and medication indicators.  
Key preprocessing steps include:
- **Median imputation** for missing numeric values
- **One-hot encoding** for categorical variables (`sex`, `is_smoking`)
- **Standardization** of numeric features to ensure stable model training

All preprocessing and modeling steps are combined using a **scikit-learn Pipeline** to prevent data leakage and ensure reproducibility.

---

## Exploratory Data Analysis (EDA)
Exploratory analysis revealed:
- Strong class imbalance in the target variable
- Right-skewed distributions for several clinical variables (e.g., glucose, cigarettes per day)
- Meaningful relationships between CHD and known risk factors such as:
  - Age
  - Systolic blood pressure
  - Hypertension indicators
  - Diabetes and glucose levels

Correlation analysis confirmed that the dataset aligns well with established medical knowledge, supporting its suitability for predictive modeling.

---

## Model Selection
A **Logistic Regression** model was chosen because:
- The target variable is binary
- The model provides interpretable coefficients
- Logistic regression is widely used in medical risk modeling

At least one categorical variable and multiple transformed numeric variables were included, following best practices.

---

## Model Evaluation
Due to class imbalance, **accuracy alone is not sufficient**. The following metrics were used:
- **ROC AUC** (primary metric)
- Precision, Recall, and F1-score
- Confusion matrices

The final model achieved:
- **ROC AUC ≈ 0.74**, indicating good discriminative ability
- **Recall ≈ 0.70** for CHD cases, meaning most high-risk patients were correctly identified

---

## Threshold Optimization
Instead of using the default probability threshold (0.5), an **optimal threshold** was selected by maximizing the **F1-score** using the Precision–Recall curve.

This approach balances:
- Detecting as many CHD cases as possible (high recall)
- Limiting false positives to a reasonable level

Threshold tuning slightly improved precision without reducing recall, making the model more suitable for real-world screening scenarios.

---

## Key Insights

- Age and systolic blood pressure are the strongest predictors of 10-year CHD risk. Risk increases steadily with higher values.
- Smoking is a significant risk factor; smokers show a noticeably higher probability of CHD.
- Diabetes and glucose levels contribute to risk, but their effect is less linear and influenced by outliers.
- CHD cases are rare (~15%), so accuracy is misleading; recall and ROC AUC are more appropriate metrics.
- Logistic regression achieves ROC AUC ≈ 0.74, making it suitable for risk screening, not diagnosis.


## Possible Improvements

- Address class imbalance using class weights or resampling.
- Add feature engineering (e.g., pulse pressure, risk categories).
- Check probability calibration for better clinical usability.


---

## Conclusion
This project demonstrates a complete and well-justified analytical approach to medical risk prediction:
- Data-driven preprocessing decisions
- Appropriate evaluation metrics for imbalanced classification
- Clear interpretation of model outputs
- Emphasis on practical and actionable insights

The results show that logistic regression, when properly evaluated and tuned, can be an effective and interpretable tool for predicting CHD risk.
