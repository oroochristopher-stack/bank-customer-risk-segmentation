# Bank Portfolio Risk & Customer Segmentation
**Analyst:** Christopher Oroo | **Project Status:** Production Ready | **Stack:** Google BigQuery (SQL), Python, Excel

---

## I. Executive Summary: The Bottom Line
**Problem:** The bank was operating with an **18% capital charge** and losing money on **100% of its Tier 3 Renter segments**. The legacy credit grading system failed to account for **Debt Capacity**, leading to severe under-pricing of risk.

**Strategy:** I architected a tri-tier risk framework in BigQuery, implementing a **Governed View Layer** that handles data imputation (**9.56% gap**) and engineers high-signal risk metrics like **LTI Ratios**.

**Impact:**
*   **Identified $12.5M in "Toxic Exposure":** Confirmed 100% default correlation for high-LTI Renters.
*   **Capital Release:** Proposed a 0.30 LTI Cap to trigger a **$50M+ Long-term Capital Release** as toxic stock runs off the balance sheet.
*   **NIM Restoration:** Recommended a **14.5% interest floor** for Prime Renters to flip a negative Net Risk Margin into profitability.

---

## II. Analytical Infrastructure & Governance
### **1. Cloud-Native Environment**
*   **Platform:** Google BigQuery (Simulating a multi-million row enterprise environment).
*   **Security:** Successfully architected a **Python-to-BigQuery bridge** using tokenized OAuth 2.0.
*   **Cost Control:** I have implemented a **50MB Safety Guardrail** and mandatory **Dry Run Audits** to ensure analytical cost-efficiency.

### **2. Data Triage & Hardening**
*   **The Portfolio Baseline:** Anchored the ETL pipeline against a raw baseline of 32,581 loan records.
*   **The 9.56% Gap:** Identified schema auto-detect errors in interest rates and employment length.
*   **The Solution:** Built a **SQL Cleaning Layer (Silver View)** using `SAFE_CAST` and `COALESCE`. 
*   **Validation:** Conducted a **Data Integrity Stress Test** on 3,116 imputed records. Statistical parity in LTI (0.171) and Default Rates (20.67% vs. 21.94%) validates the imputation as a **non-biasing strategy**.

---
## III. Data Integrity & Health Audit
I performed a transparency audit on the 'Silver' layer to quantify the residual data quality gaps. 

**Resulting Data Health Report:**
| total_loans | null_interest_rows | null_emp_rows | pct_interest_gap |
| :--- | :--- | :--- | :--- |
| 32581 | 3116 | 895 | 9.56 |

*   **Operational Interpretation:** The analysis reveals a **9.56% interest-rate documentation gap**. I have verified that this gap is statistically safe for grade-level median imputation.
*   **Strategic Recommendation:** I recommend that the Data Operations team investigate the source extraction pipeline, as a 9.56% documentation failure rate is a significant operational risk that should be addressed at the root.

Successfully audited ETL integrity via a UNION ALL reconciliation, establishing a 1:1 row count parity between Raw and Hardened assets.

| Data Source     | Total Records |
| :---           | :---:         |
| Raw Source     | 32,581        |
| Hardened View  | 32,581        |

---
### 1. Data Governance: Imputation Integrity Audit
I performed a comparative stress test between the Imputed (Gap) and Original (Clean) datasets to detect **Selection Bias**.
*   **Result:** The 'Gap Group' and 'Clean Group' exhibit statistical parity in default rates (20.67% vs. 21.94%).
*   **Conclusion:** The missing data is verified as **Missing At Random (MAR)**, confirming that grade-level median imputation is a non-biasing strategy for this portfolio.
---
## IV. Financial Risk Insights
### **1. The "Insolvency Frontier"**
The analysis reveals a **"Hard Wall"** for Renters at **0.40 LTI**. Beyond this point, default is a mathematical certainty (100% PD), making the segment un-priceable regardless of interest rates.

### **2. The Grade-LTI Override**
**Systemic Weakness:** I discovered that **Grade 'A' borrowers** with High-LTI ratios are **18x riskier** than Grade 'A' borrowers with low debt. This proves that credit history is secondary to current **Debt Capacity**.

### **3. Board-Level Provisioning & Yield Report (Expected Loss)**
**Business Goal:** Compare Interest Yield (`avg_int_rate`) versus the Cost of Risk (`loss_intensity`) to identify under-priced risk and calculate required Basel III capital provisions.

**The Findings:**
| risk_tier | customer_count | pd_percentage | capital_provision | avg_int_rate | loss_intensity |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Tier 1: Low Risk (Prime) | 16,700 | 11.89% | $9,072,796 | 10.63% | 8.32% |
| Tier 2: Medium Risk (Standard) | 14,695 | 28.84% | $36,875,126 | 11.39% | 20.19% |
| Tier 3: High Risk (Subprime) | 1,186 | 74.62% | $10,826,990 | 11.71% | 52.23% |

**Financial Interpretation:**
*   **The Yield-Risk Gap:** In Tier 3, the average interest rate is **11.71%**, yet the Loss Intensity is **52.23%**. For every dollar lent, the bank effectively loses ~52 cents while only collecting ~12 cents in interest. The bank is operating at a severe negative risk-adjusted margin.
*   **Concentration Risk:** While Tier 1 is the primary profit engine, Tier 2 requires a massive **$36.8M capital provision**. The bank is over-leveraged in this "Standard Risk" category, which is dragging down overall liquidity.

**Strategic Recommendations:**
1.  **Immediate Origination Moratorium:** Halt all new loan originations for Tier 3 (LTI > 0.40). No interest rate adjustment can mathematically compensate for a 74.62% PD and 52.23% Loss Intensity.
2.  **Strategic Debt Restructuring:** For existing Tier 3 and stressed Tier 2 borrowers, implement a **Debt Consolidation Initiative**. By extending loan terms (e.g., 36 to 60 months), we mathematically force the LTI ratio down from >0.40 to <0.25. This migrates borrowers away from the "Default Frontier," potentially reducing PD by over 40% without writing off the principal.
3.  **Pricing Floor Adjustment:** Establish a minimum interest rate floor of **15% for all Tier 2 loans** to offset the 20.19% Loss Intensity. The current 11.39% rate is failing to cover the bank’s cost of risk.

### **4. Multivariate Risk Discovery: The "Collateral Buffer"**
By cross-tabulating **LTI Risk Tiers** against **Home Ownership**, I uncovered a severe concentration of risk specifically tied to Renters, while identifying a hyper-stable "Safe Harbor" in Homeowners.

**The Findings:**

| Risk Tier | Ownership | Customer Volume | Default Rate (PD) | Exposure at Risk |
| :--- | :--- | :--- | :--- | :--- |
| **Tier 3 (Subprime)** | **RENT** | 754 | **100.00%** | **$12.57M** |
| **Tier 2 (Standard)** | **RENT** | 8,040 | **39.91%** | **$90.04M** |
| **Tier 2 (Standard)** | **MORTGAGE** | 5,309 | **16.12%** | $77.84M |
| **Tier 1 (Prime)** | **OWN** | 1,162 | **0.95%** | $7.28M |

**Strategic Insights & Actionable Outcomes:**
*   **The Renter "Death Zone":** Analysis identifies a **100% historical default correlation** for Tier 3 Renters. This represents **$12.5M in guaranteed loss**, proving that extreme leverage (LTI > 0.40) without tangible assets leads to total principal loss. 
*   **The Systemic Threat:** Tier 2 Renters represent the bank's largest "Hidden Fire," with a **39.9% default rate** across a massive **$90M exposure**. This segment is the primary driver of the bank's negative risk-adjusted margin.
*   **The Collateral Buffer:** Homeownership acts as a profound risk mitigant. Outright Owners in Tier 1 display an ultra-stable **0.95% default rate**, while Tier 2 Mortgage holders default at less than half the rate of their Renter counterparts (16.1% vs 39.9%).
*   **Policy Pivot:** I proposed a **Dual-Track Underwriting Policy**: Implement a strict **0.30 LTI cap for Renters** to halt losses, while aggressively expanding LTI limits (up to 0.45) for **Homeowners** to capture high-quality, collateral-backed volume.


---

## V. Strategic Recommendations
### **1. Underwriting Policy Shift**
*   **Recommend implementing a Hard LTI Cap of 0.30 for Renters** to protect bank solvency.
*   **Mandate a "Hard Stop" Override:** Regardless of Credit Grade, any applicant with an **LTI > 0.40** must be auto-rejected.

### **2. Capital Provisioning (IFRS 9)**
*   **Action:** Increase **Expected Credit Loss (ECL) provisions** for the Tier 2 Renter segment immediately. The $90M exposure in this segment is the bank's single largest "Hidden Fire."

---

## VI. Repository Structure & Reproducibility
The project is organized to follow the **Data Medallion Architecture**:
*   `scripts/sql/`: Pure logic for data hardening, segmentation, and provisioning.
*   `scripts/python/`: The automation engine, configuration, and cost-control gateway.
*   `notebook/`: The full analytical narrative and "Head-to-Tail" execution.
*   `reports/`: Houses the Excel Decision Sandbox and visual risk heatmaps.

**To Reproduce Results:**
1. Configure `scripts/python/config.py` with your GCP Project ID.
2. Execute `notebook/Risk_Pipeline.ipynb` to deploy the **Governed View Layer** and generate the financial reports.
