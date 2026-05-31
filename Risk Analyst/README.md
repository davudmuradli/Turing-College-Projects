# Credit Risk RWA Calculation – Basel III (Standardized vs IRB)

## Overview
This project calculates **credit risk Risk-Weighted Assets (RWA)** and **capital requirements** for a mortgage loan portfolio under two regulatory approaches:

- **Standardized Approach**
- **Internal Ratings-Based (IRB) Approach**

The goal is to compare the capital requirements produced by each method and analyze the risk characteristics of the portfolio.

**Dataset:** `Mortgage_default (HMEQ)`  
**Total loans analyzed:** 5,960

Google Sheets:
https://docs.google.com/spreadsheets/d/11Ntf_CmfgqHuVo7WJ3Bb3kekDYXvWqDzwlKJL4Fr0pE/edit?usp=sharing

---

## 1. Dataset Description

The dataset contains mortgage loans with borrower and credit history attributes.

| Variable | Description |
| :--- | :--- |
| **BAD** | Default indicator (1 = defaulted, 0 = paid loan) |
| **MORTDUE** | Amount due on existing mortgage |
| **VALUE** | Property value (collateral) |
| **JOB** | Occupation category |
| **YOJ** | Years at current job |
| **DEROG** | Number of major derogatory reports |
| **DELINQ** | Number of delinquent credit lines |
| **CLAGE** | Age of oldest credit line |
| **NINQ** | Number of recent credit inquiries |
| **CLNO** | Number of credit lines |
| **DEBTINC** | Debt-to-income ratio |

---

## 2. Data Preparation

### Basic Portfolio Metrics
- **Total loans:** 5,960
- **Defaults:** 1,189
- **Default rate:** 19.95%

**Default rate formula:**
$$\text{Default Rate} = \frac{\text{Defaults}}{\text{Total Loans}}$$

---

## 3. Standardized Approach

Under the Basel III standardized approach, risk weights are assigned primarily based on **Loan-to-Value (LTV)** ratios.

### Exposure at Default (EAD)

> **Assumption:** $EAD = MORTDUE$  
> This assumes the outstanding mortgage balance represents the exposure.

---

### Adjusted Collateral Value

Some loans had missing property values. To handle this, a **default LTV of 45%** was assumed.

$$\text{Adjusted Value} = \text{IF(VALUE is missing, } \frac{MORTDUE}{0.45}, \text{ VALUE)}$$

---

### Loan-to-Value (LTV)
$$LTV = \frac{EAD}{\text{Adjusted Value}}$$

---

### Risk Weight Assignment

Risk weights were applied based on LTV buckets.

| LTV Range | Risk Weight |
| :--- | :--- |
| $\le 50\%$ | 20% |
| 50–70% | 30% |
| 70–90% | 45% |
| 90–100% | 70% |
| $>100\%$ | 105% |

---

### Risk-Weighted Assets
$$RWA_{STD} = EAD \times \text{Risk Weight}$$

---

### Capital Requirement

Basel III minimum capital requirement:
$$\text{Capital}_{STD} = 8\% \times RWA_{STD}$$

---

## 5. Portfolio Results

| Metric | Value |
| :--- | :--- |
| **Total Exposure (EAD)** | 401,406,367 |
| **Total RWA – Standardized** | 141,273,503 |
| **Capital – Standardized** | 11,301,880 |
| **Total RWA – IRB** | 718,416,553 |
| **Capital – IRB** | 57,473,324 |

---

## 6. Portfolio Risk Analysis

### LTV Distribution

| LTV Bucket | Loans |
| :--- | :--- |
| 0–50% | 1,235 |
| 50–70% | 1,723 |
| 70–90% | 2,758 |
| 90–100% | 173 |

- Most loans fall in the **70–90% LTV range**, indicating moderate leverage.
- High-LTV loans (>90%) represent a smaller but higher-risk segment.

---

### Debt-to-Income vs Default Risk

The scatter analysis shows:
- Most borrowers have **20–50% debt-to-income ratios**.
- Higher debt-to-income ratios are associated with **higher predicted default probabilities**.
- This indicates **borrower financial burden is a major driver of credit risk**.

---

## 7. Key Insights

- The portfolio contains **moderate credit risk**, with most loans clustered in mid-range LTV levels.
- Borrowers with **higher debt-to-income ratios** exhibit higher default risk.
- The standardized approach **overestimates risk** because it relies on broad regulatory categories.
- The IRB approach provides **more accurate risk sensitivity** by incorporating borrower characteristics.

---

## 8. Conclusion

The comparison shows a significant difference between the two Basel III approaches. The Standardized approach results in total RWA of 141.27 million and capital of 11.30 million, while the IRB approach results in total RWA of 718.42 million and capital of 57.47 million. This means that, for this portfolio, the IRB approach produces substantially higher capital requirements.

This outcome is driven by the higher risk sensitivity of the IRB method. Using a logistic regression PD model, several borrower characteristics were identified as important drivers of default risk, especially delinquent credit lines, derogatory reports, and debt-to-income ratio. Because many loans in the dataset have relatively high estimated PDs, the IRB framework assigns much higher capital charges than the Standardized approach.

In conclusion, the IRB method provides a more granular assessment of credit risk and reveals that this mortgage portfolio is considerably riskier than suggested by the Standardized approach.

---

## Tools Used

- **Google Sheets** https://docs.google.com/spreadsheets/d/11Ntf_CmfgqHuVo7WJ3Bb3kekDYXvWqDzwlKJL4Fr0pE/edit?usp=sharing
- Basel III regulatory framework
- Logistic probability model approximation
- Portfolio risk visualization
